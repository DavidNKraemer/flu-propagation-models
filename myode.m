function [ dydt ] = myode( t, y, ft, f, gt, g )
% From the MathWorks help file on ode45

f = interp1(ft,f,t); % Interpolate the data set (ft,f) at time t
g = interp1(gt,g,t); % Interpolate the data set (gt,g) at time t
dydt = -f.*y + g; % Evaluate ODE at time t

end

