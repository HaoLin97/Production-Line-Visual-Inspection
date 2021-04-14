% Basic frequency domain filtering 
A=imread('cameraman.tif'); 
figure;
imshow(A);
B=fft2(A); 
B=fftshift(B);
[rows, cols]=size(A);
figure;
imagesc(log(1+abs(B))); 
axis image; axis off; colormap(gray)

% set up a “mask” to do the filtering
dim=5;
mask=zeros(rows,cols); 
mask(rows./2-dim:rows./2+dim,cols./2-dim:cols./2+dim)=1;
% apply the filter (simple multiplication of the mask by the spectrum of
% the image)
B2 = B.*mask;
Arecon=ifft2(B2);
figure;
subplot(1,2,1), imshow(mask); 
subplot(1,2,2), imagesc(abs(Arecon)); 
axis image; axis off; colormap(gray)


