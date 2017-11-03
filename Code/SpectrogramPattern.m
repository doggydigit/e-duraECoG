function [ F, T, P ] = SpectrogramPattern( d )
%SPECTROGRAMPATTERN computes the average spectrogram from an array of
%trials that have all exactly the same length (Use "GetEvents" before using
%this function).

r=8192;
fmax=300;
a=round(2.5*d(1).TDT.frequency/r);
b=1;
if r>1000
    c=r-512;
else
    c=r/2-1;
end

[S,F,T,P1]=spectrogram(d(1).TDT.Electrode(1,:),r,c,[a:b:45 55:b:fmax],d(1).TDT.frequency);
x=length(P1(:,1));
y=length(P1(1,:));
P=zeros(x,y,9);

j=zeros(9,1);
for k=1:length(d)
    if d(k).TDT.good(10)
        for i=1:9
            if d(k).TDT.good(i)
                [S,F,T,P1]=spectrogram(d(k).TDT.Electrode(i,:),r,c,[a:b:45 55:b:fmax],d(k).TDT.frequency);
                P(:,:,i)= P(:,:,i)+P1/(mean(mean(P1)));
                j(i)=j(i)+1;
            end
        end
    end
end

for i=1:9
    P(:,:,i)=P(:,:,i)/j(i);
end


end

