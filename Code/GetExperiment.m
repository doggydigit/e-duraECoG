function [ out ] = GetExperiment( d ,x)
%GETEXPERIMENT selects only the experiments x, which can be ladder ('LD')
%or runway ('RW').

j=1;
for i=1:length(d)
    if strcmp(d(i).ID.track, x)
        out(j)=d(i);
        j=j+1;
    end
end

end

