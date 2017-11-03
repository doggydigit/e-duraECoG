function PlotSpectrogramPattern( F,T,P )
%PLOTSPECTROGRAMPATTERN plots the spectrogram patterns of an event for each
%electrode.

h=figure('units','normalized','outerposition',[0 0 1 1]);

colormin=-5;
colormax=5;

for i=1:9

s(i)=subaxis(2,5,i,'SpacingVert',0.03,'SpacingHoriz',0.003,'Padding',0,'Margin',0.04);
surf(T-T(end)/2,F,10*log10(P(:,:,i)./(mean(P(:,:,i)')'*ones(size(T)))),'edgecolor','none');
axis tight; 
view(0,90);
caxis([colormin colormax]);
vline(0,'r');
if(i<6)
    set(gca, 'XTickLabelMode', 'Manual');
    set(gca, 'XTick', []);
else
    xlabel('Time [s]');
end
if(i==1 || i==6)
    ylabel('Frequency [Hz]');
else
    set(gca, 'YTickLabelMode', 'Manual');
    set(gca, 'YTick', []);
end
if i==9
    title('Common Average Reference');
else
    title(strcat('Electrode ',num2str(i)));
end
end

s(10)=subaxis(2,5,10,'SpacingVert',0.03,'SpacingHoriz',0.003,'Padding',0,'Margin',0.04);
caxis([colormin colormax]);
colorbar('West');
axis off;

end

