clear all;
run('C:\Program Files\DIPimage 2.9\dipstart.m');
video = VideoReader('vid.avi');
%frame = imread('firstframe.png');
frame = read(video, 345);
figure, imshow(frame);

% Removing objects that are not within a certain color range which represents a
% licenseplate
HSV = rgb2hsv(frame);

R = frame(:,:,1);
G = frame(:,:,2);
B = frame(:,:,3);

H = HSV(:,:,1);
S = HSV(:,:,2);

y = (R > 60 & ...
    R < 240 & ...
    G > 80 & ...
    G < 160 & ...
    B > 10 & ... 
    B < 100 & ...
    B < 14/18 *G & ...
    G > 2/3 * R & ...
    G < 19/20 * R);  
% Removing small holes
closed = bclosing(y, 14, 2, 0);

% Removing small groups of pixels
opened = bopening(closed, 4, 2, 0);

% Convert the dip_image back to a MATLAB array
dip = dip_array(opened);

binarized = dip == 1;

plate = bwareafilt(binarized,1);
% figure, imshow(plate);
% title('filtered');

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
    I_adapthisteq = adapthisteq(I);
    sharpened = imsharpen(I_adapthisteq);
    
%     figure, imshow(I_histeq);
%     title('histeq');

    %Icorrected = imtophat(I_adapthisteq, strel('disk', 50));

%     BW1 = imbinarize(I_adapthisteq);
    BW1 = I_adapthisteq > 90;
%     figure, imshow(BW1);
%     title('Own threshold');
    complement = imcomplement(BW1);
    groupSize = round((1/3) * size(complement, 2));

    binary = bwareaopen(complement, groupSize, 8);

    L2 = bwlabel(binary);
    s = regionprops(L2, 'BoundingBox');

    X1 = -1;
    Y1 = -1;
    X2 = -1;
    Y2 = -1;

    for i=1:numel(s)
        Sdata=regionprops(L2 == i,'BoundingBox');
        size(binary,1)
        size(binary,2)
        if abs(Sdata.BoundingBox(3)) < (1/6) * size(binary, 2)
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

figure, imshow(finalPlate);
title('Final');




