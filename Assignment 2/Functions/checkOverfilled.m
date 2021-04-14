function [overfilled] = checkOverfilled(input_img)
%CHECKOVERFILLED Checks if the bottle is underfilled
%   By cropping the region of interest(area above the normal mark), and checking if the region is black
%   we can tell if there is cola in the region. If cola exist then would
%   show as black. Normal mark determined by getting the average cola level
%   position of normal bottles

% Converting the image to gray 
img_gray = rgb2gray(input_img);

upper_bounds = (120:140);
mid_cropping_bounds = (140:210);

% Cropping and binarizing around the region of interest
above_normal = img_gray(upper_bounds,mid_cropping_bounds,:);
above_bin = imbinarize(above_normal, 0.5);

% Counting black pixels
black_count = sum(above_bin(:) == 0 );
total_count = numel(above_bin(:));

proportion = black_count/total_count;
% If many black pixels then region is filled and hence over filled
overfilled = proportion > 0.6;

end

