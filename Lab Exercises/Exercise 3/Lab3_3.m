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
%PID paramters - pos
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

%% Pos P controller

close all;
clc;

%pos Proportional
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 20; %rad/s

%For the first exercise, choose how much should the pos be decreased
relative_ts = 0.9;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_pos);
tr_pos = S1.RiseTime;
Mp_pos = 0.00;
ts_pos = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 100;
subplot(2,3,1)
rlocus(Gpos)
title('Root locus before the controller')

%Calculate the controler
[FF_P_pos,FB_P_pos, PD, P, D, I, N] = PID_calc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd);

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Feedback the system with the controller
G_P_pos = FF_P_pos*feedback(Gpos,FB_P_pos);

%As we just want a faster response we will use a Proportional controller
%with higher gain
P = 1.3;
G_P_pos = feedback(Gpos*P,1);
FF_P_pos = P;
FB_P_pos = P;
[Num_FF,Den_FF] = tfdata(tf(FF_P_pos,1));

%Get the step response info
SP = stepinfo(G_P_pos);

%Plot
%Rlocus after the controller
subplot(2,3,2)
rlocus(G_P_pos);
title('Root locus after the controller');

%Step response with and without controller
subplot(2,3,3)
Step_with_controller = pos_ref_step*G_P_pos;
step(Step_with_controller)
hold on
Step_without_controller = pos_ref_step*G_NR_pos;
step(Step_without_controller)
legend('show')
title('Step response');
hold off

%Sin wave respones
subplot(2,3,4)
t = 0:0.01:32;
u = pos_ref_step*sin(0.2*t);
lsim(G_P_pos,u,t)
hold on
t = 0:0.01:32;
u = pos_ref_step*sin(0.2*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:0.01:1;
u = pos_ref_step*10*sin(10*t);
lsim(G_P_pos,u,t)
hold on
t = 0:0.01:1;
u = pos_ref_step*10*sin(10*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_3

%% Pos PD controller

close all;
clc;

%pos Proportional
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 20; %rad/s

%For the first exercise, choose how much should the pos be decreased
relative_ts = 0.2;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_pos);
tr_pos = S1.RiseTime;
Mp_pos = 0.05;
ts_pos = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 100;
subplot(2,3,1)
rlocus(Gpos)
title('Root locus before the controller')

%Calculate the controler
[FF_PD_pos,FB_PD_pos, PD, P, D, I, N] = PID_calc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd);


[Num_FF,Den_FF] = tfdata(FF_PD_pos);
%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Feedback the system with the controller
G_PD_pos = FF_PD_pos*feedback(Gpos,FB_PD_pos);

%Get the step response info
SPD = stepinfo(G_PD_pos);

%Plot
%Rlocus after the controller
subplot(2,3,2)
rlocus(G_PD_pos);
title('Root locus after the controller');

%Step response with and without controller
subplot(2,3,3)
Step_with_controller = pos_ref_step*G_PD_pos;
step(Step_with_controller)
hold on
Step_without_controller = pos_ref_step*G_NR_pos;
step(Step_without_controller)
legend('show')
title('Step response');
hold off

%Sin wave respones
subplot(2,3,4)
t = 0:0.01:34;
u = pos_ref_step*sin(0.2*t);
lsim(G_PD_pos,u,t)
hold on
t = 0:0.01:34;
u = pos_ref_step*sin(0.2*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:0.01:2;
u = pos_ref_step*10*sin(10*t);
lsim(G_PD_pos,u,t)
hold on
t = 0:0.01:2;
u = pos_ref_step*10*sin(10*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_3

%% Pos PID controller

close all;
clc;

%pos Proportional
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 4; %rad/s

%For the first exercise, choose how much should the pos be decreased
relative_ts = 0.2;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Get main parameters of step response of the system without controller
S1 = stepinfo(G_NR_pos);
tr_pos = S1.RiseTime;
Mp_pos = 0.05;
ts_pos = S1.SettlingTime;

%steady state error allowed. We want a proportional controller so we set a
%really high value
ess = 0;
subplot(2,3,1)
rlocus(Gpos)
title('Root locus before the controller')

%Calculate the controler
[FF_PID_pos,FB_PID_pos, PD, P, D, I, N] = PID_calc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd);


[Num_FF,Den_FF] = tfdata(FF_PID_pos);
%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Feedback the system with the controller
G_PID_pos = FF_PID_pos*feedback(Gpos,FB_PID_pos);

%Get the step response info
SPID = stepinfo(G_PID_pos);

%Plot
%Rlocus after the controller
subplot(2,3,2)
rlocus(G_PID_pos);
title('Root locus after the controller');

%Step response with and without controller
subplot(2,3,3)
Step_with_controller = pos_ref_step*G_PID_pos;
step(Step_with_controller)
hold on
Step_without_controller = pos_ref_step*G_NR_pos;
step(Step_without_controller)
legend('show')
title('Step response');
hold off

%Sin wave respones
subplot(2,3,4)
t = 0:0.01:34;
u = pos_ref_step*sin(0.2*t);
lsim(G_PID_pos,u,t)
hold on
t = 0:0.01:34;
u = pos_ref_step*sin(0.2*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 20, freq: 0.2');
hold off

%Sin wave respones
subplot(2,3,5)
t = 0:0.01:2;
u = pos_ref_step*10*sin(10*t);
lsim(G_PID_pos,u,t)
hold on
t = 0:0.01:2;
u = pos_ref_step*10*sin(10*t);
lsim(G_NR_pos,u,t)
legend('show')
title('Sin response Amplitude: 200, freq: 10');
hold off

Simulations_3





