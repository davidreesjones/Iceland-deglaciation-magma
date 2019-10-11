%% Create box figure 2 x 2

%% axis dimensions, inches
axh = 2.1/size_scale;  % axis height
axw = 2.73/size_scale;  % axis width
ahs = 0.35/size_scale;  % axis horiz spacing
avs = 0.5/size_scale;  % axis vert spacing
axb = 0.6/size_scale;  % axis bottom spacing
axt = 0.45/size_scale;  % axis top spacing
axl = 0.46/size_scale;  % axis left spacing
axr = 0.13/size_scale;  % axis right spacing

%% compute figure size and make figure
fh = axb + 2*axh +avs + axt;
fw = axl + 3*axw + 2*ahs + axr;
set(fig,'Units','centimeters','Position',[0.7 12 fw fh]);
set(fig,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
set(fig,'Color','w','InvertHardcopy','off', 'MenuBar','none');
set(fig,'Resize','off','Toolbar','none','Renderer','painters');


%% create axes
clf
ax(1) = axes('Units','centimeters','position',[axl axb+avs+axh axw axh]);
ax(2) = axes('Units','centimeters','position',[axl+axw+ahs axb+avs+axh axw axh]);
ax(3) = axes('Units','centimeters','position',[axl+2*axw+2*ahs axb+avs+axh axw axh]);
ax(4) = axes('Units','centimeters','position',[axl axb axw axh]);
ax(5) = axes('Units','centimeters','position',[axl+axw+ahs axb axw axh]);
ax(6) = axes('Units','centimeters','position',[axl+2*axw+2*ahs axb axw axh]);

for I=1:6
    axes(ax(I)); 
end 