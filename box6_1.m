clear all; close all; clc;      % Clear all workspaces

%Define acceptable false discovery rate & number of tests
q=.05; N=120;

% Create (or read in) data (i.e., z- or t-values)
Z=[normrnd(0,1,[1,100]),normrnd(3,1,[1,20])];

% Convert data to P values, rank order, and plot
P=1-normcdf(Z,0,1);
P_rank=sort(P);
i=1:120; plot(i,P_rank,'o'); hold on; 

% Plot criterion values
plot(i,q*i/N); axis([0 40 0 .02]); hold on;

% Find threshold
TT=0; nsig=0;
for j=1:N;
   if q*j/N > P_rank(j), nsig=nsig+1; TT=q*j/N; end;
end;

% Plot threshold
T=ones(1,N)*TT; plot(i,T);
nsig








