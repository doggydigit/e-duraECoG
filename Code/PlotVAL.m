function PlotVAL( v )
%PLOTVAL plots the VALs focused on one electrode

% Input should be an array of VAL. If the function "VAL" is used, one
% should only use one line of the output matrix as input of the function
% "PlotVAL".
%
% Example: 
% >> x=VAL(trials);
% >> PlotVAL(x(1,:))

m(1,1)=v(8);
m(1,2)=v(3);
if length(v)==9
    m(1,3)=v(9);
else
    m(1,3)=NaN;
end
m(2,1)=v(7);
m(2,2)=v(5);
m(2,3)=v(1);
m(3,1)=v(6);
m(3,2)=v(4);
m(3,3)=v(2);

imagesc(m); % Create a colored plot of the matrix values
colormap(flipud('autumn')); 
colormap(flipud(colormap));          
colorbar;
textStrings = strtrim(cellstr(num2str(m(:),'%0.2f'))); % Create strings of the VAL
[x,y] = meshgrid(1:3); % Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),'HorizontalAlignment','center'); % Plot the strings
                
view(0,90);
set(gca, 'XTick', []);
set(gca, 'YTick', []);

end

