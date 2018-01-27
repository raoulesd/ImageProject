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


% display(numel(s));

count = 1;
for label = 1:numel(s)
       

    index = label;


    Sdata=regionprops(labeled == index,'BoundingBox');
    Img=imcrop(labeled,Sdata(1).BoundingBox);

    boolean = size(Img,2) < 15 || size(Img,2) > 70;
    Img = im2bw(imresize(Img,[30 25]));



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

            croppedImage = imresize(croppedImage,[30 25]);

            totals(i) = mean(max(corr2(Img, croppedImage)));
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
    else
%         result(1,label) = '-'
    end

end



if(exist('result','var'))
    finalPlate = result;
else
    finalPlate = '';

end


