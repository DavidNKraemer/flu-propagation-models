% Basic Model

syms f s r d

c = 0.02;
p = 0.1;

df = c*f*(1-f-r) - p*f;
dr = 0;
ds = -df;

[T Y] = ode45(@(t,y) double(subs([df; dr; ds],[f r s],[y(1) y(2) y(3)])),[0 100], [0.5 0.0 0.5])


hold off
plot(T,Y)
legend('infectives', 'removes', 'susceptibles')

J = jacobian([df, dr, ds], [f, r, s]);

FixPts = vpasolve([df == 0, dr == 0, ds == 0], [f, r, s]);






