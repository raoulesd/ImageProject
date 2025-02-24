function finalPlate = getPlate2(frame, alpabet) %input is a license plate as binary image 

aIndex = size(alpabet,2);

labeled = bwlabel(frame);

s = regionprops(labeled, 'extrema');
if(numel(s) < 6)
    labeled = bwlabel(~frame);
    s = regionprops(labeled, 'extrema');
end

permutation = [];
permutations= {[1 1 1 0 0 1]
               [0 0 1 1 0 1]
               [1 1 1 1 0 0]
               [0 1 1 1 0 0]
               [0 0 1 1 1 0]
               [0 0 1 1 1 1]};



count = 1;
for label = 1:numel(s)


    index = label;


    Sdata=regionprops(labeled == index,'BoundingBox');
    Img=imcrop(labeled,Sdata(1).BoundingBox);

    boolean = size(Img,1) / size(frame,1) < 0.35 || size(Img,1) / size(frame,1)  > 0.80 ;
    Img = im2bw(imresize(Img,[15 12.5]));

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

            croppedImage = imresize(croppedImage,[15 12.5]);

            totals(i) = corr2(Img, croppedImage);
        end
    end
    if(~boolean)
        [L,I] = max(totals);
        permutation(count) = I < 21;
        result(1,count) = alphabetIndex(I);

        if(count == 6)
            for j=1:count
                onePerm = cell2mat(permutations(j));
                if(isequal(permutation,onePerm) || isequal(permutation, ~onePerm))
                    result = addStreepjes(j,result);
                    count = count + 2;
                end
            end
        end

        count = count + 1;
    end
end



if(exist('result','var') && length(strfind(result,'-')) == 2)
    finalPlate = result;
else
    finalPlate = '';
end


