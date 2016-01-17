%------------------------------------------------------
% SeparateHorVerLines
%------------------------------------------------------
% L  - lines array
%------------------------------------------------------
% H  - horizontal lines array
% V  - vertical lines array
%------------------------------------------------------
function [H,V] = SeparateHorVerLines(L)
  nl = size(L,1);
  V = zeros(nl,3);
  H = zeros(nl,3);
  nv = 0;
  nh = 0;
  for i = 1:nl
    if L(i,3) < 45 || L(i,3) > 135
      nv = nv + 1;
      V(nv,:) = L(i,:);
    else
      nh = nh + 1;
      H(nh,:) = L(i,:);
    end
  end
  H = sortrows(H(1:nh,:));
  V = sortrows(V(1:nv,:));
  disp(['Lines: Horizontal = ', num2str(nh), ' Vertical = ', num2str(nv)]);
end

