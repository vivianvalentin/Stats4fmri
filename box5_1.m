clear all; close all; clc;      %Clear all workspaces

% Define the time axis and the hrf 
t25=0:.01:25; T0=0; n=4; lamda=2;
hrf=((t25-T0).^(n-1)).*exp(-(t25-T0)/lamda)/((lamda^n)*factorial(n-1));

% Define and plot the boxcar
box=[ones(1,300),zeros(1,300),ones(1,600),zeros(1,900),ones(1,300),zeros(1,101)];
subplot(3,1,1); plot(t25,box); axis([0 40 0 2]);

% Convolve the hrf and boxcar and then plot
B=conv(hrf,box)/100;
t=0:.01:50;
subplot(3,1,2); plot(t,B); axis([0 40 0 1]);

% Discretize the predicted BOLD response (i.e., in the vector N) & plot
Nplot=zeros(1,5001);
for i=1:13
    N(i)=B(i*300);
    Nplot(i*300)=N(i);
end;
subplot(3,1,3); plot(t,Nplot); axis([0 40 0 1]);

