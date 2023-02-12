clearvars
close all

f=@(x) 1./(1+25*x.^2);
a = -1; b = 1;
nDiv = 10;         %number of divisions
n = nDiv + 1;      %number of points
h = (b-a)/nDiv;
%xSample = a:0.2:b; 
xSample = linspace(a,b,nDiv+1);
ySample = f(xSample);
%x = linspace(-1,1,201);
x = a:0.01:b;
y = f(x);

p = polyfit(xSample,ySample,10);
px = polyval(p,x);
plot(x,y,'-','color','black')
hold on
plot(xSample,ySample,'o','MarkerFaceColor','red',...
    'MarkerSize',10)
plot(x,px,'-','color','blue')
hold off

degree = [3,5,7,10];

for i = 1:length(degree)
    p = polyfit(xSample,ySample,degree(i));
    px = polyval(p,x);
    subplot(3,2,i)
    plot(x,y,'-','color','black')
    hold on
    plot(xSample,ySample,'o','Marker','o',...
        'MarkerFaceColor','red',...
        'MarkerSize',10)
    plot(x,px,'-','color','blue')
    if degree(i) < nDiv
        title(['Degree ',num2str(degree(i)),...
            ' LSF approximation'])
    else
        title(['Degree ', num2str(degree(i)),...
            ' interpolation'])
    end
    axis([-1,1,-0.2,1]);
    hold off
end

%Splines,
%Linear spline (polygonal)
lx=interp1(xSample,ySample,x);
subplot(3,2,5)
plot(x,y,'-','color','black')
hold on
plot(xSample,ySample,'o','Marker','o',...
     'MarkerFaceColor','red',...
     'MarkerSize',10)
plot(x,lx,'-','color','blue')
title('1D polygonal approximation')
axis([-1,1,-0.2,1]);
hold off

%Cubic spline (polygonal)
sx=spline(xSample,ySample,x);
subplot(3,2,6)
plot(x,y,'-','color','black')
hold on
plot(xSample,ySample,'o','Marker','o',...
     'MarkerFaceColor','red',...
     'MarkerSize',10)
plot(x,sx,'-','color','blue')
title('1D spline approximation')
axis([-1,1,-0.2,1]);
hold off


% Exercise
% Compute the mean and maximum error between the original
% curve and their approximation according to the polynomial
% degree for the measure points x=a:0.2:b and y=f(x). (Use
% all plotted points, xx=a:0.01:b to compute errors).
fprintf('%5s%13s%14s\n','Deg.','MEAN ERR.','MAX. ERR.')
for i = 1:length(degree)
    p = polyfit(xSample,ySample,degree(i));
    px = polyval(p,x);
    maxErr = norm(px-y,inf);
    meanErr = norm(px-y,1)/length(y);
    fprintf('%4d%14.4e%14.4e\n',degree(i),meanErr,maxErr)
end






 




    




