%% EXC5                 (CONTROL OF HYDRAULIC VALVE)
%
%           Linearization of nonlinear Hydraulic model
%
%
% ex5LIN;           % Call Linearization function (parameter: z and showeq in M File)

syms s;


%% ################### Velocity CONTROL #######################
%%#############################################################
%
Bv      = N11;
Av      = D11;

Gpv     = minreal(tf(Bv,Av));                      % Plant TF xvq -> pq (Valve2Vel)
% display('Linearized TF for velocity output [xvp -> dxp]');
% display(zpk(minreal(Gpv)));
[Bvp, Avp] = tfdata(minreal(Gpv));

% (Polynomials)
AvpEQ   = s*s*Avp{1,1}(1) + s*Avp{1,1}(2) + Avp{1,1}(3);
BvpEQ   = Bvp{1,1}(1)*s*s + Bvp{1,1}(2)*s + Bvp{1,1}(3);
Bvp0    = Bvp{1,1}(3);
%%          (PROPERTIES: CL - Plant: Unity Feedback)
%
[Zeros,Poles,Gain] = zpkdata(Gpv);
Gpvpzk = zpk(Zeros, Poles, Gain);
sysOrdv = size(Poles{1,1},1);

%get sys properties
Gpv_CL  = feedback(Gpv,1);
Spv = stepinfo(Gpv_CL);
trv = Spv.RiseTime;
Mpv = Spv.Overshoot;
tsv = Spv.SettlingTime;
ess = 100;
%%          (TF - Velocity [NOT PARAMETRIZED])
%
% t_str = 'TF - Velocity [NOT PARAMETRIZED]';
% if ~exist('ex5v_h')
%         ex5v_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5v_h)
%         ex5v_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5v_h(z));
%         delete(ex5v_h)
%         ex5v_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% % display(zpk(minreal(Gpv)));
% % display(zpk(minreal(Gpv_CL)));
% subplot(1,3,1); step(minreal(Gpv)); grid;
% subplot(1,3,2); pzmap(minreal(Gpv));grid;
% subplot(1,3,3); margin(minreal(Gpv)); grid;
%%          (CL - Velocity [NOT PARAMETRIZED])
%
% t_str = 'CL - Velocity [NOT PARAMETRIZED]';
% if ~exist('ex5vcl_h')
%         ex5vcl_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5vcl_h)
%         ex5vcl_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5vcl_h(z));
%         delete(ex5vcl_h)
%         ex5vcl_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% subplot(1,3,1); step(minreal(Gpv_CL)); grid;
% subplot(1,3,2); pzmap(minreal(Gpv_CL));grid;
% subplot(1,3,3); margin(minreal(Gpv_CL)); grid;
%%          (Calculate Controller)
%
[H_FFv,H_FBv, PD, P_Cv, D_Cv, I_Cv, N_Cv] = PID_calc(0,-1,0.25e-3,ess,Gpv,AvpEQ,BvpEQ,Bvp0,sysOrdv);

P_Cv    = double(P_Cv);
D_Cv    = double(D_Cv);
I_Cv    = double(I_Cv);
N_Cv    = double(N_Cv);
%SIMULINK IMPLEMENTATION
[N_temp, D_temp]=tfdata(H_FFv); N_FFv = N_temp{1,1}; D_FFv = D_temp{1,1};
[N_temp, D_temp]=tfdata(H_FBv); N_FBv = N_temp{1,1};D_FBv = D_temp{1,1};

%Calculate Closed Loop - Controller
GpvP    = H_FFv*feedback(Gpv,H_FBv);

%Compare Results
Spv     = stepinfo(Gpv_CL);
SpvP    = stepinfo(GpvP);

display('############### VELOCITY #############');
display('Rise Time: Unity | PID');
display([Spv.RiseTime SpvP.RiseTime]);
% display('Gpv');
% minreal(zpk(Gpv))
% display('GpvP');
% minreal(zpk(GpvP))
% figure; step(Gpv_CL,'r:'); hold; step(GpvP, 'b');grid;
%%          (CL - Velocity [PARAMETRIZED])
%
t_str = 'CL - Velocity [PARAMETRIZED]';
if ~exist('ex5vclpar_h')
        ex5vclpar_t=figure('Name',t_str,'numbertitle','off');
else
    if ~isvalid(ex5vclpar_h)
        ex5vclpar_h=figure('Name',t_str,'numbertitle','off');
    else   
        set(groot,'CurrentFigure',ex5vclpar_h(z));
        delete(ex5vclpar_h)
        ex5vclpar_h=figure('Name',t_str,'numbertitle','off');
    end
end
subplot(1,3,1); step(minreal(GpvP)); grid;
subplot(1,3,2); pzmap(minreal(GpvP));grid;
subplot(1,3,3); margin(minreal(GpvP)); grid;





%% ################### POSITION CONTROL #######################
%%#############################################################
%
integration    = tf([1],[1 0]);
Gpp     = minreal(integration*GpvP);
[N_temp, D_temp]    = tfdata(minreal(Gpp));                
Bpp = N_temp{1,1};
App = D_temp{1,1};
% display('Linearized TF for position output [xvp -> dxp -> 1/s -> xp]');

% (Polynomials)
AppEQ   = s*s*App(1) + s*App(2) + App(3);
BppEQ   = Bpp(1)*s*s + Bpp(2)*s + Bpp(3);
Bpp0    = Bpp(3);
%%          (PROPERTIES: CL - Plant: Unity Feedback)
%
[Zeros,Poles,Gain] = zpkdata(Gpp);
Gpppzk = zpk(Zeros, Poles, Gain);
sysOrdp = size(Poles{1,1},1);

%get sys properties
Gpp_CL  = feedback(Gpp,1);
Spp= stepinfo(Gpp_CL);
trp = Spp.RiseTime;
Mpp = Spp.Overshoot;
tsp = Spp.SettlingTime;
ess = 100;
%%          (TF - Position [NOT PARAMETRIZED])
%
% t_str = 'TF - Position - [NOT PARAMETRIZED]';
% if ~exist('ex5p_h')
%         ex5p_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5p_h)
%         ex5p_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5p_h(z));
%         delete(ex5p_h)
%         ex5p_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% subplot(1,3,1); step(minreal(Gpp)); grid;
% subplot(1,3,2); pzmap(minreal(Gpp));grid;
% subplot(1,3,3); margin(minreal(Gpp)); grid;
%%          (CL - Position [NOT PARAMETRIZED])

t_str = 'CL - Position [NOT PARAMETRIZED]';
if ~exist('ex5pCL_h')
        ex5pCL_t=figure('Name',t_str,'numbertitle','off');
else
    if ~isvalid(ex5pCL_h)
        ex5pCL_h=figure('Name',t_str,'numbertitle','off');
    else   
        set(groot,'CurrentFigure',ex5pCL_h(z));
        delete(ex5pCL_h)
        ex5pCL_h=figure('Name',t_str,'numbertitle','off');
    end
end
subplot(1,3,1); step(minreal(Gpp_CL)); grid;
subplot(1,3,2); pzmap(minreal(Gpp_CL));grid;
subplot(1,3,3); margin(minreal(Gpp_CL)); grid;
%%          (Calculate Controller)
%
[H_FFp,H_FBp, PD, P_Cp, D_Cp, I_Cp, N_Cp] = PID_calc(0,-1,trv*10,ess,Gpp,AppEQ,BppEQ,Bpp0,sysOrdp);
P_Cp    = double(P_Cp);
D_Cp    = double(D_Cp);
I_Cp    = double(I_Cp);
N_Cp    = double(N_Cp);

%SIMULINK IMPLEMENTATION
[N_temp, D_temp]    = tfdata(H_FFp); N_FFp = N_temp{1,1}; D_FFp = D_temp{1,1};
[N_temp, D_temp]    = tfdata(H_FBp); N_FBp = N_temp{1,1};D_FBp = D_temp{1,1};

%Calculate Closed Loop - Controller
GppP    = H_FFp*feedback(Gpp,H_FBp);

%Compare Results
Spp     = stepinfo(Gpp_CL);
SppP    = stepinfo(GppP);

display('############### Position #############');
display('Rise Time: Unity | PID');
display([Spp.RiseTime SppP.RiseTime]);
% display('Gpp');
% minreal(zpk(Gpp))
% display('GppP');
% minreal(zpk(GppP))
% figure; step(Gpp_CL,'r:'); hold; step(GppP, 'b');grid;
%%          (CL - Position [PARAMETRIZED])

t_str = 'CL - Position [PARAMETRIZED]';
if ~exist('ex5pCLpar_h')
        ex5pCLpar_t=figure('Name',t_str,'numbertitle','off');
else
    if ~isvalid(ex5pCLpar_h)
        ex5pCLpar_h=figure('Name',t_str,'numbertitle','off');
    else   
        set(groot,'CurrentFigure',ex5pCLpar_h(z));
        delete(ex5pCLpar_h)
        ex5pCLpar_h=figure('Name',t_str,'numbertitle','off');
    end
end
subplot(1,3,1); step(minreal(GppP)); grid;
subplot(1,3,2); pzmap(minreal(GppP));grid;
subplot(1,3,3); margin(minreal(GppP)); grid;
