clearvars
close all

f=@(x) 1./(1+25*x.^2);

a=-1;
b=1;
x=a:0.2:b;
y=f(x);
xOrig=a:0.01:b;
yOrig=f(xOrig);

degree=[3,5,7,10];

figure()
for i=1:size(degree,2)
    subplot(3,2,i);
    plot(x,y,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
        'LineWidth',2,'MarkerEdgeColor','black');
    hold on
    plot(xOrig,yOrig,'-r')
    p = polyfit(x,y,degree(i));
    yy = polyval(p,xOrig);
    plot(xOrig,yy,'--b')
    if (degree(i) < 10)
        title(['Degree ',num2str(degree(i)),' approximation']);
    else
        title(['Degree ',num2str(degree(i)),' interpolation']);
    end
    axis([-1,1,-0.2,1])
    hold off
end

% Polygonal
xp=a:0.1:b;
yp=f(xp);
subplot(3,2,5)
plot(xp,yp,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
            'LineWidth',2,'MarkerEdgeColor','black');
hold on
plot(xOrig,yOrig,'-r')
yyp = interp1(xp,yp,xOrig);
plot(xOrig,yyp,'--b')
title('1D polygonal approximation')
hold off

% Spline
subplot(3,2,6)
plot(xp,yp,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
            'LineWidth',2,'MarkerEdgeColor','black');
hold on
plot(xOrig,yOrig,'-r')
yys = spline(xp,yp,xOrig);
plot(xOrig,yys,'--b')
title('1D spline approximation')
hold off

% ========================================================================
% Exercise:
% Compute the mean and maximum error between the original 
% curve and their approximation according to the polynomial 
% degree for the measure points x=a:0.2:b and y=f(x). (Use 
% all plotted points, xx=a:0.01:b to compute errors).

f=@(x) 1./(1+25*x.^2);

a=-1;
b=1;
x=a:0.2:b;
y=f(x);
xOrig=a:0.01:b;
yOrig=f(xOrig);
numPoints = size(xOrig,2);

degree=[3,5,7,9];

fprintf(1,'Exercise 1:\n');
fprintf(1,'%5s%11s%14s\n','DEG.','MEAN.ERR.','MAX.ERR.');
for i=1:size(degree,2)
    p = polyfit(x,y,degree(i));
    yy = polyval(p,xOrig);
    meanErr = sum(abs(yy-yOrig))/numPoints;
    maxErr = max(abs(yy-yOrig));
    %FPRINTF formatted output: Error values are printed with 5 decimal 
    %places and 14 chars of total width, so the corresponding format spec 
    % is either %14.5E or %14.4e.
    fprintf(1,'%3d%14.5E%14.5E\n',degree(i),meanErr,maxErr);
end
    
    
    