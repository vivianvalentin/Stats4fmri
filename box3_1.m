% Clear all workspaces
clear all; close all; clc;

% Set the parameter values of the hrf
T0=0; n=4; lamda=2;

% Define the time axis, i.e., from 0 to 30 sec in 1 msec increments
t=0:.01:30;

% Create the hrf
hrf=((t-T0).^(n-1)).*exp(-(t-T0)/lamda)/((lamda^n)*factorial(n-1));

% Plot the hrf
plot(t,hrf); axis([0 30 0 .12]);


