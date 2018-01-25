clear all;
clear;
run('C:\Program Files\DIPimage 2.9\dipstart.m')
screen = imread('screen.png');
license1 = imread('licenseplate.png');
license2 = imread('licenseplate2.png');
license3 = imread('licenseplate3.png');
license4 = imread('licenseplate4.png');
license5 = imread('licenseplate5.png');
license6 = imread('licenseplate6.png');
background = imread('car6.png');
lamp4 = imread('lamp4.png');
front = imread('front.png');
% background = imread('background5.png');


lamp = imread('lamp.png');
lamp2 = imread('lamp2.png');
house = imread('house.png');
original = imread('firstframe.png');
frame = original;

length(screen(:,:,2))

street1 = squeeze(screen(:,:,1));
street2 = squeeze(screen(:,:,2));
street3 = squeeze(screen(:,:,3));

license1_1 = squeeze(license1(:,:,1));
license1_2 = squeeze(license1(:,:,2));
license1_3 = squeeze(license1(:,:,3));

license2_1 = squeeze(license2(:,:,1));
license2_2 = squeeze(license2(:,:,2));
license2_3 = squeeze(license2(:,:,3));

license3_1 = squeeze(license3(:,:,1));
license3_2 = squeeze(license3(:,:,2));
license3_3 = squeeze(license3(:,:,3));

license4_1 = squeeze(license6(:,:,1));
license4_2 = squeeze(license6(:,:,2));
license4_3 = squeeze(license6(:,:,3));


lamp1 = squeeze(lamp4(:,:,1));
lamp2 = squeeze(lamp4(:,:,2));
lamp3 = squeeze(lamp4(:,:,3));

background1 = squeeze(background(:,:,1));
background2 = squeeze(background(:,:,2));
background3 = squeeze(background(:,:,3));

plot(license4_3);


% plot(squeeze(background(:,:,2)));

% house1 = squeeze(house(:,:,1));
% house2 = squeeze(house(:,:,2));
% house3 = squeeze(house(:,:,3));
% hold on;
% scatter(background1(:), background2(:), 'b');
% scatter(lamp1(:), lamp2(:), 'm');
% scatter(license1_1(:), license1_2(:), 'y');
% scatter(license2_1(:), license2_2(:), 'm');
% scatter(license3_2(:), license3_3(:), 'c');
% scatter(license4_2(:), license4_3(:), 'g');
% 
% %scatter(street2(:), street3(:), 'g');
% x = 0:300;
% line = (9/10) * x;
% plot(line);
% line2 = (1/3) * x;
% plot(line2);
% legend('1', '2','3', '4');
% hold off;
% THRESHOLD: BLUE = 2/3 GREEN
