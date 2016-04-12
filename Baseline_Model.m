% This is the Disease model for Project 3 in MAT 306 Mathematical Modeling
% Evan Christianson, David Kraemer, Caleb Leedy, and Will Royle

% TODO: change our differential equation solver to a fixed step method


syms infectives susceptible removes dead

% **********************
% * Initial Conditions *
% **********************

total_population = 10;

% Initial Populations for each group
% These are given as proportions of the total population

initial_infectives = 0.4;
initial_susceptible = 0.4;
initial_removes = 0.2;
initial_dead = 0;

% **************
% * Parameters *
% **************

contagion_rate = 0.02;
recovery_rate = 0.1;
resistance_rate = 0.5;
lost_immunity_rate = 0.1;
fatalality_rate = 0.03;


% ***************
% * Basic Model *
% ***************

df = contagion_rate*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = 0;
ds = -df;

[T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),[0 100], [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T,Y*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'susceptibles')

J = jacobian([df, dr, ds], [infectives, removes, susceptible]);

FixPtsBM = vpasolve([df == 0; susceptible+infectives == 1], [infectives, susceptible])


% **********************
% * Immunization Model *
% **********************


df = contagion_rate*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = resistance_rate*recovery_rate*infectives;
ds = -df - dr;

FixPtsIM = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])

[T2, Y2] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),[0 100], [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T2,Y2*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'susceptibles')

% *****************************************
% * Immunization Model with Lost Immunity *
% *****************************************

df = contagion_rate*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = resistance_rate*recovery_rate*infectives - lost_immunity_rate*removes;
ds = -df - dr;

FixPtsIMLI = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])


[T3, Y3] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),[0 100], [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T3,Y3*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'susceptibles')

% ********************************************************
% * Printing the differences between Model 2 and Model 3 *
% ********************************************************

test1 = zeros(length(Y3));
test2 = zeros(length(Y3));

%TODO: Change this

for i = 1:length(Y2)
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

df = contagion_rate*infectives*(1-infectives-removes-dead)*total_population - recovery_rate*infectives;
dr = resistance_rate*recovery_rate*infectives - lost_immunity_rate*removes;
dd = infectives*fatalality_rate*total_population;
ds = -df - dr - dd;

FixPtsD = vpasolve([df == 0; dr == 0; dd == 0; susceptible+removes+infectives == 1], [infectives, removes, dead, susceptible])


[T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[infectives removes dead susceptible],[y(1) y(2) y(3) y(4)])),[0 100], [initial_infectives initial_removes initial_dead initial_susceptible]);

figure
hold off
plot(T4,Y4*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'dead', 'susceptibles')









