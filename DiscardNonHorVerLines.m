%------------------------------------------------------------------------------
% DiscardNonHorVerLines
%------------------------------------------------------------------------------
% L  - lines array
% T - theta threshold
%------------------------------------------------------------------------------
% L  - lines array
%------------------------------------------------------------------------------
function L = DiscardNonHorVerLines(L,T)
  nL = size(L,1);
  nl = 0;
  l = zeros(nL,3);
  for i = 1:nL
    if L(i,3) <= T || (L(i,3) >= (90-T) && L(i,3) <= (90+T)) || L(i,3) >= (180-T)
      nl = nl + 1;
      l(nl,:) = L(i,:);
    end
  end
  L = sortrows(l(1:nl,:));
  disp(['Non-Hor/Ver Lines Discarded = ', num2str(nL-nl)]);
end

