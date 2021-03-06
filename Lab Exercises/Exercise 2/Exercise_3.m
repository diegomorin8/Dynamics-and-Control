%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exercise 1
clear all;
close all;

R = 112;
L = 0;
Kemf = (137*2*pi/60)^-1;
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 5;
Tc = 1E-3;
Jeq = Jm + (J1+J2)/(n^2);

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
% 
% voltage = 10;
% %Sin wave
% %Force selection
% Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
% Freq = 1;
% Amplitude = 1;
% sim('Sim_exercise3')
% 
% %Get the output values
% PosOutBD = PositionOut.signals.values;
% SpOutBD = SpeedOut.signals.values;
% MotorTBD = MotorTorque.signals.values;
% FrictionTBD = FrictionTorque.signals.values;
% 
% %Get the sim time
% PosTimeBD = PositionOut.time;
% SpTimeBD = SpeedOut.time;
% MTTimeBD = MotorTorque.time;
% FTTimeBD = FrictionTorque.time;
% 
% %Plot them
% figure
% plot(PosTimeBD, PosOutBD);
% hold on 
% plot(SpTimeBD, SpOutBD);
% plot(MTTimeBD, MotorTBD);
% plot(FTTimeBD, FrictionTBD);
% legend('Position','Speed','Motor Torque','Friction Torque');
% % axis([0 0.1 0 0.015])
% title('Block diagram - Step 1V')
% hold off

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% voltage = 10;
% %Sin wave
% %Force selection
% Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
% Freq = 1;
% Amplitude = 1;
% sim('Sim_exercise3')
% 
% %Get the output values
% PosOutBD = PositionOut.signals.values;
% SpOutBD = SpeedOut.signals.values;
% MotorTBD = MotorTorque.signals.values;
% FrictionTBD = FrictionTorque.signals.values;
% 
% %Get the sim time
% PosTimeBD = PositionOut.time;
% SpTimeBD = SpeedOut.time;
% MTTimeBD = MotorTorque.time;
% FTTimeBD = FrictionTorque.time;
% 
% %Plot them
% figure
% plot(PosTimeBD, PosOutBD);
% hold on 
% plot(SpTimeBD, SpOutBD);
% plot(MTTimeBD, MotorTBD);
% plot(FTTimeBD, FrictionTBD);
% legend('Position','Speed','Motor Torque','Friction Torque');
% % axis([0 0.1 0 0.15])
% title('Block diagram - Step 10V')
% hold off
% 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
voltage = 10;
%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 2;
Amplitude = 2;
sim('Sim_exercise3')

%Get the output values
PosOutBD = PositionOut.signals.values;
SpOutBD = SpeedOut.signals.values;
MotorTBD = MotorTorque.signals.values;
FrictionTBD = FrictionTorque.signals.values;

%Get the sim time
PosTimeBD = PositionOut.time;
SpTimeBD = SpeedOut.time;
MTTimeBD = MotorTorque.time;
FTTimeBD = FrictionTorque.time;

%Plot them
figure
plot(PosTimeBD, PosOutBD);
hold on 
plot(SpTimeBD, SpOutBD);
legend('Position','Speed');
% axis([0 0.1 -0.015 0.015])
title('Block diagram - Sin 10V')
hold off

figure
plot(MTTimeBD, MotorTBD);
hold on
plot(FTTimeBD, FrictionTBD);
legend('Motor Torque','Friction Torque');
% axis([0 0.1 -0.015 0.015])
title('Block diagram - Sin 10V')
hold off


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%% SIMSCAPE MODEL %%%%%%%%%%%%%%%%%
% % 
% %Call the simscape model
% voltage = 0.3;
% %Sin wave
% %Force selection
% Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
% Freq = 1;
% Amplitude = 1;
% sim('Simscape_exercise3')
% 
% %Get the output values
% ScapePos = ScapePos2.signals.values;
% ScapeSpeed = ScapeSpeed2.signals.values;
% MotorTorq = MotorTorqueSc.signals.values;
% FrictionTorq = FrictionTorqueSc.signals.values;
% 
% %Get the sim time
% ScapePosT = ScapePos2.time;
% ScapeSpeedT = ScapeSpeed2.time;
% MotorT = MotorTorqueSc.time;
% FrictionT = FrictionTorqueSc.time;
% 
% %Plot them 
% figure
% plot(ScapePosT, ScapePos);
% hold on 
% plot(ScapeSpeedT, ScapeSpeed);
% plot(MotorT, MotorTorq);
% plot(FrictionT, FrictionTorq);
% %legend('Position','Speed');
% legend('Position','Speed','Motor torque','Friction Torque');
% % axis([0 2 0 45])
% title('Simscape Model - Step 1V')
% hold off
% % 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% %Call the simscape model
% voltage = 10;
% %Sin wave
% %Force selection
% Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
% Freq = 1;
% Amplitude = 1;
% sim('Simscape_exercise3')
% 
% %Get the output values
% ScapePos = ScapePos2.signals.values;
% ScapeSpeed = ScapeSpeed2.signals.values;
% MotorTorq = MotorTorqueSc.signals.values;
% FrictionTorq = FrictionTorqueSc.signals.values;
% 
% %Get the sim time
% ScapePosT = ScapePos2.time;
% ScapeSpeedT = ScapeSpeed2.time;
% MotorT = MotorTorqueSc.time;
% FrictionT = FrictionTorqueSc.time;
% 
% %Plot them 
% figure
% plot(ScapePosT, ScapePos);
% hold on 
% plot(ScapeSpeedT, ScapeSpeed);
% plot(MotorT, MotorTorq);
% plot(FrictionT, FrictionTorq);
% %legend('Position','Speed');
% legend('Position','Speed','Motor torque','Friction Torque');
% % axis([0 0.1 0 0.15])
% title('Simscape Model - Step 10V')
% hold off
% 
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 
% Call the simscape model
voltage = 1;
%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 2;
Amplitude = 2;
sim('Simscape_exercise3')

%Get the output values
ScapePos = ScapePos2.signals.values;
ScapeSpeed = ScapeSpeed2.signals.values;
MotorTorq = MotorTorqueSc.signals.values;
FrictionTorq = FrictionTorqueSc.signals.values;

%Get the sim time
ScapePosT = ScapePos2.time;
ScapeSpeedT = ScapeSpeed2.time;
MotorT = MotorTorqueSc.time;
FrictionT = FrictionTorqueSc.time;

%Plot them 
figure
plot(ScapePosT, ScapePos);
hold on 
plot(ScapeSpeedT, ScapeSpeed);
%legend('Position','Speed');
legend('Position','Speed');
% axis([0 0.1 -0.015 0.015])
title('Simscape Model - Sin 10V')
hold off

figure
plot(MotorT, MotorTorq);
hold on
plot(FrictionT, FrictionTorq);
legend('Motor torque','Friction Torque');
% axis([0 0.1 -0.015 0.015])
title('Simscape Model - Sin 10V')
hold off
