%------------------------------------------------------------------------------
% DiscardDuplicateCircles
%------------------------------------------------------------------------------
% C - circles
% T - threshold for rejection (percentage)
%------------------------------------------------------------------------------
% C - circles
% N - number of circles
%------------------------------------------------------------------------------
function [C,N] = DiscardDuplicateCircles(C,T)
  n = size(C,1);
  c = zeros(n,4);
  N = 0;
  for i = n:-1:1
    new = true;
    if N > 0
      f = T/100*C(i,2);
      for j = 1:N
        if abs(C(i,3)-c(j,3)) <= f && abs(C(i,4)-c(j,4)) <= f && ...
           abs(C(i,2)-c(j,2)) <= f
          new = false;
        end
      end
    end
    if new
      N = N + 1;
      c(N,:) = C(i,:);
    end
  end
  C = sortrows(c(1:N,:),[1,2]);
  disp(['Duplicate Circles Discarded = ', num2str(n-N)]);
end

