clear all; close all; clc;              % Clear all workspaces

ntime=2000;             % number of time points
T=200;                  % time interval in seconds
t=T*[0:ntime-1]/ntime;  % define time
tlag=10;                % lag of n2 relative to n = tlag*T/ntime

% Create the hrf
n=4; lamda=2; n2=7; lamda2=2; a=.3;
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));

% Create the boxcars
n=zeros(1,ntime); n(26:50)=ones(1,25); n(151:175)=ones(1,25); 
n(401:425)=ones(1,25); n(501:525)=ones(1,25); n(776:800)=ones(1,25); 
n(1001:1025)=ones(1,25); n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 
n2=[zeros(1,tlag),n(1:ntime-tlag)];         % lags behind n
n3=[zeros(1,250),n(1:ntime-250)];           % lags further behind n

% Convolve hrf & boxcar, add noise
B1wo=conv(hrf,n)/10; B2wo=conv(hrf,n2)/10;
B3=B1wo(1:ntime)+.03*randn(1,ntime);
B1wo=B1wo(1:ntime)+.03*randn(1,ntime); B2wo=B2wo(1:ntime)+.03*randn(1,ntime);
B1=conv(hrf,n+n3)/10; B2=conv(hrf,n2+n3)/10; 
B1=B1(1:ntime)+.03*randn(1,ntime); B2=B2(1:ntime)+.03*randn(1,ntime);

% Compute partial coherence when there is no further influence between 1 & 2
[C12wo,freq]=cohere(B1wo,B2wo,[],[]);           
[C13wo,freq]=cohere(B1wo,B3,[],[]);
[C23wo,freq]=cohere(B2wo,B3,[],[]);
Q12wo=abs(sqrt(C12wo)); Q13wo=abs(sqrt(C13wo)); Q23wo=abs(sqrt(C23wo));
C12dot3wo=(Q12wo-Q13wo.*Q23wo).^2./((1-C13wo).*(1-C23wo));
freq=freq*ntime/(T*2);
subplot(2,1,1); plot(freq, C12dot3wo); axis([0 0.5 0 1]);     

% Compute partial coherence when there is extra influence between 1 & 2
[C12,freq]=cohere(B1,B2,[],[]);          
[C13,freq]=cohere(B1,B3,[],[]);
[C23,freq]=cohere(B2,B3,[],[]);
Q12=abs(sqrt(C12)); Q13=abs(sqrt(C13)); Q23=abs(sqrt(C23));
C12dot3=(Q12-Q13.*Q23).^2./((1-C13).*(1-C23));
freq=freq*ntime/(T*2);
subplot(2,1,2); plot(freq, C12dot3); axis([0 0.5 0 1]);     

