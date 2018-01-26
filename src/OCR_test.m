clear all;

video = VideoReader('TrainingVideo.avi');
%url = 'https://blogs.mathworks.com/images/steve/186/scanned_page.png';
%bw = imread(url);
bw = getPlate(read(video,1));

imshow(bw, 'InitialMagnification', 'fit')



L1 = bwlabel(bw);

I = im2uint8(bw);
I(~bw) = 200;
I(bw) = 240;
s = regionprops(L1, 'extrema');
imshow(I, 'InitialMagnification', 'fit')
hold on
for k = 1:numel(s)
   e = s(k).Extrema;
   text(e(1,1), e(1,2), sprintf('%d', k));
end
hold off