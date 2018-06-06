clear all; close all; clc;                  % Clear all workspaces
ntime=2000; T=200; t=T*[0:ntime-1]/ntime;   % define time
TR=2;                                       % TR in seconds
TR=TR*ntime/T;

% Create the hrf
n=4; lamda=2; n2=7; lamda2=2; a=.3;
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));

% Create the boxcar & BOLD response
n=zeros(1,ntime); n(26:50)=ones(1,25); n(151:175)=ones(1,25); 
n(401:425)=ones(1,25); n(501:525)=ones(1,25); n(776:800)=ones(1,25); 
n(1001:1025)=ones(1,25); n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 
B=conv(hrf,n)/10; B=B(1:ntime);

% Order 1
X=[B(1:ntime-TR)]' ; Y=[B(TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(TR+1)*T/ntime:T/ntime:T;
subplot(3,1,1); plot(tt,Y,tt,P); axis([0 200 0 .4]);

% Order 2
X=[[B(TR+1:ntime-TR)]' [B(1:ntime-2*TR)]']; Y=[B(2*TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(2*TR+1)*T/ntime:T/ntime:T;
subplot(3,1,2); plot(tt,Y,tt,P); axis([0 200 0 .4]);

% Order 3
X=[[B(2*TR+1:ntime-TR)]' [B(TR+1:ntime-2*TR)]' [B(1:ntime-3*TR)]'];
Y=[B(3*TR+1:ntime)]'; A=(inv(X'*X))*X'*Y; P=X*A;
tt=(3*TR+1)*T/ntime:T/ntime:T;
subplot(3,1,3); plot(tt,Y,tt,P); axis([0 200 0 .4]);


