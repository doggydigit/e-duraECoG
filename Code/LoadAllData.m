function [ m ] = LoadAllData()
%LOADALLDATA loads an array containing all the data with compliant
%measurements.

%m(1)=LoadTrial('610','P21','Rest','1');
n=1;
for i=6:17
    m(n)=LoadTrial('610','P21','RW',num2str(i));
    n=n+1;
end
for i=[18:21 23:26 28:32]
    m(n)=LoadTrial('610','P21','LD',num2str(i));
    n=n+1;
end
for i=1:10
    m(n)=LoadTrial('610','P7','RW',num2str(i));
    n=n+1;
end
for i=11:20
    m(n)=LoadTrial('610','P7','LD',num2str(i));
    n=n+1;
end
for i=[1:4 6:10]
    m(n)=LoadTrial('608','P21','RW',num2str(i));
    n=n+1;
end
for i=12:22
    m(n)=LoadTrial('608','P21','LD',num2str(i));
    n=n+1;
end
for i=[1 4:10 12:13]
    m(n)=LoadTrial('608','P7','RW',num2str(i));
    n=n+1;
end
for i=[15:19 21:22]
    m(n)=LoadTrial('608','P7','LD',num2str(i));
    n=n+1;
end
for i=[2:4 8 10 11]
    m(n)=LoadTrial('610','P55','RW',num2str(i));
    n=n+1;
end
for i=[12:14 19 21:23]
    m(n)=LoadTrial('610','P55','LD',num2str(i));
    n=n+1;
end
for i=[1:3 5:8 10 12]
    m(n)=LoadTrial('608','P55','RW',num2str(i));
    n=n+1;
end
for i=[14:17 20 27:31]
    m(n)=LoadTrial('608','P55','LD',num2str(i));
    n=n+1;
end
%% Second corruption detection algorithm that also common average references the ECoG data
%  If it is not desired to use the second algorithm, the common average
%  reference algorithm should be uncommented in the function "LoadTDT"
m=RecheckCorruption(m);

end

