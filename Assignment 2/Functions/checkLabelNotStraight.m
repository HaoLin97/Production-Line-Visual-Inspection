function [label_not_straight] = checkLabelNotStraight(input_img)
%CHECKLABELNOTSTRAIGHT Checks if the label is straight
%   Using the white strip at the top of the label as the feature, if that
%   strip forms a single continuous long white pixel line then the label is 
%   considered to be straight.

white_label_bounds = (180:188);
mid_cropping_bounds = (110:240);
% Crops at the top of the label area
white_label = input_img(white_label_bounds,mid_cropping_bounds,3);
x = size(white_label, 1);
y = size(white_label, 2);

%  goes through each row of the cropped image looking for white pixels 
highest = 0;
for row = 1:x    % for number of rows of the image
    cont_count = 0;
    for col = 1:y    % for number of columns of the image
        value = white_label(row, col);
%         Increase the count if the pixel intensity is above 150
        if value > 150
            cont_count = cont_count + 1;
        end
    end
%     Finds the longest row of white pixels
    if cont_count > highest
        highest = cont_count;
    end
end
% if the longest row is shorter than 70 than label is not straight, 70
% obtained manually
label_not_straight = highest < 70;
end

