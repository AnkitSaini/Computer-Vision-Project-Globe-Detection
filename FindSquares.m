%------------------------------------------------------------------------------
% FindSquares
%------------------------------------------------------------------------------
% R - radius
% H - horizontal lines
% V - vertical lines
% T - theta resolution in degrees
% R - rho resolution in pixels
%------------------------------------------------------------------------------
% S - squares
% N - number of squares
% L - lines
%------------------------------------------------------------------------------
function [S,N,L] = FindSquares(R,H,V,tT,tR)
  h = size(H,1);
  v = size(V,1);
  o = pi*R/12;
  f = tR/100*o;
  S = zeros(1000,10);
  L = zeros(1000,8);
  sh = sind(H(:,3));
  ch = cosd(H(:,3));
  sv = sind(V(:,3));
  cv = cosd(V(:,3));
  N = 0;
  for h1 = h:-1:1
    for h2 = h:-1:1
      if h2 ~= h1 && (H(h2,2)-H(h1,2))>=(o-f) && (H(h2,2)-H(h1,2))<=(o+f) && ...
         abs(H(h1,3)-H(h2,3)) <= tT
        for v1 = v:-1:1
          if abs(H(h1,3)-V(v1,3)) >= (90-tT) && abs(H(h1,3)-V(v1,3)) <= (90+tT)
            for v2 = v:-1:1
              if v2 ~= v1 && (V(v2,2)-V(v1,2))>=(o-f) && (V(v2,2)-V(v1,2))<=(o+f) && ...
                 abs(V(v1,3)-V(v2,3)) <= tT
                if   abs(H(h2,3)-V(v2,3)) >= (90-tT) && abs(H(h2,3)-V(v2,3)) <= (90+tT)
                  N = N + 1;
                  
                  yh1 = H(h1,2)/sh(h1);
                  yh2 = -yh1/(H(h1,2)/ch(h1))*h+yh1;
                  yv1 = V(v1,2)/sv(v1);
                  yv2 = -yv1/(V(v1,2)/cv(v1))*h+yv1;
                  x11 = h*(yv1-yh1)/((yh2-yh1)-(yv2-yv1));
                  y11 = (yh2-yh1)/h*x11+yh1;
                  
                  yv1 = V(v2,2)/sv(v2);
                  yv2 = -yv1/(V(v2,2)/cv(v2))*h+yv1;
                  x12 = h*(yv1-yh1)/((yh2-yh1)-(yv2-yv1));
                  y12 = (yh2-yh1)/h*x12+yh1;
                  
                  yh1 = H(h2,2)/sh(h2);
                  yh2 = -yh1/(H(h2,2)/ch(h2))*h+yh1;
                  x22 = h*(yv1-yh1)/((yh2-yh1)-(yv2-yv1));
                  y22 = (yh2-yh1)/h*x22+yh1;
  
                  yv1 = V(v1,2)/sv(v1);
                  yv2 = -yv1/(V(v1,2)/cv(v1))*h+yv1;
                  x21 = h*(yv1-yh1)/((yh2-yh1)-(yv2-yv1));
                  y21 = (yh2-yh1)/h*x21+yh1;
                  
                  S(N,:) = round([H(h1,1)+H(h2,1)+V(v1,1)+V(v2,1) x11 y11 x12 y12 x22 y22 x21 y21 N]); 
                  L(N,:) = [H(h1,2:3) H(h2,2:3) V(v1,2:3) V(v2,2:3)];
                  
                  % FIX
                  if sum(isnan(S(N,:))) > 0
                    N = N - 1;
                  end
                  
                  %disp(['H1=',num2str(H(h1,2)),'/',num2str(H(h1,3)),...
                  %      '  H2=',num2str(H(h2,2)),'/',num2str(H(h2,3)),...
                  %      '  V1=',num2str(V(v1,2)),'/',num2str(V(v1,3)),...
                  %      '  V2=',num2str(V(v2,2)),'/',num2str(V(v2,3))]);
                  
                end
              end
            end
          end
        end
      end
    end
  end
  if N > 0
    S = sortrows(S(1:N,:));
    L = L(1:N,:);
  else
    S = 0;
    L = 0;
  end
  disp(['Squares Found = ', num2str(N)]);
end

