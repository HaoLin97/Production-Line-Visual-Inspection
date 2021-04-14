function [print_missing] = checkNoLabelPrint(input_img)
%CHECKNOLABELPRINT Checks if the label is just plain,i.e. nothing printed
%   Using the blue channel of the image, so that the red pixels are treated
%   as dark pixels, so that the only bright pixels would be white(color of
%   the plain label)

label_bounds = (180:288);
mid_cropping_bounds = (110:240);

% Cropping the label area of the image's blue channel and binarizing it
img_crop = input_img(label_bounds, mid_cropping_bounds, 3);
img_bin = imbinarize(img_crop, 0.5);

% Counting and getting the proportion of the black pixels
black_count = sum(img_bin(:) == 0 );
total_count = numel(img_bin(:));
proportion = black_count/total_count;
% If too little black pixels then area is assumed to be white and thus
% nothing printed on label.
print_missing = proportion < 0.5;

end

