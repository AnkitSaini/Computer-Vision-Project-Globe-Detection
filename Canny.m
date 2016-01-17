% ---------- CANNY FILTER
% I - image matrix
% N - gaussian kernel size
% S - gaussian sigma
% L - low threshold
% H - high threshold
% T - Sobel threshold
function [TR,SM,GM,GD,SU,TH] = Canny(I,N,S,L,H,T)
  % blur image by appling NxN gaussian filter with sigma=S
  SM = Smoothing(I,N,S);
  SM = Normalization(SM,1);
  % aaply sobel filter and calculate gradient magnitude and direction
  [GM,GD] = Sobel(SM,[1 2 1],[1 0 -1], T);
  % round gradient directions to 0,45,90 and 135
  GD = Rounding(GD);
  % perform non-maxima supression
  SU = Supression(GM,GD);
  % apply thresholding low=L, high=H
  TH = Thresholding(SU,L,H);
  % perform edge tracking by histerysis
  TR = Tracking(TH,128,255);
end

% ---------- GAUSSIAN SMOOTHING
% I - image matrix
% N - gaussian kernel size
% S - gaussian sigma
function O = Smoothing(I,N,S)
  G = Gaussian2D(N,S);
  O = Convolution2D(G,I);
end

% ---------- 2D GAUSSIAN FUNCTION
% N - gaussian kernel size
% S - gaussian sigma
function G = Gaussian2D(N,S)
  G = Gaussian1D(N,S);
  G = G'*G;
end

% ---------- 1D GAUSSIAN FUNCTION
% N - gaussian kernel size
% S - gaussian sigma
function G = Gaussian1D(N,S)
  n = floor(N/2);
  G = 1/(S*sqrt(2*pi)) * exp(-1/(2*(S^2)) * power(-n:n,2));
end

% ---------- GRADIENT DIRECTION ROUNDING
% GD - gradient direction matrix
function GD = Rounding(GD)
  GD = floor(mod(floor((GD+pi/8)*16/pi)+16,16)/4)*45;
end

% ---------- NON-MAXIMA SUPRESSION
% I - image matrix
% D - gradient direction matrix (rounded)
function O = Supression(I,D)
  O = I;
  for y = 2:size(I,1)-1
    for x = 2:size(I,2)-1
      if ((D(y,x)==0  && (O(y,x)<O(y-1,x)     || O(y,x)<O(y+1,x)))   ||...
          (D(y,x)==45 && (O(y,x)<O(y-1,x-1)   || O(y,x)<O(y+1,x+1))) ||...
          (D(y,x)==90   && (O(y,x)<O(y,x+1)   || O(y,x)<O(y,x-1)))   ||...
          (D(y,x)==135  && (O(y,x)<O(y+1,x-1) || O(y,x)<O(y-1,x+1))))
        O(y,x) = 0;
      end
    end
  end
end

% ---------- NORMALIZATION
% N - normalization value
function I = Normalization(I,N)
  if N > 0
    I = I*(N/max(max(I)));
  end
end

% ---------- THRESHOLDING
% I - image matrix
% L - low threshold
% H - high threshold
function I = Thresholding(I,L,H)
  for y = 1:size(I,1)
    for x = 1:size(I,2)
      if I(y,x) > H
        I(y,x) = 255;
      else
        if I(y,x) < L
          I(y,x) = 0;
        else
          I(y,x) = 128;
        end
      end
    end
  end
end

% ---------- EDGE TRACKING BY HYSTERISIS
% I - image matrix
% W - weak edge
% S - strong edge
function O = Tracking(I,W,S)
  O = I;
  for y = 2:size(I,1)-1
    for x = 2:size(I,2)-1
      if O(y,x) == W
        if max(max(I(y-1:y+1,x-1:x+1))) == S
          O(y,x) = S;
        else
          O(y,x) = 0;
        end
      end
    end
  end
end
