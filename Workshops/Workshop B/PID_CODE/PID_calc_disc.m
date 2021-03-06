function [FF_PID, FB_PID, poleD, Pn, Dn, In, Nn] = PID_calc_disc( Mp, tr, ts, ess, G, A, B, B0, order, Ts )
    %Param
    syms s z D N P I;
    Thres = 0.1;
    Pn = 0; 
    Dn = 0;
    In = 0;
    Nn = 1;
    %Thumb rule
%     max_wn = 2*pi/(10*Ts)
%     min_wn = 2*pi/(30*Ts)
    max_wn = 1000000;
    min_wn = 0;
    %Main code
    if Mp ~= -1 && tr == -1 && ts ~= -1
        if Mp > 0
            eqn = -pi*z/sqrt(1-z*z) == log(Mp);
            z_sol = vpa(solve(eqn,z));
        else 
            z_sol = 1;
        end
        wn = 3.9/(ts*z_sol);
        if wn >= max_wn
            wn = max_wn;
        elseif wn <= min_wn
            wn = min_wn;
        end
        %The discrete dominant pole is then
        P1 = -2*exp(-z_sol*wn*Ts)*cos(wn*Ts*sqrt(1 - z_sol^2));
        P0 = exp(-2*z_sol*wn*Ts);
        %Get the poles
        eqn_p1 = s*s + P1*s + P0 == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    elseif Mp ~= -1 && tr ~= -1 && ts == -1
        if Mp > 0
            eqn = -pi*z/sqrt(1-z*z) == log(Mp);
            z_sol = vpa(solve(eqn,z));
        else 
            z_sol = 1;
        end
        wn = 2.2/tr;
        if wn >= max_wn
            wn = max_wn;
        elseif wn <= min_wn
            wn = min_wn;
        end
        %The discrete dominant pole is then
        P1 = -2*exp(-z_sol*wn*Ts)*cos(wn*Ts*sqrt(1 - z_sol^2));
        P0 = exp(-2*z_sol*wn*Ts);
        %Get the poles
        eqn_p1 = s*s + P1*s + P0 == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    elseif Mp == -1 && tr ~= -1 && ts ~= -1
        wn = 2.2/tr;
        if wn >= max_wn
            wn = max_wn;
        elseif wn <= min_wn
            wn = min_wn;
        end
        z_sol = 3.9/(ts*wn);
        %The discrete dominant pole is then
        P1 = -2*exp(-z_sol*wn*Ts)*cos(wn*Ts*sqrt(1 - z_sol^2));
        P0 = exp(-2*z_sol*wn*Ts);
        %Get the poles
        eqn_p1 = s*s + P1*s + P0 == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    else
        FB_PID = -1;
        disp('Error no good parameters')
        return;
    end
    P_f = (1/2)*abs(pdVec(1));
    [Zeros,Poles,Gain] = zpkdata(G);
    %Let see if need a derivative action
    Poles_vec = [real(Poles{1,1}) imag(Poles{1,1})];
    Zeros_vec = [real(Zeros{1,1}) imag(Zeros{1,1})];
    %Lets calculate the position of the zero of the derivative part
    %We need to study the angles regarded to the dominant pole
    anglesPoles(1) = 0;
    for i = 1:size(Poles_vec,1)
        if Poles_vec(i,2) >= 0
            anglesPoles(i) = rad2deg(double(atan((-Poles_vec(i,2) + pdVec(2))/(-Poles_vec(i,1) + pdVec(1)))));
            if anglesPoles(i) < 0
                anglesPoles(i) = 180 + anglesPoles(i);
            end
        end
    end
    %We need to study the angles regarded to the dominant pole
    anglesZeros(1) = 0;
    for i = 1:size(Zeros_vec,1)
        if Zeros_vec(i,2) >= 0
            anglesZeros(i) = rad2deg(double(atan((-Zeros_vec(i,2) + pdVec(2))/(-Zeros_vec(i,1) + pdVec(1)))));
            if anglesZeros(i) < 0
                anglesZeros(i) = 180 + anglesZeros(i);
            end
        end
    end
    anglePD = 0;
    for i = 1:size(anglesPoles,2)
        anglePD = anglePD - anglesPoles(i);
    end
    for i = 1:size(anglesZeros,2)
        anglePD = anglePD + anglesZeros(i);
    end
    if anglePD <= Thres && anglePD >= -Thres
        %We dont need derivative action
        S = P;
        R = 1;
        Acl =  A*R + B*S;
        if order == 2
                Ad  = (z^2 + P1*z + P0);
                Am0 =1 + P1 + P0;
                A0 = 1;
        elseif order == 1
                Ad  = (z - abs(pdVec(1)));
                Am0 = (1 - abs(pdVec(1)));
                A0 = 1;
        end
        [Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
        if isempty(Pn)
            disp('Not possible to calculate using pole placement');
            FB_PID = 1;
            FF_PID = 1;
            return;
        end
        %Feedback controller
        FB_PID = tf(double(Pn),1,Ts);
        %Feedforward controller
        T = Am0*A0/B0;
        T_coeff = fliplr(double(coeffs(T,z)));
        FF_PID = tf(T_coeff,1,Ts);
        %Check the error
        [y,t] = step(feedback(G*FB_PID,1));
        error = abs(1 - y(end));
        if error > ess
            %We need integral action
            %Cero placement
%             Cero_p = (1/6)*(1-distance_origin);
            S = (z-1)*P + Ts*I;
            R = (z-1);
            Acl =  A*R + B*S;
            if order == 2
                Ad  = (z^2 + P1*z + P0)*(z - P_f);
                Am0 = 1 + P1 + P0;
                A0 = (z - P_f);
            elseif order == 1
                Ad  = (z - abs(pdVec(1)))*(z - P_f);
                Am0 = (1 - abs(pdVec(1)));
                A0 = (z - P_f);
            end
            [In,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
            if isempty(Pn)
                disp('Not possible to calculate using pole placement');
                FB_PID = 1;
                FF_PID = 1;
                return;
            end
            FB_PID = tf([double(Pn) (double(In)*Ts -double(Pn))],[1 -1],Ts);
            %Feedforward controller
            T = Am0*A0/B0;
            T_coeff = fliplr(double(coeffs(T,z)));
            FF_PID = tf(T_coeff,[1 -1],Ts);
        end
    else
        %Lets calculate the position of the zero of the derivative part
        S = (z-1)*(D*N + P) + P*N*Ts;
        R = (z-1) + N*Ts;
        Acl =  A*R + B*S;
        if order == 2
                Ad  = (z^2 + P1*z + P0)*(z - P_f);
                Am0 = 1 + P1 + P0;
                A0 = (z - P_f);
        elseif order == 1
                Ad  = (z - abs(pdVec(1)))*(z - P_f);
                Am0 = (1 - abs(pdVec(1)));
                A0 = (z - P_f);
        end
        [Dn,Nn,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
        if isempty(Pn)
            disp('Not possible to calculate using pole placement');
            FB_PID = 1;
            FF_PID = 1;
            return;
        end
        FB_PID = tf([double(Dn*Nn + Pn) (double(Nn*Pn)*Ts - double(Dn*Nn + Pn))],[1  (double(Nn)*Ts - 1)],Ts)
        %Feedforward controller
        T = Am0*A0/B0;
        T_coeff = fliplr(double(coeffs(T,z)));
        FF_PID = tf(T_coeff,[1  (double(Nn)*Ts - 1)],Ts);
        %Check the error
        [y,t] = step(FF_PID*feedback(G,FB_PID));
        error = abs(1 - y(end));
        if error > ess
            %We need integral action
            S = (z-1)*(z-1)*D*N + (z-1)*(z-1)*P + (z-1)*(I*Ts + N*P*Ts) + N*Ts*I*Ts;
            R = (z-1)*(z-1) + (z-1)*Ts*N;
            Acl =  A*R + B*S;
            if order == 2
                    Ad  = (z^2 + P1*z + P0)*(z - P_f)*(z - P_f);
                    Am0 = 1 + P1 + P0;
                    A0 = (z - P_f)*(z - P_f);
            elseif order == 1
                    Ad  = (z - abs(pdVec(1)))*(z - P_f)*(z - P_f);
                    Am0 = (1 - abs(pdVec(1)));
                    A0 = (z - P_f)*(z - P_f);
            end
            [Dn,In,Nn,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
            if isempty(Pn)
                disp('Not possible to calculate using pole placement');
                FB_PID = 1;
                FF_PID = 1;
                return;
            end
            FB_PID = tf([double(Dn*Nn+Pn) (-double(Dn*Nn)*2 - double(Pn)*2 + Ts*double(In+Nn*Pn)) (double(Dn*Nn) + double(Pn) - Ts*double(In + Nn*Pn) + Ts*Ts*double(Nn*In))],[1  (-2 + Ts*double(Nn)) (1 - Ts*double(Nn))],Ts);
            %Feedforward controller
            T = Am0*A0/B0;
            T_coeff = fliplr(double(coeffs(T,z)));
            FF_PID = tf(T_coeff,[1  (-2 + Ts*double(Nn)) (1 - Ts*double(Nn))],Ts);
            %Check the error
        end
    end
%     %Lets calculate the error of the system
%     
%     
