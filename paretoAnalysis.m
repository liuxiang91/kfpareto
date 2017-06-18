function [ acc ,dd] = paretoAnalysis(A,C,Q,R,INITX,INITV,o, train,test,step,noteTrain,noteTest ,cap)
%PARETOANALYSIS Summary of this function goes here
%   Detailed explanation goes here
close all;
n=length(0:step:1);
rhos=0:step:1;
betas=0:step:1;
rhosP=parallel.pool.Constant(0:step:1);
betasP=parallel.pool.Constant(0:step:1);

accTNTmat=zeros(n,n);
ddTNTmat=zeros(n,n);
numTestPerYearTNTmat=zeros(n,n);

A=parallel.pool.Constant(A);
C=parallel.pool.Constant(C);
Q=parallel.pool.Constant(Q);
R=parallel.pool.Constant(R);
INITX=parallel.pool.Constant(INITX);
INITV=parallel.pool.Constant(INITV);
o=parallel.pool.Constant(o);
testP=parallel.pool.Constant(test);
trainP=parallel.pool.Constant(train);
fprintf('Running rho-beta combinations in the training set:\n')

parfor_progress(n);
parfor i=1:n
    for j=1:n
        [accTNTmat(i,j),d1,numTestPerYearTNTmat(i,j),~]=TNT(A.Value,C.Value,Q.Value,R.Value,INITV.Value,INITX.Value,o.Value,betasP.Value(i),rhosP.Value(j),trainP.Value,3,cap);
        ddTNTmat(i,j)=mean(d1);
    end
    parfor_progress;
end
parfor_progress(0);

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


betaRho=parallel.pool.Constant(betaRho);
tf=parallel.pool.Constant(tf);

accTNTmatT=nan(n,n);
ddTNTmatT=nan(n,n);
numTestPerYearTNTmatT=nan(n,n);
fprintf('Running rho-beta combinations in the testing set:\n')
parfor_progress(n);
parfor i=1:n
    for j=1:n
        if tf.Value(i,j)==1
            [accTNTmatT(i,j),d1,numTestPerYearTNTmatT(i,j),~]=TNT(A.Value,C.Value,Q.Value,R.Value,INITV.Value,INITX.Value,o.Value,betaRho.Value(i,j,1),betaRho.Value(i,j,2),testP.Value,3,cap);
            ddTNTmatT(i,j)=mean(d1);
        end
    end
    parfor_progress;
end
parfor_progress(0);

[acc,dd]=plotParetoFigTest(f,test,accTNTmatT,ddTNTmatT,numTestPerYearTNTmatT,noteTest );
    set(f,'PaperUnits','Inches');
    set(f, 'PaperSize', [8.5 11*0.6]);
    set(f, 'PaperPositionMode', 'manual');
    set(f, 'PaperPosition', [0 0 8.5 11*0.6]);
print(f,['ROC.pdf'],'-dpdf','-r0');
close all;



end

