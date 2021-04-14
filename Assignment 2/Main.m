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
        
        noise_mean = 0;
        noise_img = imnoise(input_img, 'gaussian', noise_mean, noise_var);
        
        %   Checking for missing bottle, if missing ignore other tests
        if checkMissing(noise_img)
            disp('missing bottle');
            
        else
            if checkUnderfilled(noise_img)
                results(file_idx,1) = 1;
            end
            % %         Check for cap
%                     if checkCapMissing(noise_img)
% %                         disp('no cap');
%                         fault_found = 1;
%                         results(file_idx,1) = 1;
% 
%                     end
            %         Check for underfilled
%                         if checkUnderfilled(noise_img)
%                             %             disp('underfilled')
%                             fault_found = 1;
%                             results(file_idx,1) = 1;
%                         end
            % %         Check for deformations, if deformed then ignore overfilled
            %         if checkDeformed(input_img)
            %             disp('deformed');
            %
            %             fault_found = 1;
            %         elseif checkOverfilled(input_img)
            %             disp('overfilled');
            %             fault_found = 1;
            %         end
            %         Check for labels
%             if checkNoLabel(input_img)
%                 %             disp('no label')
%                 fault_found = 1;
%             elseif checkNoLabelPrint(input_img) %if no labels ignore
%                 disp('label not printed')
%                 fault_found = 1;
%                 %if no labels or deformed ignore
%             elseif checkLabelNotStraight(input_img)&&~checkDeformed(input_img)
%                 disp('label not straight');
%                 fault_found = 1;
%             end
            %             if fault_found == 0
            %                 disp('normal');
            %             end
            %       Used for better image inspection and fault inspection, can comment
            %       out if dont want to use.
            %         imshow(input_img);
            %         w = waitforbuttonpress
        end
        
        
        
    end
    accuracy = (sum(results(:,1))/nfiles)*100;
    %     disp(['Variance: ', num2str(noise_var)]);
    %     disp(['Number of files: ', num2str(nfiles)]);
    %     disp(['Number of errors identified: ', num2str(sum(results(:,1)))]);
    %     disp(['Accuracy: ', num2str(accuracy)]);
    %     disp(round((noise_var+0.01)*100));
    results_var_acc(1, round((noise_var+0.01)*100)) = noise_var;
    results_var_acc(2, round((noise_var+0.01)*100)) = accuracy;
    
end
plot(results_var_acc(1,:),results_var_acc(2,:));
xlabel('Noise Variance')
ylabel('Accuracy')
title('Variance vs Accuracy')