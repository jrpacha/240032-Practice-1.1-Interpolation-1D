%Show Runge phenomenon
clearvars
close all

a = 1.0; b = -1.0; N = 10; M = 200;
f = @(x) 1./(1+25*x.^2);

xN = linspace(a,b,N+1); fN = f(xN);
xM = linspace(a,b,M+1); fM = f(xM);

%LSF approximation: polyfit
degrees = [3,5,7,10];

figure()
set(gcf,'defaultTextInterpreter','LaTeX')

for k = 1:size(degrees,2)
    pn = polyfit(xN,fN,degrees(k));
    pM = polyval(pn,xM);
    subplot(3,2,k);
    plot(xN,fN,'o',...
        'Marker','o',...
        'MarkerFaceColor','black',...
        'MarkerEdgeColor',...
        'black',...
        'MarkerSize', 2, ...
        'lineWidth',1)
    hold on
    plot(xM,fM,'-','color','red')
    plot(xM,pM,'-','color','blue')
    xlabel('$x$')
    ylabel('$y\quad$','rot',360)
    if degrees(k) < N
        title(['LSF polynomial of deg. ', num2str(degrees(k))],...
            'interpreter','LaTeX')
    else
        title(['Interp. polynomial of deg. ', num2str(degrees(k))],...
            'interpreter','LaTeX')
    end
    ymax = max([fM,pM]);
    ymin = min([fM,pM])-0.1;
    axis([-1,1,ymin,ymax])
    hold off
end

%Linear splines: interp1
lM = interp1(xN,fN,xM);
subplot(3,2,5)
plot(xN,fN,'o',...
        'Marker','o',...
        'MarkerFaceColor','black',...
        'MarkerEdgeColor',...
        'black',...
        'MarkerSize', 2, ...
        'lineWidth',1)
title('1D Linear spline approximation')
hold on
plot(xM,fM,'-','color','red')
plot(xM,lM,"LineStyle",'-','color','blue')
xlabel('$x$')
ylabel('$y\quad$','rot', 360)
hold off

%Cubic splines: spline
sM = spline(xN,fN,xM);
subplot(3,2,6)
plot(xN,fN,'o',...
        'Marker','o',...
        'MarkerFaceColor','black',...
        'MarkerEdgeColor',...
        'black',...
        'MarkerSize', 2, ...
        'lineWidth',1)
title('1D cubic spline approximation')
hold on
plot(xM,fM,'-','color','red')
plot(xM,sM,"LineStyle",'-','color','blue')
xlabel('$x$')
ylabel('$y\quad$','rot', 360)
hold off