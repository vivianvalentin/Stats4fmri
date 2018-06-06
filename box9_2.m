clear all; close all; clc;                  % Clear all workspaces
ntime=2000; T=200; t=T*[0:ntime-1]/ntime;   % define time
TR=2; TR=TR*ntime/T;                        % TR in seconds
lag=1; lag=lag*ntime/T;                     % ny lag in seconds

n=4; lamda=2;                               % Create the hrf
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));

% Create the boxcars & BOLD responses
n=zeros(1,ntime); n(26:50)=ones(1,25); n(151:175)=ones(1,25); 
n(401:425)=ones(1,25); n(501:525)=ones(1,25); n(776:800)=ones(1,25); 
n(1001:1025)=ones(1,25); n(1401:1425)=ones(1,25); n(1601:1625)=ones(1,25); 
Bx=conv(hrf,n)/10; Bx=Bx(1:ntime);
ny=[zeros(1,lag), n(1:ntime-lag)]; By=conv(hrf,ny)/10; By=By(1:ntime);

% Simple Order 2 model
X=[[By(TR+1:ntime-TR)]' [By(1:ntime-2*TR)]']; Y=[By(2*TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(2*TR+1)*T/ntime:T/ntime:T;
subplot(2,1,1); plot(tt,Y,tt,P); axis([0 200 0 .4]);
sigsimp=(Y-P)'*(Y-P)                        % sum of squared error

% Full Order 2 model
X=[[By(TR+1:ntime-TR)]' [Bx(TR+1:ntime-TR)]' [By(1:ntime-2*TR)]' [Bx(1:ntime-2*TR)]']; 
Y=[By(2*TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(2*TR+1)*T/ntime:T/ntime:T;
subplot(2,1,2); plot(tt,Y,tt,P); axis([0 200 0 .4]);

sigfull=(Y-P)'*(Y-P)                        % sum of squared error
Fij=log(sigsimp/sigfull)                    % Granger causality