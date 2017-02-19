clear all 
close all
% 
% %Space state model
d = 0.5;    %damping 
m = 0.1;    %mass
k = 8;      %spring

% w0 = sqrt(k/m);
% C = d/(2*sqrt(k*m));
% wd = sqrt(1-C^2)*w0;

%Declare the matrices
A1 = [ 0 1; -k/m -d/m];
B1 = [0 ; k/m];
C1 = [1 0]; %Speed of node 2
D1 = 0;

A2 = [ 0 1; 0 -d/m];
B2 = [0 ; 1/m];
C2 = [0 1]; %Speed of node 2
D2 = 0;

%System model
Syst_1 = ss( A1,B1,C1,D1);
Syst_2 = ss( A2,B2,C2,D2);
Syst_3 = 1/k*tf([1 d/m k/m],[1 d/m]);

%Compute the Tf
G1 = tf(Syst_1);
G2 = tf(Syst_2);
G3 = tf(Syst_3);

%Obtain the natural and the damped resonance frequency
[Wn,zeta] = damp(G1);
wd1 = sqrt(1-zeta.^2).*Wn;
[Wn2,zeta2] = damp(G2);
wd2 = sqrt(1-zeta2.^2).*Wn2;
[Wn3,zeta3] = damp(G3);
wd3 = sqrt(1-zeta3.^2).*Wn3;

%Get the den and num
[G1num, G1den] = tfdata(G1);
[G2num, G2den] = tfdata(G2);
[G3num, G3den] = tfdata(G3);

figure
subplot(2,2,[1,2])
%Bode diagram
bode(G1,'r',G2,'g',G3,'b')
legend('Speed2 - Speed1','Speed2 - Force','Speed1 - Force');
title('Bode diagram - Matlab')

%poles-zeros map
subplot(2,2,3)
pzmap(G1,G2,G3)
legend('Speed2 - Speed1','Speed2 - Force','Speed1 - Force');
title('Zero pole map')

%step response
subplot(2,2,4)
step(G1,G2) %Cannot simulate the time response of models with more zeros than poles
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -1 3])
title('Step response')
 
%DC gain 
G1_gain = dcgain(G1);
G2_gain = dcgain(G2);
G3_gain = dcgain(G3);

%Time constant
S1 = stepinfo(G1,'RiseTimeLimits',[0.00,0.632]);
S2 = stepinfo(G2,'RiseTimeLimits',[0.00,0.632]);
%S3 = stepinfo(G3,'RiseTimeLimits',[0.00,0.632]);
time_constant1 = S1.RiseTime;
time_constant2 = S2.RiseTime;
%time_constant3 = S3.RiseTime;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%SIMULINK MODEL%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimModel3')

%Get the output values
SpOutTF1 = SpeedOutTF1.signals.values;
SpOutTF2 = SpeedOutTF2.signals.values;

%Get the sim time
SpTimeTF1 = SpeedOutTF1.time;
SpTimeTF2 = SpeedOutTF2.time;

%Plot them 
figure
subplot(2,1,1)
plot(SpTimeTF1, SpOutTF1);
hold on 
plot(SpTimeTF2, SpOutTF2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -1 3])
title('Transfer funtion block - Step')
hold off

%Get the output values
SpOutSS1 = SpeedOutSS1.signals.values;
SpOutSS2 = SpeedOutSS2.signals.values;

%Get the sim time
SpTimeSS1 = SpeedOutSS1.time;
SpTimeSS2 = SpeedOutSS2.time;

%Plot them 
subplot(2,1,2)
plot(SpTimeSS1, SpOutSS1);
hold on 
plot(SpTimeSS2, SpOutSS2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -1 3])
title('State space - Step ')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(2)-2; 
%Call the simulink model
sim('SimModel3')

%Get the output values
SpOutTF1 = SpeedOutTF1.signals.values;
SpOutTF2 = SpeedOutTF2.signals.values;

%Get the sim time
SpTimeTF1 = SpeedOutTF1.time;
SpTimeTF2 = SpeedOutTF2.time;

%Plot them 
figure
subplot(2,1,1)
plot(SpTimeTF1, SpOutTF1);
hold on 
plot(SpTimeTF2, SpOutTF2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('Transfer funtion block - Sin wave f = %d rad/s',Wn(2)-2))
hold off

%Get the output values
SpOutSS1 = SpeedOutSS1.signals.values;
SpOutSS2 = SpeedOutSS2.signals.values;

%Get the sim time
SpTimeSS1 = SpeedOutSS1.time;
SpTimeSS2 = SpeedOutSS2.time;

%Plot them 
subplot(2,1,2)
plot(SpTimeSS1, SpOutSS1);
hold on 
plot(SpTimeSS2, SpOutSS2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('State space - Sin wave f = %d rad/s',Wn(2)-2))
hold off

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(2); 
%Call the simulink model
sim('SimModel3')

%Get the output values
SpOutTF1 = SpeedOutTF1.signals.values;
SpOutTF2 = SpeedOutTF2.signals.values;

%Get the sim time
SpTimeTF1 = SpeedOutTF1.time;
SpTimeTF2 = SpeedOutTF2.time;

%Plot them 
figure
subplot(2,1,1)
plot(SpTimeTF1, SpOutTF1);
hold on 
plot(SpTimeTF2, SpOutTF2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('Transfer funtion block - Sin wave f = %d rad/s',Wn(2)))
hold off

%Get the output values
SpOutSS1 = SpeedOutSS1.signals.values;
SpOutSS2 = SpeedOutSS2.signals.values;

%Get the sim time
SpTimeSS1 = SpeedOutSS1.time;
SpTimeSS2 = SpeedOutSS2.time;

%Plot them 
subplot(2,1,2)
plot(SpTimeSS1, SpOutSS1);
hold on 
plot(SpTimeSS2, SpOutSS2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('State space - Sin wave f = %d rad/s',Wn(2)))
hold off

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(2)+2; 
%Call the simulink model
sim('SimModel3')

%Get the output values
SpOutTF1 = SpeedOutTF1.signals.values;
SpOutTF2 = SpeedOutTF2.signals.values;

%Get the sim time
SpTimeTF1 = SpeedOutTF1.time;
SpTimeTF2 = SpeedOutTF2.time;

%Plot them 
figure
subplot(2,1,1)
plot(SpTimeTF1, SpOutTF1);
hold on 
plot(SpTimeTF2, SpOutTF2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('Transfer funtion block - Sin wave f = %d rad/s',Wn(2)+2))
hold off

%Get the output values
SpOutSS1 = SpeedOutSS1.signals.values;
SpOutSS2 = SpeedOutSS2.signals.values;

%Get the sim time
SpTimeSS1 = SpeedOutSS1.time;
SpTimeSS2 = SpeedOutSS2.time;

%Plot them 
subplot(2,1,2)
plot(SpTimeSS1, SpOutSS1);
hold on 
plot(SpTimeSS2, SpOutSS2);
legend('Speed2 - Speed1','Speed2 - Force');
axis([0 5 -2 2])
title(sprintf('State space - Sin wave f = %d rad/s',Wn(2)+2))
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%SIMSCAPE MODEL%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Sine_wave = 0; % 0 - Step force input - 1 - Sine wave input
Freq = 1; 
%Call the simulink model
sim('SimscapeModel3')

%Get the output values
%ScapePos = ScapePos.signals.values;
ScapeSpeed1 = ScapeSpeed1.signals.values;
ScapeSpeed2 = ScapeSpeed2.signals.values;

%Get the sim time
ScapeSpeed1T = ScapeForce.time;
ScapeSpeed2T = ScapeForce.time;

%Plot them 
figure
plot(ScapeSpeed2T, ScapeForce.signals.values);
hold on 
plot(ScapeSpeed2T, ScapeSpeed2);
plot(ScapeSpeed1T, ScapeSpeed1);
legend('Force','Speed node 2', 'Speed node 1');
axis([0 5 -1 3])
title('Simscape Model - Step')
hold off


%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(2)-2; 
%Call the simulink model
sim('SimscapeModel3')

%Get the output values
ScapeSpeed1 = ScapeSpeed1.signals.values;
ScapeSpeed2 = ScapeSpeed2.signals.values;

%Get the sim time
ScapeSpeed1T = ScapeForce.time;
ScapeSpeed2T = ScapeForce.time;

%Plot them 
figure
subplot(2,1,1)
plot(ScapeSpeed2T, ScapeForce.signals.values);
hold on 
plot(ScapeSpeed2T, ScapeSpeed2);
plot(ScapeSpeed1T, ScapeSpeed1);
legend('Force','Speed node 2','Speed node 1');
axis([0 5 -2 2])
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn(2)-2))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(1); 
%Call the simulink model
sim('SimscapeModel3')

%Get the output values
ScapeSpeed1 = ScapeSpeed1.signals.values;
ScapeSpeed2 = ScapeSpeed2.signals.values;

%Get the sim time
ScapeSpeed1T = ScapeForce.time;
ScapeSpeed2T = ScapeForce.time;

%Plot them 
figure
subplot(2,1,1)
plot(ScapeSpeed2T, ScapeForce.signals.values);
hold on 
plot(ScapeSpeed2T, ScapeSpeed2);
plot(ScapeSpeed1T, ScapeSpeed1);
legend('Force','Speed node 2','Speed node 1');
axis([0 5 -2 2])
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn(2)))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')

%Sin wave
%Force selection
Sine_wave = 1; % 0 - Step force input - 1 - Sine wave input
Freq = Wn(1)+2; 
%Call the simulink model
sim('SimscapeModel3')

%Get the output values
ScapeSpeed1 = ScapeSpeed1.signals.values;
ScapeSpeed2 = ScapeSpeed2.signals.values;

%Get the sim time
ScapeSpeed1T = ScapeForce.time;
ScapeSpeed2T = ScapeForce.time;

%Plot them 
figure
subplot(2,1,1)
plot(ScapeSpeed2T, ScapeForce.signals.values);
hold on 
plot(ScapeSpeed2T, ScapeSpeed2);
plot(ScapeSpeed1T, ScapeSpeed1);
legend('Force','Speed node 2','Speed node 1');
axis([0 5 -2 2])
title(sprintf('Simscape - Sin wave f = %d rad/s',Wn(2)+2))
hold off
subplot(2,1,2)
bode(G2)
title('Bode of the speed')
