function [missing] = checkMissing(input_img)
%CHECKMISSING Checks if there is a bottle at the middle of the image
%   Uses the blue channel to account for the red cap scenarios, red would
%   be counted as black
%   Using the binary version of the image to see if there are any dark
%   pixels, if there is less than the threshold then assumed no bottle

% Binarizing the middle section of the image 
img_crop = input_img(:, (110:240),3);
img_bin = imbinarize(img_crop, 100/255);

% Counting and getting proportion of dark pixels
black_count = sum(img_bin(:) == 0 );
total_count = numel(img_bin(:));

proportion = black_count/total_count;
% If less than 10% of the pixels are black then empty image is assumed
missing = proportion < 0.1;
end

