%% EXC5                 (CONTROL OF HYDRAULIC VALVE)
%
%           Linearization of nonlinear Hydraulic model
%
%
% ex5LIN;           % Call Linearization function (parameter: z and showeq in M File)

syms s;

%% ######################## Velocity CONTROL ############################
display('###############################################');
display('############## BEGIN VELOCITY ################');
Bv      = N11; Av      = D11;

Gpv     = minreal(tf(Bv,Av));Gpv_zpk=zpk(Gpv);display(Gpv_zpk);                                         % display('Linearized TF for velocity output [xvp -> dxp]'); display(zpk(minreal(Gpv)));                                                       % Plant TF xvq -> pq (Valve2Vel)
[N_T, D_T] = tfdata(minreal(Gpv)); 
Bvp     = N_T{1,1};
Avp     = D_T{1,1};
AvpEQ   = s*s*Avp(1) + s*Avp(2) + Avp(3);                                               % Determine Polynomials
BvpEQ   = Bvp(1)*s*s + Bvp(2)*s + Bvp(3);
Bvp0    = Bvp(3);
%%          (PROPERTIES: CL - Plant: Unity Feedback)
%
[Zeros,Poles,Gain] = zpkdata(Gpv);                                                      % Gpvpzk = zpk(Zeros, Poles, Gain);
    sysOrdv = size(Poles{1,1},1);

Gpv_CL  = feedback(Gpv,1);
    
Spv     = stepinfo(Gpv_CL);                                                             % STEP PROPERTIES
    trv     = Spv.RiseTime;
    Mpv     = Spv.Overshoot;
    tsv     = Spv.SettlingTime;
    ess     = 0.05;
%%          (Calculate Controller)
%
[H_FFv,H_FBv, PD, P_Cv, D_Cv, I_Cv, N_Cv] = PID_v2(0,-1,0.1,ess,Gpv,AvpEQ,BvpEQ,Bvp0,sysOrdv);

        %SIMULINK IMPLEMENTATION
        P_Cv    = double(P_Cv);
        D_Cv    = double(D_Cv);
        I_Cv    = double(I_Cv);
        N_Cv    = double(N_Cv);
        [N_T, D_T]=tfdata(H_FFv); N_FFv = N_T{1,1}; D_FFv = D_T{1,1};
        [N_T, D_T]=tfdata(H_FBv); N_FBv = N_T{1,1};D_FBv = D_T{1,1};


GpvP    = H_FFv*feedback(Gpv,H_FBv);GpvP_zpk = zpk(minreal(GpvP)); display(GpvP_zpk);                           % Calculate Closed Loop - Controller
Spv     = stepinfo(Gpv_CL); SpvP    = stepinfo(GpvP);                                                           % Compare Results
display(' ');
outstr=strcat('Gpv_CL : t_R =  ',num2str(Spv.RiseTime));disp(outstr);
outstr=strcat('GpvP_CL: t_R =  ',num2str(SpvP.RiseTime));disp(outstr);
% display('Gpv');display(minreal(zpk(Gpv)));display('GpvP'); display(minreal(zpk(GpvP)));
% figure; step(Gpv_CL,'r:');hold; step(GpvP, 'b');grid;
%% ################### Controller Design Completed #######################

%% ------------------  BEGIN PLOTS ------------------------------------
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
%%          (CL - Velocity [PARAMETRIZED])
%
% t_str = 'CL - Velocity [PARAMETRIZED]';
% if ~exist('ex5vclpar_h')
%         ex5vclpar_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5vclpar_h)
%         ex5vclpar_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5vclpar_h(z));
%         delete(ex5vclpar_h)
%         ex5vclpar_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% subplot(1,3,1); step(minreal(GpvP)); grid;
% subplot(1,3,2); pzmap(minreal(GpvP));grid;
% subplot(1,3,3); margin(minreal(GpvP)); grid;
%% ------------------  END PLOTS  ------------------------------------
%%
display('############## END VELOCITY ###################');
display('###############################################');
display(' ');display(' ');display(' ');



%% ################### POSITION CONTROL #################################
display('###############################################');
display('############## BEGIN POSITION #################');
intg    = tf([1],[1 0]);
Gpp     = minreal(intg*GpvP);Gpp_zpk=zpk(Gpp);display(Gpp_zpk);                                        % display('Linearized TF for position output [xvp -> dxp -> 1/s -> xp]');
[N_T, D_T]    = tfdata(minreal(Gpp));                
Bpp     = N_T{1,1};
App     = D_T{1,1};


AppEQ   = App(1)*s^3 + App(2)*s^2 + App(3)*s+App(4);                                                    % Determine Polynomials
BppEQ   = Bpp(1)*s^3 + Bpp(2)*s^2 + Bpp(3)*s+Bpp(4);
Bpp0    = Bpp(3);
%%          (PROPERTIES: CL - Plant: Unity Feedback)

[Zeros,Poles,Gain] = zpkdata(Gpp);                                                                      % Gpppzk = zpk(Zeros, Poles, Gain);
    sysOrdp = size(Poles{1,1},1);



Gpp_CL  = feedback(Gpp,1);        
        % figure;
        % subplot(2,2,1);pzmap(Gpp);grid;
        % subplot(2,2,2);pzmap(Gpv);grid;
        % subplot(2,2,3);pzmap(Gpp_CL);grid;
        % subplot(2,2,4);pzmap(Gpv_CL);grid;
    Spp     = stepinfo(Gpp_CL);                                                                         % STEP PROPERTIES
    trp     = Spp.RiseTime;
    Mpp     = Spp.Overshoot;
    tsp     = Spp.SettlingTime;
    ess     = 100;
%%          (Calculate Controller)

[H_FFp,H_FBp, PD, P_Cp, D_Cp, I_Cp, N_Cp] = PID_v2(-1,-1,-1,ess,Gpp,AppEQ,BppEQ,Bpp0,sysOrdp);

        %SIMULINK IMPLEMENTATION
        P_Cp    = double(P_Cp);
        D_Cp    = double(D_Cp);
        I_Cp    = double(I_Cp);
        N_Cp    = double(N_Cp);
        [N_T, D_T]    = tfdata(H_FFp); N_FFp = N_T{1,1}; D_FFp = D_T{1,1};
        [N_T, D_T]    = tfdata(H_FBp); N_FBp = N_T{1,1}; D_FBp = D_T{1,1};


GppP    = H_FFp*feedback(Gpp,H_FBp);GppP_zpk = zpk(minreal(GpvP)); display(GppP_zpk);                        % Calculate Closed Loop - Controller
Spp     = stepinfo(Gpp_CL); SppP    = stepinfo(GppP);                                   % Compare Results

display(' ');
outstr=strcat('Gpp_CL : t_R =  ',num2str(Spp.RiseTime));disp(outstr);
outstr=strcat('GppP_CL: t_R =  ',num2str(SppP.RiseTime));disp(outstr);

display('Gpp');  display(minreal(zpk(Gpp)));display('GppP');display(minreal(zpk(GppP)));
figure;step(Gpp_CL,'r:');hold;step(GppP, 'b');grid;
%% ################### Controller Design Completed #######################

%% ------------------  BEGIN PLOTS ------------------------------------
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
% 
% t_str = 'CL - Position [NOT PARAMETRIZED]';
% if ~exist('ex5pCL_h')
%         ex5pCL_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5pCL_h)
%         ex5pCL_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5pCL_h(z));
%         delete(ex5pCL_h)
%         ex5pCL_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% subplot(1,3,1); step(minreal(Gpp_CL)); grid;
% subplot(1,3,2); pzmap(minreal(Gpp_CL));grid;
% subplot(1,3,3); margin(minreal(Gpp_CL)); grid;
%%          (CL - Position [PARAMETRIZED])
% 
% t_str = 'CL - Position [PARAMETRIZED]';
% if ~exist('ex5pCLpar_h')
%         ex5pCLpar_t=figure('Name',t_str,'numbertitle','off');
% else
%     if ~isvalid(ex5pCLpar_h)
%         ex5pCLpar_h=figure('Name',t_str,'numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex5pCLpar_h(z));
%         delete(ex5pCLpar_h)
%         ex5pCLpar_h=figure('Name',t_str,'numbertitle','off');
%     end
% end
% subplot(1,3,1); step(minreal(GppP)); grid;
% subplot(1,3,2); pzmap(minreal(GppP));grid;
% subplot(1,3,3); margin(minreal(GppP)); grid;
%% ------------------  END PLOTS  ------------------------------------ 
%%
display('############## END POSITION ###################');
display('###############################################');