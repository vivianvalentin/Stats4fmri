clear all; close all; clc;              % Clear all workspaces

% Create the hrf
n=4; lamda=2; n2=7; lamda2=2; a=.3;
t=0:.1:200;
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));
h2=(t.^(n2-1)).*exp(-t/lamda2)/((lamda2^n2)*factorial(n2-1));
hrf2=(hrf-a*h2)/(sum(hrf-a*h2)*.1);

% Create the boxcar
n=zeros(1,2001);
n(26:50)=ones(1,25); n(151:175)=ones(1,25); n(401:425)=ones(1,25); 
n(501:525)=ones(1,25); n(776:800)=ones(1,25); n(1001:1025)=ones(1,25); 
n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 
n2=[zeros(1,100),n(1:1901)];

% Convolve hrf & boxcar, then add noise
B=conv(hrf,n)/10; B2=conv(hrf2,n2)/10;
B=B(1:2001)+.03*randn(1,2001); B2=B2(1:2001)+.03*randn(1,2001);
subplot(4,1,1); plot(t,B); axis([0 200 -.1 .4]);

% Compute autocorrelation function & plot
[R_B,lags]=xcorr(B,'coeff');
subplot(4,1,2); plot(lags/10,R_B); axis([-200 200 0 1]);

% Plot both BOLD responses
subplot(4,1,3); plot(t,B,t,B2); axis([0 200 -.1 .4]);

%Compute cross-correlation function & plot
[R12,lags]=xcorr(B,B2,'coeff');
subplot(4,1,4); plot(lags/10,R12); axis([-200 200 0 1]);


