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
if(size(angle,1) == 0)
    angle = 0;
end
rotatedBinary = imrotate(plate, 1 - angle);
measurements2 = regionprops(rotatedBinary, 'BoundingBox');

% Rotate the original image the same amount and crop according to the
% boundingbox
if(size(angle,1) == 0)
    angle = 0;
end
rotatedOriginal = imrotate(frame, 1 - angle);
if(size(measurements2,1) == 0)
    finalPlate = [];
else
    croppedPlate = imcrop(rotatedOriginal, measurements2.BoundingBox);
    I = rgb2gray(croppedPlate);
    BW = imbinarize(I);

    Icorrected = imtophat(I, strel('disk', 50));

    BW1 = imbinarize(Icorrected);
    complement = imcomplement(BW1);
    groupSize = round((11/18) * size(complement, 2));

    binary = bwareaopen(complement, groupSize, 8);

    L2 = bwlabel(binary);
    s = regionprops(L2, 'BoundingBox');

    X1 = -1;
    Y1 = -1;
    X2 = -1;
    Y2 = -1;

    for i=1:numel(s)
        Sdata=regionprops(L2 == i,'BoundingBox');
        if abs(Sdata.BoundingBox(3)) < (1/2) * size(binary, 2)
           if X1 == -1
               X1 = Sdata.BoundingBox(1);
               Y1 = Sdata.BoundingBox(2);
           end
           if Sdata.BoundingBox(1) > X2
               X2 = Sdata.BoundingBox(1) + Sdata.BoundingBox(3);
               Y2 = Sdata.BoundingBox(2);
           end
        end
    end
    if ((X1== -1) || (X2 == -1) || (Y1 == -1) || (Y2 == -1))
        finalPlate = binary;
    else
        angleDeg = radtodeg(tan(abs(Y2 - Y1)/abs(X2 - X1)));
        if isLarger(Y1, Y2)
            finalPlate = imrotate(binary, -angleDeg);
        else
            finalPlate = imrotate(binary, angleDeg);
        end
    end
end
    


