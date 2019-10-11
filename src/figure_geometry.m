%% Make figure to show time series of emissions (rate and cumulative)

%% Initialization
figure(fnum);
z0=0.5;

%% Plot different melting region geometries
axes(ax(1)); % 1D
A_shallow=area([-1 1],[1 1],'DisplayName','Early');
hold on;
A_shallow.LineStyle='none';
A_shallow.FaceAlpha=1;
A_shallow.FaceColor=co(1,:);
A_deep=area([-1 1],[z0 z0],'DisplayName','Late');
A_deep.LineStyle='none';
A_deep.FaceAlpha=1;
A_deep.FaceColor=co(3,:);
plot([0 0],[0 1],'LineWidth',LW,'Color','k')
plot([- 1 1],[1 1],'--k','LineWidth',LW,'HandleVisibility','off')
box on

axes(ax(2)); %2D (constant depth)
A_shallow=area([-z0 0 z0],[z0 1 z0],'DisplayName','Early');
hold on;
A_shallow.LineStyle='none';
A_shallow.FaceAlpha=1;
A_shallow.FaceColor=co(1,:);
A_deep=area([-1 -z0 z0 1],[0 z0 z0 0],'DisplayName','Late');
A_deep.LineStyle='none';
A_deep.FaceAlpha=1;
A_deep.FaceColor=co(3,:);
plot([0 0],[0 1],'LineWidth',LW,'Color','k')
plot([- 1 0 1],[0 1 0],'--k','LineWidth',LW)
box on

axes(ax(3)); %2D (constant distance)
A_shallow=area([-1 0 1],[0 1 0],'DisplayName','Early');
hold on;
A_shallow.LineStyle='none';
A_shallow.FaceAlpha=1;
A_shallow.FaceColor=co(1,:);
A_deep=area([-z0 0 z0],[0 z0 0],'DisplayName','Late');
A_deep.LineStyle='none';
A_deep.FaceAlpha=1;
A_deep.FaceColor=co(3,:);
plot([0 0],[0 1],'LineWidth',LW,'Color','k','HandleVisibility','off')
plot([- 1 0 1],[0 1 0],'--k','LineWidth',LW,'HandleVisibility','off')
box on

l=legend(); % add a legend
l.Interpreter='latex';
l.FontSize=10;

%% Formating of axes
str={'(a)','(b)','(c)'};
title_str={'1D','2D (slow)','2D (fast)'};
for I=1:3
    axes(ax(I));
    set(gca,'TickLabelInterpreter','latex','FontSize',FS)
    set(gca,'XLim',[-1 1],'XTick',-1:0.5:1);
    set(gca,'YLim',[0 1],'YTick',0:.5:1);
    %xlabel('$\hat{x}$','Interpreter','latex','rotation',0,'FontSize',FS)
    if ~(I==1)
        set(gca,'YTickLabel',[]);
    else
        lab=ylabel('$\hat{z}$','Interpreter','latex','rotation',0,'FontSize',FS);
        lab.Position(2)=0.6;
        %lab.Position(1)=lab.Position(1)+.1;
    end
    text(-0.97, 0.92,str{I},'Interpreter','latex','FontSize',FS)
    title(title_str{I},'Interpreter','latex','rotation',0,'FontSize',FS);
end

%% Print figure
file_name=[fig_dir,'geometry'];
print(file_name,'-depsc')