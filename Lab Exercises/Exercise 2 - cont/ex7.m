%% -------------- EXERCISE 7 (Only run single sections!) ----------------  
% REFERENCE:
% https://se.mathworks.com/help/physmod/sps/ref/permanentmagnetsynchronousmotor.html?requestedDomain=www.mathworks.com
%%          -   (Parameters)
param;                                                      % Global EXC2-cont params
%%          a   (No-Load line Voltage and short circuit current)
%
R_P         =   R/2;
L_P         =   L/2;
w_mech      =   1000*2*pi/60;                               % rad/s         mech. ang. vel
w_el        =   P/2*w_mech;                                 % rad/s         electr. ang. vel

%NO-LOAD LINE VOLTAGE
V_PP        =   w_mech*Ke;                                  % V             phase-to-phase voltage
V_P         =   V_PP/sqrt(3);                               % V             phase voltage
display('No-Load Line Voltage: (V)');
display(vpa(V_P,3));

%SHORTCIRCUIT CURRENT
I_N         =   T_N/Kt;
I_SC        =   V_P/(sqrt(R_P^2+(w_el*L_P)^2));
display('Short-Circuit current: (A)');
display(vpa(I_SC,3));


%%          b   (Speed to shortcircuit the machine)
%

%  SET I_SC (Short Circuit current to) >= 14.375 A
w_SC        =   1/3*sqrt((V_P/I_N/L_P)^2-(R_P/L_P)^2);
w_SC_rpm    =   w_SC*60/(2*pi);
display('Mech. Ang. Vel. when Shortcircuit is acceptable: (rpm)');
display(vpa(w_SC_rpm,5));



%%          c   (Parametrize PSI)
%

%FIND FLUX LINKAGE CONSTANT PSI
psi         =   Kt/sqrt(2);                                 % Nm/A   

%sim('noload_shortcircuit_tests',1);