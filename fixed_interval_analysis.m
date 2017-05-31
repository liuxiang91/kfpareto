function [Accuracy NtestsPerPat DD]=fixed_interval_analysis(alldata, n)
%[Accuracy NtestsPerPat DD]=fixed_interval_analysis(alldata, n)
% Goals:
%   Calculate the accuracy, number of tests, and diagnostic delay for
%       fixed-interval testing
% Inputs:
%   alldata: cell array. output of TNTread.%      
%   n: interval length (unit: 6 month)
% Output:
%   Accuracy: # hit / (# hit + # miss)
%   NtestsPerPat: number of tests per patient.
%   DD: diagnostic delay per progression instance
% Xiang Liu, 7/19/2012, liuxiang@umich.edu
l=length(alldata);
d=cell2mat(alldata(2:l,18));
dold=d;
count=1;
i=2;
exit=0;
 while i< l-1
    
    id=alldata{i,1};
    c=0;
    
    
    while isequal(id,alldata{i+c,1})&&~exit
        d(i+c-1,2)=count;
        if i+c<l
            c=c+1;
        else
            exit=1;
        end
    end
    i=i+c;
    count=count+1;
end
HIT=0;
MISS=0;
FA=0;
CR=0;
counter=0;
Ntests=0;
DD=0;
Accuracy=0;
dnew=zeros(l-1,3);
dnew(:,2:3)=d;
for i=1:n
    dnew(:,1)=zeros(l-1,1);
    ind=i:n:l-1;
    dnew(ind)=1;
    [DDd Dummy]=Diagnostic_Delay(dnew,1);
    DD=DD+DDd;
    Accuracy= Accuracy+sum(dold(ind))/sum(dold);
    counter=counter+1;
    Ntests=Ntests+length(ind);
end

Accuracy=Accuracy/counter;
DD=DD/counter;
Ntests=Ntests/counter;
NtestsPerPat=Ntests/max(dnew(:,3));