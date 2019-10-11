function [Q,C] = fun_nonlinear_characteristics(t,lambda,Gamma_i)
%fun_nonlinear_characteristics 
%   Determine time series emissions rate (Q) and cumulative emissions (C).
%   Uses analytical method based on the method of characteristics
%   INPUTS:
%       * t: time (\hat{t} in paper)
%       * lambda: ratio of deglaciation to melt travel time
%       * \Gamma_i: factor of extra melting due to deglaciation (called
%       \mathcal{A} in paper)
%   OUTPUTS:
%       * Q: relative emissions rate (called \hat{Q} in paper)
%       * C: cumulative emissions (n.b. not scaled with lambda).
%               C=\int_0^t Q(t') dt'

if lambda<=0||Gamma_i<0
    error('parameters not in allowed range');
end
t1=(1+Gamma_i)^(-1/2); % time scale when regime changes
vt=t;
vQ=zeros(size(t));
vC=zeros(size(t));
if lambda>=t1 % case of fast melt transport
    for t=vt
        if t<0
            Q=0;
            C=0;
        elseif t<=t1
            Q=2*t*sqrt(1-t^2*Gamma_i) - t^2*(1 - Gamma_i);
            C=(1/3/Gamma_i)*(2-2*(1-Gamma_i*t^2)^(3/2)-t^3*Gamma_i*(1-Gamma_i));
        elseif t<=lambda
            Q=1;
            C=t+(2/3/Gamma_i)*(1-(1+Gamma_i)^0.5);
        elseif t<=lambda+1
            Q=1+(t-lambda)^2*(1+2*Gamma_i)-2*(t-lambda)*sqrt(1+Gamma_i)*sqrt(1+Gamma_i*(t-lambda)^2);
            C=t+1/3*(t-lambda)^3*(1+2*Gamma_i)+(2/3/Gamma_i)*(1-sqrt(1+Gamma_i)*(1+Gamma_i*(t-lambda)^2)^(3/2));
        else
            Q=0;
            C=lambda;
        end
        vQ(t==vt)=Q;
        vC(t==vt)=C;
    end
else % case of slow melt transport
    t2=sqrt(1+Gamma_i*(1+Gamma_i)*lambda^2)-Gamma_i*lambda; % time scale when regime changes
    for t=vt
        if t<0
            Q=0;
            C=0;
        elseif t<=lambda
            Q=2*t*sqrt(1-t^2*Gamma_i) - t^2*(1 - Gamma_i);
            C=(1/3/Gamma_i)*(2-2*(1-Gamma_i*t^2)^(3/2)-t^3*Gamma_i*(1-Gamma_i));
        elseif t<=t2
            Q=lambda*(-2*t+lambda*(1+Gamma_i)+2*sqrt(1+lambda*Gamma_i*(lambda-2*t)));
            C=lambda*((t-lambda)*(lambda*Gamma_i-t)-lambda^2/3*(1-Gamma_i))+(2/3/Gamma_i)*(-(1+lambda*Gamma_i*(lambda-2*t))^(3/2)+1) ;
        elseif t<=lambda+1
            Q=1+(t-lambda)^2*(1+2*Gamma_i)-2*(t-lambda)*sqrt(1+Gamma_i)*sqrt(1+Gamma_i*(t-lambda)^2);
            C=lambda*((t2-lambda)*(lambda*Gamma_i-t2)-lambda^2/3*(1-Gamma_i))+(2/3/Gamma_i)*(-(1+lambda*Gamma_i*(lambda-2*t2))^(3/2)+1) + ...
                t-t2+1/3*((t-lambda)^3-(t2-lambda)^3)*(1+2*Gamma_i)-(2/3/Gamma_i)*sqrt(1+Gamma_i)*((1+Gamma_i*(t-lambda)^2)^(3/2)-(1+Gamma_i*(t2-lambda)^2)^(3/2));
        else
            Q=0;
            C=lambda;
        end
        vQ(t==vt)=Q;
        vC(t==vt)=C;
    end
end
Q=vQ;
C=vC;
