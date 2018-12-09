% main.m depends on shoot.m, rhs.m and drawBoat.m
clear all
close all
global x0 xf ty dp v

% constant boat velocity
v = 3;

% peak drift velocity at xf(1)/2
dp = -2; 

% initial state
x0 = [0;0];

% end state
xf = [500;150];

% line distance for an initial time guess
tf0 = sqrt(xf(1)^2+xf(2)^2)/v;

% initial co-states
p0 = [-1; 1];

% solve the nonlinear equations
w = fsolve(@shoot,[p0;tf0],optimset('MaxFunEvals',10000));

% start the animation
drawBoat(ty, dp, xf, w);

