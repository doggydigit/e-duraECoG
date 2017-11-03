function [ filtered ] = FilterDesign(m,f1,f2)
%FILTERDESIGN filters the ECoG data of the input by filtering out
%frequencies that are outside the frequency range between f1 and f2 (given
%in Hz).

D = fdesign.bandpass('N,Fst1,Fp1,Fp2,Fst2,Ap',10,f1-0.2,f1,f2,f2+0.2,1,m.TDT.frequency);
Hd = design(D,'default');
filtered.ID = m.ID;
filtered.TDT.TriggerLength = m.TDT.TriggerLength;
filtered.TDT.frequency = m.TDT.frequency;
filtered.TDT.t0 = m.TDT.t0;
filtered.TDT.TimeCentered=m.TDT.TimeCentered;
for i=1:8
    filtered.TDT.Electrode(i,:)=filter(Hd,m.TDT.Electrode(i,:));
end
filtered.TDT.good=m.TDT.good;
filtered.vicon=m.vicon;

end

