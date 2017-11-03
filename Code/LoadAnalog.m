function [ analog ] = LoadAnalog( filename )
%LOADANALOG loads the analog data desined by the file name given as string
%as input.

file=fileread(filename);
str=strread(file,'%s','delimiter','\n');
N=length(str);
a=str2double(strread(str{5},'%s','delimiter',','))';

Sample=a(1);
TDT_trigger=a(2); 
S1=a(3); 
RMG=a(4);
RTA=a(5);
RVL=a(6);
RST=a(7);

%FILE LETTO E IMMAGAZZINATO

for(i=6:N-1) %start from the third line  
    a=str2double(strread(str{i},'%s','delimiter',','))';
    Sample(end+1)=a(1);
    TDT_trigger(end+1)=a(2); 
    S1(end+1)=a(3); 
    RMG(end+1)=a(4);
    RTA(end+1)=a(5);
    RVL(end+1)=a(6);
    RST(end+1)=a(7);                          
end

% The trigger didn't fonction properly in the trials of P55 and therefore
% necessitate a special algorithm that will give a false t0 for the vicon
% data but will permit the program to continue
if strcmp(filename(20),'5')
    S1=S1./max(abs(S1));
    trigv=diff(S1>0.5);
else
    TDT_trigger=TDT_trigger./max(abs(TDT_trigger));
    trigv=diff(TDT_trigger>0.5);
end


fEMG=2000;% Sampling frequency of analog Vicon signals
tv=Sample/fEMG; % Same thing that before but for analogical data from VICON
 [pks,locUpv] = findpeaks(trigv);
 [pks,locDownv] = findpeaks(-trigv);
analog.TriggerLength=(locDownv-locUpv)/fEMG;
t0v=locUpv/fEMG;

analog.frequency =fEMG;
analog.t0=t0v;
analog.TimeCentered=tv-t0v;
analog.Trig=TDT_trigger./max(abs(TDT_trigger));
analog.S1=S1./max(abs(S1));
analog.RMG=RMG./max(abs(RMG));
analog.RTA=RTA./max(abs(RTA));
analog.RVL=RVL./max(abs(RVL));
analog.RST=RST./max(abs(RST));

end

