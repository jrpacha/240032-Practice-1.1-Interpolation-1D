%Show Runge phenomenon
clearvars
close all

f = @(x) 1./(1+25*x.^2); %Runge phenomenon....
a = -1; b = 1; numSamplePoints = 11; degree = [3,5,7,10];

% To plot the original funciton
delta = 0.01;
numPlotPoints = floor((b-a)/delta)+1;
x = linspace(a,b,numPlotPoints);
y = f(x);

%Generate table
T = sample(f,a,b,numSamplePoints);

figure()
set(gcf,'defaultTextInterpreter','LaTeX')
title('LSF polynomials v.s. splines')
for k = 1:length(degree)
    subplot(3,2,k)
    plot(T.DataX,T.DataY,'o','MarkerFaceColor','red','MarkerSize',6)
    hold on
    plot(x,y,'--','color','green','LineWidth',1)
    p = polyfit(T.DataX,T.DataY,degree(k));
    yPol = polyval(p,x);
    plot(x,yPol,'-','color','blue','LineWidth',1)
    if degree(k) ~= numSamplePoints-1
        title(['LSF polynomial. Degree: ',num2str(degree(k))])
    else
        title(['Inter. polynomial. Degree: ',num2str(degree(k))])
    end
    xlabel('$$x$$')
    ylabel('$$y\quad$$','rot',360)
    yMAX = max([y,yPol]);
    yMIN = min([y,yPol]);
    axis([a,b,yMIN,yMAX]);
    hold off
end

%Linear splines
subplot(3,2,k+1)
plot(T.DataX, T.DataY,'o','MarkerFaceColor','red','MarkerSize',6)
hold on
plot(x,y,'--','color','green','LineWidth',1);
yLinearSpline = interp1(T.DataX,T.DataY,x);
plot(x,yLinearSpline,'-','color','blue','LineWidth',1)
title('Linear spline (p-w deg.-1 polynom.)')
xlabel('$$x$$')
ylabel('$$y\quad$$','rot',360)
yMAX = max([y,yLinearSpline]);
yMIN = min([y,yLinearSpline]);
axis([a,b,yMIN,yMAX]);
hold off

%Cubic splines
subplot(3,2,k+2)
plot(T.DataX, T.DataY,'o','MarkerFaceColor','red','MarkerSize',6)
hold on
plot(x,y,'--','color','green','LineWidth',1);
yCubicSpline = spline(T.DataX,T.DataY,x);
plot(x,yCubicSpline,'-','color','blue','LineWidth',1)
title('Cubic spline (p-w deg.-3 polynom.)')
xlabel('$$x$$')
ylabel('$$y\quad$$','rot',360)
yMAX = max([y,yCubicSpline]);
yMIN = min([y,yCubicSpline]);
axis([a,b,yMIN,yMAX]);
hold off