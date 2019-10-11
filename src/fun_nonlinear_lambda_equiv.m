function lambda_L = fun_nonlinear_lambda_equiv(lambda,Gamma_i,F_crit)
%fun_nonlinear_lambda_equiv 
%   Determine an equivalent linear lambda_L for a true (nonlinear) lambda
%   Equivalent dimensional time to get F_crit*100% of cumulative emissions
%   INPUTS:
%       * lambda: (true/nonlinear) ratio of deglaciation to melt travel time
%       * \Gamma_i: factor of extra melting due to deglaciation (called
%       \mathcal{A} in paper)
%       * F_crit: fraction of cumulative emissions
%   OUTPUTS:
%       * lambda_L: (equivalent linear) ratio of deglaciation to melt travel time

%% Determine time (hat{t}) when F=F_crit for true nonlinear model
th = fzero(@(th) fun1(th,lambda,Gamma_i,F_crit),[0 1+lambda]); 
lambda_max=10*lambda; % might need increasing for very large Gamma_i

%% Determine an equivalent linear model
lambda_L = fzero(@(lambda_L) fun1(th*lambda_L/lambda,lambda_L,1e-8,F_crit),[lambda,lambda_max]);
end

function F = fun1(th,lambda,Gamma_i,F_crit)
    [~,C] = fun_nonlinear_characteristics(th,lambda,Gamma_i);
    F=C/lambda-F_crit; % a zero of this function has F=F_crit
end