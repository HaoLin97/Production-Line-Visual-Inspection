clear all;
clc;
close all;
% Used as a scratch file for debugging

input_img = imread('underfilled-image031.jpg');
% input_img = imread('normal-image001.jpg');

img_noise = imnoise(input_img, 'gaussian', 0, 0.4);
img_gray = rgb2gray(img_noise);

% f_size = [9 9];
% f = fspecial('average');
% img_avg = imfilter(img_noise, f);
% 
% sigma = 1.5;
% img_gaus = imgaussfilt3(img_noise,sigma);


% Basic frequency domain filtering 
A=img_gray; 
% figure;
% imshow(img_noise);
B=fft2(A); 
B=fftshift(B);
[rows, cols]=size(A);
figure;
imagesc(log(1+abs(B))); 
axis image; axis off; colormap(gray)

% set up a “mask” to do the filtering
dim=15;
mask=zeros(rows,cols); 
mask(rows./2-dim:rows./2+dim,cols./2-dim:cols./2+dim)=1;
% apply the filter (simple multiplication of the mask by the spectrum of
% the image)
B2 = B.*mask;
Arecon=ifft2(B2);
% figure;
% subplot(1,2,1), imshow(mask); 
% subplot(1,2,2), imagesc(abs(Arecon)); 
% axis image; axis off; colormap(gray)

filtered_img = uint8(abs(Arecon));

% figure;
% imshow(filtered_img);

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

figure;
imshow(input_img)
title('Input image')
figure;
imshow(img_gray)
title('Gray image')
figure;
imshow(img_noise)
title('Noise image')

figure;
imshow(below_bin)
title('Binary noise')

% Cropping and binarizing the image blow the normal mark
below_normal = filtered_img(lower_bounds,mid_cropping_bounds,:);
below_bin = imbinarize(below_normal, 0.5);
figure;
imshow(below_bin)
title('Binary filtered')

% figure(4);
% imshow(img_avg)
% title('Filtered average')
% figure(5);
% imshow(img_gaus)
% title('Filtered gaussian')
% 
% figure(6);
% imshow(below_bin)
% title('Binary noise')

% img_gray = rgb2gray(img_avg);
% % Cropping and binarizing the image blow the normal mark
% below_normal = img_gray(lower_bounds,mid_cropping_bounds,:);
% below_bin = imbinarize(below_normal, 0.5);
% figure(7);
% imshow(below_bin)
% title('Binary avg')
% 
% img_gray = rgb2gray(img_gaus);
% % Cropping and binarizing the image blow the normal mark
% below_normal = img_gray(lower_bounds,mid_cropping_bounds,:);
% below_bin = imbinarize(below_normal, 0.5);
% figure(8);
% imshow(below_bin)
% title('Binary gaus')
