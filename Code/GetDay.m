function [ out ] = GetDay( x,d )
%GETDAY selects the data recorded on day x, which can be 'P7', 'P21' or 'P55'
j=1;
for i=1:length(d)
    if strcmp(d(i).ID.day, x)
        out(j)=d(i);
        j=j+1;
    end
end

end

