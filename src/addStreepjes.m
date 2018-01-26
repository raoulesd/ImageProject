function res = addStreepjes(index, result)
    if(index == 1)
        result(1,8) = result(1,6);
        result(1,7) = '-';
        result(1,6) = result(1,5);
        result(1,5) = result(1,4);
        result(1,4) = '-';  
    elseif(index == 2 || index == 3)
        result(1,8) = result(1,6);
        result(1,7) = result(1,5);
        result(1,6) = '-';  
        result(1,5) = result(1,4);
        result(1,4) = result(1,3);
        result(1,3) = '-';
    elseif(index == 4)
        result(1,7) = result(1,6);
        result(1,6) = '-';
        result(1,5) = result(1,4);
        result(1,4) = result(1,3);
        result(1,3) = result(1,2);
        result(1,2) = '-';
    elseif(index == 5)
        result(1,8) = result(1,6);
        result(1,7) = '-';
        result(1,6) = result(1,5);
        result(1,5) = result(1,4);
        result(1,4) = result(1,3);
        result(1,3) = '-';
    elseif(index == 6)
        result(1,8) = result(1,6);
        result(1,7) = result(1,5);
        result(1,6) = '-';
        result(1,5) = result(1,4);
        result(1,4) = result(1,3);
        result(1,3) = '-';
    end
    res = result;
end
