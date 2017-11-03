function [ filename ] = GetFileName( mouseID,day,track,runID,datatype )
%UNTITLED returns the path to the file defined by the input (all in
%strings).
switch datatype
    case 'TDT'
        filename=strcat('../Data/TDT/',mouseID,'/DATATANK/',mouseID,'_',day,'_',track,'_',runID);
    case {'Analog','Event'}
        filename=strcat('../Data/Vicon/',mouseID,'_',day,'_',track,'_',runID,'_',datatype,'.csv');
    otherwise
        disp('datatype must be: TDT, Analog or Event');
end
end

