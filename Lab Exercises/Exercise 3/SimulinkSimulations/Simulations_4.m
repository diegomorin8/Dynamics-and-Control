% Simulink

L1 = 11.4E-3;
Pulses = (2*pi)/1000; % Pulses per rad
Psp_d = vpa(P);

%%%%% Change to discrete coeficients in PID controller
Psp = double(Psp_d);
Isp = double(Isp_d);
Dsp = double(Dsp_d);
Nsp = double(Nsp_d);

%Step response with and without controller
Sine_wave = 0; % 0 - Step input - 1 - Sine wave input
time = 2;
%Call the simulink model
sim('SimLab3_4')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
PositionL = PositionOutL.signals.values(:,2); %Controlled control signal
PositionFriction = PositionOutFriction.signals.values(:,2); %Controlled output
PositionLTime = PositionOutL.time;
PositionFrictionTime = PositionOutFriction.time;

figure
subplot(3,2,1)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
axis([0 time 0 20])
title('Control signal (voltage) - Step')
hold off

subplot(3,2,2)
stairs(PositionLTime, PositionL);
hold on 
stairs(PositionFrictionTime, PositionFriction);
legend('Position L','Position Friction');
axis([0 time 0 20])
title('Controlled state (Position) - Step')
hold off


%Sin wave response
Sine_wave = 1; % 0 - Step input - 1 - Sine wave input
Amplitude = 20;
Freq = 0.2;
time = 32;
%Call the simulink model
sim('SimLab3_4')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
PositionL = PositionOutL.signals.values(:,2); %Controlled control signal
PositionFriction = PositionOutFriction.signals.values(:,2); %Controlled output
PositionLTime = PositionOutL.time;
PositionFrictionTime = PositionOutFriction.time;

subplot(3,2,3)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
axis([0 time -20 20])
title('Control signal (voltage) - Sin 0.2')
hold off

subplot(3,2,4)
stairs(PositionLTime, PositionL);
hold on 
stairs(PositionFrictionTime, PositionFriction);
legend('Position L','Position Friction');
axis([0 time -20 20])
title('Controlled state (Position) - Sin 0.2')
hold off


%Sin wave response
Sine_wave = 1; % 0 - Step input - 1 - Sine wave input
Amplitude = 200;
Freq = 10;
time = 1;
%Call the simulink model
sim('SimLab3_4')

%Plots
VoltageL = VoltageOutL.signals.values(:,2); %Controlled control signal
VoltageFriction = VoltageOutFriction.signals.values(:,2); %Controlled output
VoltageLTime = VoltageOutL.time;
VoltageFrictionTime = VoltageOutFriction.time;
PositionL = PositionOutL.signals.values(:,2); %Controlled control signal
PositionFriction = PositionOutFriction.signals.values(:,2); %Controlled output
PositionLTime = PositionOutL.time;
PositionFrictionTime = PositionOutFriction.time;

subplot(3,2,5)
stairs(VoltageLTime, VoltageL);
hold on 
stairs(VoltageFrictionTime, VoltageFriction);
legend('Voltage L','Voltage Friction');
axis([0 time -400 400])
title('Control signal (voltage) - Sin 10')
hold off

subplot(3,2,6)
stairs(PositionLTime, PositionL);
hold on 
stairs(PositionFrictionTime, PositionFriction);
legend('Position L','Position Friction');
axis([0 time -200 200])
title('Controlled state (Position) - Sin 10')
hold off