function [ AccTest ,ddTest,NTTest] = nonParetoAnalysis(A,C,Q,R,INITX,INITV,o, train,test,step,noteTrain,noteTest )
%PARETOANALYSIS Summary of this function goes here
%   Detailed explanation goes here
close all;
n=length(0:step:1);
rhos=parallel.pool.Constant(0:step:1);
betas=parallel.pool.Constant(0:step:1);

warning off



accTNTmatT=nan(n,n);
ddTNTmatT=nan(n,n);
numTestPerYearTNTmatT=nan(n,n);

A=parallel.pool.Constant(A);
C=parallel.pool.Constant(C);
Q=parallel.pool.Constant(Q);
R=parallel.pool.Constant(R);
INITX=parallel.pool.Constant(INITX);
INITV=parallel.pool.Constant(INITV);
o=parallel.pool.Constant(o);
test=parallel.pool.Constant(test);
fprintf('Running rho-beta combinations:\n')
parfor_progress(n);

parfor i=1:n
    for j=1:n
		[accTNTmatT(i,j),d1,numTestPerYearTNTmatT(i,j),~]=TNT(A.Value,C.Value,Q.Value,R.Value,INITV.Value,INITX.Value,o.Value,betas.Value(i),rhos.Value(j),test.Value);
        ddTNTmatT(i,j)=mean(d1);
    end
    parfor_progress;
end
parfor_progress(0);


AccTest=accTNTmatT(:);
ddTest=ddTNTmatT(:);
NTTest=numTestPerYearTNTmatT(:);




end

