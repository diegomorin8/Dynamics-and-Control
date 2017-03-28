clear all;

syms s z;

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

Ts = 5e-3; %See step response (2-1.6
Pulses = (2*pi)/1000; % Pulses per rad


eps_Jeq = 0.6; % Scaling factor for inertia
eps_dm = 3.56; % scaling blabals

Jeq = eps_Jeq*Jeq;
dm = dm*eps_dm; 

Fc = 0.0013;
dv = 1e-2;

%%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);

%Discretization
G_dis = c2d(G,Ts,'zoh');

%Rename
Gspeed = G_dis(2);
Gpos = G_dis(1);

%Get denominators and numerator os the transfer functions
[num_pos,den_pos] = tfdata(Gpos);
[num_s,den_s] = tfdata(Gspeed);

%B/A format for PDD tuning
Ain_pos = z*z*den_pos{1,1}(1) + z*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*z*z + num_pos{1,1}(2)*z + num_pos{1,1}(3);
B0_pos = num_pos{1,1}(1)*1 + num_pos{1,1}(2)*1 + num_pos{1,1}(3);

Ain_speed = z*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = z*num_s{1,1}(1) + num_s{1,1}(2);
B0_speed = 1*num_s{1,1}(1) + num_s{1,1}(2);



%%PID%%
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 4; %rad/s

%For the first exercise, choose how much should the pos be decreased
relative_ts = 0.05;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_pos);
tr_pos = S1.RiseTime;
Mp_pos = 0.000001;
ts_pos = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 0;

%Calculate the controler
[FF_PID_pos,FB_PID_pos, PD, P, D, I, N] = PID_calc_disc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd, Ts);

%Set the parameters that will be used in simulink
Ppos = double(P);
Dpos = double(D);
Ipos = double(I);
Npos = double(N);

MaxCurrent = 0.182*0.8;
MaxVoltage = 24*0.8;
%Parmas max
Max_Speed = MaxVoltage/Kemf;
Max_Accel = Km*MaxCurrent/Jeq;
trising = Max_Speed/Max_Accel;

%%Signal builder
%%For 10 rad - 0.35 secs
trising = 0.5;
Max_Speed_ = 10/(trising);
% if Max_Speed_ >= Max_Speed
    Max_Speed_ = 10/(2*trising);
    Max_Accel_ = Max_Speed_/trising;
    time_in_1035 = [0,trising,trising,trising*2,trising*2,trising*3,trising*3];
    values_1035 = [Max_Accel_,Max_Accel_,0,0,-Max_Accel_,-Max_Accel_, 0];
% else
%     Max_Accel_ = Max_Speed_/trising;
%     time_in_1035 = [0,trising,trising,trising*2,trising*2];
%     values_1035 = [Max_Accel_,Max_Accel_,-Max_Accel_,-Max_Accel_, 0];
% end

%%For 100 rad - 35 secs
Max_Speed_ = 100/(trising);
% if Max_Speed_ >= Max_Speed
    Max_Speed_ = 100/(2*trising);
    Max_Accel_ = Max_Speed_/trising;
    time_in_10035 = [0,trising,trising,trising*2,trising*2,trising*3,trising*3];
    values_10035 = [Max_Accel_,Max_Accel_,0,0,-Max_Accel_,-Max_Accel_, 0];
% else
%     Max_Accel_ = Max_Speed_/trising;
%     time_in_10035 = [0,trising,trising,trising*2,trising*2];
%     values_10035 = [Max_Accel_,Max_Accel_,-Max_Accel_,-Max_Accel_, 0];
% end
%%Simulink
sim('WorkshopB_1');
