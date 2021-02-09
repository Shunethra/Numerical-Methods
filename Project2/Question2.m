%Bisection method
prompt = "Enter the value of resistance: ";
resistance = input(prompt);         % to accept any value of resistance 
syms t;
f=(5.775*10^-7*t^2)-(3.9083*10^-3*t)+(resistance/100 - 1);
t_low = -200;
t_high = 600;
t_mid =0;
itr =0;
tol = 0.001;
normVal = Inf;

while (normVal > tol)
    t_old = t_mid;
    t_mid = (t_low + t_high)/2;     % to find estimate of t
    result_mid = subs(f,t,t_mid);   % substitute t_mid in f 
    result = subs(f, t, t_low);     % substitute t_low in f 
    if result*result_mid < 0        % root lies between t_low and t_mid
         t_high = t_mid;
    elseif result*result_mid > 0    % root lies between t_mid and t_high
         t_low= t_mid;
    elseif (result*result_mid) == 0 % root is t_mid
         return;
    end
    normVal=norm(t_mid - t_old);    % to find the approximate error
    itr = itr + 1;
end

ans = t_mid;
disp('For Bisection Method:');
fprintf("T = %f\n", ans);
fprintf("Number of iterations = %d\n",itr);


%Newton Raphson Method
d = diff(f);
tnew = 0;
tol = 0.001;
normVal = Inf;
itr = 0;
while (normVal > tol)
    t = tnew;
    ans1 = subs(f);
    ans2 = subs(d);
    tnew = t - (ans1/ans2);
    itr=itr+1;
    normVal=norm(tnew - t); 
end
ans = tnew;
disp('For Newton-Raphson Method:');
fprintf("T = %f\n", ans);
fprintf("Number of iterations = %d\n",itr);