clear all; close all; clc;          % Clear all workspaces

% Define time, the 3 basis functions, and the boxcar 
t50=0:.01:50;
b1=(t50.^3).*exp(-t50)/factorial(3);
b2=(t50.^7).*exp(-t50)/factorial(7);
b3=(t50.^15).*exp(-t50)/factorial(15);
box=[ones(1,500),zeros(1,100),ones(1,500),zeros(1,100),ones(1,500),zeros(1,3301)];

% Compute the 3 convolutions. Divide by 100 to set time unit at .01 sec
x1=conv(box,b1)/100; x2=conv(box,b2)/100; x3=conv(box,b3)/100;

% Compute the convolution products 
y11=x1.*x1; y13=x1.*x3;

% Set the weight parameters
a1=.2; a2=.2; a3=.2;
b11=.25; b13=-.25;

% Compute the predicted nonlinear BOLD response
H1=a1*x1+a2*x2+a3*x3;
H2=b11*y11+b13*y13;
B=H1+H2;

% Compute the predicted linear response (normalize weights so they sum to 1)
S=a1+a2+a3;
Lin=H1/S;

% Normalize area under nonlinear response to equal area under linear response
B=sum(Lin)*B/sum(B);

% Plot the boxcar and predicted nonlinear and linear responses 
t=0:.01:100;
plot(t50,box,t,B,t,Lin);
axis([0 40 0 1.1]);



