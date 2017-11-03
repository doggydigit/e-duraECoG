function [ r ] = RecheckCorruption( d )
%RECHECKCORRUPTION checks if for one type of experiment (same mouse, same
%day and same expermiental track), one electrode was corrupted over 50% of
%the time. If this is the case this electrode is tagged as corrupted for
%each trial corresponding to this type of experiment.
%The function also performs an additional check to see if the whole sample
%might be corrupted and resets d(i).TDT.good(10) as equal to zero if this
%is the case, which will prevent the sample from being included in some
%analysis (for example in the spectrogram patterns)D

r=d;
counter=zeros(3,3,3);
nrCorrupted=zeros(3,3,3,8);

%% count how often each electrode was corrupted in the different types of experiment
for i=1:length(d)
    c=0;
    switch d(i).ID.mouseID
        case '607'
            a=1;            
        case '608'
            a=2;
        case '610'
            a=3;
        otherwise
            display(strcat('Error: Unknown mouseID "', d(i).ID.mouseID, '"'));
            c=3;
    end
    
    switch d(i).ID.day
        case 'P7'
            b=1;
        case 'P21'
            b=2;
        case 'P55'
            b=3;
        otherwise
            display(strcat('Error: Unknown experiment day "', d(i).ID.day, '"'));
            c=3;
    end
    if c==0
        switch d(i).ID.track
            case 'RW'
                c=1;
            case 'LD'
                c=2;
            otherwise
                if ~strcmp(d(i).ID.track,'Rest')
                    display(strcat('Error: Unknown experimental track "', d(i).ID.track, '"'));
                end
                c=3;
        end
    end
    counter(a,b,c)=counter(a,b,c)+1;
    for j=1:8
        if d(i).TDT.good(j)==0
            nrCorrupted(a,b,c,j)=nrCorrupted(a,b,c,j)+1;
        end
    end
end


%% Check if one electrode was corrupted over 50% of the time
n=0;
for i=1:3
    for j=1:3
        for h=1:2
            if(counter(i,j,h)>3.5)
                for k=1:8
                    if(nrCorrupted(i,j,h,k)*2 > counter(i,j,h))
                        n=n+1;
                        e(n,:)=[i; j; h; k];
                    end
                end
            end
        end
    end
end

%% taggs the corrupted electrode as bad for every trial of the corresponding type of experiment
for i=1:n
    switch e(i,1)
        case 1
            switch e(i,2)
                case 1
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
                case 2
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end                  
                case 3
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'607') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
            end
        case 2
            switch e(i,2)
                case 1
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
                case 2
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end                  
                case 3
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'608') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
            end            
        case 3
            switch e(i,2)
                case 1
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P7') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
                case 2
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P21') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end                  
                case 3
                    switch e(i,3)
                        case 1
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'RW'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end
                        case 2
                            for k=1:length(d)
                                if(strcmp(d(k).ID.mouseID,'610') && strcmp(d(k).ID.day,'P55') && strcmp(d(k).ID.track,'LD'))
                                    r(k).TDT.good(e(i,4))=0;
                                end
                            end                            
                    end
            end            
    end
end


%% Common average referencing adequatly

for j=1:length(r)
    avgood = zeros(1,length(r(j).TDT.Electrode(1,:)));
    nr_good=0;
    for i=1:8
        if r(j).TDT.good(i)==1
            nr_good=nr_good+1;
            avgood=avgood+r(j).TDT.Electrode(i,:)/mean(abs(r(j).TDT.Electrode(i,:)));
        end
    end
    r(j).TDT.Electrode(9,:)=avgood/nr_good;
    for i=1:8
        r(j).TDT.Electrode(i,:)=(r(j).TDT.Electrode(i,:)/mean(abs(r(j).TDT.Electrode(i,:))))-r(j).TDT.Electrode(9,:);
    end
    r(j).TDT.Electrode(9,:)=r(j).TDT.Electrode(9,:)*mean(abs(r(j).TDT.Electrode(9,:)));
end

%% More checking for bad samples

for i=1:length(r)
    n=0;
    [y,k]=min(max(abs(r(i).TDT.Electrode(:,:)'))./mean(abs(r(i).TDT.Electrode(:,:)')));
    for j=1:8
        if max(abs(r(i).TDT.Electrode(j,:)))/mean(abs(r(i).TDT.Electrode(j,:)))>40         
            n=n+1;
        end
    end
    if (n>4.5 || k==9)
        r(i).TDT.good(10)=0;
    end
end

end

