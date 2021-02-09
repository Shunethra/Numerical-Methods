% Gaussian elimination
load N:\ECE_204\Lab2\A.txt;
M = load('A.txt');
rowsA = length(A);
load N:\ECE_204\Lab2\B.txt;
N = load('B.txt');
rowsB = length(B);

Y = [M N];              %to concatenate the matrix and vector B
X = rref(Y);            %to row reduce the matrix Y

%.3f is used to round off the values to 3 significant digits
for counter=1:rowsB
    fprintf("I%d = %.3f A\n", counter, X(counter,7));
end