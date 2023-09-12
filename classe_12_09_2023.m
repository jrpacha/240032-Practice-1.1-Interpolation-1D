%Practice 1-1
% Interpolation 1D

clearvars
close all

% Inline functions
%f = @(x) 1./(1 + x.^2);
f = @(x) 1./(1 + 25*x.^2); % Runge's phenomenon

% Sample
xp = -1.0:0.2:1.0;
yp = f(xp);
degPolInterp = size(xp,2)-1;

% Points to plot the function and its approximations
xx = -1:0.01:1;
yy = f(xx);
m = size(xx, 2);

% LSF + Interpolation: polyfit + polyval
degree = [3,5,7,10];

for i = 1:size(degree,2)
    p = polyfit(xp,yp,degree(i));
    px = polyval(p,xx);
    subplot(3,2,i);
    plot(xp,yp,'ko', ...
        'MarkerFaceColor','black', ...
        'MarkerSize',4)
    hold on
    plot(xx,px,'r-','LineWidth',1.5)
    plot(xx,yy,'g-','LineWidth',1.5)
    if degree(i) == degPolInterp
        title(['Degree ', num2str(degree(i)), ' interpolation'])
        legend('Sample points','Interp. polynomial','Function')
    else
        title(['Degree ', num2str(degree(i)), ' approximation'])
        legend('Sample points','LSF polynomial','Function')
    end
    axis([-1,1,-0.2,1])
    hold off
end

% Splines

% Lineal Splines: interp1
yl = interp1(xp,yp,xx);
subplot(3,2,5);
plot(xp,yp,'Marker','o','MarkerFaceColor','green','MarkerSize',3)
hold on
plot(xx,yl,'-','color','blue')
plot(xx,yy,'-','color','red')
title('1D polygonal approximation')
hold off

% Cúbic splines: spline
ys = spline(xp,yp,xx);
subplot(3,2,6);
plot(xp,yp,'o','MarkerFaceColor','green','MarkerSize',3)
hold on
plot(xx,ys,'-','color','blue')
plot(xx,yy,'-','color','red')
title('1D spline approximation')
hold off

% Exercici 1
clc
fprintf('\tExercici 1\n')
fprintf('%5s%12s%12s\n','deg','Mean Err.','Max. Err.')
for n = degree
    p = polyfit(xp, yp, n);
    px = polyval(p,xx);
    meanErr = norm(px-yy,1)/m;
    maxErr = norm(px-yy,inf);
    fprintf('%5d%12.4f%12.4f\n',n,meanErr,maxErr)
end