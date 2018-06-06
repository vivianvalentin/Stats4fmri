% Clear all workspaces
clear all;
close all;
clc;

% Set the parameter values of the hrf
T0=0; n=4; lamda=2;

% Define the time axis, i.e., from 0 to 50 sec in .01 sec increments
% and the 3 boxcar functions
t50=0:.01:50;
null=zeros(1,5000);
box5=[ones(1,500),zeros(1,4501)];
box20=[ones(1,2000),zeros(1,3001)];
box50=[ones(1,5000),0];

% Create the hrf
hrf=((t50-T0).^(n-1)).*exp(-(t50-T0)/lamda)/((lamda^n)*factorial(n-1));

% Compute the 3 convolutions. Divide by 100 to set time unit at .01 sec.
BOLD5=conv(box5,hrf)/100;
BOLD20=conv(box20,hrf)/100;
BOLD50=conv(box50,hrf)/100;

% Plot the predicted BOLD response
t=0:.01:100;
subplot(3,1,1);
plot(t,BOLD5,t50,box5);
axis([0 100 0 1.5]);

subplot(3,1,2);
plot(t,BOLD20,t50,box20);
axis([0 100 0 1.5]);

subplot(3,1,3);
plot(t,BOLD50,t50,box50);
axis([0 100 0 1.5]);


