
syms f s r d

c = 0.02;
p = 0.1;
z = 0.5;
L = 0.01;
fatal = 0.0003;

% ***************
% * Basic Model *
% ***************

df = c*f*(1-f-r) - p*f;
dr = 0;
ds = -df;

[T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[f r s],[y(1) y(2) y(3)])),[0 100], [0.5 0.0 0.5]);

%figure
%hold off
%plot(T,Y)
%legend('infectives', 'removes', 'susceptibles')

J = jacobian([df, dr, ds], [f, r, s]);

FixPts = vpasolve([df == 0; dr == 0; ds == 0], [f, r, s])

% **********************
% * Immunization Model *
% **********************


df = c*f*(1-f-r) - p*f;
dr = z*p*f;
ds = -df - dr;

[T2, Y2] = ode45(@(t,y) double(subs([df; dr; ds],[f r s],[y(1) y(2) y(3)])),[0 100], [0.4 0.2 0.4])

figure
hold off
plot(T2,Y2)
axis([0 100 0 1])
legend('infectives', 'removes', 'susceptibles')

% *****************************************
% * Immunization Model with Lost Immunity *
% *****************************************

df = c*f*(1-f-r) - p*f;
dr = z*p*f - L*r;
ds = -df - dr;

[T3, Y3] = ode45(@(t,y) double(subs([df; dr; ds],[f r s],[y(1) y(2) y(3)])),[0 100], [0.4 0.2 0.4])

figure
hold off
plot(T3,Y3)
axis([0 100 0 1])
legend('infectives', 'removes', 'susceptibles')

% ********************************************************
% * Printing the differences between Model 2 and Model 3 *
% ********************************************************

test1 = zeros(length(Y3));
test2 = zeros(length(Y3));

for i = 1:length(Y3)
    test1(i) = Y3(i,1) - Y2(i,1);
    test2(i) = Y3(i,2) - Y2(i,2);
    test3(i) = Y3(i,3) - Y2(i,3);
end

figure
hold on
plot(test1, 'b')
plot(test2, 'g')
plot(test3, 'r')

% **************************
% * Model with Dead People *
% **************************

df = c*f*(1-f-r-d) - p*f;
dr = z*p*f - L*r;
dd = f*i;
ds = -df - dr - dd;

[T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[f r d s],[y(1) y(2) y(3) y(4)])),[0 100], [0.5 0.0 0.0 0.5]);

figure
hold off
plot(T4,Y4)
axis([0 100 0 1])
legend('infectives', 'removes', 'dead', 'susceptibles')









