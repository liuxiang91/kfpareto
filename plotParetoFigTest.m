function [acc,dd] = plotParetoFigTest(f,data,accTNTmat,ddTNTmat,numTestPerYearTNTmat,note)
%PLOTPARETOFIG Summary of this function goes here
%   Detailed explanation goes here

    accTNT=accTNTmat(:);
    ddTNT=ddTNTmat(:);
    numTestPerYearTNT=numTestPerYearTNTmat(:);

    
    t1=true(length(accTNT),1);
    t2=true(length(accTNT),1);
    

    
%     [ accuracy1,dd1,numTestPerYear1 ] = fixedTest( data,2 );
%     [ accuracy2,dd2,numTestPerYear2 ] = fixedTest( data,3 );
%     [ accuracy3,dd3,numTestPerYear3 ] = fixedTest( data,4 );
%     
    figure(f);
    subplot(2,2,3);
    plot(numTestPerYearTNT(t1),accTNT(t1),'.');
    
    [Accuracy1 NtestsPerPat1 DD1]=fixedIntervalAnalysis(data, 2)
    [Accuracy2 NtestsPerPat2 DD2]=fixedIntervalAnalysis(data, 3)
    [Accuracy3 NtestsPerPat3 DD3]=fixedIntervalAnalysis(data, 4)
    hold on;
    plot(NtestsPerPat1,Accuracy1,'*r');
    plot(NtestsPerPat2,Accuracy2,'*r');
    plot(NtestsPerPat3,Accuracy3,'*r');
    text(NtestsPerPat1,Accuracy1,'  1 yr')
    text(NtestsPerPat2,Accuracy2,'  1.5 yr')
    text(NtestsPerPat3,Accuracy3,'  2 yr')
    l=legend('TNT','Fixed Interval');
    l.Location='southeast';
    xlabel('Average Number of Tests per Patient per Year');
    ylabel('Average Efficiency');
    title('Testing')
    xlim([0,2])
    ylim([0,1])
    
    
    subplot(2,2,4);
    plot(numTestPerYearTNT(t2),ddTNT(t2)./2,'.');
    hold on;
    plot(NtestsPerPat1,mean(DD1./2),'*r');
    plot(NtestsPerPat2,mean(DD2./2),'*r');
    plot(NtestsPerPat3,mean(DD3./2),'*r');
    text(NtestsPerPat1,mean(DD1./2),'  1 yr')
    text(NtestsPerPat2,mean(DD2./2),'  1.5 yr')
    text(NtestsPerPat3,mean(DD3./2),'  2 yr')
    legend('TNT','Fixed Interval');
    xlabel('Average Number of Tests per Patient per Year');
    ylabel('Diagnostic Delay (years)');
    title('Testing')
    xlim([0,2])
    ylim([0,1])
    acc=[numTestPerYearTNT(t1),accTNT(t1)];
    dd=[numTestPerYearTNT(t2),ddTNT(t2)];

end
