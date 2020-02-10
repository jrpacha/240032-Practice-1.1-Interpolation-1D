clearvars
close all

f=@(x) 1./(1+25*x.^2);

a=-1.0;
b=1.0;
x=a:0.2:b;      % 11 points (table)
xx = a:0.01:b;  % 201 points (to plot & compute errors)
y = f(x);
ff = f(xx);
N = size(xx,2);

deg=[3,5,7,9];

fprintf("%8s%12s%16s\n",'Degree','meanError','maxError')
for i=deg
    p=polyfit(x,y,i);
    yy=polyval(p,xx);
    meanErr = sum(abs(yy-ff))/N;
    maxErr = max(abs(yy-ff));
    fprintf("%5d%16.5e%16.5e\n",i,meanErr,maxErr)
end
    