clear all; close all; clc;      % Clear all workspaces

% Create and plot the data
t=[0:.1:600];
y=50+50*sin(.01*t)+50*square(.25*t);
subplot(2,1,1); plot(t,y); axis([0 600 -100 200]); hold on;

% Low pass filter by smoothing with a Gaussian kernel & plot
W=250;          % W = kernel width
for j=1:6001;
    r=exp(-(t-j*.1).^2/W);
    Corect=r.*y;
    ylow(j)=sum(Corect)/sum(r);
end;
plot(t,ylow,'k');

% Subtract low-pass filtered data from raw data & plot
ypred=y-ylow;
subplot(2,1,2); plot(t,ypred); axis([0 600 -100 100]);





