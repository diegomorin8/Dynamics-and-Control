%% EXC5                 (CONTROL OF HYDRAULIC VALVE)
%
%           Linearization of nonlinear Hydraulic model
%
%
% ex5LIN;           % Call Linearization function (parameter: z and showeq)
s       = tf('s');

%%          (Linearized Velocity Transfer Function)
%
Bv      = N11;
Av      = D11;

Gpv      = tf(Bv,Av);                      % Plant TF xvq -> pq (Valve2Vel)
display(minreal(Gpv));

%%          (Linearized Position Transfer Function)
%

% Gpp         = Gpv/s;                      % Plant TF xvq -> pq (Valve2Pos)
% display(minreal(Gppv);


%Denominator and Nominator
Ti_C        =       0.5;
Td_C        =       1;
K_C         =       2;

P_C         =       K;
I_C         =       K/Ti;
D_C         =       K*Td;
K_C         =       1;

S         =       2;
R         =       3;
% Define Transfer Function
H_C         =       tf(S,R);
% Plot zero poles 


%%              (H_FF - PID)
% 

%Denominator and Nominator
Ti_FF      =       0.5;
Td_FF      =       1;
K_FF       =       2;

P_FF       =       K;
I_FF       =       K/Ti;
D_FF       =       K*Td;
K_FF       =       1;

T     =       [D];
R     =       3;
% Define Transfer Function
H_FF       = tf(T, R);

%%
%


%%                 (Closed Loop Response
%
H_cl      =     feedback(H_C*H_FF*H_11,H_C);

% Plot Zero poles 
% Plot Step function
% Plot margin


%%                  (Do Root-Locus for Closed Loop System)
%



%%                  (PID - Controller)
%
% Control law =>  u = P(r-y)  - D
%TRANSFER FUNCTION according to Parameters


% Design Error Feedback H_c         S/R
H_PID = tf([D P I],[1 0]);

% Design Output Feedback with Feedforward T/R



%%                      Plot Poles and Zeros of Closed Loop System
%
%


%%                      (desired transfer function for velocity control)
t_str = 'xvq -> vq (piston velocity';
if ~exist('ex6t_h')
        ex6p_t(z)=figure('Name',t_str,'numbertitle','off');
else
    if ~isvalid(ex6t_h)
        ex6t_h(z)=figure('Name',t_str,'numbertitle','off');
    else   
        set(groot,'CurrentFigure',ex6t_h(z));
        delete(ex6t_h)
        ex6t_h(z)=figure('Name',t_str,'numbertitle','off');
    end
end
display(H_11);
subplot(1,3,1); step(H_11); grid;
subplot(1,3,2); pzmap(H_11);grid;
subplot(1,3,3); margin(H_11); grid;
