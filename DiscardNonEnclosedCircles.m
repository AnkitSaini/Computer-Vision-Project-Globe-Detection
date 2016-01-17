%------------------------------------------------------------------------------
% DiscardNonEnclosedCircles
%------------------------------------------------------------------------------
% C - circles
% X - X limit in pixels
% Y - Y limit in pixels
%------------------------------------------------------------------------------
% C - circles
% N - number of circles
%------------------------------------------------------------------------------
function [C,N] = DiscardNonEnclosedCircles(C,X,Y)
  n = size(C,1);
  c = zeros(n,4);
  N = 0;
  for i = 1:n
    if (C(i,3)+C(i,2)) <= X && (C(i,3)-C(i,2)) >= 1 && ...
       (C(i,4)+C(i,2)) <= Y && (C(i,4)-C(i,2)) >= 1
      N = N + 1;
      c(N,:) = C(i,:);
    end
  end
  C = c(1:N,:);
  disp(['Non-Enclosed Circles Discarded = ', num2str(n-N)]);
end

