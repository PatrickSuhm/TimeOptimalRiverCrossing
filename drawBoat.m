function drawBoat(ty, dp, xf, w)
% position of the boat
px = ty(:,2);
py = ty(:,3);
u = atan(ty(:,5)./ty(:,4));

% create the river and drift vectors
b = xf(1);  
h = b/2;
figure('position', [50 500 600 500])
plot([0 0],[-h h],'k','LineWidth',4)
title('TIME OPTIMAL RIVER CROSSING (Zermelos navigation problem)')
hold on
plot([b b],[-h h],'k','LineWidth',4)
[x1,x2] = meshgrid(0:50:b,-h:100:h);
q1 = 0*x1;
q2 = 4/b^2*x1.*(b-x1)*dp;
hq = quiver(x1,x2,q1,q2);
set (hq, "maxheadsize", 0.15);
xlim([-100 b+100]);
ylim([-h-100 h+150]);
xlabel('x_1 in m');
ylabel('x_2 in m');
boatLength = 0.15*b;

% plot trajectory start
h0 = plot(0, 0, 'r');

% plot start position
h10 = plot([px(1)  px(1)+boatLength/6*cos(0)],[py(1) py(1)],'r','LineWidth',5);

% plot boat at initial conditions
h1 = plot([px(1)  px(1)+boatLength/2*cos(u(1))],[py(1) py(1)+boatLength/2*sin(u(1))],'k','LineWidth',5);

% plot end position
h2 = plot([b b+boatLength/6*cos(0)],[xf(2) xf(2)],'r','LineWidth',4);

% plot some info
h3 = text(-b*0.15, h*1.5, ['drift velocity: ', num2str(0)], 'fontsize', 11);
h4 = text(-b*0.15, h*1.4, ['steering angle: ', num2str(0)], 'fontsize', 11);
h5 = text(-b*0.15, h*1.3, ['trajectory time: ', num2str(0), ' s'], 'fontsize', 11);
set(gca,'Color',[0.95 0.95 0.95],'XColor','k','YColor','k')
set(gcf,'Color',[0.95 0.95 0.95])

%start timer
tic

% animation in a for loop 
for i = 1:length(px)
  
  % draw trajectory
  set(h0, 'xdata', px(1:i),'ydata', py(1:i))
  
  % update pole and cart position
  set(h1, 'xdata', [px(i), px(i)+boatLength/2*cos(u(i))], 'ydata',[py(i), py(i)+boatLength/2*sin(u(i))]);
  
  % print drift velocity, angle and traj time
  set(h3, 'string',['drift velocity: ', num2str(4/b^2*px(i)*(b-px(i))*dp), ' m/s']);
  set(h4, 'string',['steering angle: ', num2str(u(i)*180/pi), ' °']);
  set(h5, 'string',['trajectory time: ',num2str(w(3)*ty(i,1)),' s']);
  drawnow();
  
  % strop the animation when q is pressed
  if (kbhit (1) == 'q')
    break
  endif
  
  % pause the plotting
  pause(0.01);
end

end
