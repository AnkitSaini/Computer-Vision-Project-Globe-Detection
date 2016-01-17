%
% Carlos Morato
%
%%
%This program show the effect of thresholding. 
%The output are four subfigures shown in the same figure:
%
%   Subfigure 1: The initial "lena"
%   Subfigure 2: Threshold level is one alfa
%   Subfigure 3: Threshold level is two alfa
%   Subfigure 4: Threshold level is three alfa
%%

close all
clear all
clc

%% Threshold level parameter alfa:
alfa = 0.1;% less than 1/3

x = imread('three-wolf-moon.jpg');
ix = rgb2gray(x);
I_max = max(max(ix));
I_min = min(min(ix));
level1 = alfa *(I_max-I_min)+I_min;
level2 = 2*level1;
level3 = 3*level1;
thix1 = max(double(ix),double(level1) * double(ones(size(ix))));
thix2 = max(double(ix),double(level2) * double(ones(size(ix))));
thix3 = max(double(ix),double(level3) * double(ones(size(ix))));

figure(1);
colormap(gray);
subplot(2,2,1);
imagesc(ix);
title('lena');
subplot(2,2,2);
imagesc(thix1);
title('threshold one alfa');
subplot(2,2,3);
imagesc(thix2);
title('threshold two alfa');
subplot(2,2,4);
imagesc(thix3);
title('threshold three alfa');