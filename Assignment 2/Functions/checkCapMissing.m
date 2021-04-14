function [cap_missing] = checkCapMissing(input_img)
%CHECKCAPMISSING Summary of this function goes here
%   Detailed explanation goes here
cap_bounds = (1:60);
mid_cropping_bounds = (110:240);
threshold = 1000;

% Extracting blue channel and cropping the cap
cap_cropped = input_img(cap_bounds,mid_cropping_bounds,3);

img_bin = imbinarize(cap_cropped, 50/255);

black_count = sum(img_bin(:) == 0 );

cap_missing = black_count < threshold;
end

