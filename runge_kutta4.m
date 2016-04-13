function [t, y] = runge_kutta4(f, t0, y0, tn, h)
disp(size(y0)); % 3x1
disp(size(f(t0,y0))); % 3x1
n = int16((tn - t0) / h);
eqns = size(y0); % [3 1]
disp(eqns(1));
t = [t0 zeros(1, n)];
y = [y0 zeros(eqns(1), n)];
for i = 2:n+1
    k1 = f(t(i-1),y(:, i-1)).';
    k2 = f(t(i-1) + h / 2, y(:, i-1) + h * k1 / 2).';
    k3 = f(t(i-1) + h / 2, y(:, i-1) + h * k2 / 2).';
    k4 = f(t(i-1) + h,     y(:, i-1) + h * k3).';
    y(:, i) = y(:, i - 1) + h / 6 * (k1 + 2 * k2 + 2 * k3 + k4); 
    t(i) = t(i - 1) + h;
end
end
