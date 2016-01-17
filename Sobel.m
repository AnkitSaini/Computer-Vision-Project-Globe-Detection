% ---------- SOBEL FILTER
% I  - image matrix
% KX - kernel x
% KY - kernel y
% N  - normalization number
function [GM,GD] = Sobel(I,KX,KY,N)
  % x gradient
  %GX = Convolution2D(KX',Convolution2D(KY,I));
  GX = conv2(KX',conv2(KY,single(I)));
  % y gradient
  %GY = Convolution2D(KY',Convolution2D(KX,I));
  GY = conv2(KY',conv2(KX,single(I)));
  % gradient magnitude
  GM = sqrt(power(GX,2)+power(GY,2));
  % normalization
  GM = Normalization(GM,N);
  GM = GM(2:size(GM,1)-1,2:size(GM,2)-1);
  % gradient direction
  GD = atan2(GY,GX);
end

% ---------- NORMALIZATION
% N - normalization value
function I = Normalization(I,N)
  I = I*(255/max(max(I)));
  for i = 1:size(I,1)
    for j = 1:size(I,2)
     if I(i,j) < N 
        I(i,j) = 0;
      else
        I(i,j) = 255;
      end
    end
  end
  %I = I*(N/max(max(I)));
  %I(1,:)=0;
  %I(:,1)=0;
  %I(size(I,1),:)=0;
  %I(:,size(I,2))=0;
end



