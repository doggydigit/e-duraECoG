function [ ma ] = CutActive( m )
%CUTACTIVE returns only trials containing the data, during which the rat
%was running. Input and output are both arrays of trials.
q=1;
for p=1:length(m)
    if strcmp(m(p).ID.day,'P55')
        
        display('Data made on day 55 is compromised');
        display('Please, do not use it, if it necessitates the correct moments of the events');
        
    else
        for i=1:length(m(p).vicon.events.ge.start)
            if (m(p).vicon.events.ge.start(i)<m(p).TDT.TimeCentered(1))
                if m(p).vicon.events.ge.stop(i)>m(p).TDT.TimeCentered(end)
                    ma(q)=m(p);
                else
                    ma(q)=Cut(m(p),m(p).TDT.TimeCentered(1),m(p).vicon.events.ge.stop(i));
                end
            elseif (m(p).vicon.events.ge.stop(i)>m(p).TDT.TimeCentered(end))
                ma(q)=Cut(m(p),m(p).vicon.events.ge.start(i),m(p).TDT.TimeCentered(end));
            else
                ma(q)=Cut(m(p),m(p).vicon.events.ge.start(i),m(p).vicon.events.ge.stop(i));
            end
            q=q+1;
        end
    end
end
end

