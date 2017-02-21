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

Gspeed = G(2);
Gpos = G(1);

[num_pos,den_pos] = tfdata(Gpos);
[num_s,den_s] = tfdata(Gspeed);

Ain_pos = s*s*den_pos{1,1}(1) + s*den_pos{1,1}(2) + den_pos{1,1}(3);
Bin_pos = num_pos{1,1}(1)*s*s + num_pos{1,1}(2)*s + num_pos{1,1}(3);

Ain_speed = s*den_s{1,1}(1) + den_s{1,1}(2);
Bin_speed = s*num_s{1,1}(1) + num_s{1,1}(2);



%Speed Proportional
%Change the format of the transfer function
[Zeros,Poles,Gain] = zpkdata(Gspeed);
Gzpk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

step_size = 20; %rad/s
relative_ts = 0.9;

G_NR_speed = feedback(Gspeed,1);

S1 = stepinfo(step_size*G_NR_speed);
tr_speed = S1.RiseTime;
Mp_speed = S1.Overshoot;
ts_speed = S1.SettlingTime;
rlocus(Gspeed)

[P_speed, PD, P, D, I, N] = PID_calc(Mp_speed,-1,ts_speed*relative_ts,100,Gspeed,Ain_speed,Bin_speed,sysOrd);

Psp = double(P);
Dsp = double(D);
Isp = double(I);
Nsp = double(N);

GP_speed = double(P_speed)*Gspeed;
G_P_speed = feedback(double(P_speed)*Gspeed,1);

S2 = stepinfo(step_size*G_P_speed);
tr_speed = S2.RiseTime;
Mp_speed = S2.Overshoot;
ts_speed = S2.SettlingTime;

figure;
step(step_size*G_P_speed)
hold on
step(step_size*G_NR_speed)
legend('show')
hold off

figure;
bode(GP_speed);

Speed_ref_step = 20;
%Sin wave ref
Freq = 0.2;
Amplitude = 20;
sim('SimLab3')




