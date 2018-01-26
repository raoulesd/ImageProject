clear all;
run('alphabet.m')

video = VideoReader('TrainingVideo.avi');
%url = 'https://blogs.mathworks.com/images/steve/186/scanned_page.png';
%bw = imread(url);
bw2 = getPlate(read(video,1));

%imshow(bw2, 'InitialMagnification', 'fit')
%bw2 = rgb2gray(bw2)
%bw = edge(bw2,'canny')
bw2 = ~im2bw(bw2, 0.40);

bw = bwareaopen(bw2, 50);

image(bw);
result = getPlate2(bw)

 

 

