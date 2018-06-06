clear all; close all; clc;              % Clear all workspaces

ntime=2000;             % number of time points
T=200;                  % time interval in seconds
t=T*[0:ntime-1]/ntime;  % define time

% Create the hrfs & plot
n=4; lamda=2; n2=7; lamda2=2; a=.3;
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));
h2=(t.^(n2-1)).*exp(-t/lamda2)/((lamda2^n2)*factorial(n2-1));
hrf2=(hrf-a*h2)/(sum(hrf-a*h2)*.1);
subplot(3,1,1); plot(t,hrf,t,hrf2); axis([0 25 -.02 .2]);

% Create the boxcars
n=zeros(1,ntime);
n(26:50)=ones(1,25); n(151:175)=ones(1,25); n(401:425)=ones(1,25); 
n(501:525)=ones(1,25); n(776:800)=ones(1,25); n(1001:1025)=ones(1,25); 
n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 
n2=[zeros(1,3),n(1:1997)];

% Convolve hrf & boxcar, add noise, then plot
B=conv(hrf,n)/10; B2=conv(hrf2,n2)/10;
B=B(1:ntime)+.03*randn(1,ntime); B2=B2(1:ntime)+.03*randn(1,ntime);
subplot(3,1,2); plot(t,B,t,B2); axis([0 200 -.1 .5]);

[C12,freq]=cohere(B,B2,[],[]);          % Compute coherence 

% freq runs from 0 to 1. Our sampling rate is ntime/T samples per sec.
% Nyquist rate is half this value. So in Hz, frequencies run from 0
% to one-half ntime/T.
freq=freq*ntime/(T*2);

subplot(3,1,3); plot(freq, C12); axis([0 0.5 0 1]);     % Plot

