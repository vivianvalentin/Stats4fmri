clear all; close all; clc;      %Clear all workspaces

% Define parameters, time, and the hrf
nTRs=480; theta=2.9; B0=40; delta=.01;
beta=[theta; B0; delta];
t=0:.1:1200; T0=0; n=4; lamda=2;
hrf=((t-T0).^(n-1)).*exp(-(t-T0)/lamda)/((lamda^n)*factorial(n-1));

% Define and plot the boxcar
box=[ones(1,3000),zeros(1,3000),ones(1,3000),zeros(1,3001)];
subplot(3,1,1); plot(t,box); axis([0 1200 0 1.5]);

% Convolve the hrf and boxcar and discretize
B=conv(hrf,box)/10;
tp=0:.1:2400;
for i=1:480
    N(i)=B(i*25);
end;

% Fill the design matrix
X(:,1)=N'; X(:,2)=ones(nTRs,1); X(:,3)=linspace(1, nTRs, nTRs)';

% Create and plot the data
Bdat=X*beta+normrnd(0,4,[nTRs,1]);
Bdat_plot=zeros(1,12001);
for i=1:480
    Bdat_plot(i*25)=Bdat(i);
end;
subplot(3,1,2); plot(t,Bdat_plot); axis([0 1200 30 60]); 

% Estimate the beta vector & error variance
beta_hat=inv(X'*X)*X'*Bdat
Var_e=(Bdat-X*beta_hat)'*(Bdat-X*beta_hat)/(nTRs-1-length(beta))

% Compute the t statistic
c=[1; 0; 0];
t_stat=c'*beta_hat/sqrt(Var_e*c'*inv(X'*X)*c)

%Plot predicted BOLD response
B_pred=X*beta_hat;
Bpred_plot=zeros(1,12001);
for i=1:480
    Bpred_plot((i-1)*25+1:i*25)=B_pred(i);
end;
subplot(3,1,3); plot(t,Bdat_plot); axis([0 1200 30 60]); 
hold on; plot(t,Bpred_plot); 


