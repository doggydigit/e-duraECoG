function [ o ] = AverageFrequencySpectrum( m )
%AVERAGEFREQUENCYSPECTRUM returns the averaged frequency amplitudes of the
%ECoG signals of the trials m

%% compute frequency spectra
l=[];
cutting_frequency=300;
for i=1:length(m)
    L=length(m(i).TDT.TimeCentered);
    f(i).T=L;
    NFFT=2^nextpow2(L);
    f(i).L=NFFT;
    fcut=round(2*cutting_frequency/m(i).TDT.frequency*(NFFT/2+1));
    for j=1:8
        if(m(i).TDT.good(j))
            e=fft(m(i).TDT.Electrode(j,:),NFFT)';
            f(i).TDT.Electrode(j,:)=2*abs(e(1:fcut))/L;
        end
    end
    l=[l L]; %create vector containing all the Time lengths of the trials
end

%% chose spectrum with shortest vector and use it as base
ll=min(l);
NFFT=2^nextpow2(ll);
fcut=round(2*cutting_frequency/m(1).TDT.frequency*(NFFT/2+1));
fa=(m(1).TDT.frequency*linspace(0,1,NFFT/2+1)/2);
o.fAxis=fa(1:fcut-1);
d=length(o.fAxis)-1;

%% inventar of good electrodes
nrgood=zeros(1,8);
good=zeros(8,0);
for j=1:length(f)
    for i=1:8
        if m(j).TDT.good(i)
            nrgood(i)=nrgood(i)+1;
            good(j,i)=i;
        end
    end
end
good(good==0)=[];

%% scale each frequency spectrum to the same vector size
for i=1:length(f)
    c=round(f(i).T/ll);
    a(i).TDT.Electrode(:,:)=zeros(8,d);
    if(c>1.2)     
        for j=1:(d)
            for k=0:(c-1)
                a(i).TDT.Electrode(good(i,:),j)=a(i).TDT.Electrode(good(i,:),j)+f(i).TDT.Electrode(good(i,:),c*j-k);
            end
        end
        a(i).TDT.Electrode=a(i).TDT.Electrode/c;
    else
        a(i).TDT.Electrode(good(i,:),:)=f(i).TDT.Electrode(good(i,:),1:d);    
    end
end

%% Average over trials
av.TDT.Electrode=zeros(8,d);

k=0;
for i=1:length(f)
    k=k+f(i).T;        
    av.TDT.Electrode=av.TDT.Electrode+f(i).T*a(i).TDT.Electrode;
end

av.TDT.Electrode=av.TDT.Electrode/k;
for i=1:8
    av.TDT.Electrode(i,:)=av.TDT.Electrode(i,:)/nrgood(i);
end


%% average over electrodes
n=0;
o.Electrode=zeros(1,d);
for i=1:8
    if(m(1).TDT.good(i))
        o.Electrode=o.Electrode+av.TDT.Electrode(i,:);
        n=n+1;
    end
end
o.Electrode=o.Electrode/n;

end

