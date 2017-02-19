function [R_PID, poleD] = PID_cont_calc( Mp, tr, ts, ess, G )
    %Param
    syms s z;
    Thres = 0.1;
    
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
        %First we calculate the proportional gain
         modPoles(1) = 0;
        for i = 1:size(Poles_vec,1)
            if Poles_vec(i,2) >= 0
                modPoles(i) = sqrt(double((-Poles_vec(i,2) + pdVec(2))^2 + (-Poles_vec(i,1) + pdVec(1))^2));
            end
        end
        for i = 1:size(Zeros_vec,1)
            if Zeros_vec(i,2) >= 0
                modZeros(i) = sqrt(double((-Zeros_vec(i,2) + pdVec(2))^2 + (-Zeros_vec(i,1) + pdVec(1))^2));
            end
        end
        modZeros(size(Zeros_vec,1) + 1) = sqrt(double((pdVec(2))^2 + (-Dzero + pdVec(1))^2));
        %The gain is then 
        Pnum = 1;
        for i = 1:size(modPoles,2)
            Pnum = Pnum*modPoles(i);
        end
        Pden = 1;
        for i = 1:size(modZeros,2)
            Pden = Pden*modZeros(i);
        end
        P = Pnum/(Pden*Gain);
        [zR,pR,Kp] = zpkdata(G*P);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            Izero = pdVec(1)/2;
            R_PID = zpk(double(Izero),0,P); 
        else
             R_PID = P; 
        end
    else
        %we need derivative action
        [Zeros,Poles,Gain] = zpkdata(G);
        %As the dominant pole calculated is not part of the Root locus of the
        %systemwe need derivative action
        Poles_vec = [real(Poles{1,1}) imag(Poles{1,1})];
        Zeros_vec = [real(Zeros{1,1}) imag(Zeros{1,1})];
        %Lets calculate the position of the zero of the derivative part
        %We need to study the angles regarded to the dominant pole
        anglesPoles(1) = 0;
        Poles_vec
        pdVec
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
        anglePD = 180;
        for i = 1:size(anglesPoles,2)
            anglePD = anglePD - anglesPoles(i);
        end
        for i = 1:size(anglesZeros,2)
            anglePD = anglePD + anglesZeros(i);
        end
        Dzero = -pdVec(1) + pdVec(2)/tan(anglePD);
        %Now that we have the needed zero, we calculate the Gain using the
        %module theorem.
        %We need the modules now
        %We need to study the angles regarded to the dominant pole
        modPoles(1) = 0;
        for i = 1:size(Poles_vec,1)
            if Poles_vec(i,2) >= 0
                modPoles(i) = sqrt(double((-Poles_vec(i,2) + pdVec(2))^2 + (-Poles_vec(i,1) + pdVec(1))^2));
            end
        end
        %We need to study the angles regarded to the dominant pole
        for i = 1:size(Zeros_vec,1)
            if Zeros_vec(i,2) >= 0
                modZeros(i) = sqrt(double((-Zeros_vec(i,2) + pdVec(2))^2 + (-Zeros_vec(i,1) + pdVec(1))^2));
            end
        end
        modZeros(size(Zeros_vec,1) + 1) = sqrt(double((pdVec(2))^2 + (-Dzero + pdVec(1))^2));
        %The gain is then 
        Pnum = 1;
        for i = 1:size(modPoles,2)
            Pnum = Pnum*modPoles(i);
        end
        Pden = 1;
        for i = 1:size(modZeros,2)
            Pden = Pden*modZeros(i);
        end
        P = Pnum/(Pden*Gain);
        R_PID = zpk(double(Dzero),[],P);
        [zR,pR,Kp] = zpkdata(G*R_PID);
        Kp = Kp*prod(zR{1})/prod(pR{1});
        error = 1/(1 + Kp);
        if error > ess
            %We need integral action
            Izero = pdVec(1)/2;
            R_PID = zpk([double(Izero) double(Dzero)],0,P); 
        else
            R_PID = R_PID ; 
        end
    end
%     %Lets calculate the error of the system
%     
%     
