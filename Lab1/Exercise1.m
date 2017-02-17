clear all 
close all
% 
% %Space state model
d = 0.5;    %dumping 
m = 0.1;    %mass
%a
%Declare the matrices
A = [ 0 1; 0 -d/m];
B = [0 ; 1/m];
C1 = [ 1 0]; %Position
C2 = [0 1];
D = 0;

%System model
Syst_pos = ss( A,B,C1,D);
Syst_speed = ss( A,B,C2,D);

%Compute the Tf
G1 = tf(Syst_pos);
G2 = tf(Syst_speed);

%Get the den and num
[G1num, G1den] =  tfdata(G1);
[G2num, G2den] = tfdata(G2);

figure
subplot(2,2,[1,2])
%Bode diagram
bode(G1,'r',G2,'g')
legend('Position','Speed');
title('Bode diagram - Matlab')

%poles-zeros map
subplot(2,2,3)
pzmap(G1,G2)
legend('Position','Speed');
title('Zero pole map')

%step response
subplot(2,2,4)
step(G1,G2)
legend('Position','Speed');
axis([0 10 0 20])
title('Step response for position and speed')
 
%DC gain 
G1_gain = dcgain(G1);
G2_gain = dcgain(G2);

%Time constant
S1 = stepinfo(G1,'RiseTimeLimits',[0.00,0.632]);
S2 = stepinfo(G2,'RiseTimeLimits',[0.00,0.632]);
time_constant1 = S1.RiseTime;
time_constant2 = S2.RiseTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%SIMULINK MODEL%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimModel1')

%Get the output values
PosOutTF = PositionOutTF.signals.values;
SpOutTF = SpeedOutTF.signals.values;

%Get the sim time
PosTimeTF = PositionOutTF.time;
SpTimeTF = SpeedOutTF.time;

%Plot them 
figure
subplot(2,1,1)
plot(PosTimeTF, PosOutTF);
hold on 
plot(SpTimeTF, SpOutTF);
legend('Position','Speed');
axis([0 10 0 20])
title('Transfer funtion block - Step')
hold off

%Get the output values
PosOutSS = PositionOutSS.signals.values;
SpOutSS = SpeedOutSS.signals.values;

%Get the sim time
PosTimeSS = PositionOutSS.time;
SpTimeSS = SpeedOutSS.time;

%Plot them 
subplot(2,1,2)
plot(PosTimeSS, PosOutSS);
hold on 
plot(SpTimeSS, SpOutSS);
legend('Position','Speed');
axis([0 10 0 20])
title('State space - Step ')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimModel1')
%Get the output values
SpOutSS = SpeedOutSS.signals.values;

%Get the sim time
SpTimeSS = SpeedOutSS.time;

figure; 
%Plot them 
subplot(2,1,1)
plot(SpTimeSS, Force.signals.values);
hold on 
plot(SpTimeSS, SpOutSS);
legend('Force','Speed');
axis([0 10 -10 10])
title('Sin wave input freq - 1 rad/s')
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')
%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 10; 
%Call the simulink model
sim('SimModel1')
%Get the output values
SpOutSS = SpeedOutSS.signals.values;

%Get the sim time
SpTimeSS = SpeedOutSS.time;

figure; 
%Plot them 
subplot(2,1,1)
plot(SpTimeSS, Force.signals.values);
hold on 
plot(SpTimeSS, SpOutSS);
legend('Force','Speed');
axis([0 10 -10 10])
title('Sin wave input freq - 10 rad/s')
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%SIMSCAPE MODEL%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimscapeModel1')

%Get the output values
ScapePos = ScapePos.signals.values;
ScapeSpeed = ScapeSpeed.signals.values;

%Get the sim time
ScapePosT = ScapeForce.time;
ScapeSpeedT = ScapeForce.time;

%Plot them 
figure
plot(ScapePosT, ScapePos);
hold on 
plot(ScapeSpeedT, ScapeSpeed);
legend('Position','Speed');
axis([0 10 0 20])
title('Simscape Model - Step')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimscapeModel1')

%Get the output values
ScapeSpeed = ScapeSpeed.signals.values;

%Get the sim time
ScapeSpeedT = ScapeForce.time;

%Plot them 
figure
subplot(2,1,1)
plot(ScapeSpeedT, ScapeForce.signals.values);
hold on 
plot(ScapeSpeedT, ScapeSpeed);
legend('Force','Speed');
axis([0 10 -10 10])
title('Simscape - Sin wave f = 1 rad/s')
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = 10; 
%Call the simulink model
sim('SimscapeModel1')

%Get the output values
ScapeSpeed = ScapeSpeed.signals.values;

%Get the sim time
ScapeSpeedT = ScapeForce.time;

%Plot them 
figure
subplot(2,1,1)
plot(ScapeSpeedT, ScapeForce.signals.values);
hold on 
plot(ScapeSpeedT, ScapeSpeed);
legend('Force','Speed');
axis([0 10 -10 10])
title('Simscape - Sin wave f = 10 rad/s')
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')


