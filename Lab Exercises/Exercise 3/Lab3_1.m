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

%% Speed P

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
rlocus(Gspeed)

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

%Feedback the system with the controller
G_P_speed = Speed_ref_step*feedback(P_speed*Gspeed,1);
GP_speed = P_speed*Gspeed;

%Get the step response info
S2 = stepinfo(G_P_speed);
tr_speed = S2.RiseTime;
Mp_speed = S2.Overshoot;
ts_speed = S2.SettlingTime;

%Plot
figure;
step(G_P_speed)
hold on
step(G_NR_speed)
legend('show')
hold off

%Bode
figure;
bode(GP_speed);

%Simulate in simulink

% Sensor simulation
Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')

%% PI controller
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
rlocus(Gspeed)

%Calculate the controler
[P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,ess,Gspeed,Ain_speed,Bin_speed,sysOrd)

%Set the parameters that will be used in simulink
Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

%Output format
if Dsp == 0 && Isp == 0
    P_speed = double(P_speed);
end

%Feedback the system with the controller
G_P_speed = Speed_ref_step*feedback(P_speed*Gspeed,1);
GPI_speed = P_speed*Gspeed;

%We need the poles and zeros
[Poles_FB Zeros_FB Gain_FB] = zpkdata(G_PI_speed)
%Get the step response info
S2 = stepinfo(G_PI_speed);
tr_speed = S2.RiseTime;
Mp_speed = S2.Overshoot;
ts_speed = S2.SettlingTime;

%Plot
figure;
step(G_PI_speed)
hold on
step(G_NR_speed)
legend('show')
hold off

%Bode
figure;
bode(GP_speed);

%Simulate in simulink

% Sensor simulation
Ts = 2E-3; % Sampling time
Pulses = (2*pi)/1000; % Pulses per rad

%Input reference
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')








