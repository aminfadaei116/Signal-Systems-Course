clear;clc;close all
%% like the previose part we do the exact same thing
filter_type=input('enter the type of the filter that you want \n it could be lowpass or highpass: ','s');
filter_name=input('enter the name of filter it could be\n butterworth gaussian ideal: ','s');
fc=input('enter the cut off frequency: ');
f0=input('enter the filter rate: ','s');
image='noisyhead.jpg';
Yx  = Filter(image, filter_name ,filter_type , [fc f0] );
imshow(Yx);