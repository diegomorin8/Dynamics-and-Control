clear all;
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

Ts = 0.25e-1;                                       % See step response (2-1.6
Pulses = (2*pi)/1000;                               % Pulses per rad


eps_Jeq = 0.6;                                      % Scaling factor for inertia
eps_dm = 3.56;                                      % scaling blabals

Jeq = eps_Jeq*Jeq;
dm = dm*eps_dm;

Fc = 0.0013;
dv = 1e-2;

%%%%%%%%% Voltage input Model
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];


Sys = ss(A,B,C,D);                              % State space model
G = tf(Sys);


Gspeed = G(2);                                  % Velocity tf
Gpos = G(1);                                    % Position tf

%Get denominators and numerator os the transfer functions
%so that we get the equations of A and B that will be used for pole
%placement
[num_pos,den_pos] = tfdata(Gpos);
[num_s,den_s] = tfdata(Gspeed);

% B/A format for PID tuning for the position and B(0)
Ain_pos = s*s*den_pos{1,1}(1) + s*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*s*s + num_pos{1,1}(2)*s + num_pos{1,1}(3);
B0_pos = num_pos{1,1}(3);

% B/A format for PID tuning for the position and B(0)
Ain_speed = s*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = s*num_s{1,1}(1) + num_s{1,1}(2);
B0_speed = num_s{1,1}(2);


%%PID%%
%pos Proportional
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 4; %rad/s

%For the first exercise, choose how much should the pos be decreased
relative_ts = 0.01;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_pos);
tr_pos = S1.RiseTime;
Mp_pos = 0.1;
ts_pos = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 0;
subplot(2,3,1)
% rlocus(Gpos); title('Root locus before the controller');


%Calculate the controler
[FF_PID_pos,FB_PID_pos, PD, P, D, I, N] = PID_calc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd);

%Set the parameters that will be used in simulink
Ppos = double(P);
Dpos = double(D);
Ipos = double(I);
Npos = double(N);


%Parmas max
Max_torque = 29.9e-3;
Max_Accel = Max_torque/Jeq;
Max_Speed = 24/Kemf;

trising = Max_Speed/Max_Accel;

time_in = [0,trising,trising,trising*2,trising*2];
values = [Max_Accel,Max_Accel,-Max_Accel,-Max_Accel, 0];


% sim('WorkshopB_1');

