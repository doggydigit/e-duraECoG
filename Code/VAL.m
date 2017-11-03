function [ VAL ] = VAL( d )
%VAL computes the VAL for each pair of good electrodes

% Input must be an array of trials. The set of data should at least be
% sorted to contain only trials from the same rat.
% Output is a 8x8 matrix of VAL for each pair of electrode

goodAll=zeros(length(d),8);
VAL=zeros(8,8);
nrgood=zeros(8,8);
for i=1:length(d)
    for j=1:8
        if d(i).TDT.good(j)
            goodAll(i,j)=j;
        end
    end
end
for i=1:length(d)
    if d(i).TDT.good(10)
        good=goodAll(i,:);
        good(good==0)=[];
        for j=good
            for k=good
                if k~=j
                    VAL(j,k)=VAL(j,k)+var(d(i).TDT.Electrode(j,:)-d(i).TDT.Electrode(k,:));
                    nrgood(j,k)=nrgood(j,k)+1;
                end
            end
        end
    end
end
VAL=VAL./nrgood;
end

