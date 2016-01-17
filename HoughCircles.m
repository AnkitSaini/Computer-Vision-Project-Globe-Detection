%------------------------------------------------------------------------------
% HoughCircles
%------------------------------------------------------------------------------
% I - image
% T - theta resolution in degrees
% R - radius resolution in pixels
% V - threshold for top voting selection in percentage
%------------------------------------------------------------------------------
% C - circles
%------------------------------------------------------------------------------
function C = HoughCircles(I,T,R,V)

  % get image size
  nx = size(I,2);
  ny = size(I,1);
  disp(['Image: ', num2str(nx), 'x', num2str(ny)]);
  
  % calculate min and max radius
  rmax = floor(min(nx,ny)/2*100/100);
  nr = floor((rmax-0.2*rmax)/R);
  rmin = rmax-nr*R;
  
  disp(['Radius: Min = ', num2str(rmin), ' Max = ', num2str(rmax)]);
  
  % calculate # of angles
  nt = 360/T;

  % create R*sin(t) and R*cos(t) arrays for performance
  it = 0:T:360-T;
  c = cosd(it);
  s = sind(it);
  rc = zeros(nr,nt);
  rs = zeros(nr,nt);
  for r = rmin:R:rmax
    ir = (r-rmin)/R+1;
    rc(ir,:) = floor(r*c)';
    rs(ir,:) = floor(r*s)';
  end
  
  % build Hough space
  disp(['Building hough space...',num2str(nx),'x',num2str(ny),'x',...
         num2str(nr)]);
  ne = 0;
  nc = 0;
  ox = nx;
  oy = ny;
  H = zeros(nx+ox*2,ny+oy*2,nr);
  for x = 1:nx
    for y = 1:ny
      if I(y,x) == 255
        ax = ox+x;
        ay = oy+y;
        ne = ne + 1;
        for ir = 1:nr
          for it = 1:nt
            xc = ax+rc(ir,it);
            yc = ay+rs(ir,it);
            H(xc,yc,ir) = H(xc,yc,ir)+1;
            nc = nc + 1;
          end
        end
      end
    end
  end
  vmax = max(H(:));
  disp(['# of edges = ', num2str(ne)]);
  disp(['# of votes = ', num2str(nc)]);
  disp(['Top vote = ', num2str(vmax)]);

  % find most voted circles
  disp('Finding circles...');
  nc = 0;
  rmax = 0;
  C = zeros(20000,4);
  r = (0:nr-1)*R+rmin;
  v = (1-V/100)*vmax;
  for x = 1:nx+ox*2
    for y = 1:ny+oy*2
      for ir = 1:nr
        if H(x,y,ir) >= v
          nc = nc + 1;
          C(nc,:) = [H(x,y,ir) r(ir) x-ox y-oy];
          if r(ir) > rmax
            rmax = r(ir);
          end
        end
      end
    end
  end
  C = sortrows(C(1:nc,:));
  disp(['Largest circle radius = ', num2str(rmax)]);
  disp(['Initial # of circles = ', num2str(nc)]);
  
end
