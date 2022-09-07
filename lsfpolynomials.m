%Least square polynomials
clearvars
close all

% Exmaple functions
%f = @(x) exp(x/2).*sin(2*x);
%f = @(x) 1./(1+x.^2);
f = @(x) 1./(1+25*x.^2); %Runge phenomenon....
a = -1; b = 1; numSamplePoints = 11; degree = 4;

% To plot the original funciton
delta = 0.01;
numPlotPoints = floor((b-a)/delta)+1;
x = linspace(a,b,numPlotPoints);
y = f(x);

%Generate table
T = sample(f,a,b,numSamplePoints);

%Plot sample
plot(T.DataX, T.DataY, 'o', 'MarkerFaceColor','red', 'MarkerSize', 6)
hold on
plot(x,y,'--','color','green','LineWidth',1);

%lsf polynomial: polyfit
p = polyfit(T.DataX,T.DataY,degree);
%p(1) = p(1) + 0.01;  %Test: change a bit one of the coefficients

%Plot
yPol = polyval(p,x);              
yPolAtDataX = polyval(p,T.DataX);

plot(x, yPol,'-','Color','blue','LineWidth', 2)
plot(T.DataX,yPolAtDataX,'o','MarkerFaceColor','yellow','MarkerSize',6)

for i=1:length(T.DataX)  %to plot the "error" vertical segments
    line=[T.DataX(i), T.DataY(i);
        T.DataX(i), yPolAtDataX(i)];
    plot(line(:,1), line(:,2),'-','color','black','lineWidth',2)
end

errSQRT = norm(yPolAtDataX-T.DataY,2);    %Error (norm-2) 
errINF = norm(yPolAtDataX-T.DataY,Inf);   %Error (norm-INF)

set(gcf,'defaultTextInterpreter','LaTeX')
title(['LSF degree: ', num2str(degree),...
    ', err$_{2}$ = ',num2str(errSQRT), ...
    ', err$_\infty$ = ', num2str(errINF)],...
    'FontSize',12)
xlabel('$$x$$')
ylabel('$$y$$','rot',360)
hold off

fprintf('degree: %d, lsf-err(norm-2): %e, lsf-err(norm-inf) : %e\n', ...
    degree,errSQRT,errINF)