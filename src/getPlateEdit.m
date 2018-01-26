clear all;
run('C:\Program Files\DIPimage 2.9\dipstart.m');
video = VideoReader('TrainingVideo.avi');
%frame = imread('firstframe.png');
frame = read(video, 200);

% Removing objects that are not within a certain color range which represents a
% licenseplate
red = frame(:,:,1);
green = frame(:,:,2);
blue = frame(:,:,3);

y = (red > 60 & red < 240 & green > 80 & green < 160 & blue > 30 & blue < 100 & blue < 14/18 *green & green > 2/3 * red & green < 9/10 * red);

% Removing small holes
closed = bclosing(y, 11, 2, 0);

% Removing small groups of pixels
opened = bopening(closed, 8, 2, 0);

% Convert the dip_image back to a MATLAB array
plate = dip_array(opened);

% Retrieving measurements from the image with just the plate
measurements = regionprops(plate, 'Orientation');

% Use the orientation measurement to rotate the binary image to get a
% boundingbox
angle = cat(1, measurements.Orientation);
rotatedBinary = imrotate(plate, 1 - angle);
measurements2 = regionprops(rotatedBinary, 'BoundingBox');

% Rotate the original image the same amount and crop according to the
% boundingbox
rotatedOriginal = imrotate(frame, 1 - angle);
croppedPlate = imcrop(rotatedOriginal, measurements2.BoundingBox);
figure;
image(croppedPlate);

red2 = croppedPlate(:,:,1);
green2 = croppedPlate(:,:,2);
blue2 = croppedPlate(:,:,3);

thresh = (red2 + green2 + blue2) / 3;

HSV = rgb2hsv(croppedPlate);
value = HSV(:,:,3);
meanValue = mean(value);
locations = (value < meanValue & thresh < 92);

%marker = imerode(locations, strel('line',10,0));
%Iclean = imreconstruct(marker, locations);

figure;
image(locations);
colormap(gray(2));
title('cleaned');




% greyscale = rgb2gray(finalPlate);
% Icorrected = imtophat(greyscale, strel('square', 30));
% BW1 = imbinarize(Icorrected);
% figure;
% image(BW1);
% colormap(gray(2));



% 
% binary = (greyscale < 100);
% figure;
% image(binary);
% colormap(gray(2));
% title('Greyscale');
% 
% bw2 = bwareaopen(binary,50);
% 
% figure;
% image(bw2);
% colormap(gray(2));





