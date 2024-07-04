% ------------------------GOLDEN SECTION METHOD----------------------------
% -------------------------------------------------------------------------
% Copyright (c) 2009, Katarzyna Zarnowiec, all rights reserved 
% mailto: katarzyna.zarnowiec@gmail.com
% -------------------------------------------------------------------------
clc; clear all;
figure; hold on;
a=-2;                           % start of interval
b=2;                            % end of interval
epsilon=0.00001;                % accuracy value
iter=100;                       % maximum number of iterations
fun = @(x) x^3*exp(-x^2);
phi=double((sqrt(5)-1)/2);      % golden proportion coefficient, around 0.618
k=0;                            % number of iterations
x1=a+(1-phi)*(b-a);             % computing x values
x2=a+phi*(b-a);
f_x1=fun(x1);                     % computing values in x points
f_x2=fun(x2);
% plot(x1,f_x1,'rx')            % plotting x
% plot(x2,f_x2,'rx')
sprintf('===============')
sprintf('===============')
title( 'Golden section search on f(x)' );
xlabel('iteration number');
ylabel('function value');
while ((abs(b-a)>epsilon))
    k=k+1;
    sprintf('k=%f', k)
    if(f_x1<f_x2)
        b=x2;
        x2=x1;
        x1=a+(1-phi)*(b-a);
        
        f_x1=fun(x1);
        f_x2=fun(x2);
        
        sprintf('x_min=%f', x1)
        sprintf('f(x_min)=%f ', f_x1)
        plot(k,f_x1,'bd')
    else
        a=x1;
        x1=x2;
        x2=a+phi*(b-a);
        
        f_x1=fun(x1);
        f_x2=fun(x2);
        
        sprintf('x_min=%f', x2)
        sprintf('f(x_min)=%f ', f_x2)
        plot(k,f_x2,'rd')
    end
%     xmin = (x1+x2)/2;
%     fmin = f(xmin);
%     plot(k,fmin,'.r','MarkerSize',10) 
    
    % k=k+1;
end
% chooses minimum point
% if(f_x1<f_x2)
%     sprintf('x_min=%f', x1)
%     sprintf('f(x_min)=%f ', f_x1)
%     plot(k,f_x1,'b*')
% else
%     sprintf('x_min=%f', x2)
%     sprintf('f(x_min)=%f ', f_x2)
%     plot(k,f_x2,'b*')
% end
hold off;
saveas(gcf,'Golden-section_result.png')