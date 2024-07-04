clear;clc;close all
figure; hold on;
title( 'Hooke-Jeeves' );
xlabel('x1');
ylabel('x2');
[iters, endpt] = hooke(2, [0, 0], 0.5, 1e-6, 500)
function y = f(x)
% z =  @(x,y)3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
%     - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
%     - 1/3*exp(-(x+1).^2 - y.^2);
z =  @(x,y)(x.^2 + y -11).^2 + (x + y.^2 -7).^2;
y  = z(x(1), x(2));
end
function [minf, point] = beat_nearby(delta, point, prebest, nvars)
minf = prebest;
z = point;
for i = 1 : nvars
    z(i) = point(i) + delta(i);
    ftmp = f(z);
    if ftmp < minf
        minf = ftmp;
    else
        delta(i) = 0 - delta(i);
        z(i) = point(i) + delta(i);
        ftmp = f(z);
        if ftmp < minf
            minf = ftmp;
        else
            z(i) = point(i);
        end
    end
end
point = z;
end
function [iters, endpt] = hooke(nvars, startpt, rho, epsilon, itermax)    
    [newx, xbefore] = deal(startpt);
    delta = abs(startpt * rho);
    delta(delta == 0) = rho;
    iadj = 0;
    steplength = rho;
    iters = 0;
    fbefore = f(newx);
%     newf = fbefore;
    while iters < itermax && steplength > epsilon
        iters = iters + 1;
        iadj = iadj + 1;
        % fprintf('\n f(x) =  %12.8f at\n', fbefore);       
        newx = xbefore;            
        [newf, newx] = beat_nearby(delta, newx, fbefore, nvars);
        keep = 1;
        while newf < fbefore && keep == 1
            iadj = 0;            
            for i = 1 : nvars                
                if newx(i) <= xbefore(i)
                    delta(i) = 0 - abs(delta(i));
                else
                    delta(i) = abs(delta(i));
                end
                endpt = xbefore;
                fprintf('[Xmin=  %5.5f] : [Ymin=  %5.5f] \n', endpt(1), endpt(2));                    

                tmp = xbefore(i);               
                xbefore(i) = newx(i);
                newx(i) = newx(i) * 2 - tmp;   

                % Plot
                plot([ endpt(1) xbefore(1)], [endpt(2) xbefore(2)],'-k')
                axis([-5 5 -5 5])                
                hold on
            end
            fbefore = newf;
            [newf, newx] = beat_nearby(delta, newx, fbefore, nvars);
            if newf >= fbefore
                break
            end
            keep = 0;
            for i = 1 : nvars
                keep = 1;
                if abs(newx(i) - xbefore(i)) > 0.5 * abs(delta(i))
                    break
                else
                    keep = 0;
                end
            end                 
        end
        if steplength >= epsilon && newf >= fbefore
            steplength = steplength * rho;
            delta = delta * rho;
        end
    end
    endpt = xbefore;
    label = {'P1'};
    text(startpt(1),startpt(2),label,'VerticalAlignment','bottom','HorizontalAlignment','right')
    label = {'Pmin'};
    text(endpt(1),endpt(2),label,'VerticalAlignment','bottom','HorizontalAlignment','right')
    hold off
    saveas(gcf,'Hooke-Jeeves_result.png')
end