function [deformed] = checkDeformed(input_img)
%CHECKDEFORMED This function checks if the bottle is deformed
%   The function finds the largest regions of connected pixels
%  The relationship between pixels are found using bwconncomp
%  The thesholds on the area,height,width of the region is used, if the
%  bottle is deformed then the region should be outside the threshold. The
%  threshold is chosen manually after inspecting the min and max for the
%  properties for each image category. Main concept is that deformation
%  will cause the bottle to shink in width

% Cropping the image to show only the label of middle bottle
img_crop = input_img((180:288), (100:260), :);

% Taking the red channel
img_red = img_crop(:,:,1);

% Getting binary image using threshold obtained from imhist of normal img
img_bin = imbinarize(img_red, 200/256);

% Unused as decreases accuracy, was originally coded to tackle the issue
% where there is no label thus a different threshold and channel is needed
% to obtain a binary image that separates foreground and background

% Counting and getting proportion of black pixels in binary img
% black_count = sum(img_bin(:) == 0 );
% total_count = numel(img_bin(:));
%
% proportion = black_count/total_count;

%     img_gray = rgb2gray(img_crop);
%     img_bin = imbinarize(img_gray, 2/256);


% If the label is missing, then ignore (as all images in the dataset have a
% mutual exclusive between deformation and missing label)
if checkNoLabel(input_img)
    deformed = 0;
    return
end

% Finds the connected pixels and generate the region of interest using
% bounding boxes
conn_comp = bwconncomp(img_bin, 4);

properties = regionprops(conn_comp, 'BoundingBox');
max_area = 0;
max_height = 0;
max_width = 0;

for i = 1 : length(properties)
    b_box = properties(i).BoundingBox;
    area = b_box(3)*b_box(4);
    %     checks for the largest bounding box
    if area > max_area
        max_area = area;
        max_width = b_box(3);
        max_height = b_box(4);
    end
end
% checks the properties of the bounding box against the thresholds
check_area = (max_area >= 10000) && (max_area <= 13500);
check_width = (max_width >= 110) && (max_width <= 130);
check_height = (max_height >= 80) && (max_height <= 110);

% If none the thresholds are violated then no deformation, otherwise bottle
% is deformed
deformed = (check_area && check_width && check_height) == 0;
end

