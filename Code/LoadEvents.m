function [ events ] = LoadEvents( filename,t0 )
%LOADEVENTS loads the moments of the events for the trial defined by the
%file name given as input.
file=fileread(filename);
strfile=fileread(filename);
str=strread(file,'%s','delimiter','\n');
N=length(str);
events.lf.start(1)=0;%Sniff
events.lf.stop(1)=0;%Sniff
events.lf.fail(1)=0;
events.rf.start(1)=0;%chill
events.rf.stop(1)=0;%chill
events.rf.fail(1)=0;
events.ge.start(1)=0;
events.ge.stop(1)=0;
events.ge.fail(1)=0;


for(i=3:N-1) %start from the third line  
         if(~isempty(findstr(str{i},'Left')))
              if(~isempty(findstr(str{i},'Strike')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.lf.start(end+1)=str2double(t{4})-t0; %strike time in seconds
              elseif(~isempty(findstr(str{i},'Off')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.lf.stop(end+1)=str2double(t{4})-t0; %off time in seconds              
              else
                  t=strread(str{i},'%s','delimiter',',');
                  events.lf.fail(end+1)=str2double(t{4})-t0; %fail time in seconds
              end
         elseif(~isempty(findstr(str{i},'Right')))
              if(~isempty(findstr(str{i},'Strike')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.rf.start(end+1)=str2double(t{4})-t0; %strike time in seconds
              elseif(~isempty(findstr(str{i},'Off')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.rf.stop(end+1)=str2double(t{4})-t0; %off time in seconds              
              else
                  t=strread(str{i},'%s','delimiter',',');
                  events.rf.fail(end+1)=str2double(t{4})-t0; %fail time in seconds
              end
         elseif(~isempty(findstr(str{i},'General')))
              if(~isempty(findstr(str{i},'Strike')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.ge.stop(end+1)=str2double(t{4})-t0; %strike time in seconds
              elseif(~isempty(findstr(str{i},'Off')))
                  t=strread(str{i},'%s','delimiter',',');
                  events.ge.start(end+1)=str2double(t{4})-t0; %off time in seconds              
              else
                  t=strread(str{i},'%s','delimiter',',');
                  events.ge.fail(end+1)=str2double(t{4})-t0; %fail time in seconds
              end
         end         
end

events.ge.start(1) = [];
events.ge.stop(1) = [];
events.ge.fail(1) = [];
events.rf.start(1) = [];
events.rf.stop(1) = [];
events.rf.fail(1) = [];
events.lf.start(1) = [];
events.lf.stop(1) = [];
events.lf.fail(1) = [];

end

