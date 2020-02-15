% Exercise:
% Compute the mean and maximum error between the original curve and their
% approximation according to the polynomial degree for the measure points 
% x=a:0.2:b and y=f(x). (Use all plotted points, xx=a:0.01:b to compute 
% errors).
clearvars
close all

f=@(x) 1./(1+25*x.^2);

a=-1.0;
b=1.0;
x=a:0.2:b;      % 11 points (table)
xx = a:0.01:b;  % 201 points (to plot & compute errors)
y = f(x);
ff = f(xx);
    
degree = [3,5,7,9];
sz = size(degree,2);
numPoints = size(xx,2);

%Create a table
T = table('Size',[sz, 3],'VariableTypes',...
    {'uint8','double','double'},...
    'VariableNames',{'Degree','MeanError','MaxError'});

for k=1:sz
    p = polyfit(x,y,degree(k));
    pxx = polyval(p,xx);
    %mean error
    meanErr = sum(abs(ff-pxx))/numPoints;
    %max error
    maxErr = max(abs(ff-pxx));
    T.Degree(k,1) = degree(k);
    T.MeanError(k,1) = meanErr;
    T.MaxError(k,1) = maxErr;
end

format short e
T