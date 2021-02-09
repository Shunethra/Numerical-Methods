% load N:\ECE_204\Lab4\test1.txt;
% M = load('test1.txt');
% rows1 = length(test1);
load N:\ECE_204\Lab4\test2.txt;
M = load('test2.txt');
rows1 = length(test2);

x = M(:,1);
y = M(:,2);
format long;

% Linear regression
X1 = [ones(length(x),1) x];
b1 = X1\y;
yCalc = X1*b1;
l_a0 = b1(1,1);
l_a1 = b1(2,1);
Linear_Rsq = 1 - sum((y - yCalc).^2)/sum((y - mean(y)).^2);

% Polynomial
tol = 0.01;
normVal = Inf;
degree = 1;
old_Polynomial_Rsq = 0;
Polynomial_Rsq = 0;

while normVal>tol
    old_Polynomial_Rsq = Polynomial_Rsq;
    degree = degree + 1;
    A2 = zeros(degree+1, degree+1);
    Sol = zeros(degree+1, 1);
    for i=1:degree+1
        for j=1:degree+1
                A2(i, j) = sum(x.^(i+j-2));      
        end
        Sol(i, 1) = sum((x.^(i-1)).*y);
    end

    coeff = A2\Sol;   
    i = [0:degree];
    xpoly = x.^i;
    p_y2 = xpoly*coeff;
    St2 = sum((y - mean(y)).^2);
    Sr2 = sum((y-p_y2).^2);
    Polynomial_Rsq = 1-(Sr2/St2);
    
    normVal=Polynomial_Rsq-old_Polynomial_Rsq;  
    %find the relative error between old and updated current values
end

degree = degree - 1;
A2 = zeros(degree+1, degree+1);
Sol = zeros(degree+1, 1);
for i=1:degree+1
        for j=1:degree+1
                A2(i, j) = sum(x.^(i+j-2));      
        end
        Sol(i, 1) = sum((x.^(i-1)).*y);
end

coeff = A2\Sol;   
i = [0:degree];
xpoly = x.^i;
p_y2 = xpoly*coeff;
St2 = sum((y - mean(y)).^2);
Sr2 = sum((y-p_y2).^2);
Polynomial_Rsq = 1-(Sr2/St2);

%Exponential Regression
Y3 = log(y);
X3 = [ones(length(x),1) x];
b3 = X3\Y3;
e_a0 = b3(1,1);
e_A = exp(e_a0);
e_a1 = b3(2,1);
e_y2 = e_A*exp(e_a1*x);
St3 = sum((y - mean(y)).^2);
Sr3 = sum((y-e_y2).^2);
Exp_Rsq = 1-(Sr3/St3);

%Power Regression
x = M(:,1);
num = find(~x);
x(num, :) = [];
y = M(:,2);
y(num, :) = [];
format long;
Y4 = log10(y);
X4 = log10(x);
new_X = [ones(length(X4),1) X4];
b4 = new_X\Y4;
pow_a0 = b4(1,1);
pow_A = 10^pow_a0;
pow_a1 = b4(2,1);
pow_A1 = pow_a1;
pow_y2 = pow_A*(x.^pow_A1);
St4 = sum((y - mean(y)).^2);
Sr4 = sum((y-pow_y2).^2);
Power_Rsq = 1-(Sr4/St4);

x = M(:,1);
y = M(:,2);
format long;

Max_matrix = [Linear_Rsq Polynomial_Rsq Exp_Rsq Power_Rsq];
max_Rsq = max(Max_matrix);
if max_Rsq==Linear_Rsq
    disp("The most efficient method is Linear Regression");
    scatter(x,y);
    hold on;
    plot(x,yCalc)
    xlabel('x');
    ylabel('y');
    title('Linear Regression Relation');
    grid on;
    string = sprintf('y = %f + %fx, R^2 = %f', l_a0, l_a1, Linear_Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
elseif max_Rsq==Polynomial_Rsq
    disp("The most efficient method is Polynomial Regression");
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Polynomial Regression Relation');
    plot(x(:, 1),p_y2(:,1));
    string = sprintf('Order = %d, R^2 = %f', degree, Polynomial_Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
    fprintf("The coefficients are:\n");
    for counter=1:degree+1
    fprintf("a%d = %f \n", counter-1, coeff(counter));
    end
elseif max_Rsq==Exp_Rsq
    disp("The most efficient method is Exponential Regression");
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Exponential Regression Relation');
    plot(x(:, 1),e_y2(:,1));
    string = sprintf('y = %fe^{%fx}, R^2 = %f', e_A, e_a1, Exp_Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
elseif max_Rsq==Power_Rsq
    disp("The most efficient method is Power Regression");
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Power Regression Relation');
    plot(x(:, 1),y2(:,1));
    string = sprintf('y = %fx^{%f}, R^2 = %f', pow_A, pow_A1, Power_Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
end