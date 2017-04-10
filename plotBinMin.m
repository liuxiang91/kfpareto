function [ auc ] = plotBinMin( dd,ntest,step,binWidth ,plotting)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
auc=zeros(33,3);
s=length(0:step:1)^2;
cc=0;
for i=1:s:size(dd,1)
    cc=cc+1;
    if plotting
        figure();
    end
    for j=1:3
        hold on
        ddMax=[];
        d=dd(i:i+s-1,j);
        nt=ntest(i:i+s-1,j);
        bins=0:binWidth:2;
        for k=1:length(bins)-1
            ddMax=[ddMax,min([3,min(d(nt>=bins(k)&nt<bins(k+1),1))])];
        end
        if plotting
            plot(bins(2:end)-binWidth,ddMax);
        end
        auc(cc,j)=trapz( bins(2:end)-binWidth,ddMax);
    end
    if plotting
        legend('AC','JP','JP+');
    end
    
end
mean(auc)
end