function [m]=fibonacci(g)
f=[];
if g<3
    disp('Enter g>3');
    % g should be greater than 3 because f(0) is not defined in MATLAB.
    % Positive Index is required
end
for i=3:g
    f(1)=1;
    f(2)=1;
f(i)=f(i-1)+f(i-2);
m=f(i-2);
end