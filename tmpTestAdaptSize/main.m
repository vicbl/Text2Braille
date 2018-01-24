%%
clear all; close all; clc
% On a joué sur le size de l'image d'input (x20) 
% et pour que l image de sortie ne soit pas grande, on l'a fait un resize (x1/20) 
imgATester =  double((imread('../img/alpha.PNG')))/255;

% Region d'interet
imgATesterBW = ~im2bw(imgATester);

[fl re]=lines(imgATesterBW);
subplot(3,1,1);imshow(imgATester);title('INPUT IMAGE')
subplot(3,1,2);imshow(fl);title('FIRST LINE')
subplot(3,1,3);imshow(re);title('REMAIN LINES')
% %
% imgBraille = text2brailleAdaptSize(imgATester);
% 
% figure;
% subplot(1,2,1);imshow(imgATester,[]);title('Image de départ');
% subplot(1,2,2);imshow(imgBraille,[]);title('Image finale');
%%
% th = linspace(0,2*pi);
% c = [0 0] ;  % center of circle 
% r = 0.5 ;  % radius of circle 
% 
% x = c(1)+r*cos(th) ;
% y = c(2)+r*sin(th) ;
% figure;
% imshow(imgATester,[]);title('Image de départ');
% patch(x,y,'k')
