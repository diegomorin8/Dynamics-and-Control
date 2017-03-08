clear all

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
Pulses = (2*pi)/1000; % Pulses per rad


eps_Jeq = 0.6; % Scaling factor for inertia
eps_dm = 3.56; % scaling blabals

Jeq = eps_Jeq*Jeq;
dm = dm*eps_dm;

Tc = 0.0013;
dv = 1e-2;

syms z s
%%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];
%% PDD paramters

%PDD paramters - speed
Psp_d = 1;
Isp_d = 0;
Dsp_d = 0;
Nsp_d = 0;

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

%B/A format for PDD tuning
Ain_pos = z*z*den_pos{1,1}(1) + z*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*z*z + num_pos{1,1}(2)*z + num_pos{1,1}(3);
B0_pos = num_pos{1,1}(1)*1 + num_pos{1,1}(2)*1 + num_pos{1,1}(3);

Ain_speed = z*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = z*num_s{1,1}(1) + num_s{1,1}(2);
B0_speed = 1*num_s{1,1}(1) + num_s{1,1}(2);


%% speed PID discrete controller
 
clc;
%Speed Proportional

%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspeed);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
speed_ref_step = 50; %rad/s

%For the first exercise, choose how much should the speed be decreased
relative_ts = 0.9;

%Feedback the model without controller
G_NR_speed = feedback(Gspeed,1);

%Feedback the model without controller
G_NR_speed_cont = feedback(Gspeed_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_speed_cont);
tr_speed = S1.RiseTime;
Mp_speed = 0.0;
ts_speed = S1.SettlingTime;
ess = 0;

subplot(2,3,1)
rlocus(Gspeed)
title('Root locus before the controller')

%Calculate the controler
[FF_P_speed, FB_P_speed, PD, P, D, I, N] = PID_calc_disc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,B0_speed,sysOrd,Ts);

[FB_num, FB_den] = tfdata(tf(FB_P_speed,1));
[FF_num, FF_den] = tfdata(tf(FF_P_speed,1));
%Set the parameters that will be used in simulink
Psp_d = vpa(P);
Dsp_d = vpa(D);
Isp_d = vpa(I);
Nsp_d = vpa(N);


%% Pos PID discrete controller
 
clc;
%Speed Proportional

%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gpos);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%Param choose
pos_ref_step = 20; %rad/s

%For the first exercise, choose how much should the speed be decreased
relative_ts = 0.9;

%Feedback the model without controller
G_NR_pos = feedback(Gpos,1);

%Feedback the model without controller
G_NR_pos_cont = feedback(Gpos_cont,1);
%Get main parameters of step response
S1 = stepinfo(G_NR_pos_cont);
tr_pos = S1.RiseTime;
Mp_pos = S1.Overshoot;
ts_pos = S1.SettlingTime;
ess = 100;

subplot(2,3,1)
rlocus(Gpos)
title('Root locus before the controller')

%Calculate the controler
[FF_P_pos, FB_P_pos, PD, P, D, I, N] = PID_calc_disc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd,Ts);

[FB_num, FB_den] = tfdata(tf(FB_P_pos,1));
[FF_num, FF_den] = tfdata(tf(FF_P_pos,1));
%Set the parameters that will be used in simulink
Ppos_d = vpa(P);
Dpos_d = vpa(D);
Ipos_d = vpa(I);
Npos_d = vpa(N);

%PID paramters - pos
Ppos = 1;
Ipos = 0;
Dpos = 0;
Npos = 0;

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

% %% Pos PID continuous controller
% 
% %PID_paramters set for simulink
% %PID paramters - pos
% Psp = 1;
% Isp = 0;
% Dsp = 0;
% Nsp = 0;
% 
% %PID paramters - pos
% Ppos = 1;
% Ipos = 0;
% Dpos = 0;
% Npos = 0;
% 
% % State space model
% Sys = ss(A,B,C,D);
% G = tf(Sys);
% 
% %Rename
% %Velocity tf
% Gspeed = G(2);
% %Position tf
% Gpos = G(1);
% 
% %Get denominators and numerator os the transfer functions
% %so that we get the equations of A and B that will be used for pole
% %placement
% [num_pos,den_pos] = tfdata(Gpos);
% [num_s,den_s] = tfdata(Gspeed);
% 
% % B/A format for PID tuning for the position and B(0)
% Ain_pos = s*s*den_pos{1,1}(1) + s*den_pos{1,1}(2) + den_pos{1,1}(3);
% Bin_pos = num_pos{1,1}(1)*s*s + num_pos{1,1}(2)*s + num_pos{1,1}(3);
% B0_pos = num_pos{1,1}(3);
% 
% % B/A format for PID tuning for the position and B(0)
% Ain_speed = s*den_s{1,1}(1) + den_s{1,1}(2);
% Bin_speed = s*num_s{1,1}(1) + num_s{1,1}(2);
% B0_speed = num_s{1,1}(2);
% 
% clc;
% 
% %pos Proportional
% %Change the format of the transfer function
% [Zeros,Poles,Gain] = zpkdata(Gpos);
% Gzpk = zpk(Zeros, Poles, Gain);
% sysOrd = size(Poles{1,1},1);
% 
% %Param choose
% pos_ref_step = 20; %rad/s
% 
% %For the first exercise, choose how much should the pos be decreased
% relative_ts = 0.9;
% 
% %Feedback the model without controller
% G_NR_pos = feedback(Gpos,1);
% 
% %Get main parameters of step response of the system without controller
% S1 = stepinfo(G_NR_pos);
% tr_pos = S1.RiseTime;
% Mp_pos = 0.00;
% ts_pos = S1.SettlingTime;
% 
% %steady state error allowed. We want a proportional controller so we set a
% %really high value
% ess = 100;
% subplot(2,3,1)
% rlocus(Gpos)
% title('Root locus before the controller')
% 
% %Calculate the controler
% [FF_P_pos,FB_P_pos, PD, P, D, I, N] = PID_calc(Mp_pos,-1,ts_pos*relative_ts,ess,Gpos,Ain_pos,Bin_pos,B0_pos,sysOrd);
% 
% %Set the parameters that will be used in simulink
% Psp = double(P);
% Dsp = double(D);
% Isp = double(I);
% Nsp = double(N);

