function res = shoot(w)
global x0 xf ty norm_tf dp v
 
% rename variables
p0 = w(1:2);
tf = w(end);
norm_tf = tf;

% time vector (transformation to fixed endtime)
tspan = linspace(0, 1, 750);

% solveroptions
odeoptions = odeset( 'AbsTol' ,  1e-10, 'RelTol' ,  1e-10,  'Refine',  10);

% integrate the canonical system
[t, y] = ode45(@rhs,tspan,[x0;p0],odeoptions);

% save and rename variables
ty = [t y];
x_tf = y(end,  1:2)' ;
p_tf = y(end,  3:4)' ;

% evaluate the transversality condition 
u_tf = atan(p_tf(2)/p_tf(1));
H_tf = 1+p_tf(1)*v*cos(u_tf)+p_tf(2)*(4/(xf(1)^2)*x_tf(1)*(xf(1)-x_tf(1))*dp+v*sin(u_tf));

% calculate the residuum
res = [ x_tf-xf ;
       H_tf-0 ];
end