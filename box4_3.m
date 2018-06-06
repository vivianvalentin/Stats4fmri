clear all; close all; clc;      % Clear all workspaces

% Define time and the signal. Plot.
t=[0:.01:40]; ystand=20*exp(-(t-15).^2/5);
subplot(3,1,1); plot(t,ystand); axis([0 40 -10 30]);

% Read in (or create) the data. Plot.
ydat=ystand+normrnd(0,35,1,length(t));
subplot(3,1,2);
plot(t,ydat); axis([0 40 -200 200]);

% correlate the matched filter with the data & plot the results.
for j=1:4001;
    r=exp(-(t-j*.01).^2/5);
    Corect=r.*ydat;
    ypred(j)=sum(Corect)/sum(r);
end;
subplot(3,1,3); plot(t,ypred); axis([0 40 -5 20]);





