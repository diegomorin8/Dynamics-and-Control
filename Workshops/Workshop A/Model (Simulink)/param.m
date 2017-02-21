close all;

R = 112;
L = 0;
Kemf = 1/(137*2*pi/60);
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 1;
Jeq = Jm + (J1+J2)/(n^2);
Ts = 1e-2; %See step response (2-1.6
eps_Jeq = 0.6; % Scaling factor for inertia
eps_dm = 3.56; % scaling blabals

Tc = 0.0013;
dv = 1e-2;

syms s;

% Discretization
Ts = 1E-3; % Sampling time
Pulses = (2*pi)/512; % Pulses per rad

%Define the transfer function (No friction)

%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];

Ain = s*(s + dm/Jeq + Km*Kemf/(R*Jeq));
Bin = Km/(R*Jeq*n);
Bin0 = Km/(R*Jeq*n);
% Ain = s*(s + 4.5);
% Bin = 36;
% Bin0 = 36;

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);
Gspeed = G(2);
Gspos = G(1);

%Specifications PID controllers
PID_specs;

%Discrete

%Discretization
Gspeed_z = c2d(Gspeed,Ts,'zoh');
Gpos_z = c2d(Gspos,Ts,'zoh');

%Get the num and den
[B,A] = tfdata(Gspeed_z);
syms z;
Azspeed = A{1,1}(1)*z + A{1,1}(2);
Bzspeed = B{1,1}(1)*z + B{1,1}(2);
Bz0 = Bzspeed; 

%Set the order
sysOrdZ = size(A{1,1},2) - 1;
%PID discrete speed tuning
%Calculate the PID
[PID_Rsd, pdsd, Psd, Dsd, Isd, Nsd] = PID_calc_disc(Mpz,trz,tsz,essz,Gspeed_z, Azspeed, Bzspeed, sysOrdZ, Ts);

%Final system
figure;
RG = feedback(Gspeed_z*PID_Rsd,1);
subplot(1,2,1); rlocus(Gspeed_z*PID_Rsd);
subplot(1,2,2); step(RG);

%Get the num and den of the pos
[B,A] = tfdata(Gpos_z);
Azpos = A{1,1}(1)*z*z + A{1,1}(2)*z + A{1,1}(3);
Bzpos = B{1,1}(1)*z*z + B{1,1}(2)*z + B{1,1}(3);
%Set the order
sysOrdZ = size(A{1,1},2) - 1;
%PID discrete speed tuning
%Calculate the PID
[PID_Rpd, pdpd, Ppd, Dpd, Ipd, Npd] = PID_calc_disc(Mppz,trpz,tspz,esspz,Gpos_z, Azpos, Bzpos , sysOrdZ, Ts);

%Final system
figure;
RG = feedback(Gpos_z*PID_Rpd,1);
subplot(1,2,1); rlocus(Gpos_z*PID_Rpd);
subplot(1,2,2); step(RG);

%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Calculate the PID
[PID_R, pd, P, D, I, N] = PID_calc(Mp,tr_max,-1,ess,Gzpk, Ain, Bin, sysOrd);

% %Final system
figure;
RG = feedback(Gzpk*PID_R,1);
subplot(1,2,1); rlocus(Gzpk*PID_R);
subplot(1,2,2); step(RG);

