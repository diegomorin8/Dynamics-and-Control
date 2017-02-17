function [T_PID, R_PID, poleD, Pn, Dn, In, Nn, t0, wn] = PID_calc( Mp, tr, ts, ess, G, A, B, Bin0, order )
    %Param
    syms s z D N P I;
    Thres = 0.1;
    Pn = 0; 
    Dn = 0;
    In = 0;
    Nn = 0;
    
    %Main code
    if Mp ~= -1 && tr == -1 && ts ~= -1
        eqn = -pi*z/sqrt(1-z*z) == log(Mp);
        z_sol = vpa(solve(eqn,z));
        wn = 4.6/ts*z_sol;
        %Get the poles
        eqn_p1 = s*s + 2*z_sol*wn*s + wn*wn == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    elseif Mp ~= -1 && tr ~= -1 && ts == -1
        eqn = -pi*z/sqrt(1-z*z) == log(Mp);
        z_sol = vpa(solve(eqn,z));
        wn = 1.8/tr;
        %Get the poles
        eqn_p1 = s*s + 2*z_sol*wn*s + wn*wn == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    elseif Mp == -1 && tr ~= -1 && ts ~= -1
        wn = 1.8/tr;
        z_sol = 4.6/ts*wn;
        %Get the poles
        eqn_p1 = s*s + 2*z_sol*wn*s + wn*wn == 0;
        poleD = vpa(solve(eqn_p1,s));
        pdVec = [real(poleD(1)) imag(poleD(1))];
    else
        R_PID = -1;
        disp('Error no good parameters')
        return;
    end
%     wn = 10; 
%     z_sol = 0.9;
    %Let see if need a derivative action
    %We calculate the rlocus
    [complexVec,gainsVec] = rlocus(G);
    %Compute the distance to every possible value of the poles of G to see
    %if the calculated pole is part of the rlocus
    minDist = abs(min(min(dist(double(poleD(1)),complexVec(1)))));
    
    if minDist <= Thres
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
            Ad  = (s + wn);
        elseif order == 2
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn);
        elseif order == 3
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)*(s + wn);
        elseif order == 4
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)^2;
        end
        [Pn] = solve(coeffs(Acl,s) == coeffs(Ad,s));
        R_PID = Pn;
        [zR,pR,Kp] = zpkdata(G*P);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            S = s*P + I;
            R = s;
            Acl =  A*R + B*S;
            if order == 0
                Ad  = (s + wn);
            elseif order == 1
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn);
            elseif order == 2
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)*(s + wn);
            elseif order == 3
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)^2;
            end
            [In,Pn] = solve(coeffs(Acl,s) == coeffs(Ad,s));
            R_PID = tf([double(Pn) double(In)],[1 0]);
        else
             R_PID = Pn; 
        end
    else
        %we need derivative action
        [Zeros,Poles,Gain] = zpkdata(G);
        %As the dominant pole calculated is not part of the Root locus of the
        %systemwe need derivative action
        Poles_vec = [real(Poles{1,1}) imag(Poles{1,1})];
        Zeros_vec = [real(Zeros{1,1}) imag(Zeros{1,1})];
        %Lets calculate the position of the zero of the derivative part
        S = s*(D*N + P) + P*N;
        R = s + N;
        Acl =  A*R + B*S;
        if order == 0
            Ad  = (s + wn);
        elseif order == 1
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn);
        elseif order == 2
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)*(s + wn);
        elseif order == 3
            Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)^2;
        end
        [Dn,Nn,Pn] = solve(coeffs(Acl,s) == coeffs(Ad,s));
        R_PID = tf([double(Dn*Nn+Pn) double(Nn*Pn)],[1  double(Nn)]);
        t0 = wn*wn/Bin0;
        T_PID = tf([t0  wn*t0],[1  double(Nn)]);
        [zR,pR,Kp] = zpkdata(G*R_PID);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            S = s*s*D*N + s*s*P + s*(I + N*P) + N*I;
            R = s*s + s*N;
            Acl =  A*R + B*S;
            if order == 0
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn);
            elseif order == 1
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)*(s + wn);
            elseif order == 2
                Ad  = (s^2 + 2*wn*z_sol*s + wn*wn)^2;
            end
            [Dn,In,Nn,Pn] = solve(coeffs(Acl,s) == coeffs(Ad,s));
            R_PID = tf([double(Dn*Nn+Pn) double(In+Nn*Pn) double(Nn*In)],[1  double(Nn) 0]);
        else
            R_PID = R_PID ; 
        end
    end
%     %Lets calculate the error of the system
%     
%     
