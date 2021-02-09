% Gauss-Seidel iteration
load N:\ECE_204\Lab2\A.txt;
A = load('A.txt');
rowsA = length(A);
load N:\ECE_204\Lab2\B.txt;
b = load('B.txt');
rowsB = length(B);              

for s=1:4
    if s==1
        tol = 0.01;
    elseif s==2
       tol = 0.005;
    elseif s==3
        tol = 0.001;
    elseif s==4
        tol = 0.0001;
    end     
    
    x=[0 0 0 0 0 0]';       % set initial current values to zero
    n=size(x,1);  
    normVal=Inf;                  
    itr=0;          
    while normVal>tol
        x_old=x;

        for i=1:n
            result=0;
            limit = i-1;
            for j=1:limit
                    result=result + ( A(i,j)*x(j) );      
                    %substitutes the initial assumption and finds the result
            end

            limit2 = i+1;
            for j=limit2:n
                    result=result+ ( A(i,j)*x_old(j) );   
                    %substitutes the updated values and finds the result
            end

            x(i)=(1/A(i,i))*(b(i)-result);
            %calculates value of individual currents
        end

        itr=itr+1;
        normVal=norm(x_old-x);  
        %find the relative error between old and updated current values
    end

    if s==4
        fprintf("For absolute approximate relative error of %.2f percent:\n", tol*100);
    else
        fprintf("For absolute approximate relative error of %.1f percent:\n", tol*100);
    end
    
    for counter=1:rowsB
        fprintf("I%d = %.3f A\n", counter, x(counter));
    end
    fprintf("Number of iterations = %d\n",itr);
end