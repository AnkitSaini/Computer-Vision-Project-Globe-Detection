%------------------------------------------------------------------------------
% globe.m
%------------------------------------------------------------------------------

% setup
clear all; clc; close all;

% parameters
% picure name (jpg)
picture = 'globe_6';
% circles to find (increase until it finds the globe)
max_circles_to_find = 8;


% Sobel threshold when detecting circles
th_sobel_circle = 45;
% scaling when doing edge-detection for circles (x dimension)
scaling = 150;
% theta/rho steps for Hough transform
theta_step = 2;
rho_step = 2;
% threshold for voting selection (top percentage)
th_votes = 50;
% discard thresholds
th_duplicate_circles = 20;
%percentage_inner = 50;
% Sobel threshold when detecting squares
th_sobel_square = 20;
% draw squares/lines
draw_squares = true;
draw_lines = false;

% load image, convert to gray scale and perform edge detection
jpg = sprintf('%s.jpg',picture);
[image,image_gray,image_scale,scale,X,Y] = LoadImage(jpg,scaling);

% find edges
edges = FindEdges(image_scale,th_sobel_circle);
%figure; imshow(edges); drawnow;

% find circles using Houg transform
hough_circles = HoughCircles(edges,theta_step,rho_step,th_votes);

% adjust circles for scaling
hough_circles = round([hough_circles(:,1) hough_circles(:,2:4)/scale]); 

% discard duplicate circles
unique_circles = DiscardDuplicateCircles(hough_circles,th_duplicate_circles);

% discard circles not fully enclosed into image frame (can be bypassed)
[circles,num_circles] = DiscardNonEnclosedCircles(unique_circles,X,Y);

% discard circles inside others
%[circles,num_circles] = DiscardInnerCircles(circles_enclosed,percentage_inner);

% draw circles
figure; imshow(image); hold on;
if num_circles > 0
  T = 0:2*pi/360:2*pi;
  n = min(num_circles,max_circles_to_find);
  for i = num_circles:-1:num_circles-n+1
   plot(circles(i,3)+cos(T)*circles(i,2),circles(i,4)+sin(T)*circles(i,2), ...
        'Color', 'yellow', 'LineWidth', 1);
  end
end
drawnow;

% perform edge-detection on full image
edges = FindEdges(image_gray,th_sobel_square);

% for each circle found
more_squares = 0;
for c = num_circles:-1:num_circles-min(num_circles,max_circles_to_find)+1
    
  % create sub-image
  o = round(circles(c,2)*0.8);
  sub_edges = edges(circles(c,4)-o:circles(c,4)+o,circles(c,3)-o:circles(c,3)+o);
    
  % find squares
  hough_lines = HoughLines(sub_edges,50);
  unique_lines = DiscardDuplicateLines(hough_lines,4,4);
  [horizontal,vertical] = SeparateHorVerLines(unique_lines);
  [squares,num_squares,lines] = FindSquares(circles(c,2),horizontal, ...
                                              vertical,3,3);

  % save most likely square
  if num_squares > more_squares
    more_squares = num_squares;
    top_circle = circles(c,2:4);
  end
    
  % draw squares/lines
  if num_squares > 0
    
    % draw sub-image
    figure; 
    imshow(sub_edges); 
    
    % for each square found
    for s = 1:min(num_squares,8)
      
      % draw lines
      if draw_lines
        l = squares(s,10);
        for i = 1:4
          y1 = round(lines(l,i*2-1)/sind(lines(l,i*2)));
          y2 = -y1/round(lines(l,i*2-1)/cosd(lines(l,i*2)))*X+y1;
          line([0 X],[y1 y2], 'Color', 'red');
        end
      end
        
      % draw squares
      if draw_squares
        for i = 1:4
          j = mod(i,4)+1;
          line([squares(s,i*2) squares(s,j*2)],[squares(s,i*2+1) squares(s,j*2+1)], ...
               'Color', 'yellow', 'LineWidth', 1);
        end
      end
      
    end
    drawnow
      
  end
end

% draw most likely
if more_squares > 1
  figure; 
  imshow(image);
  hold on;
  T = 0:2*pi/360:2*pi;
  plot(top_circle(2)+cos(T)*top_circle(1),top_circle(3)+sin(T)*top_circle(1), ...
      'Color', 'yellow', 'LineWidth', 2);
  drawnow;
end
