%------------------------------------------------------------------------------
% DiscardDuplicateLines
%------------------------------------------------------------------------------
% L - lines
% T - theta threshold for rejection
% R - rho threshold for rejection
%------------------------------------------------------------------------------
% L  - lines array
%------------------------------------------------------------------------------
function L = DiscardDuplicateLines(L,T,R)
  nL = size(L,1);
  l = zeros(nL,3);
  nl = 0;
  for i = nL:-1:1
    new = true;
    if nl > 0
      for j = 1:nl
        if abs(L(i,2)-l(j,2)) <= R && abs(L(i,3)-l(j,3)) <= T
          new = false;
        end
      end
    end
    if new
      nl = nl + 1;
      l(nl,:) = L(i,:);
    end
  end
  L = sortrows(l(1:nl,:),[1,2]);
  disp(['Duplicate Lines Discarded = ', num2str(nL-nl)]);
end

