%% Make figure to show nonlinear vs linear velocity as a function of amount of extra melting Gamma_i

%% Initialize figure
figure(fnum); 
axes(ax(1));
hold on; box on;

%% Calculate and plot velocities (panel a)
velocity_scale = 65; %m/yr
F_crit=0.8;
vlambda=logspace(.3,3,24)/velocity_scale;
Gamma_i=[0 10 30];
v_correction=zeros(size(Gamma_i));
for I=1:numel(Gamma_i)
     if Gamma_i(I)<1e-4
        legend_name='$\mathcal{A} \ll 1$';
    else
        legend_name=['$\mathcal{A}=',num2str(Gamma_i(I),'%1.0f'),'$'];
    end
    vlambda_L = zeros(size(vlambda));
    for J=1:numel(vlambda)
        if Gamma_i(I)==0
            vlambda_L(J)=vlambda(J);
        else
            vlambda_L(J) = fun_nonlinear_lambda_equiv(vlambda(J),Gamma_i(I),F_crit);
        end
    end
    v_correction(I)=vlambda_L(end)/vlambda(end);
    plot(vlambda_L*velocity_scale,vlambda*velocity_scale,'DisplayName',legend_name,'LineWidth',LW,'Color',co(I,:));
end
for I=3
      if Gamma_i(I)==0
        vlambda_L_limit = vlambda;
    else
        vlambda_L_limit = vlambda*(Gamma_i(I)/2)/(sqrt(1+Gamma_i(I))-1);
      end
      plot(vlambda_L_limit*velocity_scale,vlambda*velocity_scale,'--k','LineWidth',LW,'DisplayName','Limit')
end

%% Format panel (a)
l=legend();
l.Interpreter='latex';
l.Location='southeast';
l.FontSize=FS;
set(gca,'YLim',[1 1000],'XLim',[10 1000])
set(gca,'XScale','log','YScale','log')
set(gca,'TickLabelInterpreter','latex','FontSize',FS)
xlabel('$\overline{w}_\mathrm{linear}$ (m/yr)','Interpreter','latex','FontSize',FS+1)
ylabel('$\overline{w}_\mathrm{nonlinear}$ (m/yr)','Interpreter','latex','FontSize',FS+1)
text(11, 600,'({a})','Interpreter','latex','FontSize',FS)

%% Ininitialize panel (b)
axes(ax(2)); hold on; box on;

%% Calculate and plot correction factor (panel b)
vGamma_i=linspace(1e-8,100,N_plot);
plot(vGamma_i,1./(vGamma_i/2).*(sqrt(1+vGamma_i)-1),'k','LineWidth',LW)
%plot(vGamma_i,2./sqrt(vGamma_i),'--k','LineWidth',LW) % limit Gamma_i>>1
for I=1:numel(Gamma_i)
    plot(Gamma_i(I),1/v_correction(I),'x','LineWidth',LW,'MarkerSize',MS,'Color',co(I,:))
end

%% Format panel (b)
set(gca,'TickLabelInterpreter','latex','FontSize',FS)
xlabel('$\mathcal{A}$','Interpreter','latex','FontSize',FS+1)
ylabel('${\overline{w}_\mathrm{nonlinear}}/{\overline{w}_\mathrm{linear}}$','Interpreter','latex','FontSize',FS+1)
text(2, .93,'({b})','Interpreter','latex','FontSize',FS)
set(gca,'YLim',[0 1],'XLim',[0 100],'XTick',0:20:100,'YTick',0:.20:1)

%% Print figure
file_name=[fig_dir,'lambda_equiv'];
print(file_name,'-depsc')