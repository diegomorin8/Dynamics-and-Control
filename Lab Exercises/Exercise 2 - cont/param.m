%% Part II - cont
% Mechanical Parameters
% 6SM107S-3000
%
% 6 poles
% Thermal T=2400s
% 

%% (Mechanical)
%
m           =   32.5kg;
Kt          =   1.6;                    % Nm/A          Torque Constant
Ke          =   97e-3*60/(2*pi)*sqrt(3);  % Vs/rad        Voltage Constant (U_pp = sqrt(3)*U)
P           =   6;
psi         =   1;                        % Nm/A          To be Calculated
Kb          =   2.5730e-04;             % Vs/rad        Back emf Const
Kt          =   1.6;                    % Nm/A          Torque Const
R           =   0.37;                   % Ohm           Phase to Phase Resistance
L           =   3.6e-3;                 % H             Phase to Phase Inductance
Tth         =   2400;                    % s             Thermal time constant




% %Commands:
% % zpk() --> command for polynomial factorization
% % get(ex5_m,'Number')                                 %Get Handle Property - 'Number'
% % set(groot,'CurrentFigure',ex5_m);
% 
% 
% %%
% % Invers
% % Ainv=inv(s*eye(2)-A);
% 
% % Determinant
% % Adet=det(s*eye(2)-A);
% 
% %Finding change in Transfer function
% % Y = Cp*Ainv*Adet*B
% % Gives Adjungate of Ainv