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

%% Speed P controller

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
subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_P_speed,FB_P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd);

[Num_FF,Den_FF] = tfdata(FF_P_speed);
%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Feedback the system with the controller
G_P_speed = FF_P_speed*feedback(Gspeed,FB_P_speed);


%Get the step response info
SP = stepinfo(G_P_speed);

%Plot
%Rlocus after the controller
subplot(2,3,2)
rlocus(G_P_speed);
title('Root locus after the controller');

%Step response with and without controller
subplot(2,3,3)
Step_with_controller = Speed_ref_step*G_P_speed;
step(Step_with_controller)
hold on
Step_without_controller = Speed_ref_step*G_NR_speed;
step(Step_without_controller)
legend('show')
title('Step response');
hold off

%Sin wave respones
subplot(2,3,4)
t = 0:0.01:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_P_speed,u,t)
hold on
t = 0:0.01:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:0.01:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_P_speed,u,t)
hold on
t = 0:0.01:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_1
%% Speed PI controller

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
subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_PI_speed,FB_PI_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd);

[Num_FF,Den_FF] = tfdata(FF_PI_speed);
%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Feedback the system with the controller
G_PI_speed = FF_P_speed*feedback(Gspeed,FB_P_speed);

%Get the step response info
SP = stepinfo(G_PI_speed);

%Plot
%Rlocus after the controller
subplot(2,3,2)
rlocus(G_PI_speed);
title('Root locus after the controller');

%Step response with and without controller
subplot(2,3,3)
Step_with_controller = Speed_ref_step*G_PI_speed;
step(Step_with_controller)
hold on
Step_without_controller = Speed_ref_step*G_NR_speed;
step(Step_without_controller)
legend('show')
title('Step response');
hold off

%Sin wave respones
subplot(2,3,4)
t = 0:0.01:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:0.01:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:0.01:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:0.01:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_1

