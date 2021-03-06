%% Init
%Clean workspace
clear all;
close all;
clc;

%Symbolic expressions
syms s;

%Model parameters
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

%State space equations
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];


%% PID paramters

%PID_paramters set for simulink
%PID paramters - speed
Psp = 1;
Isp = 0;
Dsp = 0;
Nsp = 0;

%PID paramters - pos
Ppos = 1;
Ipos = 0;
Dpos = 0;
Npos = 0;

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);

%Rename
%Velocity tf
Gspeed = G(2);
%Position tf
Gpos = G(1);

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

%% Speed P to discrete

close all;
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
G_NR_speed = feedback(Gspeed,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 100;

%Calculate the controler
[FF_P_speed,FB_P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd);

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);


%% P Discretization for Ts = 0.02
Ts = 2E-2; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');

figure;
%Root locus before the controller
subplot(2,3,1)
rlocus(Gspeed_disc);
title('Root locus before the controller');

FB_P_speed_disc = c2d(FB_P_speed,Ts,'Tunstin');
FF_P_speed_disc = c2d(FF_P_speed,Ts,'Tunstin');

[FB_num, FB_den] = tfdata(FB_P_speed_disc);

G_NR_speed_disc = feedback(Gspeed_disc,1);
G_P_speed_disc = FF_P_speed_disc*feedback(Gspeed_disc,FB_P_speed_disc);

%Root locus after
subplot(2,3,2)
rlocus(G_P_speed_disc);
title('Root locus after the controller');

%Step response
subplot(2,3,3)
step(Speed_ref_step*G_NR_speed_disc);
hold on;
step(Speed_ref_step*G_P_speed_disc);
hold off;
title('Step responses 20 rad/s as reference');


%Sin wave respones
subplot(2,3,4)
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_P_speed_disc,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_P_speed_disc,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Damping values
[Wn,Z,P] = damp(G_P_speed_disc);

Simulations_2
Simulations_2_disc

%% P Discretization for Ts = 0.002

Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');

figure;
%Root locus before the controller
subplot(2,3,1)
rlocus(Gspeed_disc);
title('Root locus before the controller');

FB_P_speed_disc = c2d(FB_P_speed,Ts,'Tunstin');
FF_P_speed_disc = c2d(FF_P_speed,Ts,'Tunstin');

[FB_num, FB_den] = tfdata(FB_P_speed_disc);

G_NR_speed_disc = feedback(Gspeed_disc,1);
G_P_speed_disc = FF_P_speed_disc*feedback(Gspeed_disc,FB_P_speed_disc);

%Root locus after
subplot(2,3,2)
rlocus(G_P_speed_disc);
title('Root locus after the controller');

%Step response
subplot(2,3,3)
step(Speed_ref_step*G_NR_speed_disc);
hold on;
step(Speed_ref_step*G_P_speed_disc);
hold off;
title('Step responses 20 rad/s as reference');


%Sin wave respones
subplot(2,3,4)
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_P_speed_disc,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_P_speed_disc,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Damping values
[Wn,Z,P] = damp(G_P_speed_disc);

Simulations_2
Simulations_2_disc
%% PI to discrete

close all;
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
G_NR_speed = feedback(Gspeed,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 0;

%Calculate the controler
[FF_PI_speed,FB_PI_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd);

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%% PI Discretization for Ts = 0.02

Ts = 2E-2; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');

figure;
%Root locus before the controller
subplot(2,3,1)
rlocus(Gspeed_disc);
title('Root locus before the controller');

FB_PI_speed_disc = c2d(FB_PI_speed,Ts,'Tunstin');
FF_PI_speed_disc = c2d(FF_PI_speed,Ts,'Tunstin');

[FB_num, FB_den] = tfdata(FB_PI_speed_disc);

G_NR_speed_disc = feedback(Gspeed_disc,1);
G_PI_speed_disc = FF_PI_speed_disc*feedback(Gspeed_disc,FB_PI_speed_disc);

%Root locus after
subplot(2,3,2)
rlocus(G_PI_speed_disc);
title('Root locus after the controller');

%Step response
subplot(2,3,3)
step(Speed_ref_step*G_NR_speed_disc);
hold on;
step(Speed_ref_step*G_PI_speed_disc);
hold off;
title('Step responses 20 rad/s as reference');


%Sin wave respones
subplot(2,3,4)
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_PI_speed_disc,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_PI_speed_disc,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_2
Simulations_2_disc
%% PI Discretization for Ts = 0.002

Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');

figure;
%Root locus before the controller
subplot(2,3,1)
rlocus(Gspeed_disc);
title('Root locus before the controller');

FB_PI_speed_disc = c2d(FB_PI_speed,Ts,'Tunstin');
FF_PI_speed_disc = c2d(FF_PI_speed,Ts,'Tunstin');

[FB_num, FB_den] = tfdata(FB_PI_speed_disc);

G_NR_speed_disc = feedback(Gspeed_disc,1);
G_PI_speed_disc = FF_PI_speed_disc*feedback(Gspeed_disc,FB_PI_speed_disc);

%Root locus after
subplot(2,3,2)
rlocus(G_PI_speed_disc);
title('Root locus after the controller');

%Step response
subplot(2,3,3)
step(Speed_ref_step*G_NR_speed_disc);
hold on;
step(Speed_ref_step*G_PI_speed_disc);
hold off;
title('Step responses 20 rad/s as reference');


%Sin wave respones
subplot(2,3,4)
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_PI_speed_disc,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_PI_speed_disc,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed_disc,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_2
Simulations_2_disc
