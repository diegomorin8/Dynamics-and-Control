%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 1
clear all;
close all;

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

%%%%%%%% Current input
A1 = [0 1; 0 -dm/Jeq];
B1 = [0; Km/Jeq];
C1 = [1/n 0; 0 1/n];
D1 = [0; 0]; 

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);
Sys1 = ss(A1,B1,C1,D1);
G1 = tf(Sys1);


% Poles and zeros of the transfer functions
[z,p,k] = zpkdata(Sys);
z1 = z{1,1};
z2 = z{2,1};
p1 = p{1,1};
p2 = p{2,1};
g1 = k(1);
g2 = k(2);
figure
pzmap(G(1),G(2));
legend('Position','Speed');
title('Voltage input')
figure
pzmap(G1(1),G1(2));
legend('Position','Speed');
title('Current input')

% Step responses
figure
step(G(1),G(2));
legend('Position','Speed');
axis([0 0.1 0 0.015]);
title('Voltage input')
figure
step(G1(1),G1(2));
legend('Position','Speed');
axis([0 6 0 2E4]);
title('Current input')

% Frequency responses
figure
bode(G(1),G(2));
legend('Position','Speed');
title('Voltage input')
figure
bode(G1(1),G1(2));
legend('Position','Speed');
title('Current input')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMULINK MODEL %%%%%%%%%%%%%%%%%

sim('Sim_exercise2')

%Get the output values
PosOutBD = PositionOut2.signals.values;
SpOutBD = SpeedOut2.signals.values;
PosOutSS = OutSS.signals.values(:,1);
SpOutSS = OutSS.signals.values(:,2);

PosOutBD1 = PositionOut1.signals.values;
SpOutBD1 = SpeedOut1.signals.values;
PosOutSS1 = OutSS1.signals.values(:,1);
SpOutSS1 = OutSS1.signals.values(:,2);

%Get the sim time
PosTimeBD = PositionOut2.time;
SpTimeBD = SpeedOut2.time;
TimeSS = OutSS.time;

PosTimeBD1 = PositionOut1.time;
SpTimeBD1 = SpeedOut1.time;
TimeSS1 = OutSS1.time;

%Plot them
%Voltage
figure
subplot(2,1,1)
plot(PosTimeBD, PosOutBD);
hold on 
plot(SpTimeBD, SpOutBD);
legend('Position','Speed');
% axis([0 0.1 0 0.015])
title('Block diagram - Step voltage')
hold off

subplot(2,1,2)
plot(TimeSS, PosOutSS);
hold on 
plot(TimeSS, SpOutSS);
legend('Position','Speed');
% axis([0 0.1 0 0.015])
title('State space model - Step voltage')
hold off

%Current
figure
subplot(2,1,1)
plot(PosTimeBD1, PosOutBD1);
hold on 
plot(SpTimeBD1, SpOutBD1);
legend('Position','Speed');
% axis([0 6 0 2E4])
title('Block diagram - Step current')
hold off

subplot(2,1,2)
plot(TimeSS1, PosOutSS1);
hold on 
plot(TimeSS1, SpOutSS1);
legend('Position','Speed');
% axis([0 6 0 2E4])
title('State space model - Step current')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMSCAPE MODEL %%%%%%%%%%%%%%%%%

%Call the simscape model
sim('Simscape_exercise2')

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
% axis([0 0.1 0 0.015])
title('Simscape Model - Step')
hold off