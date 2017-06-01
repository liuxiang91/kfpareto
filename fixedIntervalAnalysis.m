function [Accuracy NtestsPerPat DD]=fixedIntervalAnalysis(data, n)
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
l=length(data);

allProg=0;
hit=0;
nTest=0;
dd=[];
for j=1:n
    for i=2:l
        if size(data,2)>8
            prog=data{i,12};
        else
            prog=data{i,8};
        end
        allProg=allProg+sum(prog);
        T=length(prog);
        tests=j:n:T;
        test2=zeros(1,T);
        test2(tests)=1;
        nTest=nTest+sum(test2)*2/(T-1);
        hit=hit+sum(prog(tests));
        for k=1:T
            if prog(k)==1 && sum(tests==k)==0
                nextTest=find([zeros(1,k-1),test2(k:T)],1,'first');
                if ~isnan(nextTest)
                       dd=[dd nextTest-k];
                end
            end
        end

    end
end
Accuracy=hit/allProg;
NtestsPerPat=nTest/(n*(l-1));
DD=mean(dd);
