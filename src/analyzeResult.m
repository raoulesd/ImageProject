function [result matrix] = analyzeResult(toCheck, resultMatrix)

if(size(toCheck,2) == 8)
    resultMatrix(size(resultMatrix,1) + 1,1) = toCheck;
end
if(size(resultMatrix,1) ~= 0)
    [M,F] = mode(resultMatrix(:));
    result = M;
    matrix = resultMatrix;
else
    result = toCheck;
    matrix = resultMatrix;
end
end