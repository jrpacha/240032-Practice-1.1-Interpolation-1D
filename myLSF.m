clearvars
close all

a = -1; b = 1; N = 10; delta = 0.01; M = ceil((b-a)/delta); n = 5;

f = @(x) exp(x/2).*sin(2*x); 
myFunction = '$$f(x) = \mathrm{e}^{x/2}\sin\left(2x\right)$$';

%f = @(x) 1./(1+x.^2);
%myFunction = '$$f(x) = \frac{1}{1 + x^{2}}$$';

%f = @(x) 1./(1+25*x.^2); %Runge phenomenon....
%myFunction = '$$f(x) = \frac{1}{1 + x^{2}}$$';

xN = linspace(a, b, N+1); fN = f(xN);
xM = linspace(a, b, M+1); fM = f(xM);

%Plot sample points
plot(xN, fN, 'o', 'MarkerFaceColor','red', 'MarkerSize', 6)
hold on

%Plot the function
plot(xM,fM,'--','color','green','LineWidth',1);

%LSF polynomial: polyfit (for n = N: interpolation polynomial)
pn = polyfit(xN, fN, n);

%pn(1) = pn(1) + 0.01;  %Test: change a bit one of the coefficients

%Plot
pM = polyval(pn, xM);              
pN = polyval(pn, xN);

plot(xM,pM,'-','Color','blue','LineWidth', 2)
plot(xN,pN,'o','MarkerFaceColor','yellow','MarkerSize',6)

for i=1:length(xN)  %to plot the "error" vertical segments
    line=[xN(i), fN(i);
          xN(i), pN(i)];
    plot(line(:,1), line(:,2),'-','color','black','lineWidth',2)
end
lsfError = norm(pN-fN,2);    %Error (norm-2) 

if n < N
    typeOfPolynomial = 'LSF polynomial';
else
    typeOfPolynomial = 'Interp. polynomial';
end

set(gcf,'defaultTextInterpreter','LaTeX')
title({myFunction, ...
    [typeOfPolynomial, ...
    ' of degree $n = $', num2str(n),...
    ', $E[p_{n}] = $ ',num2str(lsfError)]}, ...
    'FontSize',12)
xlabel('$$x$$')
ylabel('$$y$$','rot',360)
legend('Sample points', 'Function', 'LSF polynomial',...
    'Location','southEast')

hold off

fprintf('degree: %d, E[pn] =  %.4e\n', n, lsfError)