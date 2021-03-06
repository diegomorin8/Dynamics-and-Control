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

%Rename
%Velocity tf
Gspeed_cont = G(2);
%Position tf
Gpos_cont = G(1);


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
B0_pos = num_pos{1,1}(1)*1 + num_pos{1,1}(2)*1 + num_pos{1,1}(3);

Ain_speed = z*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = z*num_s{1,1}(1) + num_s{1,1}(2);
B0_speed = 1*num_s{1,1}(1) + num_s{1,1}(2);

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
G_NR_speed = feedback(Gspeed,1);

%Feedback the model without controller
G_NR_speed_cont = feedback(Gspeed_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed_cont);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 100;

subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_P_speed, FB_P_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd,Ts);

%Set the parameters that will be used in simulink
Psp_d = vpa(P);
Dsp_d = vpa(D);
Isp_d = vpa(I);
Nsp_d = vpa(N);

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
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_P_speed,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_P_speed,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')
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
G_NR_speed = feedback(Gspeed,1);

%Feedback the model without controller
G_NR_speed_cont = feedback(Gspeed_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed_cont);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 0.000;

subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_PI_speed, FB_PI_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd,Ts);

%Feedback the system with the controller
G_PI_speed = FF_PI_speed*feedback(Gspeed,FB_PI_speed);

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
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Simulate in simulink
% Sensor simulation
Ts = 2E-2; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')
% sim('SimLab3')

%% Init Ts = 0.02

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
Ts = 2E-2; % Sampling time
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

%Rename
%Velocity tf
Gspeed_cont = G(2);
%Position tf
Gpos_cont = G(1);


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
B0_pos = num_pos{1,1}(1)*1 + num_pos{1,1}(2)*1 + num_pos{1,1}(3);

Ain_speed = z*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = z*num_s{1,1}(1) + num_s{1,1}(2);
B0_speed = 1*num_s{1,1}(1) + num_s{1,1}(2);

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
G_NR_speed = feedback(Gspeed,1);

%Feedback the model without controller
G_NR_speed_cont = feedback(Gspeed_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed_cont);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 100;

subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_P_speed, FB_P_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd,Ts);

%Set the parameters that will be used in simulink
Psp_d = vpa(P);
Dsp_d = vpa(D);
Isp_d = vpa(I);
Nsp_d = vpa(N);

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
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_P_speed,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_P_speed,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')
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
G_NR_speed = feedback(Gspeed,1);

%Feedback the model without controller
G_NR_speed_cont = feedback(Gspeed_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed_cont);
tr_speed = S1.RiseTime;
Mp_speed = 0;
ts_speed = S1.SettlingTime;
ess = 0.000;

subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_PI_speed, FB_PI_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd,Ts);

%Feedback the system with the controller
G_PI_speed = FF_PI_speed*feedback(Gspeed,FB_PI_speed);

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
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:Ts:32;
u = Speed_ref_step*sin(0.2*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_PI_speed,u,t)
hold on
t = 0:Ts:1;
u = Speed_ref_step*10*sin(10*t);
lsim(G_NR_speed,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

%Simulate in simulink
% Sensor simulation
Ts = 2E-2; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')
% sim('SimLab3')