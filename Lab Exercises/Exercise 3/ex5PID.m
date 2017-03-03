%% EXC5                 (CONTROL OF HYDRAULIC VALVE)
%
%           Linearization of nonlinear Hydraulic model
%
%
% ex5LIN;           % Call Linearization function (parameter: z and showeq)
% s       = tf('s');
syms s;

%%          (Linearized Velocity Transfer Function)
%
Bv      = N11;
Av      = D11;

Gpv     = minreal(tf(Bv,Av));                      % Plant TF xvq -> pq (Valve2Vel)
display('Linearized TF for velocity output [xvp -> dxp]');
display(minreal(Gpv));
[Bvp, Avp] = tfdata(minreal(Gpv));

% (Polynomials)
AvpEQ   = s*s*Avp{1,1}(1) + s*Avp{1,1}(2) + Avp{1,1}(3);
BvpEQ   = Bvp{1,1}(1)*s*s + Bvp{1,1}(2)*s + Bvp{1,1}(3);
Bvp0    = Bvp{1,1}(3);

%%          (Closed Loop - Plant: Unity Feedback)
%
[Zeros,Poles,Gain] = zpkdata(Gpv);
Gpvpzk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%get sys properties
Gpv_CL  = feedback(Gpv,1);
Sv = stepinfo(Gpv_CL);
trv = Sv.RiseTime;
Mpv = Sv.Overshoot;
tsv = Sv.SettlingTime;
ess = 100;

%%          (Calculate Controller)
%
[H_FFv,H_FBv, PD, P, D, I, N] = PID_calc(0,-1,trv*0.9,ess,Gpv,AvpEQ,BvpEQ,Bvp0,sysOrd);

%SIMULINK IMPLEMENTATION
[N_temp, D_temp]=tfdata(H_FFv); N_FFv = N_temp{1,1}; D_FFv = D_temp{1,1};
[N_temp, D_temp]=tfdata(H_FBv); N_FBv = N_temp{1,1};D_FBv = D_temp{1,1};

%Calculate Closed Loop - Controller
GpvP = H_FFv*feedback(Gpv,H_FBv);

%Compare Results
Sv = stepinfo(Gpv_CL)
SP = stepinfo(GpvP)

display('Gpv');
minreal(zpk(Gpv))
display('GvpP');
minreal(zpk(GpvP))
% figure; step(Gpv_CL,'r:'); hold; step(GpvP, 'b');grid;




%%          (Linearized Velocity Transfer Function)
%
derivative    = tf([1],[1 0]);
Gpp     = derivative*Gpv;
[N_temp, D_temp]    = tfdata(minreal(Gpp);)                
Bpp = N_temp{1,1};
App = D_temp{1,1};
display('Linearized TF for velocity output [xvp -> dxp]');
display(minreal(Gpp));
% [Bvp, Avp] = tfdata(minreal(Gpv));

% (Polynomials)
AppEQ   = s*s*App(1) + s*App(2) + App(3);
BppEQ   = Bpp(1)*s*s + Bpp(2)*s + Bpp(3);
Bpp0    = Bpp(3);

%%          (Closed Loop - Plant: Unity Feedback)
%
[Zeros,Poles,Gain] = zpkdata(Gpv);
Gpppzk = zpk(Zeros, Poles, Gain);
sysOrd = size(Poles{1,1},1);

%get sys properties
Gpp_CL  = feedback(Gpp,1);
Sv = stepinfo(Gpv_CL);
trv = Sv.RiseTime;
Mpv = Sv.Overshoot;
tsv = Sv.SettlingTime;
ess = 100;

%%          (Calculate Controller)
%
% [H_FFv,H_FBv, PD, P, D, I, N] = PID_calc(0,-1,trv*0.9,ess,Gpv,AvpEQ,BvpEQ,Bvp0,sysOrd);
% 
% %SIMULINK IMPLEMENTATION
% [N_temp, D_temp]=tfdata(H_FFv); N_FFv = N_temp{1,1}; D_FFv = D_temp{1,1};
% [N_temp, D_temp]=tfdata(H_FBv); N_FBv = N_temp{1,1};D_FBv = D_temp{1,1};
% 
% %Calculate Closed Loop - Controller
% GpvP = H_FFv*feedback(Gpv,H_FBv);
% 
% %Compare Results
% Sv = stepinfo(Gpv_CL)
% SP = stepinfo(GpvP)
% 
% display('Gpv');
% minreal(zpk(Gpv))
% display('GvpP');
% minreal(zpk(GpvP))
% figure; step(Gpv_CL,'r:'); hold; step(GpvP, 'b');grid;




















%%          (H_C - PID Feedback TF)
%
% Denominator and Nominator
% Ti_C        =       0.5;
% Td_C        =       1;
% K_C         =       2;
% 
% P_C         =       K_C;
% I_C         =       K_C/Ti_C;
% D_C         =       K_C*Td_C;
% 
% S         =       2;
% R         =       3;
% Define Transfer Function
% H_C         =       tf(S,R);
% Plot zero poles 


% %%              (H_FF - PID Feedforward TF)
% % 
% 
% %Denominator and Nominator
% Ti_FF      =       0.5;
% Td_FF      =       1;
% K_FF       =       2;
% 
% P_FF       =       K_FF;
% I_FF       =       K_FF/Ti_FF;
% D_FF       =       K_FF*Td_FF;
% K_FF       =       1;
% 
% Tv     =       [D];
% Rv     =       3;
% % Define Transfer Function
% H_FF       = tf(N_FFv, D_FFv);
%%                 (H_CL - Closed Loop TF)
%
% H_cl      =     feedback(H_C*H_FF*H_11,H_C);

% Plot Zero poles 
% Plot Step function
% Plot margin
%%                  (PID - Controller)
%
% Control law =>  u = P(r-y)  - D
%TRANSFER FUNCTION according to Parameters


% Design Error Feedback H_c         S/R
% H_PID = tf([D_C P_C I_C],[1 0]);

% Design Output Feedback with Feedforward T/R

% H_PID = tf([D_FF P_FF I_FF],[1 0]);
%%
%----------------------------------END OF FILE ----------------------------------------
%%                      Plot Poles and Zeros of Closed Loop System
%
%
%%    XX      (Linearized Position Transfer Function)
%

% Gpp         = Gpv/s;                      % Plant TF xvq -> pq (Valve2Pos)
% display(minreal(Gppv);
%%                      (desired transfer function for velocity control)
% t_str = 'xvq -> vq (piston velocity';
% if ~exist('ex6t_h')
%         ex6p_t(z)=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex6t_h)
%         ex6t_h(z)=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex6t_h(z));
%         delete(ex6t_h)
%         ex6t_h(z)=figure('Name',t_str,'numbertitle','off');
%     end
% end
% display(zpk(minreal(Gpv)));
% display(zpk(minreal(Gpv_CL)));
% subplot(1,3,1); step(minreal(Gpv)); grid;
% subplot(1,3,2); pzmap(minreal(Gpv));grid;
% subplot(1,3,3); margin(minreal(Gpv)); grid;
