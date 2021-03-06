%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 1
clear all;
close all;

R = 112;
L = 0;
Kemf = 137*2*pi/60;
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 5;
Tc = 1E-3;
Jeq = Jm + (J1+J2)/(n^2);

% Sensor simulation
Ts = 100E-3; % Sampling time
Pulses = (2*pi)/512; % Pulses per rad

%%%%%%%%% Voltage input
A = [0 1; 0 -(dm/Jeq + Km*Kemf/(R*Jeq))];
B = [0; Km/(R*Jeq)];
C = [1/n 0; 0 1/n];
D = [0; 0];

% State space model
Sys = ss(A,B,C,D);
G = tf(Sys);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMULINK MODEL %%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMULINK MODEL %%%%%%%%%%%%%%%%%

voltage = 1;
Ts = 0.1;
Pulses = (2*pi)/512;
%Sin wave
%Force selection
Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
Freq = 1;
Amplitude = 1;
sim('Sim_exercise4')

SpOutBD = SpeedOut.signals.values;
SpTimeBD = SpeedOut.time;
SpOutBDDisc = SpeedOutDiscrete.signals.values;
SpTimeBDDisc = SpeedOutDiscrete.time;

%Plot them
figure
stairs(SpTimeBD, SpOutBD);
hold on
stairs(SpTimeBDDisc, SpOutBDDisc);
axis([0 0.1 0 0.015])
title('Quantization theoretical - Step 1V')
hold off


% 
% voltage = 1;
% 
% sim('Sim_exercise4')
% 
% %Get the output values
% PosOutBD = PositionOut.signals.values;
% SpOutBD = SpeedOut.signals.values;
% % PosOutSS = OutSS.signals.values(:,1);
% % SpOutSS = OutSS.signals.values(:,2);
% 
% %Get the sim time
% PosTimeBD = PositionOut.time;
% SpTimeBD = SpeedOut.time;
% % TimeSS = OutSS.time;
% 
% %Plot them
% figure
% % subplot(2,1,1)
% stairs(PosTimeBD, PosOutBD);
% hold on 
% stairs(SpTimeBD, SpOutBD);
% legend('Position','Speed');
% %axis([0 0.1 0 0.015])
% title('Block diagram - Step 1V')
% hold off
% 
% % subplot(2,1,2)
% % plot(TimeSS, PosOutSS);
% % hold on 
% % plot(TimeSS, SpOutSS);
% % legend('Position','Speed');
% % axis([0 0.1 0 0.015])
% % title('State space model - Step voltage')
% % hold off
% 
% voltage = 10;
% 
% sim('Sim_exercise4')
% 
% %Get the output values
% PosOutBD = PositionOut.signals.values;
% SpOutBD = SpeedOut.signals.values;
% % PosOutSS = OutSS.signals.values(:,1);
% % SpOutSS = OutSS.signals.values(:,2);
% 
% %Get the sim time
% PosTimeBD = PositionOut.time;
% SpTimeBD = SpeedOut.time;
% % TimeSS = OutSS.time;
% 
% %Plot them
% figure
% % subplot(2,1,1)
% stairs(PosTimeBD, PosOutBD);
% hold on 
% stairs(SpTimeBD, SpOutBD);
% legend('Position','Speed');
% % axis([0 0.1 0 0.015])
% title('Block diagram - Step 10V')
% hold off

% subplot(2,1,2)
% plot(TimeSS, PosOutSS);
% hold on 
% plot(TimeSS, SpOutSS);
% legend('Position','Speed');
% axis([0 0.1 0 0.015])
% title('State space model - Step voltage')
% hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMSCAPE MODEL %%%%%%%%%%%%%%%%%

% %Call the simscape model
% voltage = 1;
% sim('Simscape_exercise4')
% 
% %Get the output values
% ScapePos = ScapePos2.signals.values;
% ScapeSpeed = ScapeSpeed2.signals.values;
% MotorTorq = MotorTorque.signals.values;
% FrictionTorq = FrictionTorque.signals.values;
% 
% %Get the sim time
% ScapePosT = ScapePos2.time;
% ScapeSpeedT = ScapeSpeed2.time;
% MotorT = MotorTorque.time;
% FrictionT = FrictionTorque.time;
% 
% %Plot them 
% figure
% stairs(ScapePosT, ScapePos);
% hold on 
% stairs(ScapeSpeedT, ScapeSpeed);
% stairs(MotorT, MotorTorq);
% stairs(FrictionT, FrictionTorq);
% %legend('Position','Speed');
% legend('Position','Speed','Motor torque','Friction Torque');
% %axis([0 0.1 0 0.015])
% title('Simscape Model - Step 1V')
% hold off
% 
% voltage = 10;
% sim('Simscape_exercise4')
% 
% %Get the output values
% ScapePos = ScapePos2.signals.values;
% ScapeSpeed = ScapeSpeed2.signals.values;
% MotorTorq = MotorTorque.signals.values;
% FrictionTorq = FrictionTorque.signals.values;
% 
% %Get the sim time
% ScapePosT = ScapePos2.time;
% ScapeSpeedT = ScapeSpeed2.time;
% MotorT = MotorTorque.time;
% FrictionT = FrictionTorque.time;
% 
% %Plot them 
% figure
% stairs(ScapePosT, ScapePos);
% hold on 
% stairs(ScapeSpeedT, ScapeSpeed);
% stairs(MotorT, MotorTorq);
% stairs(FrictionT, FrictionTorq);
% %legend('Position','Speed');
% legend('Position','Speed','Motor torque','Friction Torque');
% %axis([0 0.1 0 0.14])
% title('Simscape Model - Step 10V')
% hold off