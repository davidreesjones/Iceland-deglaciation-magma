%% Make figure to show time series of emissions (rate and cumulative)

%% Initialization
figure(fnum);
Gamma_i=[1e-8,10,30];
t_deglaciation = 1; % kyr
t_scale = [1.3*100/30,1.3,.65]; % kyr
t_max=3;
legend_name=cell(1,numel(Gamma_i));
for J=1:numel(Gamma_i)
    if Gamma_i(J)<1e-4
        legend_name{J}='$\mathcal{A} \ll 1$';
    else
        legend_name{J}=['$\mathcal{A}=',num2str(Gamma_i(J),'%1.0f'),'$'];
    end
end

%% Calculate and plot time series
for I=1:3 %loop over different melt velocities
    for J=1:numel(Gamma_i) %loop over extra melt rate
        lambda= t_deglaciation/t_scale(I);
        t=linspace(0,t_max*lambda,N_plot);
        [Q,C] = fun_nonlinear_characteristics(t,lambda,Gamma_i(J));
        tp=t/lambda;
        axes(ax((I-1)+1));
        if J==1
            A=area([0 1],[1 1],'DisplayName','Deglaciation');
            hold on;
            A.LineStyle='none';
            A.FaceAlpha=1;
            A.FaceColor=[237,248,251]/255;
        end
        plot(tp,Q,'LineWidth',LW,'DisplayName',legend_name{J},'Color',co(J,:))
        box on
        axes(ax((I-1)+4));
        if J==1
            A=area([0 1],[100 100],'DisplayName','Deglaciation');
            hold on;
            A.LineStyle='none';
            A.FaceAlpha=1;
            A.FaceColor=[237,248,251]/255;
        end
        plot(tp,C/lambda*100,'LineWidth',LW,'DisplayName',legend_name{J},'Color',co(J,:))
        box on
    end
end

%% Formating of axes
for I=1:6
    axes(ax(I));
    set(gca,'TickLabelInterpreter','latex','FontSize',FS)
    set(gca,'XLim',[0 3],'XTick',0:0.5:3);
    if I<=3
        set(gca,'YLim',[0 1],'YTick',0:.20:1);
        if ~(I==1)
            set(gca,'YTickLabel',[]);
        end
    else
        set(gca,'YLim',[0 100],'YTick',0:20:100);
         if ~(I==4)
            set(gca,'YTickLabel',[]);
        end
    end
    
end



axes(ax(1));
yl1=ylabel('$\hat{Q}$ [Emission rate]','Interpreter','latex','rotation',90,'FontSize',FS);
title('$\overline{w}_\mathrm{max} = 30$ m/yr','Interpreter','latex','FontSize',FS)
text(2.7, 0.93,'({a})','Interpreter','latex','FontSize',FS)

axes(ax(2));
title('$\overline{w}_\mathrm{max} = 100$ m/yr','Interpreter','latex','FontSize',FS)
text(2.7, 0.93,'({b})','Interpreter','latex','FontSize',FS) 

axes(ax(3));
title('$\overline{w}_\mathrm{max} = 200$ m/yr','Interpreter','latex','FontSize',FS)
text(2.7, 0.93,'({c})','Interpreter','latex','FontSize',FS)

axes(ax(4));
yl2=ylabel('$\hat{F}$ [Cumulative emissions (\%)]','Interpreter','latex','rotation',90,'FontSize',FS);
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)
text(0.05, 93,'({d})','Interpreter','latex','FontSize',FS)

axes(ax(5));
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)
text(0.05, 93,'({e})','Interpreter','latex','FontSize',FS)

axes(ax(6));
l=legend(); % add a legend
l.Interpreter='latex';
l.Location='southeast';
l.FontSize=10;
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)
text(0.05, 93,'({f})','Interpreter','latex','FontSize',FS)

yl2.Position(1) = min(yl2.Position(1),yl1.Position(1)); % align labels
yl1.Position(1) = min(yl2.Position(1),yl1.Position(1));

%% Print figure
file_name=[fig_dir,'timeseries'];
print(file_name,'-depsc')