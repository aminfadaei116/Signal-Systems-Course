function [ Yx ] = Filter( image , filterType , highpassORlowpass , parameters )
%Filter Summary of this function goes here
%   Detailed explanation goes here
%   First you must enter the image such as 'a.tif' or 'b.jpg'
%   Then you must choose the filter type by typing the : 'ideal' or
%   'gaussian' or 'butterworth'
%   Then you must choose between high or low pass by typing the
%   'highpass' or 'lowpass'
%   At the end, you must determine the parameters of your selected filter,
%   for this section, you should enter your parameters in matrix such as [f0 n]

%   So, the function return an image that filtered by your desired filter.  


P = imread(image) ;       

%P = rgb2gray(P) ;                 % if is needed
P = im2double(P) ;

Pf = fft2(P) ;                     % calculate the fast Fourier of image
Pfc = fftshift(Pf) ;               % to implement effect of (-1)^(x+y) on inputs...

S = abs(Pfc) ;                     % magnitude of image's fft
S_log = log(1 + S) ;               % log_magnittude


switch filterType                  % this code decide according to filter`s name.. 
    
    
    case 'ideal'
        
        switch highpassORlowpass
            
            case 'highpass'
                
                H = ones(size(S,1),size(S,2)) ;
                radius = parameters(1) ;             % radius is cutoff frequency (f0)
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the highpass filter (circle)
                for i=1:size(H,1)                    % by this code, we can calculate circle & set in side 0 and set out side 1 .
                    for j=1:size(H,2)
                        dist=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        if dist<=radius
                            H(j,i)=0;
                        end
                    end
                end
                
                                
            case 'lowpass'
           
                H = zeros(size(S,1),size(S,2)) ;
                radius = parameters(1) ;           % radius is cutoff frequency (f0)
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the lowpass filter (circle)
                for i=1:size(H,1)                  % by this code, we can calculate circle & set in side 1 and set out side 0 .
                    for j=1:size(H,2)
                        dist=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        if dist<=radius
                            H(j,i)=1;
                        end
                    end
                end
           
                
            otherwise
                warning('Unexpected filter type. try again and just type highpass or lowpass. ')   % if the entered name is not valid.
        end
        
        
        
    case 'gaussian'
        
        switch highpassORlowpass
            
            case 'highpass'
                           
                H = zeros(size(S,1),size(S,2)) ;
                sigma = parameters(1) ;            % sigma is cutoff frequency (f0)
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the lowpass filter
                for i=1:size(H,1)                  % by this code, we can calculate the related book equation for gaussian.
                    for j=1:size(H,2)
                        D=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        H(j,i)= 1- exp(  -(D^2) / (2*sigma^2)  );
                    end
                end
    
                
            case 'lowpass'
                H = zeros(size(S,1),size(S,2)) ;
                sigma = parameters(1) ;            % sigma is cutoff frequency (f0)
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the lowpass filter
                for i=1:size(H,1)                  % by this code, we can calculate the related book equation for gaussian.
                    for j=1:size(H,2)
                        D=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        H(j,i)= exp(  -(D^2) / (2*sigma^2)  );
                    end
                end
                
                
            otherwise
                warning('Unexpected filter type. try again and just type highpass or lowpass. ')   % if the entered name is not valid.
        end
        
        
        
    case 'butterworth'
        
        switch highpassORlowpass
            
            case 'highpass'
                H = zeros(size(S,1),size(S,2)) ;
                D0 = parameters(1) ;               % D0 is cutoff frequency (f0)
                n = parameters(2) ;                % n is the order of filter
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the lowpass filter
                for i=1:size(H,1)                  % by this code, we can calculate the related book equation for butterworth.
                    for j=1:size(H,2)
                        D=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        H(j,i)= 1 / ( 1+ (D0/D)^(2*n) ) ;
                    end
                end        
                
                
            case 'lowpass'
                H = zeros(size(S,1),size(S,2)) ;
                D0 = parameters(1) ;               % D0 is cutoff frequency (f0)
                n = parameters(2) ;                % n is the order of filter
                a = round(size(H,1)/2) ;  b = round(size(H,2)/2) ;    % calculate the center of H(u,v) for locating the lowpass filter
                for i=1:size(H,1)                  % by this code, we can calculate the related book equation for butterworth.
                    for j=1:size(H,2)
                        D=sqrt( (i-a)^2 + (j-b)^2 ) ;
                        H(j,i)= 1 / ( 1+ (D/D0)^(2*n) ) ;
                    end
                end               
                
                        
            otherwise
                warning('Unexpected filter type. try again and just type highpass or lowpass. ')   % if the entered name is not valid.
        end
        
        
        
    otherwise
        warning('Unexpected filter. No filter implemented.')   % if the entered name is not valid.
end


% Now, we multiple the H(u,v) with S(u,v)   

Y = Pfc.*H ;                      % filtering

Y1 = ifftshift(Y) ;               % to neutralize the effect of (-1)^(x+y)
Yx = ifft2(Y1) ;                  % restore the image by inverse fast Fourier

% now, Yx (output) is the filtered image.
end
