function [ c ] = Cut( m,e1,e2 )
%CUT resizes the data of the input by keeping only the signal and events
%present in the time interval between e1 and e2 (which are time points
%in seconds)

v1=round(m.TDT.frequency*(e1-m.TDT.TimeCentered(1)))+1;
v2=round(m.TDT.frequency*(e2-m.TDT.TimeCentered(1)))+1;
if strcmp(m.ID.day,'55')
    t1=1;
    t2=length(m.vicon.TimCentered);
    is55=1;
else
    t1=round(m.vicon.frequency*(e1-m.vicon.TimeCentered(1)))+1;
    t2=round(m.vicon.frequency*(e2-m.vicon.TimeCentered(1)))+1;
    is55=0;
end

c.ID=m.ID;
c.TDT.TriggerLength=m.TDT.TriggerLength;
c.TDT.frequency=m.TDT.frequency;
c.TDT.t0=m.TDT.t0;
c.TDT.TimeCentered=m.TDT.TimeCentered(v1:v2);
c.TDT.Electrode=m.TDT.Electrode(:,v1:v2);
c.TDT.good=m.TDT.good;
c.vicon.TriggerLength=m.vicon.TriggerLength;
c.vicon.frequency=m.vicon.frequency;
c.vicon.t0=m.vicon.t0;
c.vicon.TimeCentered=m.vicon.TimeCentered(t1:t2);
c.vicon.S1=m.vicon.S1(t1:t2);
c.vicon.RMG=m.vicon.RMG(t1:t2);
c.vicon.RTA=m.vicon.RTA(t1:t2);
c.vicon.RVL=m.vicon.RVL(t1:t2);
c.vicon.RST=m.vicon.RST(t1:t2);
c.vicon.events=m.vicon.events;


a=[];

if is55
    
    if(~isempty(m.vicon.events.lf.start))
        for i=1:numel(m.vicon.events.lf.start)
            if(m.vicon.events.lf.start(i)<e1 || m.vicon.events.lf.start(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.lf.start(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.lf.stop))
        for i=1:numel(m.vicon.events.lf.stop)
            if(m.vicon.events.lf.stop(i)<e1 || m.vicon.events.lf.stop(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.lf.stop(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.lf.fail))
        for i=1:numel(m.vicon.events.lf.fail)
            if(m.vicon.events.lf.fail(i)<e1 || m.vicon.events.lf.fail(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.lf.fail(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.rf.start))
        for i=1:numel(m.vicon.events.rf.start)
            if(m.vicon.events.rf.start(i)<e1 || m.vicon.events.rf.start(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.rf.start(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.rf.stop))
        for i=1:numel(m.vicon.events.rf.stop)
            if(m.vicon.events.rf.stop(i)<e1 || m.vicon.events.rf.stop(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.rf.stop(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.rf.fail))
        for i=1:numel(m.vicon.events.rf.fail)
            if(m.vicon.events.rf.fail(i)<e1 || m.vicon.events.rf.fail(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.rf.fail(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.ge.start))
        for i=1:numel(m.vicon.events.ge.start)
            if(m.vicon.events.ge.start(i)<e1 || m.vicon.events.ge.start(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.ge.start(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.ge.stop))
        for i=1:numel(m.vicon.events.ge.stop)
            if(m.vicon.events.ge.stop(i)<e1 || m.vicon.events.ge.stop(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.ge.stop(a)=[];
        a=[];
    end
    if(~isempty(m.vicon.events.ge.fail))
        for i=1:numel(m.vicon.events.ge.fail)
            if(m.vicon.events.ge.fail(i)<e1 || m.vicon.events.ge.fail(i)>e2)
                a=[a i];
            end
        end
        c.vicon.events.ge.fail(a)=[];
        a=[];
    end
end
end

