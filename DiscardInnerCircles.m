%------------------------------------------------------------------------------
% DiscardInnerCircles
%------------------------------------------------------------------------------
% C - circles
% T - enclosed threshold in percentage (100% = fully enclosed)
%------------------------------------------------------------------------------
% C - circles
% N - number of circles
%------------------------------------------------------------------------------
function [C,N] = DiscardInnerCircles(C,T)
  n = size(C,1);
  C = sortrows(C,[2,1]);
  c = zeros(n,4);
  N = 0;
  f = 2-T/100;
  for i = n:-1:1
    new = true;
    if N > 0
      for j = 1:N
        if sqrt((C(i,3)-c(j,3))^2+(C(i,4)-c(j,4))^2)*f < (abs(C(i,2))+abs(c(j,2)))
        %if sqrt((C(i,3)-c(j,3))^2+(C(i,4)-c(j,4))^2)*f <= (abs(C(i,2)-c(j,2)))
          new = false;
        end
      end
    end
    if new
      N = N + 1;
      c(N,:) = C(i,:);
    end
  end
  C = sortrows(c(1:N,:),[2,1]);
  disp(['Inner Circles Discarded = ', num2str(n-N)]);
end

