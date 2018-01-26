matrix = zeros(1,29);

v = fileread('data.m');

matrix(1,1) = length(strfind(v,'B'));
matrix(1,2) = length(strfind(v,'C'));
matrix(1,3) = length(strfind(v,'D'));

matrix(1,4) = length(strfind(v,'F'));
matrix(1,5) = length(strfind(v,'G'));
matrix(1,6) = length(strfind(v,'H'));

matrix(1,7) = length(strfind(v,'J'));
matrix(1,8) = length(strfind(v,'K'));
matrix(1,9) = length(strfind(v,'L'));

matrix(1,10) = length(strfind(v,'N'));

matrix(1,11) = length(strfind(v,'P'));

matrix(1,12) = length(strfind(v,'R'));
matrix(1,13) = length(strfind(v,'S'));
matrix(1,14) = length(strfind(v,'T'));

matrix(1,15) = length(strfind(v,'V'));
matrix(1,16) = length(strfind(v,'W'));
matrix(1,17) = length(strfind(v,'X'));
matrix(1,18) = length(strfind(v,'Y'));
matrix(1,19) = length(strfind(v,'Z'));
matrix(1,20) = length(strfind(v,'0'));
matrix(1,21) = length(strfind(v,'1'));
matrix(1,22) = length(strfind(v,'2'));
matrix(1,23) = length(strfind(v,'3'));
matrix(1,24) = length(strfind(v,'4'));
matrix(1,25) = length(strfind(v,'5'));
matrix(1,26) = length(strfind(v,'6'));
matrix(1,27) = length(strfind(v,'7'));
matrix(1,28) = length(strfind(v,'8'));
matrix(1,29) = length(strfind(v,'9'));

plot(matrix);
