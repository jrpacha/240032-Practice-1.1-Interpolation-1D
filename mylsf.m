clearvars
close all

a = -1.0; b = 1.0; N = 10; M = 200; n = 11; % (n = 1,...,N)
f = @(x) 1./(1 + 25*x.^2);

%Partitions
%Coarse partition
xN = linspace(a,b,N+1); fN = f(xN); 

%Finer partition
xM = linspace(a,b,M+1); fM = f(xM);

plot(xN, fN, 'ok');
hold on
plot(xM, fM, 'g-');

%LSF: polyfit + polyval 
pn = polyfit(xN, fN, n);
pM = polyval(pn,xM);
plot(xM, pM, 'r-');

hold off

%Error

%E(pn)
ep = norm(fN-polyval(pn,xN));
fprintf('degree: %d E(pn) = %8.4e\n', n, ep)

%Mean error
meanErr = norm(fM-pM,1)/(M+1);
fprintf('degree: %d Mean Error: %8.4e\n', n, meanErr)

%Max error
maxErr = norm(fM-pM,inf);
fprintf('degree: %d Max. Error: %8.4e\n', n, maxErr)
