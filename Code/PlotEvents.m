function PlotEvents( m,t )
%PLOTEVENTS draws a vertical line at the moment, at which an event
%occurred. Depending on the type of event the line will have a different
%color.
%
%Input: m must be a trial and t must be a bool defining if it is desired to
%write the name of the event beside the line or not.
if(t)
    if(~isempty(m.vicon.events.rf.fail))
        vline(m.vicon.events.rf.fail,'b','RIGHT');
    end
    if(~isempty(m.vicon.events.rf.start))
        vline(m.vicon.events.rf.start,'m','STARTCHILL');
    end
    if(~isempty(m.vicon.events.rf.stop))
        vline(m.vicon.events.rf.stop,'m','STOPCHILL');
    end
    if(~isempty(m.vicon.events.lf.fail))
        vline(m.vicon.events.lf.fail,'b','LEFT');
    end
    if(~isempty(m.vicon.events.lf.start))
        vline(m.vicon.events.lf.start,'c','STARTSNIFF');
    end
    if(~isempty(m.vicon.events.lf.stop))
        vline(m.vicon.events.lf.stop,'c','STOPSNIFF');
    end
    if(~isempty(m.vicon.events.ge.start))
        vline(m.vicon.events.ge.start,'g','STARTRUN');
    end
    if(~isempty(m.vicon.events.ge.stop))
        vline(m.vicon.events.ge.stop,'r','STOPRUN');
    end
    if(~isempty(m.vicon.events.ge.fail))
        vline(m.vicon.events.ge.fail,'b','SPECIAL');
    end
else
    if(~isempty(m.vicon.events.rf.fail))
        vline(m.vicon.events.rf.fail,'b');
    end
    if(~isempty(m.vicon.events.rf.start))
        vline(m.vicon.events.rf.start,'m');
    end
    if(~isempty(m.vicon.events.rf.stop))
        vline(m.vicon.events.rf.stop,'m');
    end
    if(~isempty(m.vicon.events.lf.fail))
        vline(m.vicon.events.lf.fail,'b');
    end
    if(~isempty(m.vicon.events.lf.start))
        vline(m.vicon.events.lf.start,'c');
    end
    if(~isempty(m.vicon.events.lf.stop))
        vline(m.vicon.events.lf.stop,'c');
    end
    if(~isempty(m.vicon.events.ge.start))
        vline(m.vicon.events.ge.start,'g');
    end
    if(~isempty(m.vicon.events.ge.stop))
        vline(m.vicon.events.ge.stop,'r');
    end
    if(~isempty(m.vicon.events.ge.fail))
        vline(m.vicon.events.ge.fail,'b');
    end
end
end