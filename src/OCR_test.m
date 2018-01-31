clear all;

alpabet = alphabet();


video = VideoReader('vid.avi');

img = read(video,701);

imageplate = getPlate(img);

firstResult = getPlate2(imageplate,alpabet)