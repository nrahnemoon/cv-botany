function [imgMarkup, M] = Segmentation(seeds, I_leaf)

% Leaf segmentation using seeds.
labels = linspace(0, length(seeds)-1 , length(seeds))';

Mask1 = [];
beta = 40.0;
[M, ~] = grady(I_leaf,Mask1,seeds,labels,beta);
[~,~,imgMarkup] = segoutput(im2double(I_leaf),im2double(M));