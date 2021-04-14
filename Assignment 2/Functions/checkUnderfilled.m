function [underfilled] = checkUnderfilled(input_img)
%CHECKUNDERFILLED Checks if the bottle is underfilled
%   By cropping the region of interest(area under the normal mark), and checking if the region is black
%   we can tell if there is cola in the region. If cola exist then would
%   show as black. 

% Converting image to gray
img_gray = rgb2gray(input_img);

% Will need to switch to this gray image for part 2's frequency testing as
% the image is already in gray after filtering
% img_gray = input_img;


lower_bounds = (140:160);
mid_cropping_bounds = (140:210);

% Cropping and binarizing the image blow the normal mark
below_normal = img_gray(lower_bounds,mid_cropping_bounds,:);
below_bin = imbinarize(below_normal, 0.5);

% Counting the black pixels
black_count = sum(below_bin(:) == 0 );
total_count = numel(below_bin(:));

proportion = black_count/total_count;
% If very few black pixels under then norm mark then underfilled is
% returned
underfilled = proportion < 0.3;

end

