function [ AccTest ,ddTest,NTTest] = nonParetoAnalysis(A,C,Q,R,INITX,INITV,o, train,test,step,noteTrain,noteTest )
%PARETOANALYSIS Summary of this function goes here
%   Detailed explanation goes here
close all;
n=length(0:step:1);
rhos=0:step:1;
betas=0:step:1;





accTNTmatT=nan(n,n);
ddTNTmatT=nan(n,n);
numTestPerYearTNTmatT=nan(n,n);
parfor i=1:n
    for j=1:n
            fprintf('Test i=%d,j=%d\n',i,j);
            [accTNTmatT(i,j),d1,numTestPerYearTNTmatT(i,j),~]=TNT(A,C,Q,R,INITV,INITX,o,betaRho(i,j,1),betaRho(i,j,2),test);
            ddTNTmatT(i,j)=mean(d1);
        end
    end
end

AccTest=accTNTmat(:);
ddTest=ddTNTmat(:);
NTTest=numTestPerYearTNTmat(:);




end

