clear all; close all; clc;      % Clear all workspaces

% Create difference of gammas hrf and plot
t=0:.01:24;
n1=4; lamda1=2; n2=7; lamda2=2; a=.3; c1=1; c2=.5;
hx=(t.^(n1-1)).*exp(-t/lamda1)/((lamda1^n1)*factorial(n1-1));
hy=(t.^(n2-1)).*exp(-t/lamda2)/((lamda2^n2)*factorial(n2-1));
hrf=a*(c1*hx-c2*hy);
plot(t,hrf,'k'); axis([0 25 -.01 .04]); hold on;

% Sample hrf every TR=3 seconds. Plot these points as circles.
for i=1:9
    xx(i)=hrf(300*i-299);
    n(i)=300*i-299;
end;
tt=0:3:24;
plot(tt,xx,'o'); hold on;

% Sinc interpolate with Eq. 4.4. L = width of Hanning window.
L=10;
for i=1:2401;
    B_interp(i)=sum(xx.*sinc((i-n)/300).*(1+cos(pi*.01*(i-n)/L))/2);
end;

% Plot
plot(t,B_interp);









