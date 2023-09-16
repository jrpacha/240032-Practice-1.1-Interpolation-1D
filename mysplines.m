clearvars
close all

a = -1.0; b = 1.0; N = 10; M = 200;
f = @(x) 1./(1 + 25*x.^2);

%Partitions

%Coarse partition
xN = linspace(a,b,N+1); fN = f(xN); 

%Finer partition
xM = linspace(a,b,M+1); M1 = length(xM); fM = f(xM);

%Linear spline (polygonal): interp1
lM = interp1(xN,fN,xM);
figure()
set(gcf,'defaultTextInterpreter','LaTeX')
subplot(1,2,1)
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
ymax = max([fM,lM]);
ymin = min([fM,lM])-0.1;
axis([-1,1,ymin,ymax])
pbaspect([1 1 1])
hold off

%Cubic spline: spline
sM = spline(xN,fN,xM);
subplot(1,2,2)
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
ymax = max([fM,sM]);
ymin = min([fM,sM])-0.1;
axis([-1,1,ymin,ymax])
pbaspect([1 1 1])
hold off

%Errors 
format short e
format compact

%Create a Matlab table
meanErr = [norm(fM-lM,1)/M1; norm(fM-sM)/M1];
maxErr = [norm(fM-lM,Inf); norm(fM-sM,Inf)];

%Create a table
%Output using sprintf:
t0 = sprintf('%35s\n','Mean and Max. Errors');
t1 = sprintf('%10s%17s%12s\n', ...
    '','Mean Err.','Max. Err.');
t2 = sprintf('%15s%12.4e%12.4e\n',...
    [["Linear Spline"; "Cubic Spline"], meanErr, maxErr]'); 
disp([t0 t1 t2])

errSplines = array2table([meanErr, maxErr],...
    'VariableNames',{'Mean Err.','Max. Err.'},...
    'RowNames',{'Linear Spline';'Cubic Spline'});

errSplines = table(errSplines,...
    'VariableNames',{'Mean and Max. Errors'}); % Nested table


disp(errSplines);