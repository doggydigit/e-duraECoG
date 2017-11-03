function [ c ] = GetCorruption( d )
%GETCORRUPTION returns an array of bool defining, which electrodes are
%corrupted. It is the future d.TDT.good array.
record=d.TDT.good;
c=record;
VAL=zeros(8,8);
VAR=zeros(1,8);
good=[];
for i=1:8
    if d.TDT.good(i)
        good=[good i];
    end
end


meanECoG=mean(d.TDT.Electrode');
meanAbsMeanECoG=mean(abs(meanECoG(good)));
constant=3;

for i=good
    for j=good
        VAL(i,j)=var(d.TDT.Electrode(i,:)-d.TDT.Electrode(j,:));
    end
    VAR(i)=var(d.TDT.Electrode(i,:));
end

meanVAR=mean(VAR);

VAL=(VAL.^2)./[1 1 1.4142 1.14142 1 2.2361 2 2.2361; 1 1 2.2361 1 1.4142 2 2.361 2.8284; 1 1 1 2 1 2.2361 1.4142 1; 1 1 1 1 1 1 1.4142 2.2361; 1 1 1 1 1 1.4142 1 1.4142; 1 1 1 1 1 1 1 2; 1 1 1 1 1 1 1 1; 1 1 1 1 1 1 1 1];
    
meanVAL=zeros(1,8);
for i=good
    for j=good(good>i)
        meanVAL(i)=meanVAL(i)+VAL(i,j);
        meanVAL(j)=meanVAL(j)+VAL(i,j);
    end
end
meanVAL=meanVAL/7;
meanMeanVAL=mean(meanVAL);

nrbad=0;
for i=1:8
    if meanVAL(i)>meanMeanVAL*constant || abs(meanECoG(i))>constant*meanAbsMeanECoG || VAR(i)>constant*meanVAR || meanVAL(i)==0 || VAR(i)==0
        c(i)=0;
    end
    if(c(i)==0)
        nrbad = nrbad+1;
    end
end

%% Uncomment if you want to set a limit on the number of electrodes that can be designed to be corrupted
% if nrbad>3.5
%     c=record;
% end

end

