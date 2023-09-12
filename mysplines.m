clearvars
close all

a = -1.0; b = 1.0; N = 10; M = 200; n = 10; % (n = 1,...,N)
f = @(x) 1./(1 + 25*x.^2);

%Partitions
%Coarse partition
xN = linspace(a,b,N+1); fN = f(xN); 

%Finer partition
xM = linspace(a,b,M+1); fM = f(xM);

%Linear splines (polygonal): interp1
lM = interp1(xN, fN, xM);

plot(xN, fN, 'ok');
hold on
plot(xM, fM, 'g-');
plot(xM, lM, 'r-');

hold off

%Error 

%Mean error
fprintf('Error. Linear splines (polygonal)\n')
meanErr = norm(fM-lM,1)/(M+1);
fprintf('degree: %d Mean Error: %8.4e\n', n, meanErr)

%Max error
maxErr = norm(fM-lM,inf);
fprintf('degree: %d Max. Error: %8.4e\n', n, maxErr)

%Cubic splines: spline
sM = spline(xN, fN, xM);

figure()
plot(xN, fN, 'ok');
hold on
plot(xM, fM, 'b-');
plot(xM, sM, 'r-');

hold off

%Error 

%Mean error
fprintf('Error. Cubic splines')
meanErr = norm(fM-sM,1)/(M+1);
fprintf('degree: %d Mean Error: %8.4e\n', n, meanErr)

%Max error
maxErr = norm(fM-sM,inf);
fprintf('degree: %d Max. Error: %8.4e\n', n, maxErr)
