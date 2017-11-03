function [ trial ] = LoadTrial(mouseID,day,track,runID)
%Loads the complete data of a trial from mouse with ID "mouseID", from testday "day" with track
%type: 'LD' or 'RW' (depending if ladder or runway is desired) and with ID
%number of the trial "runID". All inputs must be in string format.

trial.ID.mouseID=mouseID;
trial.ID.day=day;
trial.ID.track=track;
trial.ID.trialID=runID;
trial.TDT=LoadTDT(mouseID,day,track,runID);
trial.vicon=LoadVicon(mouseID,day,track,runID);

%% The more often the function "GetCorruption" is called the more probable it is that electrodes will be labeled as corrupted.
% If there is a high confidence in the correctness of the electrodes, it
% might be better to call for the fonction only once.
for i=1:4
    trial.TDT.good=GetCorruption(trial);
end
end

