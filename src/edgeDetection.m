frame = 40;

img = read(video,frame);


if(frame == 1)
    %Properties for frame 1:
    box = [225,313,204,49];
    angle = 0;
    width = 5;
end

if(frame == 40)
    %Properties for frame 40:
    box = [269,360,151,38]; 
    angle = 16;
    width = 150;
end

img = imrotate(img,angle);

figure
image(img);

roi = imcrop(img,box);
grayImage = rgb2gray(roi);
%Using kernel
if(false)
    kernel = -1 * ones(width);
    kernel(ceil(width/2), ceil(width/2)) = -sum(kernel(:)) - 1 + width^2 
    kernel = kernel / sum(kernel(:)) % Normalize.
    out = imfilter(grayImage, kernel);
end

grayImage2 = adapthisteq(grayImage);
bw = im2bw(grayImage2, graythresh(grayImage2));

bw2 = imfill(bw,'holes');
bw3 = imopen(bw2, ones(5,5));
bw4 = bwareaopen(bw3, 40);
bw4_perim = bwperim(bw4);
overlay1 = imoverlay(grayImage2, bw4_perim, [.3 1 .3]);
imshow(overlay1)
 
% figure;
% imshow(out, []);


ocrRes = ocr(out, 'TextLayout' ,'Word');
ocrRes.Text