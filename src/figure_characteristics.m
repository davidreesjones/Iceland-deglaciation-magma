%% Setup figure
figure(fnum);
co_plus=cat(1,[0 0 0],co);
for I=1:2
    axes(ax(I))
    A=area([0 1],[1 1]); % indicate deglaciation period
    hold on;
    A.LineStyle='none';
    A.FaceAlpha=1;
    A.FaceColor=[237,248,251]/255;
end

%% Calculate and plot lambda < t1 case
axes(ax(2))
lambda=0.23; Gamma_i=10;
t1=1/sqrt(1+Gamma_i); %could use to check lambda<t1
z0_c = (-lambda+sqrt(1-Gamma_i*lambda^2))^2;
for z0=[0.8, .55 0.3,z0_c] %first period
    if z0==z0_c
        J=1;
        sty='--';
    else
        J=2;            
        sty='-';

    end
    z=linspace(z0,1,N_plot);
    s=1/(1+Gamma_i)*(sqrt((1+Gamma_i)*z-Gamma_i*z0)-sqrt(z0));
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:),'LineStyle',sty)
end
for z0=[0.15 0.08 0.03 0] %second period
    if z0==0
        J=1;
    else
        J=3;
    end
    z_lambda=1/(1+Gamma_i)*(Gamma_i*z0+((1+Gamma_i)*lambda+sqrt(z0))^2);
    z=linspace(z0,z_lambda,N_plot);
    s=1/(1+Gamma_i)*(sqrt((1+Gamma_i)*z-Gamma_i*z0)-sqrt(z0));
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
    z=linspace(z_lambda,1,N_plot);
    Q_lambda=z_lambda-z0;
    s=lambda+sqrt(z+Gamma_i*Q_lambda)-sqrt(z_lambda+Gamma_i*Q_lambda);
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
end
J=4;
for t0=[0.03, 0.09,0.14 ,0.2, lambda] %third period
    s=linspace(t0,lambda);
    z=(1+Gamma_i)*(s-t0).^2;
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
    z_lambda = (1+Gamma_i)*(lambda-t0)^2;
    Q_lambda = z_lambda ;
    z=linspace(z_lambda,1,N_plot);
    s=sqrt(z+Gamma_i*Q_lambda)+lambda-(1+Gamma_i)*(lambda-t0);
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
end

%% Calculate and plot lambda > t1 case
axes(ax(1))
lambda=0.77; Gamma_i=10;
t1=1/sqrt(1+Gamma_i);
z0_c = 0;
for z0=[0.8, .55 0.3,z0_c] %first period
    if z0==z0_c
        J=1;
        sty='--';
    else
        J=2;        
        sty='-';
    end
    z=linspace(z0,1,N_plot);
    s=1/(1+Gamma_i)*(sqrt((1+Gamma_i)*z-Gamma_i*z0)-sqrt(z0));
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:),'LineStyle',sty)
end
t0_c=lambda-t1;
for t0=[ 0.1 0.2 0.3 t0_c] %second period
    if t0==t0_c
        J=1;
    else
        J=3;
    end
    s=linspace(t0,lambda,N_plot);
    z=(1+Gamma_i)*(s-t0).^2;
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
end
J=4;
for t0=[0.55 .6, .7, lambda] %third period
    s=linspace(t0,lambda);
    z=(1+Gamma_i)*(s-t0).^2;
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
    z_lambda = (1+Gamma_i)*(lambda-t0)^2;
    Q_lambda = z_lambda ;
    z=linspace(z_lambda,1,N_plot);
    s=sqrt(z+Gamma_i*Q_lambda)+lambda-(1+Gamma_i)*(lambda-t0);
    plot(s/lambda,z,'LineWidth',LW,'Color',co_plus(J,:))
end

%% Formating of axes
axes(ax(2))
set(gca,'XLim',[0 2],'YLim',[0 1])
set(gca,'TickLabelInterpreter','latex','FontSize',FS)
set(gca,'XLim',[0 3],'XTick',0:0.5:3);
set(gca,'YLim',[0 1],'YTick',0:.20:1);
title('$\mathcal{A}=10$, $\lambda=0.23<t_1$','Interpreter','latex','FontSize',FS)
text(2.8, 0.93,'({b})','Interpreter','latex','FontSize',FS)
ylabel('$\hat{z}$','Interpreter','latex','rotation',0,'FontSize',FS)
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)

axes(ax(1))
set(gca,'XLim',[0 2],'YLim',[0 1])
set(gca,'TickLabelInterpreter','latex','FontSize',FS)
set(gca,'XLim',[0 3],'XTick',0:0.5:3);
set(gca,'YLim',[0 1],'YTick',0:.20:1);
title('$\mathcal{A}=10$, $\lambda=0.77>t_1$','Interpreter','latex','FontSize',FS)
text(2.8, 0.93,'({a})','Interpreter','latex','FontSize',FS)
ylabel('$\hat{z}$','Interpreter','latex','rotation',0,'FontSize',FS)
xlabel('$\hat{t}/\lambda$ \quad [$t$ (kyr)]','Interpreter','latex','FontSize',FS)

%% Print figure
file_name=[fig_dir,'characteristics'];
print(file_name,'-depsc')