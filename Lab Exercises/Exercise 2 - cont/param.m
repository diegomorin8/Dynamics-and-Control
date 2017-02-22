%% Part II - cont
% Mechanical Parameters
% 6SM107S-3000
%
% 6 poles
% Thermal T=2400s
% 

%% (Mechanical)
%
m           =   32.5;                   % kg
T_N         =   23;                     % Nm
Kt          =   1.6;                    % Nm/A          Torque Constant
Ke          =   97e-3*60/(2*pi);        % Vs/rad        Voltage Constant (U_pp = sqrt(3)*U)
P           =   6;                      %               To be Calculated
Kb          =   2.5730e-04;             % Vs/rad        Back emf Const
Kt          =   1.6;                    % Nm/A          Torque Const
R           =   0.37;                   % Ohm           Phase to Phase Resistance
L           =   3.6e-3;                 % H             Phase to Phase Inductance
Tth         =   2400;                   % s             Thermal time constant
w_mech      =   1000*2*pi/60;           % rad/s         angular velocity (operating point)


%%      EXC 7        (Calculation of No-Load Voltage)
V_PP        = w_mech*Ke;                                % Voltage
V_P         = V_PP/sqrt(3);
R_P         = R/2;
L_P         = L/2;
w_el        = P/2*w_mech;
I_N         = T_N/Kt;
I_SC        = V_P/(sqrt(R_P^2+(w_el*L_P)^2));

w_SC        = 1/3*sqrt((V_P/I_N/L_P)^2-(R_P/L_P)^2);
w_SC_rpm    = w_SC*60/(2*pi);
psi         =   Kt/sqrt(2);                        % Nm/A   

% a) No-Load Line Voltage



% b) Speed at which it is acceptable to shortcircuit the machine and why?


% c) Adapt Parameters to match the machine and Verify with no-load voltage
