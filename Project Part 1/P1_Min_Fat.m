
function [output] = P1_Min_Fat

x0 = [1000 1000 1000 1000]; % initial guess 2 muscles/2 JRFs

% Non-linear optimization
[output] = fmincon(@BiBrachCost, x0, [],[],[],[],[],[],@BiBrachConst);

% Cost function
function [y] = BiBrachCost(F)
y = F(1)/(5.1/100) + F(2)/(1.2/100); 
% cost function: Dul et al. 1981
% Computes for minimum fatigure criterion

% Constraints
function [Cineq, Ceq] = BiBrachConst(F)
% known variables
m=52.16; %kg
m_forearm = 0.0187 * m; %kg
m_hand = 0.0065 * m; %kg
w_forearm = m_forearm*9.81; %N
w_hand = m_hand*9.81; %N
theta = deg2rad(15.95); %rad
a = 0.042; %m, Youm, 1982
b = 0.20; %m, Youm, 1982
c = 0.063; %m, Youm, 1982
d = 0.38; %m, Personal forearm length

%F(1) = FM1
%F(2) = FM2
%F(3) = FJx
%F(4) = FJy

% Inequality Constraints
Cineq = [-F(1) -F(2)];

% Equality Constraints
Ceq(1) = -F(2)*cos(theta) + F(3) ;
Ceq(2) = -F(4) + F(1) + F(2)*sin(theta) - w_forearm - w_hand;
Ceq(3) = F(1)*a - w_forearm*b + F(2)*sin(theta)*c - w_hand*d;

