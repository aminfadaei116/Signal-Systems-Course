clc;
clear ;
close all;
%% lets start this
% read the image and changing to cell 8*8
I=imread('Original.jpg');
I1 = mat2cell(I,8*(ones(1 ,100)),8*(ones(1 ,200)));
 
%reduce 128 from ever of cell and show image
I2 = cell(100 ,200);
for i=1:1:100
    for j=1:1:200
    I2{i,j}=double(I1{i,j}) - 128*(ones(8));
    end
end
I5 = cell2mat(I2);
% I5=(I5+abs(I5))/2; THis part is done by amin
%imshow(I5);


%Discrete cosine transform 2D and show image for 2 method
D = dct(eye(8));
I3 = cell(100 , 200);
for i=1:1:100
    for j=1:1:200
       I3{i,j}=D*I2{i,j}*D';
       I3{i,j}= uint8(I3{i,j});
    end
end


%for i=1:1:100
%    for j=1:1:200
%      I3{i,j} = dct2(I2{i,j});
%      I3{i,j}= uint8(I3{i,j});
%      end
%end
%I4 = cell2mat(I3);
%figure;
%imshow(I4);



%Quantization
Q= [ 16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99];
      
 
 I6 = cell(100 , 200);
for i=1:1:100
    for j=1:1:200
    I6{i,j}=double(round(double(I3{i ,j})./Q));
    end
end
%%
I7=zeros(1,800*1600);
for i=1:100
   for j=1:200
      I7(64*(j-1+200*(i-1))+1:64*(j+200*(i-1)))= huffman_f(I6{i,j});
   end
end
%% we are going to use a sytax that we understand
n=0;
M1=[];
flag=0;
for i=1:length(I7)
    if n==15
        flag=1;
    elseif I7(i)==0
       n=n+1;
       flag=0;
   else 
       flag=1;
   end
   if flag==1
       M1=[M1,[n;I7(i);length(de2bi(I7(i)))]];
       n=0;
   elseif i==length(I7)
           M1=[M1,[0;0;0]];
   end
end
%% turn in to binary
M2=de2bi(M1);
%% very_big is that very huge string that we have no isea what it is :/
very_big=zeros(1,length(M2)*5);
for i=1:length(M2)
   for j=1:5
      very_big(j+5*(i-1))=M2(i,j); 
   end  
end
%%

%%
KK=zeros(3,116617);
for i=1:(116617)
   for j=1:3 
    KK(j,i)=bi2de(very_big((3*(i-1)+j-1)*5+1:(3*(i-1)+j)*5));   
   end
end
%% this
KK2=zeros(1,800*1600);
n=1;
for i=1:length(KK)
    if KK(1,i)==0
        KK2(n)=KK(2,i);
        n=n+1;
    else
   for j=1:KK(1,i)
    KK2(n)=0;
    n=n+1;
    
   end
   KK2(n)=KK(2,i);
   n=n+1;
    end
end
%% we are going to turn it to an way that we can under stand
KK3=zeros(800,1600);
for i=1:100
   for j=1:200
       KK3(1+8*(i-1):8*i,1+8*(j-1):8*j)=inver_huffman_f(KK2(1+64*(j-1)+200*64*(i-1):64*j+200*64*(i-1)));
   end
end
kk4 = mat2cell(KK3,8*(ones(1 ,100)),8*(ones(1 ,200)));
%% Dequantization
kk5 = cell(100 , 200);
for i=1:1:100
    for j=1:1:200
     
        kk5{i,j} = kk4{i,j}.*Q;
        
    end
end
%%
%% Inverse DISCRETE COSINE TRANSFORM fot 2 method
I8 = cell(100 , 200);
for i=1:1:100
    for j=1:1:200
         I8{i,j}=D'*kk5{i,j}*D;
         I8{i,j}= uint8(I8{i,j});
    end
end


%for i=1:1:100
%    for j=1:1:200
%    I8{i,j} = idct2(I7{i,j});
%    I8{i,j}= uint8(I8{i,j});
%    end
%end
 figure;
 imshow(cell2mat(I8));

%% increas 128 from ever of cell and show image
I9 = cell(100 ,200);
for i=1:1:100
   for j=1:1:200
      I9{i,j}=double(I8{i,j}) + 128*(ones(8));
   end
end
I10 = cell2mat(I9);

% Conversion of Image Matrix to Intensity image and show
final=mat2gray(I10);

% an
figure
imshow(final);
title('this is the result after all of this');
E1=abs(final-im2double(I));
Et=abs(sum(sum(E1)))
Erms=1/(800*1600)*sqrt(sum(sum(E1.*E1)))
%% This are the function used in this part
function I1=inver_huffman_f(I2)
F=0;
i=1;
j=1;
I1=zeros(8,8);
flg1=0;
for n=1:64
switch 10*i+j
    case 11
        F=3;
        flg1=1;
    case 18
        F=1;
        flg1=0;
    case 81
        F=3;
        flg1=1;
    case {12,13,14,15,16,17}
        if flg1==0
            F=3;
            flg1=1;
        else
            F=1;
            flg1=0;
        end
    case {21,31,41,51,61,71}
        if flg1==0
            F=4;
            flg1=1;
        else 
            F=2;
            flg1=0;
        end
    case {82,83,84,85,86,87}
        if flg1==0
            F=3;
            flg1=1;
        else 
            F=2;
            flg1=0;
        end
    case {28,38,48,58,68,78}
        if flg1==0
            F=4;
            flg1=1;
        else 
            F=1;
            flg1=0;
        end       
end
[I1,m]=inv_Amins_fun(I2,i,j,I1,n,F);
j=rem(m,10);
i=(m-j)/10;
end
end
function I2=huffman_f(I1)
F=0;
i=1;
j=1;
I2=zeros(1,64);
flg1=0;
for n=1:64
switch 10*i+j
    case 11
        F=3;
        flg1=1;
    case 18
        F=1;
        flg1=0;
    case 81
        F=3;
        flg1=1;
    case {12,13,14,15,16,17}
        if flg1==0
            F=3;
            flg1=1;
        else
            F=1;
            flg1=0;
        end
    case {21,31,41,51,61,71}
        if flg1==0
            F=4;
            flg1=1;
        else 
            F=2;
            flg1=0;
        end
    case {82,83,84,85,86,87}
        if flg1==0
            F=3;
            flg1=1;
        else 
            F=2;
            flg1=0;
        end
    case {28,38,48,58,68,78}
        if flg1==0
            F=4;
            flg1=1;
        else 
            F=1;
            flg1=0;
        end       
end
[I2,m]=Amins_fun(I2,i,j,I1,n,F);
j=rem(m,10);
i=(m-j)/10;
end
end

function [I2,m]=Amins_fun(I2,i,j,I1,n,F)
switch F
    case 1
        I2(n)=I1(i,j);
        i=i+1;
        j=j-1;
    case 2
        I2(n)=I1(i,j);
        i=i-1;
        j=j+1;
    case 3
        I2(n)=I1(i,j);
        j=j+1;
    case 4
        I2(n)=I1(i,j);
        i=i+1;
end     
m=10*i+j;
end
function [I1,m]=inv_Amins_fun(I2,i,j,I1,n,F)
switch F
    case 1
        I1(i,j)=I2(n);
        i=i+1;
        j=j-1;
    case 2
        I1(i,j)=I2(n);
        i=i-1;
        j=j+1;
    case 3
        I1(i,j)=I2(n);
        j=j+1;
    case 4
        I1(i,j)=I2(n);
        i=i+1;
end     
m=10*i+j;
end



