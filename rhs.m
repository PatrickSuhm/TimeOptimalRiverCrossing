function yp = rhs(t,y)
global norm_tf v dp xf

% rename variables
b = xf(1);
p1 = y(3);
p2 = y(4);
x1 = y(1);

% evaluate the stationary condition
u = atan(p2/p1);

% calculate the flow velocity
d = 4/(b^2)*x1*(b-x1)*dp;

% evaluate the canonical system
yp = norm_tf*[ v*cos(u);...
             d+v*sin(u);...
             -dp*p2*(4/b-8/(b^2)*x1);...
             0 ];
end