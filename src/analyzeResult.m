function [result matrix] = analyzeResult(toCheck, resultMatrix)

if(size(resultMatrix,1) ~= 0)
    [M,F] = mode(resultMatrix(:));
    result = M;
    matrix = resultMatrix;
else
    result = toCheck;
    matrix = resultMatrix;
end
end