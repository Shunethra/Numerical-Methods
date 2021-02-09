% Simple Matrix Inversion
load N:\ECE_204\Lab2\A.txt;
M = load('A.txt');
rowsA = length(A);
load N:\ECE_204\Lab2\B.txt;
N = load('B.txt');
rowsB = length(B);

X = inv(M);         %to find the inverse of the matrix
sol = X*N;          %multiply the inverse matrix with vector B

%.3f is used to round off the values to 3 significant digits
for counter=1:rowsB
    fprintf("I%d = %.3f A\n", counter, sol(counter));
end