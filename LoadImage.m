function [IC,IG,IS,S,NX,NY] = LoadImage(P,S)
  
  % load image
  IC = imread(P);

  % return dimensions
  NX = size(IC,2);
  NY = size(IC,1);
  
  % convert to gray scale
  IG = rgb2gray(IC);
  
  % scale it
  S = S/NX;
  IS = imresize(IG,S);
  
end

