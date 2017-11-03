function [m] = Tune( m )
%TUNE Resizes the ECoG and the EMG data to begin at the same moment and end
%   at the same moment.
e1 = max([m.vicon.TimeCentered(1) m.TDT.TimeCentered(1)]);%start time for comparaison
e2 = min([m.vicon.TimeCentered(end) m.TDT.TimeCentered(end)]);%stop time for comparaison
t1=round((e1+m.TDT.t0)*24414.0625)+1;%first TDT index for comparaison
v1=round((e1+m.vicon.t0)*2000)+1;%first vicon index for comparaison
t2=round((e2+m.TDT.t0)*24414.0625)+1;%last TDT index for comparaison
v2=round((e2+m.vicon.t0)*2000)+1;%last vicon index for comparaison
va1=[];
va2=[];
ta1=[];
ta2=[];
if(v1>1)
    va1=1:v1;
end
if(t1>1)
    ta1=1:t1;
end
v3=length(m.vicon.TimeCentered);
if(v2<v3)
    va2=v2:v3;
end
t3=length(m.TDT.TimeCentered);
if(t2<t3)
    ta2=t2:t3;
end
v=[va1 va2];
t=[ta1 ta2];
m.vicon.S1(v)=[];
m.vicon.RMG(v)=[];
m.vicon.RTA(v)=[];
m.vicon.RVL(v)=[];
m.vicon.RST(v)=[];
m.vicon.TimeCentered(v)=[];
m.TDT.TimeCentered(t)=[];
m.TDT.Electrode(:,t)=[];


a=[];

if(~isempty(m.vicon.events.lf.start))
    for i=1:numel(m.vicon.events.lf.start)
        if(m.vicon.events.lf.start(i)<e1 || m.vicon.events.lf.start(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.lf.start(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.lf.stop))
    for i=1:numel(m.vicon.events.lf.stop)
        if(m.vicon.events.lf.stop(i)<e1 || m.vicon.events.lf.stop(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.lf.stop(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.lf.fail))
    for i=1:numel(m.vicon.events.lf.fail)
        if(m.vicon.events.lf.fail(i)<e1 || m.vicon.events.lf.fail(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.lf.fail(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.rf.start))
    for i=1:numel(m.vicon.events.rf.start)
        if(m.vicon.events.rf.start(i)<e1 || m.vicon.events.rf.start(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.rf.start(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.rf.stop))
    for i=1:numel(m.vicon.events.rf.stop)
        if(m.vicon.events.rf.stop(i)<e1 || m.vicon.events.rf.stop(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.rf.stop(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.rf.fail))
    for i=1:numel(m.vicon.events.rf.fail)
        if(m.vicon.events.rf.fail(i)<e1 || m.vicon.events.rf.fail(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.rf.fail(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.ge.start))
    for i=1:numel(m.vicon.events.ge.start)
        if(m.vicon.events.ge.start(i)<e1 || m.vicon.events.ge.start(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.ge.start(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.ge.stop))
    for i=1:numel(m.vicon.events.ge.stop)
        if(m.vicon.events.ge.stop(i)<e1 || m.vicon.events.ge.stop(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.ge.stop(a)=[];
    a=[];
end
if(~isempty(m.vicon.events.ge.fail))
    for i=1:numel(m.vicon.events.ge.fail)
        if(m.vicon.events.ge.fail(i)<e1 || m.vicon.events.ge.fail(i)>e2)
            a=[a i]; 
        end
    end
    m.vicon.events.ge.fail(a)=[];
    a=[];
end
end

