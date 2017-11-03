function [DataTDT] = LoadTDT(mouseID,day,track,runID)

%-----------------------------------------------------------------------------------------------
% Function used to load the data from the TDT. It will load simultaneously
% Neu.mat that contains the ECoG signals (even channel up to 16) and the
% Neu.mat that contains the trigger required to synchronise with vicon
% system

%Input
% The Input consists of strings. mouseID can be 607, 608 or 610. day can be
% P7, P21 or P55. track can be LD or RW depending if the experiment was
% made on the ladder or on the runway. runID is the number of the
% experiment (also as a string)



path=GetFileName(mouseID,day,track,runID,'TDT');
load(strcat(path,'/Anal.mat'));
load(strcat(path,'/Neu.mat'));

fTDT=24414.0625;%sampling frequency of TDT
t=(1:size(Neu(:,2),1))./fTDT; %time vector from tdt
trig=diff(Anal(:,4)>1);  % Trigger channel from TDT
[pks,locUp] = findpeaks(trig);
[pks,locDown] = findpeaks(-trig);
t0=locUp/fTDT; 

A=double(Neu(:,2));
for i=2: size(Neu,2)/2
     A=[A double(Neu(:,i*2))];
end


DataTDT.TriggerLength=(locDown-locUp)/fTDT;
DataTDT.frequency=fTDT;
DataTDT.t0=t0;
DataTDT.TimeCentered=(t-t0);

for i=1:10
    DataTDT.good(i)=1;
end


%% Subjectiv choice of corrupted electrodes is unecessary if performed in "GetCorruption",
%  which is called for in LoadTrial.
% switch mouseID
%     case '607'
%         display('corrupted electrodes of mouse 607 are unknown'),
%     case '608'
%         DataTDT.good(2)=0;
%     case '610'
%         DataTDT.good(5)=0;
%         DataTDT.good(8)=0;
% end

%% Asssigns ECoG data to electrodes of the trial structure
avgood = zeros(1,length(A(:,1)));

nr_good=0;
for i=1:8
    if DataTDT.good(i)
        nr_good=nr_good+1;
        avgood=avgood+A(:,i)';
    end
    DataTDT.Electrode(i,:)=A(:,i)';
end

avgood=avgood/nr_good;
DataTDT.Electrode(9,:)=avgood;

%% common average referencing, which is also performed in the function
%% "RecheckCorruption", which is called for in "LoadTrial".
%  It is important that it is only once ad that it is therefore commented
%  in one of the two functions.

% for i=1:8
%     DataTDT.Electrode(i,:)=DataTDT.Electrode(i,:)-avgood;
% end


end
