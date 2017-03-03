% Simulink

L1 = 11.4E-3;
Pulses = (2*pi)/1000; % Pulses per rad

%Step response with and without controller
Sine_wave = 0; % 0 - Step input - 1 - Sine wave input
time = 2;
Amplitude = 20;
Freq = 0.2;
%Call the simulink model
sim('SimLab3_2_discretization')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
SpeedL = SpeedOutL.signals.values(:,2); %Controlled control signal
SpeedFriction = SpeedOutFriction.signals.values(:,2); %Controlled output
SpeedLTime = SpeedOutL.time;
SpeedFrictionTime = SpeedOutFriction.time;

figure
subplot(3,2,1)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
% axis([0 time 0 20])
title('Control signal (voltage) - Step')
hold off

subplot(3,2,2)
stairs(SpeedLTime, SpeedL);
hold on 
stairs(SpeedFrictionTime, SpeedFriction);
legend('Speed L','Speed Friction');
% axis([0 time 0 20])
title('Controlled state (speed) - Step')
hold off


%Sin wave response
Sine_wave = 1; % 0 - Step input - 1 - Sine wave input
Amplitude = 20;
Freq = 0.2;
time = 32;
%Call the simulink model
sim('SimLab3_2_discretization')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
SpeedL = SpeedOutL.signals.values(:,2); %Controlled control signal
SpeedFriction = SpeedOutFriction.signals.values(:,2); %Controlled output
SpeedLTime = SpeedOutL.time;
SpeedFrictionTime = SpeedOutFriction.time;

subplot(3,2,3)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
% axis([0 time -20 20])
title('Control signal (voltage) - Sin 0.2')
hold off

subplot(3,2,4)
stairs(SpeedLTime, SpeedL);
hold on 
stairs(SpeedFrictionTime, SpeedFriction);
t = 0:0.01:time;
u = Amplitude*sin(Freq*t);
stairs(t,u);
legend('Speed L','Speed Friction','Signal ref');
% axis([0 time -20 20])
title('Controlled state (speed) - Sin 0.2')
hold off


%Sin wave response
Sine_wave = 1; % 0 - Step input - 1 - Sine wave input
Amplitude = 20;
Freq = 10;
time = 1;
%Call the simulink model
sim('SimLab3_2_discretization')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
SpeedL = SpeedOutL.signals.values(:,2); %Controlled control signal
SpeedFriction = SpeedOutFriction.signals.values(:,2); %Controlled output
SpeedLTime = SpeedOutL.time;
SpeedFrictionTime = SpeedOutFriction.time;

subplot(3,2,5)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
% axis([0 time -200 200])
title('Control signal (voltage) - Sin 10')
hold off

subplot(3,2,6)
stairs(SpeedLTime, SpeedL);
hold on 
stairs(SpeedFrictionTime, SpeedFriction);
t = 0:0.01:time;
u = Amplitude*sin(Freq*t);
stairs(t,u);
legend('Speed L','Speed Friction','Signal ref');
% axis([0 time -200 200])
title('Controlled state (speed) - Sin 10')
hold off