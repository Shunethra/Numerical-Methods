% load N:\ECE_204\Lab4\test1.txt;
% M = load('test1.txt');
% rows1 = length(test1);
load N:\ECE_204\Lab4\test2.txt;
M = load('test2.txt');
rows1 = length(test2);

prompt = "Select the function to fit your data: \n1. Linear: y = a0 + a1x\n2. Polynomial: y = a0 + a1x + ... + amx^m\n3. Exponential: y = ae^(bx)\n4. Power: y = ax^b\n";
function_number = input(prompt);         % to accept choice

if function_number==1                    % linear regression
    x = M(:,1);
    y = M(:,2);
    format long;
    X = [ones(length(x),1) x];
    b = X\y;
    yCalc = X*b;
    scatter(x,y);                        % to plot (x,y) points
    hold on;
    plot(x,yCalc)                        % to plot curve
    xlabel('x');
    ylabel('y');
    title('Linear Regression Relation');
    grid on;
    a0 = b(1,1);
    a1 = b(2,1);
    Rsq = 1 - sum((y - yCalc).^2)/sum((y - mean(y)).^2);
    %Coefficient of determinant
    string = sprintf('y = %f + %fx, R^2 = %f', a0, a1, Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
end

if function_number==2                    % polynomial regression
    prompt2 = "Determine the degree of the polynomial: ";
    degree = input(prompt2);             % to accept degree
    A = zeros(degree+1, degree+1);
    Sol = zeros(degree+1, 1);
    x = M(:,1);
    y = M(:,2);
    format long;
    for i=1:degree+1
        for j=1:degree+1
                A(i, j) = sum(x.^(i+j-2));      
        end
        Sol(i, 1) = sum((x.^(i-1)).*y);
    end
    coeff = A\Sol;   
    i = [0:degree];
    xpoly = x.^i;
    y2 = xpoly*coeff;
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Polynomial Regression Relation');
    plot(x(:, 1),y2(:,1));
    St = sum((y - mean(y)).^2);
    Sr = sum((y-y2).^2);
    Rsq = 1-(Sr/St);
    string = sprintf('Order = %d, R^2 = %f', degree, Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
    fprintf("The coefficients are:\n");
    for counter=1:degree+1
    fprintf("a%d = %f \n", counter-1, coeff(counter));
    end
end

if function_number==3                        % exponential regression
    x = M(:,1);
    y = M(:,2);
    format long;
    Y = log(y);
    X = [ones(length(x),1) x];
    b = X\Y;
    YCalc = X*b;
    a0 = b(1,1);
    A = exp(a0);
    a1 = b(2,1);
    y2 = A*exp(a1*x);
    
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Exponential Regression Relation');
    plot(x(:, 1),y2(:,1));
    St = sum((y - mean(y)).^2);
    Sr = sum((y-y2).^2);
    Rsq = 1-(Sr/St);
    string = sprintf('y = %fe^{%fx}, R^2 = %f', A, a1, Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
end

if function_number==4                        % power regression
    x = M(:,1);
    num = find(~x);
    x(num, :) = [];
    y = M(:,2);
    y(num, :) = [];
    format long;
    Y = log10(y);
    X = log10(x);
    new_X = [ones(length(X),1) X];
    b = new_X\Y;
    YCalc = new_X*b;
    a0 = b(1,1);
    A = 10^a0;
    a1 = b(2,1);
    A1 = a1;
    y2 = A*(x.^A1);
    
    scatter(x,y);
    hold on;
    xlabel('x');
    ylabel('y');
    title('Power Regression Relation');
    plot(x(:, 1),y2(:,1));
    St = sum((y - mean(y)).^2);
    Sr = sum((y-y2).^2);
    Rsq = 1-(Sr/St);
    string = sprintf('y = %fx^{%f}, R^2 = %f', A, A1, Rsq);
    string2 = sprintf('Actual data');
    legend(string2, string);
    grid on;
end