function [R_PID, poleD, Pn, Dn, In, Nn] = PID_calc_disc( Mp, tr, ts, ess, G, A, B, order, Ts )
    %Param
    syms s z D N P I;
    Thres = 0.1;
    Pn = 0; 
    Dn = 0;
    In = 0;
    Nn = 1;
    
    %Main code
    if Mp ~= -1 && tr == -1 && ts ~= -1
        if Mp > 0
            eqn = -pi*z/sqrt(1-z*z) == log(Mp);
            z_sol = vpa(solve(eqn,z));
        else 
            z_sol = 1;
        end
        wn = 3.9/ts*z_sol;
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
        wn = 1.8/tr;
        %The discrete dominant pole is then
        P1 = -2*exp(-z_sol*wn*Ts)*cos(wn*Ts*sqrt(1 - z_sol^2));
        P0 = exp(-2*z_sol*wn*Ts);
        %Get the poles
        eqn_p1 = s*s + P1*s + P0 == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    elseif Mp == -1 && tr ~= -1 && ts ~= -1
        wn = 1.8/tr;
        z_sol = 3.9/ts*wn;
        %The discrete dominant pole is then
        P1 = -2*exp(-z_sol*wn*Ts)*cos(wn*Ts*sqrt(1 - z_sol^2));
        P0 = exp(-2*z_sol*wn*Ts);
        %Get the poles
        eqn_p1 = s*s + P1*s + P0 == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    else
        R_PID = -1;
        disp('Error no good parameters')
        return;
    end
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
        %we need derivative action
        [Zeros,Poles,Gain] = zpkdata(G);
        %As the dominant pole calculated is not part of the Root locus of the
        %systemwe need derivative action
        Poles_vec = [real(Poles{1,1}) imag(Poles{1,1})];
        Zeros_vec = [real(Zeros{1,1}) imag(Zeros{1,1})];
        S = P;
        R = 1;
        Acl =  A*R + B*S;
        if order == 0
            Ad = 1;
        elseif order == 1
            Ad  = (z + P0);
        elseif order == 2
            Ad  = (z^2 + P1*z + P0);
        elseif order == 3
            Ad  = (z^2 + P1*z + P0)*(z + P0);
        elseif order == 4
            Ad  = (z^2 + P1*z + P0)^2;
        end
        [Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
        if isempty(Pn)
            disp(' Not possible to satisfy the dynamics conditions ')
            R_PID = 1;
            Pn = 1;
            Dn = 0;
            In = 0; 
            Nn = 0;
            return
        end
        R_PID = tf(double(Pn),1,Ts);
        [zR,pR,Kp] = zpkdata(G*R_PID);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            S = (z-1)*P + Ts*I;
            R = (z-1);
            Acl =  A*R + B*S;
            if order == 0
                Ad  = (z + P0);
            elseif order == 1
                Ad  = (z^2 + P1*z + P0);
            elseif order == 2
                Ad  = (z^2 + P1*z + P0)*(z + P0);
            elseif order == 3
                Ad  = (z^2 + P1*z + P0)^2;
            end
            [In,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
            R_PID = tf([double(Pn) double(In)],[1 0],Ts);
        end
    else
        %Lets calculate the position of the zero of the derivative part
        S = (z-1)*(D*N + P) + P*N*Ts;
        R = (z-1) + N*Ts;
        Acl =  A*R + B*S;
        if order == 0
            Ad  = (z + P0);
        elseif order == 1
            Ad  = (z^2 + P1*z + P0);
        elseif order == 2
            Ad  = (z^2 + P1*z + P0)*(z + P0);
        elseif order == 3
            Ad  = (z^2 + P1*z + P0)^2;
        end
        [Dn,Nn,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
        R_PID = tf([double(Dn*Nn+Pn) double(Nn*Pn)],[1  double(Nn)],Ts);
        [zR,pR,Kp] = zpkdata(G*R_PID);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            S = (z-1)*(z-1)*D*N + (z-1)*(z-1)*P + (z-1)*(I*Ts + N*P*Ts) + N*Ts*I*Ts;
            R = (z-1)*(z-1) + (z-1)*Ts*N;
            Acl =  A*R + B*S;
            if order == 0
                Ad  = (z^2 + P1*z + P0);
            elseif order == 1
                Ad  = (z^2 + P1*z + P0)*(z + P0);
            elseif order == 2
                Ad  = (z^2 + P1*z + P0)^2;
            end
            [Dn,In,Nn,Pn] = solve(coeffs(Acl,z) == coeffs(Ad,z));
            R_PID = tf([double(Dn*Nn+Pn) double(In+Nn*Pn) double(Nn*In)],[1  double(Nn) 0],Ts);
        else
            R_PID = R_PID ; 
        end
    end
%     %Lets calculate the error of the system
%     
%     
