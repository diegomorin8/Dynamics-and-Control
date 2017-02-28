
%%                              (EXC.6 - Hydraulic Parameters)

fe      = 10000;                % N                 (Applied external Force/Load)
g       = 9.81;                 % m/s^2             (Gravitational Field)
rho     = 1000;                 % kg/m^3            (Oil density)
beta    = 2e9;                  % N/m^2             (Bulk modulus)
da      = 0.05;                 % m                 (Cylinder inner diameter)
di      = 0.02;                 % m                 (Piston rod diameter)
A1      = pi/4*(da^2);          % m^2               (Area 1 (Piston diameter)
A2      = pi/4*(da^2-di^2);     % m^2               (Area 2 (Piston-rod)
smax    = 0.7;                  % m                 (Maximum piston stroke)
d       = 0.001;                % m                 (Nonlinear avoidance)
vp      =  0.01;                % m                 (max positiv valve opening)
vn      = -0.01;                % m                 (min negative valve opening)
m       = 100;                  % kg                (Mass)
df      = 200;                  % Ns/m              (Friction coefficient)
Rv      = 1e-4;                 % -                 (Flow constant)
Ps      = 20e6;                 % Pa = N/m^2        (Pump supply pressure)
Pt      = 0;                    % Pa = N/m^2        (Tank return pressure)
Cf1     = A1*smax/beta;             % m^2*m^3*s^2/kg/N  (Flow Capacitance Chamber 1)
Cf2     = Cf1;             % m^2*m^3*s^2/kg/N  (Flow Capacitance Chamber 2)
A3      = (A1+A2)/2;            % m^2               (Cross-sectional Area LINEAR MODEL for A1 and A2)
Cf      = A3*smax/beta;             % m^2*m^3*s^2/kg/N  (Flow Capacitance LINEAR MODEL Chamber 1 & Chamber 2)

% SET EQUAL PHYISCAL CONDITION IN SIMULINK
A1=A3;
A2=A3;
Cf1=Cf;
Cf2=Cf;

% SET INITIAL CONDITIONS INDEPENDENTLY OF LINEAR MODEL  (DISTINCT FROM EXC6(z)
% x0      = [0 0 0];
% u0      = [0.01 0];
% xvq0            = 0.001;
% fe0             = 0;
% vq0             = 0;
% p1q0            = 0;
% p2q0            = 0;

% SET INITIAL CONDITIONS TO LINEAR MODELS OPERATING POINT
% x0      =[vq0 p1q0 p2q0];
% u0      =[xvq0 fe0];






%%                              (Other Commands #1)
%
%Commands:
% zpk() --> command for polynomial factorization
% get(0,'format')
%{
origFormat = get(0, 'format');
format('rational');

  -- Work in rational format --

set(0,'format', origFormat);

%}

% get(ex5_m,'Number')                                 %Get Handle Property - 'Number'
% set(groot,'CurrentFigure',ex5_m);
% zpk('s')                          %defines s as a Laplace Variable and allows zpk format
% dcgain(Sys)                       % Gives dcGain of a system
% limit(a*s,s,0,'right')            % FVT
% digits(2)                         % Sets the precision of VPA to 2
% significant digis
% vpa(x,2)                          % 2 is equal to digis(2), Variable
% Precision Arithmetic uses a symbolic expression x
%
%%                              (Other Commands #2)
%Finding different Transfer functionfunctions
% zinv=inv(s*eye(2)-A);         % Invers     
% zdet=det(s*eye(2)-A);         % Determinant
% zadj = zinv*zdet            % Gives Adjungate of Ainv