function [ mp ] = CutPassive( m )
%CUTPASSIVE returns only trials containing the data, during which the rat
%was quiet. Input and output are both arrays of trials.
q=1;
for p=1:length(m)
    if strcmp(m(p).ID.day,'P55')
        
        display('Data made on day 55 is compromised');
        display('Please, do not use it, if it necessitates the correct moments of the events');
        
    else
        for i=1:length(m(p).vicon.events.rf.start)
            if m(p).vicon.events.rf.start(i)<m(p).TDT.TimeCentered(1)
                if m(p).vicon.events.rf.stop(i)>m(p).TDT.TimeCentered(end)
                    mp(i)=m(p);
                else
                    mp(i)=Cut(m(p),m(p).TDT.TimeCentered(1),m(p).vicon.events.rf.stop(i));
                end
            elseif m(p).vicon.events.rf.stop(i)>m(p).TDT.TimeCentered(end)
                mp(i)=Cut(m(p),m(p).vicon.events.rf.start(i),m(p).TDT.TimeCentered(end));
            else
                mp(i)=Cut(m(p),m(p).vicon.events.rf.start(i),m(p).vicon.events.rf.stop(i));
            end
        end
    end
end
end

