clear all; close all; clc;      % Clear all workspaces
 
% Define number of TRs (nTRs) & scale factor for plotting
nTRs=16; scalefac=4;
 
% Create the boxcar
box=[ones(1,4),zeros(1,4),ones(1,4),zeros(1,4)];
 
% Create the design matrix
X(:,1)=box';
X(:,2)=ones(nTRs,1);
X(:,3)=linspace(1, nTRs, nTRs)';
 
% Scale columns 1 and 2 so all columns have same max
X(:,1)=max(max(X))*X(:,1); X(:,2)=max(max(X))*X(:,2);
 
% Scale and plot the matrix
X=scalefac*X; 
colormap(gray); image(X);




