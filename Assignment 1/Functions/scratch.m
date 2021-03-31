% Used as a scratch file for debugging

input_img = imread('image062.jpg');
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

subplot(1,3,1), imshow(input_img)
title('Input image')
subplot(1,3,2), imshow(above_normal)
title('Cropped image')

subplot(1,3,3), imshow(above_bin)
title('Binarized image')

% imshow(input_img);
% hold on;
% rectangle('Position', pos, 'Edgecolor', 'g', 'LineWidth', 0.75);