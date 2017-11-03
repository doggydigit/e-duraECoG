function [vicon] = LoadVicon(mouseID,day,track,runID)
%UNTITLED loads the analog data as well as the moments of the events.
analogFileName=GetFileName(mouseID,day,track,runID,'Analog');
vicon=LoadAnalog(analogFileName);%load analog data
analogFileName=GetFileName(mouseID,day,track,runID,'Event');
vicon.events=LoadEvents(analogFileName,vicon.t0);%load events time centered at t0, note that the events of the P55 data will not be correctly centered
end