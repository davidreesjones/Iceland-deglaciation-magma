%% Make figure to show equivalence between linear and nonlinear models at different velocities

%% Initialize figure
figure(fnum);

%% Determine equivalent models and timeseries thereof
F_crit=0.8;
velocity_scale = 65; %m/yr
lambda=30/velocity_scale;
Gamma_i=31.30;
lambda_L = fun_nonlinear_lambda_equiv(lambda,Gamma_i,F_crit);
tp_max=3;
t=linspace(0,tp_max*lambda,N_plot);
[Q,C] = fun_nonlinear_characteristics(t,lambda,Gamma_i);
t0=linspace(0,tp_max*lambda_L,N_plot);
[Q0,C0] = fun_nonlinear_characteristics(t0,lambda_L,1e-8);
legend_name0=strcat('Linear');
legend_name=strcat('Nonlinear');

%% Plot emissions rate (panel a)
axes(ax(1)); 
A=area([0 1],[1 1],'DisplayName','Deglaciation');
hold on;
A.LineStyle='none';
A.FaceAlpha=1;
A.FaceColor=[237,248,251]/255;
plot(t0/lambda_L,Q0,'LineWidth',LW,'DisplayName',legend_name0,'Color',co(1,:));
plot(t/lambda,Q,'LineWidth',LW,'DisplayName',legend_name,'Color',co(3,:));

set(gca,'TickLabelInterpreter','latex','FontSize',FS)
set(gca,'XLim',[0 2.5],'XTick',0:0.5:3);
set(gca,'YLim',[0 1],'YTick',0:.20:1);
box on
title(['$\overline{w}_\mathrm{linear}=',num2str(lambda_L*velocity_scale,3),'$ (m/yr), $\overline{w}_\mathrm{nonlinear}=',num2str(lambda*velocity_scale,3),'$ (m/yr)'],'Interpreter','latex','FontSize',FS)
yl1=ylabel('$\hat{Q}$ [Relative emission rate]','Interpreter','latex','rotation',90,'FontSize',FS);
text(0.03, .93,'({a})','Interpreter','latex','FontSize',FS)

%% Plot cumulative emissions (panel b)
axes(ax(2)); 
A2=area([0 1],[100 100],'DisplayName','Deglaciation');
hold on;
A2.LineStyle='none';
A2.FaceAlpha=1;
A2.FaceColor=[237,248,251]/255;
plot(t0/lambda_L,100*C0/lambda_L,'LineWidth',LW,'DisplayName',legend_name0,'Color',co(1,:));
plot(t/lambda,100*C/lambda,'LineWidth',LW,'DisplayName',legend_name,'Color',co(3,:));

l=legend(); % add a legend
l.Interpreter='latex';
l.Location='southeast';
l.FontSize=FS;

box on;
set(gca,'XLim',[0 2.5],'XTick',0:0.5:3);
set(gca,'YLim',[0 100],'YTick',0:20:100);
set(gca,'TickLabelInterpreter','latex','FontSize',FS)
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)
yl2=ylabel('$\hat{F}$ [Cumulative emissions (\%)]','Interpreter','latex','rotation',90,'FontSize',FS);
text(0.03, 93,'({b})','Interpreter','latex','FontSize',FS)

yl2.Position(1) = min(yl2.Position(1),yl1.Position(1)); % align labels
yl1.Position(1) = min(yl2.Position(1),yl1.Position(1));

%% Print figure
file_name=[fig_dir,'lambda_equiv_example'];
print(file_name,'-depsc')