%% Create box figure 2 x 2

%% axis dimensions, inches
axh = 1.8/size_scale;  % axis height
axw = 2.73/size_scale;  % axis width
ahs = 0.46/size_scale;  % axis horiz spacing
avs = 0.45/size_scale;  % axis vert spacing
axb = 0.5/size_scale;  % axis bottom spacing
axt = 0.4/size_scale;  % axis top spacing
axl = 0.46/size_scale;  % axis left spacing
axr = 0.11/size_scale;  % axis right spacing

%% compute figure size and make figure
fh = axb + 2*axh +avs + axt;
fw = axl + 2*axw + ahs + axr;
set(fig,'Units','centimeters','Position',[0.7 12 fw fh]);
set(fig,'PaperPosition',[0 0 fw fh],'PaperSize',[fw fh]);
set(fig,'Color','w','InvertHardcopy','off', 'MenuBar','none');
set(fig,'Resize','off','Toolbar','none','Renderer','painters');


%% create axes
clf
ax(1) = axes('Units','centimeters','position',[axl axb+avs+axh axw axh]);
ax(2) = axes('Units','centimeters','position',[axl+axw+ahs axb+avs+axh axw axh]);
ax(3) = axes('Units','centimeters','position',[axl axb axw axh]);
ax(4) = axes('Units','centimeters','position',[axl+axw+ahs axb axw axh]);

axes(ax(1)); 
axes(ax(2)); 
axes(ax(3)); 
axes(ax(4)); 