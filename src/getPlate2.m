function finalPlate = getPlate2(frame) %input is a license plate as binary image 
run('alphabet.m')
labeled = bwlabel(frame);
s = regionprops(labeled, 'extrema');

for label = 1:numel(s)

    index = label;


    Sdata=regionprops(labeled == index,'BoundingBox');
    Img=imcrop(labeled,Sdata(1).BoundingBox);

    boolean = size(Img,1) < 15 || size(Img,1) > 50;
    Img = im2bw(imresize(Img,[120 100]));

    totals = zeros(1,30);

    for i=1:30
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
        result(1,label) = alphabetIndex(I);
    else
        if(label > 2)
            result(1,label) = '-';
        end
    end
end

finalPlate = result;

end


