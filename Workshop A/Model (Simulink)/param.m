R = 112;
L = 0;
Kemf = 1/(137*2*pi/60);
Km = 69.7E-3;
dm = 3.8E-6;
Jm = 7.46/(1000*100^2);
J1 = 1.8E-5;
J2 = 1.8E-5;
n = 1;
Jeq = Jm + (J1+J2)/(n^2);
Ts = 1e-2; %See step response (2-1.6
eps_Jeq = 0.6; % Scaling factor for inertia
eps_dm = 3.56; % scaling blabals

Tc = 0.0013;
dv = 1e-2;
% 
% R = 14.1;
% L = 0;
% Km = 0.246;
% Kemf = Km;
% dm = 3.8E-6;
% Jm = 5.74/(1000*100^2);
% J1 = 1.8E-5;
% J2 = 1.8E-5;
% n = 5;
% Jeq = Jm + (J1+J2)/(n^2);
% Ts = 1e-2; %See step response (2-1.6
% eps_Jeq = 1; % Scaling factor for inertia
% eps_dm = 1; % scaling blabals
% 
