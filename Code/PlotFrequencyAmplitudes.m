function PlotFrequencyAmplitudes( a, p, f )
%PLOTFREQUENCYAMPLITUDES plots the frequency amplitudes of different imput
%data.

figure;

%%with smooth filter

% n=16;
% c=ones(1,n)/n;
% semilogy(a.fAxis,filter(c,1,a.Electrode));
% hold on;
% semilogy(p.fAxis,filter(c,1,p.Electrode));
% hold on;
% semilogy(f.fAxis,filter(c,1,f.Electrode));


%% for individual electrode

% n=1;
% semilogy(a.fAxis,a.Electrode(n,:));
% hold on;
% semilogy(p.fAxis,p.Electrode(n,:));
% hold on;
% semilogy(f.fAxis,f.Electrode(n,:));


%% without smooth filter

semilogy(a.fAxis,a.Electrode);
hold on;
semilogy(p.fAxis,p.Electrode);
hold on;
semilogy(f.fAxis,f.Electrode);

%% legend and axis...
%legend('Active','Passive');
legend('after 7 days','after 21 days','after 55 days'); %first a than p
ylabel('Amplitude');
xlabel('Frequency (Hz)');
title('Average frequency amplitudes from the ECoG records of experiments made either 7, 21 or 55 days after e-dura implantation (for rat 610)');
%title('Average frequency amplitudes from the ECoG records of either the "active" or the "passive" data (from rat 608)');
hold off;


end

