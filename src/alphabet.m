function alpabet = alphabet()
streep = im2bw(imread('letters_numbers/-.bmp'));
zero = im2bw(imread('letters_numbers/0.bmp'));
one = im2bw(imread('letters_numbers/1.bmp'));
two = im2bw(imread('letters_numbers/2.bmp'));
three = im2bw(imread('letters_numbers/3.bmp'));
four = im2bw(imread('letters_numbers/4.bmp'));
five = im2bw(imread('letters_numbers/5.bmp'));
six = im2bw(imread('letters_numbers/6.bmp'));
seven = im2bw(imread('letters_numbers/7.bmp'));
eight = im2bw(imread('letters_numbers/8.bmp'));
nine = im2bw(imread('letters_numbers/9.bmp'));
B = im2bw(imread('letters_numbers/B.bmp'));
C = im2bw(imread('letters_numbers/C.bmp'));
D = im2bw(imread('letters_numbers/D.bmp'));
F = im2bw(imread('letters_numbers/F.bmp'));
G = im2bw(imread('letters_numbers/G.bmp'));
H = im2bw(imread('letters_numbers/H.bmp'));
J = im2bw(imread('letters_numbers/J.bmp'));
K = im2bw(imread('letters_numbers/K.bmp'));
L = im2bw(imread('letters_numbers/L.bmp'));
M = im2bw(imread('letters_numbers/M.bmp'));
N = im2bw(imread('letters_numbers/N.bmp'));
P = im2bw(imread('letters_numbers/P.bmp'));
R = im2bw(imread('letters_numbers/R.bmp'));
S = im2bw(imread('letters_numbers/S.bmp'));
T = im2bw(imread('letters_numbers/T.bmp'));
V = im2bw(imread('letters_numbers/V.bmp'));
W = im2bw(imread('letters_numbers/W.bmp'));
X = im2bw(imread('letters_numbers/X.bmp'));
Y = im2bw(imread('letters_numbers/Y.bmp'));
Z = im2bw(imread('letters_numbers/Z.bmp'));

alpabet = {[B] [C] [D] [F] [G] [H] [J] [K] [L] [M] [N] [P] [R] [S] [T] [V] [W] [X] [Y] [Z] [one] [two] [three] [four] [five] [six] [seven] [eight] [nine] [zero]};

end
