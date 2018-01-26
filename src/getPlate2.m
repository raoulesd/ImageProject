function finalPlate = getPlate2(frame) %input is a license plate as binary image 
if(~exist('alpabet','var'))
    run('alphabet.m')
end

aIndex = size(alpabet,2);

labeled = bwlabel(frame);
s = regionprops(labeled, 'extrema');

image(frame)
% display(numel(s));
count = 1;
for label = 1:numel(s)
    

    index = label;


    Sdata=regionprops(labeled == index,'BoundingBox');
    Img=imcrop(labeled,Sdata(1).BoundingBox);

%     figure;
%     image(Img);
%     title(label);
    
    boolean = size(Img,2) < 15 || size(Img,2) > 70;
    Img = im2bw(imresize(Img,[120 100]));
    
    

    totals = zeros(1,aIndex);
    
    for i=1:aIndex
        if(~boolean)
            letter = ~cell2mat(alpabet(1,i));
            [rows, columns] = find(letter);
            row1 = min(rows);
            row2 = max(rows);
            col1 = min(columns);
            col2 = max(columns);
            croppedImage = letter(row1:row2, col1:col2);

            croppedImage = imresize(croppedImage,[120 100]);
            
            totals(i) = mean(max(normxcorr2(Img, croppedImage)));
        end
    end
    if(~boolean)
        [L,I] = max(totals);
        result(1,count) = alphabetIndex(I);
        count = count + 1;
    else
%         result(1,label) = '-'
    end
    
end

if(exist('result','var'))
    finalPlate = result;
else
    finalPlate = '';

end


