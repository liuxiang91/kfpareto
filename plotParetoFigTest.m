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
    % hold on;
    % plot(1,0.5,'*r');
    % plot(2/3,1/3,'*r');
    % plot(0.5,1/4,'*r');
    % text(1,0.5,'  1 yr')
    % text(2/3,1/3,'  1.5 yr')
    % text(0.5,1/4,'  2 yr')
    % l=legend('TNT','Fixed Interval');
    % l.Location='southeast';
    xlabel('Average Number of Tests per Patient per Year');
    ylabel('Average Efficiency');
    xlim([0,2])
    ylim([0,1])
    
    
    subplot(2,2,4);
    plot(numTestPerYearTNT(t2),ddTNT(t2)./2,'.');
    % hold on;
    % plot(1,mean(0.5./2),'*r');
    % plot(2/3,mean(1./2),'*r');
    % plot(0.5,mean(1.5./2),'*r');
    % text(1,mean(0.5./2),'  1 yr')
    % text(2/3,mean(1./2),'  1.5 yr')
    % text(0.5,mean(1.5./2),'  2 yr')
    % legend('TNT','Fixed Interval');
    xlabel('Average Number of Tests per Patient per Year');
    ylabel('Diagnostic Delay (years)');
 
    xlim([0,2])
    ylim([0,1])
    acc=[numTestPerYearTNT(t1),accTNT(t1)];
    dd=[numTestPerYearTNT(t2),ddTNT(t2)];

end
