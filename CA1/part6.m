clc;clear
close all
%% part 1 this will get some info avout the sound we have
[S_old,Fs]=audioread('anykey.wav');
%% part 2 this will play the sound
sound(S_old,Fs);
%% part 3 
% we are going to make a sound with some echo we need two parameters
S_new=S_old;
a=input('Enter the emount of a: ');
N=input('Enter the emount of N we want: ');
for i=N+1:length(S_old)
	S_new(i)= S_old(i)+(a)*S_old(i-N);
end
% we play the echo as well
  sound(S_new,Fs);
  fprintf("Please wait this may take a time...\n");
%% part 4
% this part we are going to use the conv that we bulid by owerself
% the resulte must be a figure that the maximum where the two digrams are
% on each other
	C=hand_cross(S_new,S_new);
	figure
	plot(-length(S_new)+1:length(S_new)-1,C)
	grid on
	title('cross corelation new and new');
	ylabel('magnetude');
%% part 5
%this part is a hard part we should finf out what is the lag of the eco on
%the sound that we have
t=(1:length(S_new))/Fs;
 U=xcorr(S_new,S_old);% we use the xcorr for this part
 figure
	plot(-length(S_new)+1:length(S_new)-1,U)
	grid on
	title('cross corelation of new and old');
	ylabel('magnetude');
 figure
 subplot(3,1,1)
 plot(t,S_new);
 xlim([1 size(S_new,1)/Fs]);
 grid on
 xlabel('time')
 title('sound with echo')
 subplot(3,1,2)
 plot(t,S_old)
 xlim([1 size(S_old,1)/Fs]);
 xlabel('time')
 grid on
 title('original sound');
 % we use some new things to find out what is the lag on the echo that we
 % have
 [Rmm,lag]=xcorr(S_new,'unbiased');
 Rmm=Rmm(lag>0);
 lag=lag(lag>0);
 subplot(3,1,3);
 plot(Rmm);
 grid on
 title('lag');
 Rmm(1:50)=0;
 [~,n0]=max(abs(Rmm));
 txt='The n0 that we where looking for in %f \n';
 fprintf(txt,n0);

%% Function  this function is the flip from normal convoltion
function [C]=hand_cross(a,b)
if iscolumn(a)==1
    a=a.';
    b=b.';
end
a_size=length(a);
b_size=length(b);
A=[zeros(1,b_size),a,zeros(1,b_size)];
B=[zeros(1,a_size),b,zeros(1,a_size)];
C=zeros(1,a_size+b_size-1);
for i=1:a_size+b_size-1
	sum=0;	
	for j=1:b_size
		sum=sum+B(a_size+j)*A(i+j);
end
C(i)=sum;
end

end