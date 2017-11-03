function [ e ] = GetEvents( d, event, r )
%GETEVENTS Extracts the ECoG signal within a window of r (in seconds)
%around all the events corresponding to the type "event". The possible
%tapes of events are: ge_start, ge_stop, ge_fail, lf_fail, rf_fail,
%chill_start, chill_stop, sniff_start and sniff_stop

k=1;

for i=1:length(d)
    t=[];
    switch event
        case 'ge_start'
            for j=1:length(d(i).vicon.events.ge.start)
                t(j)=d(i).vicon.events.ge.start(j);
            end
        case 'ge_stop'
            for j=1:length(d(i).vicon.events.ge.stop)
                t(j)=d(i).vicon.events.ge.stop(j);
            end
        case 'ge_fail'
            for j=1:length(d(i).vicon.events.ge.fail)
                t(j)=d(i).vicon.events.ge.fail(j);
            end
        case 'lf_fail'
            for j=1:length(d(i).vicon.events.lf.fail)
                t(j)=d(i).vicon.events.lf.fail(j);
            end
        case 'rf_fail'
            for j=1:length(d(i).vicon.events.rf.fail)
                t(j)=d(i).vicon.events.rf.fail(j);
            end
        case 'chill_start'
            for j=1:length(d(i).vicon.events.rf.start)
                t(j)=d(i).vicon.events.rf.start(j);
            end
        case 'chill_stop'
            for j=1:length(d(i).vicon.events.rf.stop)
                t(j)=d(i).vicon.events.rf.stop(j);
            end
        case 'sniff_start'
            for j=1:length(d(i).vicon.events.lf.start)
                t(j)=d(i).vicon.events.lf.start(j);
            end
        case 'sniff_stop'
            for j=1:length(d(i).vicon.events.lf.stop)
                t(j)=d(i).vicon.events.lf.stop(j);
            end
    end
    
    if (~isempty(t) && d(i).TDT.good(10))
        for n=1:length(t)
            
            e1=t(n)-r/2;
            e2=t(n)+r/2;
            
            if (e1>d(i).TDT.TimeCentered(1) && e2<d(i).TDT.TimeCentered(end)) 
                
                v1=round(d(i).TDT.frequency*(e1-d(i).TDT.TimeCentered(1)));
                v2=round(d(i).TDT.frequency*(e2-d(i).TDT.TimeCentered(1)));
                
                e(k).ID=d(i).ID;
                e(k).TDT.frequency=d(i).TDT.frequency;
                e(k).TDT.TimeCentered=d(i).TDT.TimeCentered(v1:v2);           
                e(k).TDT.Electrode=d(i).TDT.Electrode(:,v1:v2);
                e(k).TDT.good=d(i).TDT.good;
                k=k+1;
            end
        end
    end

end

end

