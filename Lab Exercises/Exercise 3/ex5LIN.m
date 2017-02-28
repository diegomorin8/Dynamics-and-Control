%M SCRIPT
%%                              (Loading Parameters)
%
% PARAMETERS FOR LINEARIZED MODEL
param                           %param.m
%%                              (Parameters specific for Linearized Model

%%                              (Equilibrium Points - LINEARIZATION)
% State Space 
display('x = [vq P1 P2]'); display('u = [xvq fe]');
% x1=vm; x2=P1; x3=P2;

syms x
b = df;
i=2;                                        % Indexing Solution to quadratic polynomial
xvq_05_10k  = 0.005;            fe_05_10k   = 10000;
xvq_1_10k   = 0.01;             fe_1_10k    = 10000;
xvq_05_0k   = 0.005;            fe_05_0k    = 0;
xvq_1_0k    = 0.01;             fe_1_0k     = 0;
xvqINI      = [xvq_05_10k xvq_1_10k xvq_05_0k xvq_1_0k];
feINI       = [fe_05_10k fe_1_10k fe_05_0k fe_1_0k];
    
%%                              u(1) = f_e = 10000; u(2) = x_vq = 0.005 [_05_10k]
xvq=0.005;
a_05 = ( 2*A3^3/(Rv^2*xvq^2));            % u(1) = f_e = 10000; u(2) = x_vq = 0.005
c_10k=(10000-Ps*A3);
f_05_10k=a_05*x^2 + b*x +c_10k;
vq_05_10k=solve(f_05_10k,x);
display('u1=10k,u2=0.005');
pretty(vpa(vq_05_10k,3));

vq_05_10k= vq_05_10k(i);
p1q_05_10k = Ps- (A3*vq_05_10k/(xvq*Rv))^2;
p2q_05_10k = (A3*vq_05_10k/(xvq*Rv))^2;


%%                              u(1) = f_e = 0; u(2) = x_vq = 0.005 [_05_0k]
xvq=0.005;
a_05 = ( 2*A3^3/(Rv^2*0.005^2));            % u(1) = f_e = 0; u(2) = x_vq = 0.005
c_0k=(-Ps*A3);
f_05_0k=a_05*x^2 + b*x +c_0k;
vq_05_0k=solve(f_05_0k,x);
display('u1=0k,u2=0.005');
pretty(vpa(vq_05_0k,3));

vq_05_0k = vq_05_0k(i);
p1q_05_0k = Ps- (A3*vq_05_0k/(xvq*Rv))^2;
p2q_05_0k = (A3*vq_05_0k/(xvq*Rv))^2;


%%                              u(1) = f_e = 0; u(2) = x_vq = 0.01 [_1_0k]
xvq=0.01;
a_1 = ( 2*A3^3/(Rv^2*0.01^2));            % u(1) = f_e = 0; u(2) = x_vq = 0.01
c_0k=(-Ps*A3);
f_1_0k=a_1*x^2 + b*x +c_0k;
vq_1_0k=solve(f_1_0k,x);
display('u1=0k,u2=0.01');
pretty(vpa(vq_1_0k,3));

vq_1_0k = vq_1_0k(i);
p1q_1_0k = Ps- (A3*vq_1_0k/(xvq*Rv))^2;
p2q_1_0k = (A3*vq_1_0k/(xvq*Rv))^2;


%%                              u(1) = f_e = 10k; u(2) = x_vq = 0.01 [_1_10k]
xvq= 0.01;
a_1 = ( 2*A3^3/(Rv^2*xvq^2));            % u(1) = f_e = 10k; u(2) = x_vq = 0.01
c_10k=(10000-Ps*A3);
f_1_10k=a_1*x^2 + b*x +c_10k;
vq_1_10k=solve(f_1_10k,x);
display('u1=10k,u2=0.01');
pretty(vpa(vq_1_10k,3));
vq_1_10k = vq_1_10k(i);
p1q_1_10k = Ps- (A3*vq_1_10k/(xvq*Rv))^2;
p2q_1_10k = (A3*vq_1_10k/(xvq*Rv))^2;


%%                          Symbolic Definition of State-space
syms A3 m Cf df Ps Rv p1q0 p2q0 fe0 xvq0
A=sym(eye(3)); B=sym([ 0 0; 0 0; 0 0]);
A(1,:) = [ -df/m A3/m -A3/m ];                          B(1,:) = [0 -1/m ];
A(2,:) = [ -A3/Cf -Rv*xvq0/(2*Cf*sqrt(Ps-p1q0)) 0];     B(2,:) = [Rv*sqrt(Ps-p1q0)/Cf 0];     
A(3,:) = [ A3/Cf 0 -Rv*xvq0/(2*Cf*sqrt(p2q0))];         B(3,:) = [-Rv*sqrt(p2q0)/Cf 0]; 


%%                          Making Initial Conditions accesible
%
% DEFINITION OF INITIAL CONDITION BASED ON Shortcuts
%       _05_10k         (1)
%       _05_0k          (2)
%       _1_0k           (3)
%       _1_10k          (4)

xvqINI          = [xvq_05_10k xvq_05_0k xvq_1_0k xvq_1_10k ];
feINI           = [fe_05_10k fe_05_0k fe_1_0k fe_1_10k];

vqINI       = [0 0 0 0];
vqINI(1)        = double(vq_05_10k);
vqINI(2)        = double(vq_05_0k);
vqINI(3)        = double(vq_1_0k);
vqINI(4)        = double(vq_1_10k);

p1qINI      = [0 0 0 0];
p1qINI(1)       = double(p1q_05_10k);
p1qINI(2)       = double(p1q_05_0k);
p1qINI(3)       = double(p1q_1_0k);
p1qINI(4)       = double(p1q_1_10k);


p2qINI      = [0 0 0 0];
p2qINI(1)       = double(p2q_05_10k);
p2qINI(2)       = double(p2q_05_0k);
p2qINI(3)       = double(p2q_1_0k);
p2qINI(4)       = double(p2q_1_10k);



%%                          Substitution of Symbolic State-Space     
%
xvq0            = xvqINI(z);
fe0             = feINI(z);
vq0             = vqINI(z);
p1q0            = p1qINI(z);
p2q0            = p2qINI(z);


x0      =[vq0 p1q0 p2q0];
u0      =[xvq0 fe0];

 param; 

A=eye(3); B = [0 0; 0 0 ; 0 0];
A(1,:) = [-df/m A3/m -A3/m ];                          B(1,:) = [0 -1/m ];
A(2,:) = [-A3/Cf -Rv*xvq0/(2*Cf*sqrt(Ps-p1q0)) 0];     B(2,:) = [Rv*sqrt(Ps-p1q0)/Cf 0];     
A(3,:) = [A3/Cf 0 -Rv*xvq0/(2*Cf*sqrt(p2q0))];         B(3,:) = [-Rv*sqrt(p2q0)/Cf 0]; 

C=eye(3); D0=zeros(3,2);
C1=[1 0 0];
C2=[0 1 0];
C3=[0 0 1];D=[0 0];

%%                          Definition of OUTPUT
% FROM U(1)
[N11,D11] = ss2tf(A,B,C1,D,1);
H_11=tf(N11,D11);
[N12,D12] = ss2tf(A,B,C2,D,1);
H_12=tf(N12,D12);
[N13,D13] = ss2tf(A,B,C3,D,1);
H_13=tf(N13,D13);

% FROM U(2)
[N21,D21] = ss2tf(A,B,C1,D,2);
H_21=tf(N21,D21);
[N22,D22] = ss2tf(A,B,C2,D,2);
H_22=tf(N22,D22);
[N23,D23] = ss2tf(A,B,C3,D,2);
H_23=tf(N23,D23);


%%                          (ZEROS POLES OF ALL TFS)
%
%
%       _05_10k         (1)
%       _05_0k          (2)
%       _1_0k           (3)
%       _1_10k          (4)
k=z;
switch k
    case 1
        STR = 'xvq=0.005 & fe=10k [_05_10k]';
    case 2
        STR = 'xvq=0.005 & fe=0 [_05_0k]';
    case 3
        STR = 'xvq=0.01 & fe=0 [_1_0k]';
    case 4
        STR = 'xvq=0.01 & fe=10k [_1_10k]';
    otherwise
end
TL=strcat('Exc.6: Poles-Zeros with ',STR);


ex6p_h(1) = handle(figure);
ex6p_h(2) = handle(figure);
ex6p_h(3) = handle(figure);
ex6p_h(4) = handle(figure);


if ~exist('ex6p_h')
        ex6p_h(z)=figure('Name',TL,'numbertitle','off');
else
    if ~isvalid(ex6p_h)
        ex6p_h(z)=figure('Name',TL,'numbertitle','off');
    else   
        set(groot,'CurrentFigure',ex6p_h(z));
        delete(ex6p_h)
        ex6p_h(z)=figure('Name',TL,'numbertitle','off');
    end
end

subplot(2,3,1);pzmap(H_11);axis auto;grid;title('H11: xvq -> vq');
subplot(2,3,2);pzmap(H_12);axis auto;grid;title('H12: xvq -> P1');
subplot(2,3,3);pzmap(H_13);axis auto;grid;title('H13: xvq -> P2');
subplot(2,3,4);pzmap(H_21);axis auto;grid;title('H21: fe -> vq');
subplot(2,3,5);pzmap(H_22);axis auto;grid;title('H22: fe -> P1');
subplot(2,3,6);pzmap(H_23);axis auto;grid;title('H23: fe -> P2');

display(x0);
display(u0);











%%                  (Plotting H1: xvq -> P2 at (xvq0,p1q0,p2q0) | u(1)_0=10k, u(2)_0=0.005 |
%
% if ~exist('ex6l1_h')
%         ex6l1_h(1)=figure('Name','Exc.5: Matlab - H_11','numbertitle','off');
% else
%     if ~isvalid(ex6l1_h)
%         ex6l1_h(1)=figure('Name','Exc.5: Matlab - H_11','numbertitle','off');
%     else   
%         set(groot,'CurrentFigure',ex6l1_h(1));
%         delete(ex6l1_h)
%         ex6l1_h(1)=figure('Name','Exc.5: Matlab - H_11','numbertitle','off');
%     end
% end
% display('H_11');
% display(zpk(H_11));
% subplot(1,3,1);step(H_11);axis auto;grid;
% subplot(1,3,2);pzmap(H_11);axis auto;grid;
% subplot(1,3,3);margin(H_11);axis auto;grid;