%------------------------------------------------------------------------------
% HoughLines
%------------------------------------------------------------------------------
% I  - image
% V - threshold for top voting selection in percentage
%------------------------------------------------------------------------------
% L - lines
% N - number of lines
%------------------------------------------------------------------------------
function [L,N] = HoughLines(I,V)

  % get image size
  nx = size(I,2);
  ny = size(I,1);
  disp(['Image: ', num2str(nx), 'x', num2str(ny)]);
  
  % calculate # of thetas
  nt = 180;
  t = 0:nt-1;
  l = cosd(t);
  s = sind(t);

  % calculate # of rhos
  rmax = round(sqrt(size(I,1)^2+size(I,2)^2));
  r = -rmax:rmax;
  nr = size(r,2);
  disp(['Rho: # = ', num2str(nr), ' Range = +/-', num2str(rmax)]);

  % build Hough space
  ne = 0;
  nl = 0;
  H = zeros(nr*2+1, nt);
  for x = 1:nx
    for y = 1:ny
      if I(y,x) == 255
        ne = ne + 1;
        for it = 1:nt
          ir = round(x*l(it)+y*s(it))+rmax+1;
          H(ir,it) = H(ir,it) + 1;
          nl = nl + 1;
        end
      end
    end
  end
  vmax = max(H(:));
  disp(['# of edges = ', num2str(ne)]);
  disp(['# of votes = ', num2str(nl)]);
  disp(['Top vote = ', num2str(vmax)]);

  % find most voted lines
  disp('Finding lines...');
  N = 0;
  L = zeros(10000,3);
  v = (1-V/100)*vmax;
  for ir = 1:nr
    for it = 1:nt
      if H(ir,it) >= v
        N = N + 1;
        L(N,:) = [H(ir,it) r(ir) t(it)];
      end
    end
  end
  L = sortrows(L(1:N,:));
  disp(['Initial # of lines = ', num2str(N)]);
  
end
