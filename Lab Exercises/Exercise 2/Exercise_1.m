%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 1
clear all;
close all;

R = 112;
L = 11.4E-3;
Kemf = 137*2*pi/60;
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 5;
Jeq = Jm + (J1+J2)/(n^2);

A = [-R/L 0 -Kemf/L; 0 0 1; Km/Jeq 0 -dm/Jeq];
B = [1/L; 0; 0];
C = [0 1/n 0; 0 0 1/n];
D = [0; 0];

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);

% Poles and zeros of the transfer functions
[z,p,k] = zpkdata(Sys);
z1 = z{1,1};
z2 = z{2,1};
p1 = p{1,1};
p2 = p{2,1};
g1 = k(1);
g2 = k(2);
pzmap(G(1),G(2));
legend('Position','Speed');
figure;

% Step responses
step(G(1),G(2));
legend('Position','Speed');
axis([0 0.1 0 0.015]);
figure

% Frequency responses
bode(G(1),G(2));
legend('Position','Speed');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMULINK MODEL %%%%%%%%%%%%%%%%%

sim('Sim_exercise1')

%Get the output values
PosOutBD = PositionOut2.signals.values;
SpOutBD = SpeedOut2.signals.values;
PosOutSS = OutSS.signals.values(:,1);
SpOutSS = OutSS.signals.values(:,2);

%Get the sim time
PosTimeBD = PositionOut2.time;
SpTimeBD = SpeedOut2.time;
TimeSS = OutSS.time;

%Plot them 
figure
subplot(2,1,1)
plot(PosTimeBD, PosOutBD);
hold on 
plot(SpTimeBD, SpOutBD);
legend('Position','Speed');
axis([0 0.1 0 0.015])
title('Block diagram - Step')
hold off

subplot(2,1,2)
plot(TimeSS, PosOutSS);
hold on 
plot(TimeSS, SpOutSS);
legend('Position','Speed');
axis([0 0.1 0 0.015])
title('State space model - Step')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMSCAPE MODEL %%%%%%%%%%%%%%%%%

%Call the simscape model
sim('Simscape_exercise1')

%Get the output values
ScapePos = ScapePos2.signals.values;
ScapeSpeed = ScapeSpeed2.signals.values;

%Get the sim time
ScapePosT = ScapePos2.time;
ScapeSpeedT = ScapeSpeed2.time;

%Plot them 
figure
plot(ScapePosT, ScapePos);
hold on 
plot(ScapeSpeedT, ScapeSpeed);
legend('Position','Speed');
axis([0 0.1 0 0.015])
title('Simscape Model - Step')
hold off