function val=newrap(f,var,init)          % function declaration
j=jacobian(f',var');                     % to find Jacobian of f

init_new = init;
tol = 0.005;                             % tolerance is 5%
normVal = Inf;
itr = 0;

while (normVal > tol)
    init = init_new;
    F = subs(f, var, init);             % substitute initial values in f
    res = subs(j, var', init');         % substitute initial values in j   
    val = init - ((inv(res))*F);        % to find the new values of var
    init_new = val;
    difference = init_new - init;
    div = difference./init_new;
    maximum = max(div(:, 1));           % to find maximum value of div
    itr=itr+1;
    normVal=maximum;
end

end