%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Continuous position specs%
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%tr = 0.03 +- 0.05
tr_max = 0.3 + 0.05;
tr_min = 0.3 - 0.05;

%Overshoot = 2%;
Mp = 0.02;

%No ts specs
ts = -1;

%Error = 0.5%
ess = 0.005;

%%%%%%%%%%%%%%%%%%%%%%
%Discrete speed specs%
%%%%%%%%%%%%%%%%%%%%%%

%tr = the fastest posible
trz = 0.2;

%Overshoot = 2%;
Mpz = 0;

%No ts specs
tsz = -1;

%Error = 0.5%
essz = 0.5/50;

%%%%%%%%%%%%%%%%%%%%%%
%Discrete pos specs%
%%%%%%%%%%%%%%%%%%%%%%

%tr = the fastest posible
trpz = 0.9;

%Overshoot = 2%;
Mppz = 0;

%No ts specs
tspz = -1;

%Error = 0.5%
esspz = 0.5/50;