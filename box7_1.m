clear all; close all; clc;      %Clear all workspaces
nsubs=8;                        % Select number of subjects
ntrials=10;                     % Select number of trials per subject

% Create (or read in) the data
% Set the individual subject means by sampling from the group distribution
group=2+4*randn(1,nsubs); 

% Sample the ntrials scores from each subject
for i=1:nsubs;
    x(:,i)=group(i)*ones(1,ntrials)+.5*randn(1,ntrials);
end;

% Compute the individual subject mean and standard deviation
M=mean(x)
s=std(x)

% Compute the fixed effects t-statistic
variance=s.^2; pooledvar=mean(variance);
sfixed=sqrt(pooledvar); tfixed=mean(M)/sqrt(pooledvar/nsubs)

% Compute the random effects t-statistic
srandom=std(M); trandom=mean(M)/(srandom/sqrt(nsubs))

% Plot everything
tx=[-10:.01:15]; k=1/sqrt(2*pi);
for i=1:nsubs;
    pdf=.5*(k/.5)*exp(-(tx-group(i)).^2/(2*.25));
    plot(tx,pdf); hold on;
    scatter(x(:,i),zeros(1,10),84,'x','k');
end;
pdfg=(k/4)*exp(-(tx-2).^2/(2*16));
plot (tx,pdfg); axis([-10 15 0 .5]);




