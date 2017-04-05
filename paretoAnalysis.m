function [ acc ,dd] = paretoAnalysis(A,C,Q,R,INITX,INITV,o, train,test,step,noteTrain,noteTest )
%PARETOANALYSIS Summary of this function goes here
%   Detailed explanation goes here
close all;
n=length(0:step:1);
rhos=0:step:1;
betas=0:step:1;
accTNTmat=zeros(n,n);
ddTNTmat=zeros(n,n);
numTestPerYearTNTmat=zeros(n,n);
for i=1:n
    parfor j=1:n
        fprintf ('Train i=%d,j=%d\n',i,j)
        [accTNTmat(i,j),d1,numTestPerYearTNTmat(i,j),~]=TNT(A,C,Q,R,INITV,INITX,o,betas(i),rhos(j),train);
        ddTNTmat(i,j)=mean(d1);
    end
end
accTNT=accTNTmat(:);
ddTNT=ddTNTmat(:);
numTestPerYearTNT=numTestPerYearTNTmat(:);
t1=true(length(accTNT),1);
t2=true(length(accTNT),1);
for i=1:length(accTNT)
    if any((accTNT>accTNT(i))&(numTestPerYearTNT<numTestPerYearTNT(i)))
        t1(i)=false;
    end
    
    if any((ddTNT<ddTNT(i))&(numTestPerYearTNT<numTestPerYearTNT(i)))
        t2(i)=false;
    end
end
tf=reshape(t1.*t2,[n,n]);

betaRho=nan(n,n,2);
for i=1:n
    for j=1:n
        betaRho(i,j,1)=betas(i);
        betaRho(i,j,2)=rhos(j);
    end
end

f=figure();

[f]=plotParetoFig(f,train,accTNTmat,ddTNTmat,numTestPerYearTNTmat,noteTrain);




accTNTmatT=nan(n,n);
ddTNTmatT=nan(n,n);
numTestPerYearTNTmatT=nan(n,n);
for i=1:n
    parfor j=1:n
        if tf(i,j)==1
            fprintf('Test i=%d,j=%d\n',i,j);
            [accTNTmatT(i,j),d1,numTestPerYearTNTmatT(i,j),~]=TNT(A,C,Q,R,INITV,INITX,o,betaRho(i,j,1),betaRho(i,j,2),test);
            ddTNTmatT(i,j)=mean(d1);
        end
    end
end


[acc,dd]=plotParetoFigTest(f,test,accTNTmatT,ddTNTmatT,numTestPerYearTNTmatT,noteTest );






end

