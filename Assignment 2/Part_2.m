clear all;
clc;

addpath(genpath(pwd));

% When changing the input folder, can either use one of the commented lines
% as directory name or could simply assign a folder path to the dir_name
% variable

% dir_name = '1-UnderFilled/';
% dir_name = '2-OverFilled/';
% dir_name = '3-NoLabel/';
% dir_name = '4-NoLabelPrint/';
% dir_name = '5-LabelNotStraight/';
% dir_name = '6-CapMissing/';
% dir_name = '7-DeformedBottle/';
dir_name = 'Normal/';
% dir_name = 'All/';
% dir_name = 'MissingBottle/';
% dir_name = 'Combinations/';

disp(join([dir_name, '*.jpg']));
imagefiles = dir(join([dir_name, '*.jpg']));
nfiles = length(imagefiles);    % Number of files found

results_var_acc = zeros(2 ,100);

for noise_var=0:0.01:1
    % Initiate a matrix of zeros to be used as results
    results = zeros(nfiles, 1);
    
    % loops through all the files in the selected folder
    for file_idx=1:nfiles
        currentfilename = imagefiles(file_idx).name;
        %   Reading the current image
        input_img = imread(join([dir_name, currentfilename]));
        %     disp(currentfilename);
        
        fault_found = 0;
%         Adds noise to the image
        noise_mean = 0;
        noise_img = imnoise(input_img, 'gaussian', noise_mean, noise_var);
        
%         Uncomment for average filtering
        f_size = [9 9];
        f = fspecial('average',f_size);
        img_filtered = imfilter(noise_img, f);
        
% Uncomment for gaussian filtering
%         sigma = 1.5;
%         img_filtered = imgaussfilt3(noise_img,sigma);

% Uncomment for frequency domain testing, also uncomment img_gray in
% checkUnderfilled.m (located in Functions folder)
%         % Basic frequency domain filtering
%         img_gray = rgb2gray(input_img);
%         A=img_gray;
%         B=fft2(A);
%         B=fftshift(B);
%         [rows, cols]=size(A);
% 
%         % set up a “mask” to do the filtering
%         dim=5;
%         mask=zeros(rows,cols);
%         mask(rows./2-dim:rows./2+dim,cols./2-dim:cols./2+dim)=1;
%         % apply the filter (simple multiplication of the mask by the spectrum of
%         % the image)
%         B2 = B.*mask;
%         Arecon=ifft2(B2);
% %       Image is now in gray, comment out graying in checkunderfilled
%         img_filtered = uint8(abs(Arecon));
        

        if checkUnderfilled(img_filtered)
            results(file_idx,1) = 1;
        end
        
        
    end
    %     Calculates and displays the results
    accuracy = (sum(results(:,1))/nfiles)*100;
    %     disp(['Variance: ', num2str(noise_var)]);
    %     disp(['Number of files: ', num2str(nfiles)]);
    %     disp(['Number of errors identified: ', num2str(sum(results(:,1)))]);
    %     disp(['Accuracy: ', num2str(accuracy)]);
    %     disp(round((noise_var+0.01)*100));
    results_var_acc(1, round((noise_var+0.01)*100)) = noise_var;
    results_var_acc(2, round((noise_var+0.01)*100)) = accuracy;
    
end
% Plotting the results
plot(results_var_acc(1,:),results_var_acc(2,:));
ylim([0,100])
xlabel('Noise Variance')
ylabel('Accuracy')
title('Variance vs Accuracy')