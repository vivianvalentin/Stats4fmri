clear all; close all; clc;                  % Clear all workspaces
ntime=2000; T=200; t=T*[0:ntime-1]/ntime;   % define time
TR=2; TR=TR*ntime/T;                        % TR in seconds
lag=1; lag=lag*ntime/T;                     % ny lag in seconds

n=4; lamda=2;                               % Create the hrf
hrf=(t.^(n-1)).*exp(-t/lamda)/((lamda^n)*factorial(n-1));

% Create the boxcars & BOLD responses
% ni
ni=zeros(1,ntime); ni(1:10)=1; ni(150:160)=1; ni(400:410)=1;
ni(500:510)=1; ni(800:810)=1; ni(1000:1010)=1; ni(1400:1410)=1;
Bi=conv(hrf,ni)/10; Bi=Bi(1:ntime);

% nk
lag=30;
nk=zeros(1,ntime); nk(1+5*lag:10+5*lag)=1; nk(150+lag:160+lag)=1;
nk(400+2*lag:410+2*lag)=1; nk(500+lag:510+lag)=1; nk(800+6*lag:810+6*lag)=1;
nk(1000+3*lag:1010+3*lag)=1; nk(1400+lag:1410+lag)=1;
Bk=conv(hrf,nk)/10; Bk=Bk(1:ntime);

% nj with inputs from k only
nj=zeros(1,ntime); nj(1+lag:10+lag)=1; nj(390:400)=1; nj(150+6*lag:160+6*lag)=1;
nj(1200:1210)=1; nj(400+3*lag:410+3*lag)=1; nj(540:550)=1; nj(500+4*lag:510+4*lag)=1;
nj(30:40)=1; nj(800+2*lag:810+2*lag)=1; nj(1490:1500)=1; nj(1000+1*lag:1010+1*lag)=1;
nj(890:900)=1; nj(1400+lag:1410+lag)=1; nj(1860:1870)=1;
Bj=conv(hrf,nj)/10; Bj=Bj(1:ntime);

% nj with inputs from i and k
njik=zeros(1,ntime); njik(1+lag:10+lag)=1; njik(1+4*lag:10+4*lag)=1;
njik(150+6*lag:160+6*lag)=1; njik(150+1*lag:160+1*lag)=1; njik(400+3*lag:410+3*lag)=1;
njik(400+4*lag:410+4*lag)=1; njik(500+4*lag:510+4*lag)=1; njik(500+1*lag:510+1*lag)=1;
njik(800+2*lag:810+2*lag)=1; njik(800+1*lag:810+1*lag)=1; njik(1000+1*lag:1010+1*lag)=1;
njik(1000+3*lag:1010+3*lag)=1; njik(1400+lag:1410+lag)=1;
Bjik=conv(hrf,njik)/10; Bjik=Bjik(1:ntime);

% Evaluate (Order 2) model: j given j & k 
X=[[Bj(TR+1:ntime-TR)]' [Bk(TR+1:ntime-TR)]' [Bj(1:ntime-2*TR)]' [Bk(1:ntime-2*TR)]']; 
Y=[Bj(2*TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(2*TR+1)*T/ntime:T/ntime:T;
subplot(2,1,1); plot(tt,Y,tt,P); axis([0 200 0 .25]);
sigsimp=(Y-P)'*(Y-P);

% Evaluate (Order 2) model: j given i, j & k model 
X=[[Bj(TR+1:ntime-TR)]' [Bk(TR+1:ntime-TR)]' [Bi(TR+1:ntime-TR)]' ...
    [Bj(1:ntime-2*TR)]' [Bk(1:ntime-2*TR)]' [Bi(1:ntime-2*TR)]']; 
Y=[Bj(2*TR+1:ntime)]';
A=(inv(X'*X))*X'*Y; P=X*A;
tt=(2*TR+1)*T/ntime:T/ntime:T;
subplot(2,1,2); plot(tt,Y,tt,P); axis([0 200 0 .25])
sigfull=(Y-P)'*(Y-P);

% Compute Granger causality
Fij=log(sigsimp/sigfull);


