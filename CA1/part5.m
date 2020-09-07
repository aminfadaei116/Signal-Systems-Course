clear;clc
close all
%% part 1 in this part we get the data 
    X=imread('spine.tif');
    I=im2double(X);% the data must be between 0 to 1
%% part 2 we can also print the data that we have
figure
imshow(I,'InitialMagnification','fit');
title('original');
%% part 3
%% log transformation
% in this part we are going to apply the log transformation
c1=0.5;
g1=c1*(log10(I+1));
figure
imshow(g1,'InitialMagnification','fit');
title('c=0.5 log transformation');
c2=10;
g2=c2*(log10(I+1));
figure
imshow(g2,'InitialMagnification','fit');
title('c=10 log transformation');
%% gamma transformation we are goign to apply the gamma transformation
gama1=2;
gama2=5;
g3=c2*I.^(gama1);
g4=c2*I.^(gama2);
figure
imshow(g3,'InitialMagnification','fit');
title('c=10 gamma=2 gamma transformation');
figure
imshow(g4,'InitialMagnification','fit');
title('c=10 gamma=5 gamma transformation');



%% part 4
%in this part we are going to do a 2d convlotion 
X=imread('einstein.tif');
I=im2double(X);
m9=(1/81)*ones(9);
m7=(1/49)*ones(7);
m5=(1/25)*ones(5);
m11=(1/121)*ones(11);
C9=hand_conv2(I,m9);
% after the calculation we are going to see that the convoltion has brout
% some noise on the pictures
figure
imshow(C9,'InitialMagnification','fit');
title('with convolotion 9');
C7=hand_conv2(I,m7);
figure
imshow(C7,'InitialMagnification','fit');
title('with convolotion 7');
C11=hand_conv2(I,m11);
figure
imshow(C11,'InitialMagnification','fit');
title('with convolotion 11');
C5=hand_conv2(I,m5);
figure
imshow(C5,'InitialMagnification','fit');
title('with convolotion 5');
figure
imshow(I,'InitialMagnification','fit');
title('without convolotion');
% after all this things we have done we can see that the bigger they are
% the more noise they have

%% Function this is the 2d convoltion function
function [C]=hand_conv2(a1,b)
    a2=rot90(a1,2);
    a2_height=size(a2,1);
    b_height=size(b,1);
    a2_length=length(a2);
    b_length=length(b);
    A=[zeros(b_height-1,b_length-1),zeros(b_height-1,a2_length),zeros(b_height-1,b_length-1);
       zeros(a2_height,b_length-1),a2,zeros(a2_height,b_length-1);
       zeros(b_height-1,b_length-1),zeros(b_height-1,a2_length),zeros(b_height-1,b_length-1)];
C=zeros(a2_height+b_height-1,a2_length+b_length-1);
for i=0:a2_height+b_height-2
    for j=0:a2_length+b_length-2
    	sum=0;	
    	for k=1:b_height
    		for p=1:b_length
    		sum=sum+b(k,p)*A(i+k,j+p);
			end    
    	end
    	C(i+1,j+1)=sum;
    end 
end 
C=rot90(C,2);
end 