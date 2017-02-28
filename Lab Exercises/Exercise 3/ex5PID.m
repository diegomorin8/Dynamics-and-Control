%% EXC5 (CONTROL OF HYDRAULIC VALVE)

%%              (Set Controller Parameters EXC 5) (H_C)
% 

%Denominator and Nominator
N_C     =       2;
D_C     =       3;
Ti_C      =       0.5;
Td_C      =       1;
K_C       =       2;

P_C       =       K;
I_C       =       K/Ti;
D_C       =       K*Td;
K_C       =       1;

% Define Transfer Function
H_C     =       tf(N_C,D_C);
% Plot zero poles 


%%              (Set Controller Parameters EXC 5) (H_FF)
% 

%Denominator and NOminator
N_FF     =       2;
D_FF     =       3;
Ti_FF      =       0.5;
Td_FF      =       1;
K_FF       =       2;

P_FF       =       K;
I_FF       =       K/Ti;
D_FF       =       K*Td;
K_FF       =       1;

% Define Transfer Function
H_FF       = tf(N_FF,D_FF);
 %%                 (Closed Loop Response
%
H_cl      =     feedback(H_C*H_FF*H_11,H_C);

% Plot Zero poles 
% Plot Step function
% Plot margin


%%                  (Do Root-Locus for Closed Loop System)


%%                  (PID - Controller)
%
% Control law =>  u = P(r-y)  - D
%TRANSFER FUNCTION according to Parameters


% Design Error Feedback H_c         S/R
H_PID = tf([D P I],[1 0]);

% Design Output Feedback with Feedforward T/R



%%                      Plot Poles and Zeros of Closed Loop System




%%

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
