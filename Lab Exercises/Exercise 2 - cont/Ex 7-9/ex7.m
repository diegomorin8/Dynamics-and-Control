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
w_SC        =   R_P/sqrt(Ke^2/(3*I_N^2)-P^2*L_P^2/4)
w_SC_rpm    =   w_SC*60/(2*pi);
display('Mech. Ang. Vel. when Shortcircuit is acceptable: (rpm)');
display(vpa(w_SC_rpm,5));



%%          c   (Parametrize PSI and verify the choice with no-load and shortcircuit test)
%

%FIND FLUX LINKAGE CONSTANT PSI
psi         =   0.252;                                 % Nm/A   

% No-load test (1000 rpm, high resistance)  
w_revs = w_mech;
Load = 10000000;
sim('noload_shortcircuit_tests',1);
% No load voltage peak has to be 97*sqrt(2)=137.2 V


% Short circuit test (1000 rpm, low resistance) 
w_revs = w_mech;
Load = 0.001;
sim('noload_shortcircuit_tests',1);
% Short circuit current peak has to be 94.126*sqrt(2)=133.11 A


% Short circuit test (48 rpm, low resistance)
w_revs = w_SC;
Load = 0.001;
sim('noload_shortcircuit_tests',1);
% Short circuit current peak has to be 14.375*sqrt(2)=20.33 A


%%          d   (Check relation between electrical and mechanical frequency)

% The electrical frequency can be calculated as the mechanical frequency
% multiplied by the number of pole pairs (p/2)


%% -------------- EXERCISE 8 ----------------  
% REFERENCE:
% https://se.mathworks.com/help/physmod/sps/examples/three-phase-custom-pmsm.html
%%          a   (Current phasor = 10 A)

Phasor = 10;
Constant = exp(-2*j*pi/3);
sim('DC_current_phasor',1);

%%          b   (Current phasor = 10j A)

Phasor = 10j;
Constant = exp(-2*j*pi/3);
sim('DC_current_phasor',1);



%% -------------- EXERCISE 9 ----------------  
% REFERENCE:
% https://se.mathworks.com/help/physmod/sps/examples/three-phase-custom-pmsm.html
%%          a   (DQ coordinates = 10 A, pure D current)

J = 0.005;
Phasor = -10*exp(-2*j*pi/2);
Constant = exp(-2*j*pi/3);
sim('current_phasor_commutation',1);

%%          b   (DQ coordinates = 10j A, pure Q current)

Phasor = 10*exp(1*j*pi/2);
Constant = exp(-2*j*pi/3);
sim('current_phasor_commutation',1);

