clear all;
street = imread('street.png');
license = imread('licenseplate.png');
lamp = imread('lamp.png');
house = imread('house.png');
original = imread('firstframe.png');
frame = original;

length(street(:,:,2))

street1 = squeeze(street(:,:,1));
street2 = squeeze(street(:,:,2));
street3 = squeeze(street(:,:,3));

license1 = squeeze(license(:,:,1));
license2 = squeeze(license(:,:,2));
license3 = squeeze(license(:,:,3));

lamp1 = squeeze(lamp(:,:,1));
lamp2 = squeeze(lamp(:,:,2));
lamp3 = squeeze(lamp(:,:,3));

house1 = squeeze(house(:,:,1));
house2 = squeeze(house(:,:,2));
house3 = squeeze(house(:,:,3));

%hold on;
%scatter(house2(:), house3(:), 'b');
%scatter(lamp2(:), lamp3(:), 'm');
%scatter(license2(:), license3(:), 'c');
%scatter(street2(:), street3(:), 'g');
%x = 0:300;
%line = (2/3) * x;
%plot(line);
%line2 = (1/6) * x;
%plot(line2);
%legend('street', 'house', 'lamp', 'license');
%hold off;
% THRESHOLD: BLUE = 2/3 GREEN

frame2 = frame(0 | frame(:,:,3) < (2/3) * frame(:,:,2));

frame(frame(:,:,3) > (2/3) * frame(:,:,2)) = 0;


% for i = 1:size(frame,1)
%     for j = 1:size(frame,2)
%         b = frame(i,j,3);
%         g = frame(i,j,2);
%         if b >= (2/3) * g
%             frame(i,j,:) = 0;
%         end
%     end
% end

%BW = im2bw(frame,0.1);
%bwframe = bwareaopen(frame, 30);
figure;
image(frame);
