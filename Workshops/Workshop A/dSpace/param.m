%%              Please add usage commentary
%
syms s;

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
eps_Jeq = 1; % Scaling factor for inertia
eps_dm = 1; % scaling blabals

%Position PID Paramters
Pz_pos = 1; 
Iz_pos = 0; 
Dz_pos = 0; 
Nz_pos = 1; 
%Velocity
Pz_Vel = 1; 
Iz_Vel = 0; 
Dz_Vel = 0; 
Nz_Vel = 1; 

