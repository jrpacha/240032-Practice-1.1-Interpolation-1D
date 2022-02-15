clearvars
close all

f=@(x) 1./(1+25*x.^2);

a=-1;
b=1;
x=a:0.2:b;
y=f(x);
xOrig=a:0.01:b;
yOrig=f(xOrig);
ymax=max(yOrig); 

degree=[3,5,7,10];

figure()
for i=1:size(degree,2)
    subplot(3,2,i);
    plot(x,y,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
        'LineWidth',2,'MarkerEdgeColor','black');
    hold on
    plot(xOrig,yOrig,'-r')
    p = polyfit(x,y,degree(i));
    yy = polyval(p,xOrig);
    %yymax=max(yy);
    %y0=min([-0.2,yy]);
    %y1=max(ymax,yymax);
    plot(xOrig,yy,'--b')
    if (degree(i) < 10)
        title(['Degree ',num2str(degree(i)),' approximation'],...
            'interpreter','LaTeX');
    else
        title(['Degree ',num2str(degree(i)),' interpolation'],...
            'interpreter','LaTeX');
    end
    xlabel('$x$','interpreter','LaTeX')
    ylabel('$y$','interpreter','LaTeX')
    ymax=max([yOrig,yy]);
    ymin=min([yOrig,yy]);
    axis([-1,1,ymin,ymax]);
    %axis([-1,1,-0.2,1]);
    hold off
end

% Polygonal
xp=a:0.1:b;
yp=f(xp);
subplot(3,2,5)
plot(xp,yp,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
            'LineWidth',2,'MarkerEdgeColor','black');
hold on
plot(xOrig,yOrig,'-r')
yyp = interp1(xp,yp,xOrig);
plot(xOrig,yyp,'--b')
title('1D polygonal approximation',...
    'interpreter','LaTeX')
xlabel('$x$','interpreter','LaTeX')
ylabel('$y$','interpreter','LaTeX')
hold off

% Spline
subplot(3,2,6)
plot(xp,yp,'o','Marker','o','LineWidth',2,'MarkerFaceColor','red',...
            'LineWidth',2,'MarkerEdgeColor','black');
hold on
plot(xOrig,yOrig,'-r')
yys = spline(xp,yp,xOrig);
plot(xOrig,yys,'--b')
title('1D cubic spline approximation',...
    'interpreter','LaTeX')
xlabel('$x$','interpreter','LaTeX')
ylabel('$y$','interpreter','LaTeX')
hold off

% ========================================================================
% Exercise:
% Compute the mean and maximum error between the original 
% curve and their approximation according to the polynomial 
% degree for the measure points x=a:0.2:b and y=f(x). (Use 
% all plotted points, xx=a:0.01:b to compute errors).

f=@(x) 1./(1+25*x.^2); %Yes, already defined at the beginning (redundant)

a=-1;
b=1;
x=a:0.2:b;
y=f(x);
xOrig=a:0.01:b;
yOrig=f(xOrig);
numPoints = length(xOrig); %number of points in the "large" sample

degree=[3,5,7,10];

fprintf(1,'Exercise 1:\n');
fprintf(1,'%5s%11s%14s\n','DEG.','MEAN.ERR.','MAX.ERR.');
for i=degree
    p=polyfit(x,y,i);
    yy=polyval(p,xOrig);
    meanErr=norm(yy-yOrig,1)/numPoints;
    %meanErr=sum(abs(yy-yOrig))/numPoints; %alternatively
    maxErr=norm(yy-yOrig,inf);
    %maxErr=max(abs(yy-yOrig));            %alternatively
    fprintf(1,'%3d%14.5E%14.5E\n',i,meanErr,maxErr);
end    

%Remark (on formatSpecs)
%               i: integer with a field width of 3 digits: %3d
% menaErr, maxErr: floating pointn umbers, in exponential notation, with a  
%                  field width of 14 digits, including the exponential part, 
%                  and 5 digits after the decimal point: %14.5E, or %14.5e