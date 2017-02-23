%% Init

clear all;
close all;
clc;

%Symbolic expressions
syms s z;

%Parameters
R = 112;
L = 0;
Kemf = 1/(137*2*pi/60);
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 5;
Jeq = Jm + (J1+J2)/(n^2);

%Sampling time
% Sensor simulation
Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

%%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];



%% PID paramters

%PID paramters - speed
Psp_d = 1;
Isp_d = 0;
Dsp_d = 0;
Nsp_d = 0;

%PID paramters - pos
Ppos_d = 1;
Ipos_d = 0;
Dpos_d = 0;
Npos_d = 0;

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

%B/A format for PID tuning
Ain_pos = z*z*den_pos{1,1}(1) + z*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*z*z + num_pos{1,1}(2)*z + num_pos{1,1}(3);

Ain_speed = z*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = z*num_s{1,1}(1) + num_s{1,1}(2);

%% Speed P to discrete
 
clc;
%Speed Proportional

%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspeed);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
Speed_ref_step = 20; %rad/s

%For the first exercise, choose how much should the speed be decreased
relative_ts = 0.9;

%Feedback the model without controller
G_NR_speed = Speed_ref_step*feedback(Gspeed,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 100;

%Calculate the controler
[P_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,sysOrd,Ts);

%Set the parameters that will be used in simulink
Psp_d = vpa(P);
Dsp_d = vpa(D);
Isp_d = vpa(I);
Nsp_d = vpa(N);

figure;
subplot(1,3,1)
rlocus(Gspeed);
title('Root locus before the controller');

G_NR_speed_disc = feedback(Gspeed,1);
G_P_speed_disc = feedback(Gspeed*P_speed,1);

subplot(1,3,2)
rlocus(Gspeed*P_speed);
title('Root locus after the controller');

subplot(1,3,3)
step(G_NR_speed_disc);
hold on;
step(G_P_speed_disc);
hold off;
title('Step responses');

%Damping values
[Wn,Z,P] = damp(G_P_speed_disc);

%Simulate in simulink
%Input reference
Freq = 0.2;
Amplitude = 20;
% sim('SimLab3')

%% Speed PI to discrete
 
clc;
%Speed Proportional

%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspeed);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
Speed_ref_step = 20; %rad/s

%For the first exercise, choose how much should the speed be decreased
relative_ts = 0.9;

%Feedback the model without controller
G_NR_speed = Speed_ref_step*feedback(Gspeed,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 0;

%Calculate the controler
[P_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,sysOrd,Ts);

%Set the parameters that will be used in simulink
Psp_d = vpa(P);
Dsp_d = vpa(D);
Isp_d = vpa(I);
Nsp_d = vpa(N);

figure;
subplot(1,3,1)
rlocus(Gspeed);
title('Root locus before the controller');

G_NR_speed_disc = feedback(Gspeed,1);
G_PI_speed_disc = feedback(Gspeed*P_speed,1);

subplot(1,3,2)
rlocus(Gspeed*P_speed);
title('Root locus after the controller');

subplot(1,3,3)
step(G_NR_speed_disc);
hold on;
step(G_PI_speed_disc);
hold off;
title('Step responses');

%Damping values
[Wn,Z,P] = damp(G_PI_speed_disc);

%Simulate in simulink
%Input reference
Freq = 0.2;
Amplitude = 20;
% sim('SimLab3')