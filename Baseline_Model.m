% This is the Disease model for Project 3 in MAT 306 Mathematical Modeling
% Evan Christianson, David Kraemer, Caleb Leedy, and Will Royle

syms infectives susceptible removes dead

% **********************
% * Initial Conditions *
% **********************

total_population = 100;

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
fatalality_rate = 0.0003;

% Time Values for a Fixed Time Solver
tvalues = 0:1:100;

% ***************
% * Basic Model *
% ***************

df = contagion_rate*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = 0;
ds = -df;

[T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

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

[T2, Y2] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

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


[T3, Y3] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T3,Y3*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'susceptibles')

% ********************************************************
% * Printing the differences between Model 2 and Model 3 *
% ********************************************************

testplot = zeros(length(Y3),3);

for i = 1:3
    testplot(:,i) = Y3(:,i) - Y2(:,i);
end

figure 
hold off
plot(T3,testplot)
axis([0 100 0 1])


% **************************
% * Model with Dead People *
% **************************

df = contagion_rate*infectives*(1-infectives-removes-dead)*total_population - recovery_rate*infectives;
dr = resistance_rate*recovery_rate*infectives - lost_immunity_rate*removes;
dd = infectives*fatalality_rate*total_population;
ds = -df - dr - dd;

FixPtsD = vpasolve([df == 0; dr == 0; dd == 0; susceptible+removes+infectives == 1], [infectives, removes, dead, susceptible])


[T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[infectives removes dead susceptible],[y(1) y(2) y(3) y(4)])),tvalues, [initial_infectives initial_removes initial_dead initial_susceptible]);

figure
hold off
plot(T4,Y4*total_population)
axis([0 100 0 total_population])
legend('infectives', 'removes', 'dead', 'susceptibles')









