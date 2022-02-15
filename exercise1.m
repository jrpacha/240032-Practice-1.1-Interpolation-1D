clearvars
close all

% Exercise:
% Compute the mean and maximum error between the original 
% curve and their approximation according to the polynomial 
% degree for the measure points x=a:0.2:b and y=f(x). (Use 
% all plotted points, xx=a:0.01:b to compute errors).

f=@(x) 1./(1+25*x.^2);

a=-1; b=1;
xp=a:0.2:b;
yp=f(xp);
xx=a:0.01:b; yy=f(xx); %the "large" sample
m=length(xx); %number of points in the large sample

deg=[3,5,7,10];

fprintf('\tExercise 1\n');
fprintf('%4s%10s%9s\n','DEG','MEAN.ERR','MAX.ERR')
for i=deg
    p=polyfit(xp,yp,i);
    pxx=polyval(p,xx);
    meanErr=norm(pxx-yy,1)/m;
    %meanErr=sum(abs(pxx-yy))/m; %alternatively
    maxErr=norm(pxx-yy,inf);
    %maxErr=max(abs(pxx-yy)); %alternatively
    fprintf('%3d%10.4f%10.4f\n',i,meanErr,maxErr) 
    
end    

%Remark (on formatSpecs)
%               i: integer with a field width of 3 digits: %3d
% meanErr, maxErr: floating point numbers with a field width of 10 digits, 
%                  including 4 digits after the decimal point: %10.4f