% LU Factorization 
load N:\ECE_204\Lab2\A.txt;
M = load('A.txt');
rowsA = length(A);
load N:\ECE_204\Lab2\B.txt;
N = load('B.txt');
rowsB = length(B);

[L,U] = lu(M);       %returns an upper triangular matrix U and a permuted lower triangular matrix L such that M = L*U
Z = L\N;             %solves Z to be equal to inverse L * vector B
X = U\Z;             %solves X to be equal to inverse U * matrix Z

%.3f is used to round off the values to 3 significant digits
for counter=1:rowsB
    fprintf("I%d = %.3f A\n", counter, X(counter));
end