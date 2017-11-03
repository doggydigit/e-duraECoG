function PlotAllSignals(m)
%PLOTALLSIGNALS plots the signal of each electrode, including the common
%average reference.

fTDT = 2.4414e+04;
[bf,af]=butter(2,50/fTDT,'low');
h=figure('units','normalized','outerposition',[0 0 1 1]);

col=jet(10);

if ~strcmp(m.ID.day,'P55')
    
    n=13;
    k=4;
    events=1;
    
    s(1)=subaxis(n,1,1,'Spacing',0,'Padding',0,'Margin',0.02);
    plot(m.vicon.TimeCentered,m.vicon.RMG,'LineWidth',2);
    PlotEvents(m,1);
    axis off
     
    s(2)=subaxis(n,1,2,'Spacing',0,'Padding',0,'Margin',0.02);
    plot(m.vicon.TimeCentered,m.vicon.RST,'LineWidth',2);
    PlotEvents(m,0);
    axis off
        
    s(3)=subaxis(n,1,3,'Spacing',0,'Padding',0,'Margin',0.02);
    plot(m.vicon.TimeCentered,m.vicon.RTA,'LineWidth',2);
    PlotEvents(m,0);
    axis off
    
    s(4)=subaxis(n,1,4,'Spacing',0,'Padding',0,'Margin',0.02);
    plot(m.vicon.TimeCentered,m.vicon.RVL,'LineWidth',2);
    PlotEvents(m,0);
    axis off

else
    n=9;
    k=0;
    events = 0;
end
    

for i=1:9
    if m.TDT.good(i)
        c=col(3,:);
    else
        c= col(10,:);
    end  
    s(k+i)=subaxis(n,1,k+i,'Spacing',0,'Padding',0,'Margin',0.02);
    plot(m.TDT.TimeCentered,filtfilt(bf,af,m.TDT.Electrode(i,:)),'color',c,'LineWidth',2);
    if(events)
        PlotEvents(m,0);
    end
    axis off
end

linkaxes(s,'x'); 

end

