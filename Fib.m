% function [xs, res_vec] = f_fibonacci(fun, a, b, n)
clc; clear all;
figure; hold on;
a=-2;
b=2;
n=30;
epsilon = 0.00001;
fun = @(x) x^3*exp(-x^2);

L = b - a;
% first iteration
k = 1;
F_nk = fibonacci(n-k+1);
F_nk1 = fibonacci(n-k+1+1);
Lk = (F_nk/F_nk1)*L;
x1 = b-Lk;
x2 = a+Lk;
f_x1 = fun(x1);
f_x2 = fun(x2);
res_vec =  [];
sprintf('===============')
sprintf('===============')
title( 'Fibonacci search on f(x)' );
xlabel('iteration number');
ylabel('function value');
% 2-n iterations
% for k=2:n
while ((abs(b-a)>epsilon)) && (k<=n)
    res_vec = [ res_vec; [a, b]];
    
%     F_nk = fibonacci(n-k+1);
%     F_nk1 = fibonacci(n-k+1+1);
%     
%     Lk = (F_nk/F_nk1)*L;
    
    if (f_x1 < f_x2)
        b = x2;
        x2 = x1;
        f_x2 = f_x1;
        x1 = a+(b-x2);
        f_x1 = fun(x1);
        % Plot
        plot(k,f_x1,'bd');
        hold on  
    else
        a = x1;
        x1 = x2;
        f_x1 = f_x2;
        x2 = b-(x1-a);
        f_x2 = fun(x2);
        % Plot
        plot(k,f_x2,'rd');
        hold on  
    end
    k=k+1;
    
end
hold off;
xs = (a+b)/2;
saveas(gcf,'Fibonacci_result.png')