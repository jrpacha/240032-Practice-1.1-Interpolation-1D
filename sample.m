function T = sample(func,a,b,nPt)
dataX = linspace(a,b,nPt)';
dataY = func(dataX);
T = table(dataX,dataY,'VariableNames',{'DataX','DataY'});
end

