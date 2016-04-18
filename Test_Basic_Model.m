syms infectives susceptible removes dead contagion_rate recovery_rate 
syms immunization_rate lost_immunity_rate fatalality_rate 
syms initial_infectives initial_susceptible initial_removes initial_dead
syms total_population


radius = 1;

% **********************
% * Initial Conditions *
% **********************

% total_population = 100;

% Initial Populations for each group
% These are given as proportions of the total population

% initial_infectives = 0.4;
% initial_susceptible = 0.4;
% initial_removes = 0.2;
% initial_dead = 0;

% **************
% * Parameters *
% **************

%contagion_rate = 0.02;
%recovery_rate = 0.1;
%resistance_rate = 0.5;
%lost_immunity_rate = 0.1;
%fatalality_rate = 0.0003;

%radius = 0.5;

% ***************
% * Basic Model *
% ***************

df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = 0;
ds = -df;

tvalues = 0:1:100;

%[T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])), tvalues, [initial_infectives; initial_removes; initial_susceptible]);

%csvwrite('poplevels.csv', Y);

%figure
%hold off
%plot(T,Y*total_population)
%axis([0 100 0 total_population])
%legend('infectives', 'removes', 'susceptibles')

%J = jacobian([df, dr, ds], [infectives, removes, susceptible]);

FixPtsBM = vpasolve([df == 0; susceptible+infectives == 1-initial_removes], [infectives, susceptible])


% *****************************************
% * Immunization Model with Lost Immunity *
% *****************************************

df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
ds = -df - dr;

FixPtsIMLI = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])




% **************************
% * Model with Dead People *
% **************************

df = contagion_rate*radius*infectives*(1-infectives-removes-dead)*total_population - recovery_rate*infectives - infectives*fatalality_rate;
dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
dd = infectives*fatalality_rate;
ds = -df - dr - dd;

FixPtsD = vpasolve([df == 0; dr == 0; dd == 0; susceptible+removes+infectives+dead == 1], [infectives, removes, dead, susceptible])


%[T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[infectives removes dead susceptible],[y(1) y(2) y(3) y(4)])),tvalues, [initial_infectives initial_removes initial_dead initial_susceptible]);

