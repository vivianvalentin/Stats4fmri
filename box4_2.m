clear all; close all; clc;      %Clear all workspaces

% Read in the first image (i.e., X) and plot
X(1:20,1:20)=5; X(6:15,6:15)=12; X(6:9,6:9)=20;
X(10:12,10:12)=40; X(13:15,13:15)=32; N=normrnd(0,1.5,[20,20]);
X=X+N;
subplot(3,1,1); image(X); colormap(gray); brighten(.5);

% Read in the second image (i.e., Y) and plot
N=normrnd(0,1.5,[20,20]); Y=-X+N+50;
subplot(3,1,2); image(Y);

% Load the images into vectors
for i=1:20;
    XV(1+20*(i-1):20*i)=X(i,1:20);
    YV(1+20*(i-1):20*i)=Y(i,1:20);
end;

% Bin the entries in each vector (bin width = 1)
XBin=round(XV);
YBin=round(YV);

% Create a scatterplot
subplot(3,1,3); scatter(XBin,YBin,'k','.');




