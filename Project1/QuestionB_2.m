% Gaussian elimination with 5% increase in resistance values
load N:\ECE_204\Lab2\A.txt;
M = load('A.txt');
rowsA = length(A);
load N:\ECE_204\Lab2\B.txt;
N = load('B.txt');
rowsB = length(B);

M2 = 1.05*M;
Y = [M2 N];
X = rref(Y);
for counter=1:rowsB
    fprintf("I%d = %.3f A\n", counter, X(counter,7));
end