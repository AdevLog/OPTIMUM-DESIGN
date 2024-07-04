clear;clc;close all
format long
%% DATA
% ------------------------------------------------------------------------------------------------------ %
X0    = [0;0];     % coordinates of the first attempt (column vector)
tol   = 1e-4;      % tolerance to stop the algorithm                   (***advisable 1e-4/1e-5***)
% ------------------------------------------------------------------------------------------------------ %
% definition of the domain for N = 2 (necessary for the figures): "square domain"
% ------------------------------------------------------------------------------------------------------ %
xmin  = -6;             % minimum coordinate
xmax  =  6;             % maximum coordinate
dx    = 0.5;            % step between two consecutive coordinates
% ------------------------------------------------------------------------------------------------------ %
% initialization
N      = size(X0,1);      % state's dimension
k      = 0;               % iterations' counter
check1 = 1;               % block condition for points' values
check2 = 1;               % block condition for function's values
Xk     = X0;              % current point
Xit    = X0';             % storage the points
alpha_guess = 1;          % guess value for Armijo-backtracking
Y      = zeros(N,N+1);    % set of points assessed for each cycle
reduct = zeros(N,1);      % vector of the progressive reductions of the objective function
S      = eye(N);          % main directions (column vector) at the first cycle  
% ------------------------------------------------------------------------------------------------------ %
Fsym =  (x(1).^2+x(2)-11).^2 + (x(1)+x(2).^2-7).^2;  
% ------------------------------------------------------------------------------------------------------ %
F        = matlabFunction(Fsym,'vars',{x});
%% COMPUTATION
while (check1 || check2)
    
    % DIRECTION with MAX REDUCTION
    Y(:,1) = Xk;
    for j = 1:N
        sj  = S(:,j);   % j   <-- direction
        yj_ = Y(:,j);   % j-1 <-- point
        alphaj = backtr(alpha_guess,yj_,sj,F);
        Y(:,j+1)  = Y(:,j) +alphaj.*sj;
        if j<N
            reduct(j) = F(Y(:,j))-F(Y(:,j+1));  
        end
    end
    % max reduction
    [DELTA,index_DELTA] = max(reduct);
    F1 = F(Y(:,1));
    F2 = F(Y(:,end));
    F3 = F(2.*Y(:,end)-Y(:,1));
    
    % NEW POINT
    if ((F3>=F1) || (((F1-2*F2+F3)*(F1-F2-DELTA)^2)>=0.5*DELTA*(F1-F3)^2))
        % sj(k+1)==sj(k) --> same directions
        % X(k+1)==Y(N)   --> to start from Y(:,end)
        Xk_new = Y(:,end);
    else
        dk = (Y(:,end)-Xk)/norm(Y(:,end)-Xk);
        alphaj = backtr(alpha_guess,Xk,dk,F);
        Xk_new = Xk +alphaj.*dk;
        % delete the direction index_DELTA
        S(:,index_DELTA) = [];
        % input the new direction dk
        Snew = [S,dk];
        S = Snew;  
    end
    
    % UPDATE and STORAGE
    k      = k+1;
    Xitbis = [Xit;Xk_new'];
    Xit    = Xitbis;
    
    % CHECK
    check1 = (norm(Xk_new-Xk)/max(1,norm(Xk)))>tol;
    check2 = (abs(F(Xk_new)-F(Xk))/(max(1,norm(Xk))))>tol;
    
    Xk = Xk_new;
end
Xmin  = Xk;
iter  = k;
Fmin  = F(Xk);
punti = size(Xit,1);
%% PLOT
clc
figure; hold on;
title( 'Powell’s conjugate' );
xlabel('x1');
ylabel('x2');
plot(Xit(:,1),Xit(:,2),'-k');
axis([-5 5 -5 5]) 
hold on
label = {'P1'};
text(Xit(1,1),Xit(1,2),label,'VerticalAlignment','bottom','HorizontalAlignment','right')
label = {'Pmin'};
text(Xit(size(Xit,1),1),Xit(size(Xit,2),2),label,'VerticalAlignment','bottom','HorizontalAlignment','right')
hold off
saveas(gcf,'Powell_result.png')