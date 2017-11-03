function [ out ] = GetMouse(x, data )
%GETMOUSE selects the trials with mouse x which can be '608' or '610'
j=1;
for i=1:length(data)
    if strcmp(data(i).ID.mouseID, x)
        out(j)=data(i);
        j=j+1;
    end
end

end

