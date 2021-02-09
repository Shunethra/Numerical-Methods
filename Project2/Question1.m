%Newton Raphson Method
clear all;
syms x;     
syms y;

var=[x,y]';

init=[0.1,0.1]';
f=[4*x^2+y^2-13, x^2+y^2-10]';

val=newrap(f,var,init);     % to call the function newrap and store in val
disp('For System 1:');
ans_x = val(1, 1);
ans_y = val(2, 1);
fprintf("x = %f\n", ans_x);
fprintf("y = %f\n", ans_y);

init=[0.1,0.1]';
f=[2*x-y-exp(-x), -x+2*y-exp(-y)]';

val=newrap(f,var,init);
disp('For System 2:');
ans_x = val(1, 1);
ans_y = val(2, 1);
fprintf("x = %f\n", ans_x);
fprintf("y = %f\n", ans_y);