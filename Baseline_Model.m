% This is the Disease model for Project 3 in MAT 306 Mathematical Modeling
% Evan Christianson, David Kraemer, Caleb Leedy, and Will Royle

syms infectives susceptible removes dead

% **********************
% * Initial Conditions *
% **********************

total_population = 3000;

% Initial Populations for each group
% These are given as proportions of the total population

initial_infectives = 0.0067;
initial_susceptible = 0.66;
initial_removes = 0.3333;
initial_dead = 0;

% **************
% * Parameters *
% **************

contagion_rate = 0.02;
recovery_rate = 0.1;
immunization_rate = 0.5;
lost_immunity_rate = 0.1;
fatalality_rate = 0.03;

radius = 1;

% Time Values for a Fixed Time Solver
total_time = 10;
tvalues = 0:1:total_time;

% ***************
% * Basic Model *
% ***************

df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = 0;
ds = -df;

[T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T,Y*total_population)
axis([0 total_time 0 total_population])
legend('infectives', 'removes', 'susceptibles')

J = jacobian([df, dr, ds], [infectives, removes, susceptible]);

FixPtsBM = vpasolve([df == 0; susceptible+infectives == 1-initial_removes], [infectives, susceptible])


% **********************
% * Immunization Model *
% **********************


df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = immunization_rate*recovery_rate*infectives;
ds = -df - dr;

FixPtsIM = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])

[T2, Y2] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T2,Y2*total_population)
axis([0 total_time 0 total_population])
legend('infectives', 'removes', 'susceptibles')

% *****************************************
% * Immunization Model with Lost Immunity *
% *****************************************

df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
ds = -df - dr;

FixPtsIMLI = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])


[T3, Y3] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])

figure
hold off
plot(T3,Y3*total_population)
axis([0 total_time 0 total_population])
legend('infectives', 'removes', 'susceptibles')

% **************************
% * Model with Dead People *
% **************************

df = contagion_rate*radius*infectives*(1-infectives-removes-dead)*total_population - recovery_rate*infectives;
dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
dd = infectives*fatalality_rate;
ds = -df - dr - dd;

FixPtsD = vpasolve([df == 0; dr == 0; dd == 0; susceptible+removes+infectives == 1], [infectives, removes, dead, susceptible])


[T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[infectives removes dead susceptible],[y(1) y(2) y(3) y(4)])),tvalues, [initial_infectives initial_removes initial_dead initial_susceptible]);

figure
hold off
plot(T4,Y4*total_population)
axis([0 total_time 0 total_population])
legend('infectives', 'removes', 'dead', 'susceptibles')









