%% Init

clear all;
close all;
clc;

%Symbolic expressions
syms s;

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

%%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];


%% PID paramters

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
Gspeed = G(2);
Gpos = G(1);

%Get denominators and numerator os the transfer functions
[num_pos,den_pos] = tfdata(Gpos);
[num_s,den_s] = tfdata(Gspeed);

%B/A format for PID tuning
Ain_pos = s*s*den_pos{1,1}(1) + s*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*s*s + num_pos{1,1}(2)*s + num_pos{1,1}(3);

Ain_speed = s*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = s*num_s{1,1}(1) + num_s{1,1}(2);

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
G_NR_speed = Speed_ref_step*feedback(Gspeed,1);

%Get main parameters of step response
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 100;

%Calculate the controler
[P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,sysOrd);

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Output format
if Dsp == 0 && Isp == 0
    P_speed = double(P_speed);
end

% Sensor simulation
Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');


G_NR_speed_disc = feedback(Gspeed_disc,1)
G_P_speed_disc = feedback(Gspeed_disc*P_speed,1)
figure;
rlocus(G_P_speed_disc);

figure;
step(G_NR_speed_disc);
hold on;
step(G_P_speed_disc);
hold off;


%Simulate in simulink

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')

%% Speed PI to discrete

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
G_NR_speed = Speed_ref_step*feedback(Gspeed,1);

%Get main parameters of step response
S1 = stepinfo(G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
ess = 0;

%Calculate the controler
[P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,sysOrd);

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Output format
if Dsp == 0 && Isp == 0
    P_speed = double(P_speed);
end

% Sensor simulation
Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

Gspeed_disc = c2d(Gspeed,Ts,'zoh');
P_speed_disc = c2d(P_speed,Ts,'tustin');

G_NR_speed_disc = feedback(Gspeed_disc,1);
G_PI_speed_disc = feedback(Gspeed_disc*P_speed_disc,1);
figure;
rlocus(G_PI_speed_disc);

figure;
step(G_NR_speed_disc);
hold on;
step(G_PI_speed_disc);
hold off;


%Simulate in simulink

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')


