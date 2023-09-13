%Practice 1-1
% Interpolation 1D

clearvars
close all

a = -1.0; b= 1.0; N = 10; M = 200; n = 5; %degree of LSF polynomial 

% Inline functions
%f = @(x) exp(x/2).*sin(2*x);
%f = @(x) 1./(1 + x.^2);
f = @(x) 1./(1 + 25*x.^2); %To show runge's phenomenon

xN = linspace(a,b,N+1); fN = f(xN);
xM = linspace(a,b,M+1); M1 = length(xM); fM = f(xM);

% LSF + Interpolation: polyfit + polyval
degrees = [3,5,7,10];

for i = 1:size(degrees,2)
    pn = polyfit(xN,fN,degrees(i));
    pM = polyval(pn,xM);
    subplot(3,2,i);
    plot(xN,fN,'ko', ...
        'MarkerFaceColor','black', ...
        'MarkerSize',3)
    hold on
    plot(xM,fM,'r-','LineWidth',1.5)
    plot(xM,pM,'b-','LineWidth',1.5)
    if degrees(i) < N
        title(['Degree ', num2str(degrees(i)), 'LSF-approx.'])
        %legend('Sample points','LSF polynomial','Function')
    else
        title(['Degree ', num2str(degrees(i)), 'Interp.'])
        %legend('Sample points','Interp. polynomial','Function')
    end
    axis([-1,1,-0.2,1])
    hold off
end

% Splines

% Lineal Splines: interp1
lM = interp1(xN,fN,xM);
subplot(3,2,5);
plot(xN,fN,'Marker','o','MarkerFaceColor','black','MarkerSize',3)
hold on
plot(xM,fM,'r-','LineWidth',1.5)
plot(xM,lM,'b-','LineWidth',1.5)
title('1D polygonal approximation')
hold off

% Cúbic splines: spline
sM = spline(xN,fN,xM);
subplot(3,2,6);
plot(xN,fN,'o','MarkerFaceColor','green','MarkerSize',3)
hold on
plot(xM,fM,'r-','LineWidth',1.5)
plot(xM,sM,'b-','LineWidth',1.5)
title('1D spline approximation')
hold off

% Exercici 1
clc
fprintf('\tExercici 1\n')
fprintf('%5s%12s%12s\n','deg','Mean Err.','Max. Err.')
for n = degrees
    pn = polyfit(xN, fN, n);
    pM = polyval(pn,xM);
    meanErr = norm(fM-pM,1)/M1;
    maxErr = norm(fM-pM,Inf);
    fprintf('%5d%12.4e%12.4e\n',n,meanErr,maxErr)
end