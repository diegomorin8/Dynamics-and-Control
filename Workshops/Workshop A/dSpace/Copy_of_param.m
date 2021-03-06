%%              Please add usage commentary
%
syms s;

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
eps_Jeq = 1; % Scaling factor for inertia
eps_dm = 1; % scaling blabals

%Position PID Paramters
Pz_pos = 1; 
Iz_pos = 0; 
Dz_pos = 0; 
Nz_pos = 0; 
%Velocity
Pz_Vel = 1; 
Iz_Vel = 0; 
Dz_Vel = 0; 
Nz_Vel = 0; 


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
Bin = Km/(R*Jeq);
Bin0 = Km/(R*Jeq);
% Ain = s*(s + 4.5);
% Bin = 36;
% Bin0 = 36;

sysOrd = 2;
% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);
Gspeed = G(2);
Gspos = G(1);
% Gspeed_z = c2d(Gspeed,Ts,'zoh');
% [B,A] = tfdata(Gspeed_z);
% syms z;
% Az = A{1,1}(1)*z + A{1,1}(2);
% Bz = B{1,1}(1)*z + B{1,1}(2);

%Specifications PID continuous case
%tr = 0.03 +- 0.05
tr_max = 0.3 + 0.05;
tr_min = 0.3 - 0.05;
%Overshoot = 2%;
Mp = 0.02;
%Error = 0.5%
ess = 0.005;
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspos);
Gzpk = zpk(Zeros, Poles, Gain);
%Calculate the PID
[PID_T, PID_R, pd, P, D, I, N, t0, wn] = PID_calc(Mp,tr_max,-1,ess,Gzpk, Ain, Bin,Bin0, sysOrd);
% %Slides model
% ggr = tf([double((D*N+P)) double(N*P)],[1 double(N)])
% ggt = tf([t0 wn*t0],[1 double(N)])
%Final system
rlocus(PID_R*Gzpk);
RG = feedback(Gzpk*PID_R,1);
step(RG)
%The error is going to be always zero as the Kp = inf;
%We need a PD.
% 
% R = 14.1;

% L = 0;
% Km = 0.246;
% Kemf = Km;
% dm = 3.8E-6;
% Jm = 5.74/(1000*100^2);
% J1 = 1.8E-5;
% J2 = 1.8E-5;
% n = 5;
% Jeq = Jm + (J1+J2)/(n^2);
% Ts = 1e-2; %See step response (2-1.6
% eps_Jeq = 1; % Scaling factor for inertia
% eps_dm = 1; % scaling blabals
% 
