clear all 
close all
% 
% %Space state model
d = 0.5;    %dumping 
m = 0.1;    %mass
k = 8;      %spring

% w0 = sqrt(k/m);
% C = d/(2*sqrt(k*m));
% wd = sqrt(1-C^2)*w0;

%Declare the matrices
A = [ 0 1; -k/m -d/m];
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

%Obtain the natural and the damped resonance frequency
[Wn,zeta] = damp(G1);
wd1 = sqrt(1-zeta.^2).*Wn;
[Wn2,zeta2] = damp(G2);
wd2 = sqrt(1-zeta2.^2).*Wn2;

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
axis([0 5 -1 1])
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
sim('SimModel2')

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
axis([0 5 -1 1])
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
axis([0 5 -1 1])
title('State space - Step ')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(2)-2; 
%Call the simulink model
sim('SimModel2')
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
title(sprintf('Simulink - Sin wave f = %d rad/s',Wn2(2)-2))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(2); 
%Call the simulink model
sim('SimModel2')
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
title(sprintf('Simulink - Sin wave f = %d rad/s',Wn2(2)))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(2)+2; 
%Call the simulink model
sim('SimModel2')
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
title(sprintf('Simulink - Sin wave f = %d rad/s',Wn2(2)+2))
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
sim('SimscapeModel2')

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
axis([0 5 -1 1])
title('Simscape Model - Step')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(2)-2; 
%Call the simulink model
sim('SimscapeModel2')

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
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn2(2)-2))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(1); 
%Call the simulink model
sim('SimscapeModel2')

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
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn2(2)))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn2(1)+2; 
%Call the simulink model
sim('SimscapeModel2')

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
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn2(2)+2))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')
