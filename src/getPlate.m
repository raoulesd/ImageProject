function finalPlate = getPlate(frame)
%clear all;
%run('C:\Program Files\DIPimage 2.9\dipstart.m');
%video = VideoReader('TrainingVideo.avi');
%frame = imread('firstframe.png');
%frame = read(video, 40);

% Removing objects that are not within a certain color range which represents a
% licenseplate
red = frame(:,:,1);
green = frame(:,:,2);
blue = frame(:,:,3);

y = (red > 60 & red < 240 & green > 80 & green < 160 & blue > 30 & blue < 100 & blue < 14/18 *green);

% Removing small holes
closed = bclosing(y, 11, 2, 0);

% Removing small groups of pixels
opened = bopening(closed, 8, 2, 0);

% Convert the dip_image back to a MATLAB array
plate = dip_array(opened);

% Retrieving measurements from the image with just the plate
measurements = regionprops(plate, 'Orientation', 'BoundingBox');

% Crop the original image by the bounding box of the licenseplate
croppedImage = imcrop(frame, measurements.BoundingBox);

% Use the orientation measurement to rotate the cropped image
angle = cat(1, measurements.Orientation);
finalPlate = imrotate(croppedImage, 1 - angle);
%image(rotated);
%title('ROTATED');

end


