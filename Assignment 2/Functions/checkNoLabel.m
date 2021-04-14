function [label_missing] = checkNoLabel(input_img)
%CHECKNOLABEL Checks whether the label exist on the bottle
%   Uses the red channel to check if there is a label existing, red pixels
%   would be counted as white pixels. If there are too many black pixels
%   then assumed no labels

% Cropping the label area of the middle bottle
label_bounds = (180:288);
mid_cropping_bounds = (110:240);
img_crop = input_img(label_bounds, mid_cropping_bounds,1);
% Binarizing the image, using the red channel and threshold obtained from
% imhist()
img_bin = imbinarize(img_crop, 50/255);

% Counting and getting proportion of black pixels 
black_count = sum(img_bin(:) == 0 );
total_count = numel(img_bin(:));
proportion = black_count/total_count;
% If there are too many black pixels then label is missing 
label_missing = proportion > 0.5;
end

