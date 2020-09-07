clear;clc;close all
%% load the saved image in the current file
data=imread('car.jpg');
grey_data=im2double(data);
FT1=fft2(grey_data);
FT1=fftshift(FT1);

%% This is the fft of the image
figure
a=ones(120)*1;
imshow(log(1+abs(FT1)*(1/25)));
title('The FFT of the noisy image');
%% see what frequency does the image have
M1=(data(:,800));
M2=data(400,:);
x1=linspace(-0.5,0.5,800);
x2=linspace(-0.5,0.5,1600);
N1=fft(M1);
N1=fftshift(N1);
N2=fft(M2);
N2=fftshift(N2);
figure
plot(x1,abs(N1));
title('the frequency in y axis');
figure
plot(x2,abs(N2));
title('the frequency in x axis');
%% In this part we are going to filter the noise
new_data=sin_filter(0.2,0.2,1,grey_data); % this function is declared in the code
figure
plot(x1,abs(fftshift(fft(new_data(:,800)))));
title('one of the axis after filtering');
figure
imshow(new_data);
title('The non sin noise pic');
imwrite(new_data,'new_image1.jpg');
%% trying to get rid of the noise in different ways
x=10;
FT2=fft2(grey_data);
FT2=fftshift(FT2);
figure
imshow(log(1+abs(FT2)*(1/25)));
title('the fft of the image without noise');
%we can change this part to see the result
FT2(127-x:127+x,1:end)=0;
FT2(677-x:677+x,1:end)=0;
FT2(1:end,1342-x:1342+x)=0;
FT2(1:end,256-x:256+x)=0;
figure
imshow(log(1+abs(FT2)*(1/25)));
title('the fft of the image after delecting noise without noise');
FT2=ifftshift(FT2);
FT_image=ifft2(FT2);
figure
imshow(real(FT_image));
title('The picture from inversing the fft2');
%% puting the noise on the original picture
data2 = im2double(imread('Original.jpg'));
PSF=fspecial('motion',95,-30);
The_motion_noise=imfilter(data2,PSF);
figure
imshow(The_motion_noise);
title('The motion noise');
%% getting rid of the motion noise
PSF=fspecial('motion',95,-30);
last = deconvwnr(new_data, PSF, 0.005);
figure
imshow(abs(last));
title('The filtered picture');
%% calculate the SNR
SNR=snr(last,data2);
fprintf('The SNR is %f \n',SNR);
%%  calculate the MSE
MSE=mse(last,data2);
fprintf('The MSE is %f',MSE);
%% mean square function
function MSE=MSE_function(a,b)
K=0;
for i=1:800
   for j=1:1600
       K=K+(a(i,j)-b(i,j))^2;
   end
end
MSE=K/(800*1600);
end
%% filter function
function [res]=sin_filter(fc1,fc2,fs,data)
res=zeros(size(data));
[b1, a1]=butter(6,fc1/(fs/2),'low');
[b2, a2]=butter(6,fc2/(fs/2),'low');
for i=1:1600
   res(:,i)=filter(b1,a1,data(:,i));
end
tempt=res;
for j=1:800
   res(j,:)=filter(b2,a2,tempt(j,:));
end



end



