clear all; close all; clc;              % Clear all workspaces

ntime=2000;             % number of time points
T=200;                  % time interval in seconds
t=T*[0:ntime-1]/ntime;  % define time

% Create the hrf
n=4; lamda=2; n2=7; lamda2=2; a=.3;
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));

% Create the boxcar
n=zeros(1,ntime); n(26:50)=ones(1,25); n(151:175)=ones(1,25); 
n(401:425)=ones(1,25); n(501:525)=ones(1,25); n(776:800)=ones(1,25); 
n(1001:1025)=ones(1,25); n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 

% Convolve hrf & boxcar, add noise, then plot
B=conv(hrf,n)/10; B=B(1:ntime)+.03*randn(1,ntime); 
subplot(2,1,1); plot(t,B); axis([0 200 -.1 .4]);

[R_B,lags]=xcorr(B,'coeff');    % Compute autocorrelation function
P_B=abs(fft(R_B))/(ntime/2);    % Absolute value of the fft
P_B=P_B(1:ntime/2);             % Compute power for positive frequencies
freq=[0:ntime/2-1]/T;           % Define frequency in Hz

% Plot on semilog scale
subplot(2,1,2); semilogy(freq,P_B); axis([0 .5 0 1]);

