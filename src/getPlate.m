function finalPlate = getPlate(frame)

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
finalPlate = imcrop(rotatedOriginal, measurements2.BoundingBox);

end


