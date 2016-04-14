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
immunization_rate = 0.5;
lost_immunity_rate = 0.1;
fatalality_rate = 0.0003;
cost_infective = 10;
cost_remove= 30;
steps = 50;
cost = zeros(steps,4);

radius = 0.5;

% Time Values for a Fixed Time Solver
tvalues = 0:1:60;

% ***************
% * Basic Model *
% ***************

for i = 1:steps

    initial_removes = i / steps
    initial_susceptible = (1 - initial_removes) / 2;
    initial_infectives= (1 - initial_removes) / 2;

    df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
    dr = 0;
    ds = -df;
    
    [T, Y] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible]);
    
    cost(i,1) = cost_remove * initial_removes + sum(cost_infective * Y(:,1));
    
    J = jacobian([df, dr, ds], [infectives, removes, susceptible]);
    
    FixPtsBM = vpasolve([df == 0; susceptible+infectives == 1-initial_removes], [infectives, susceptible]);
    
    % **********************
    % * Immunization Model *
    % **********************
    
    df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
    dr = immunization_rate*recovery_rate*infectives;
    ds = -df - dr;
    
    FixPtsIM = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible])
    
    [T2, Y2] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible])
    
    cost(i,2) = cost_remove * initial_removes + sum(cost_infective * Y2(:,1));
    
    % *****************************************
    % * Immunization Model with Lost Immunity *
    % *****************************************
    
    df = contagion_rate*radius*infectives*(1-infectives-removes)*total_population - recovery_rate*infectives;
    dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
    ds = -df - dr;
    
    FixPtsIMLI = vpasolve([df == 0; dr == 0; susceptible+removes+infectives == 1], [infectives, removes, susceptible]);

    [T3, Y3] = ode45(@(t,y) double(subs([df; dr; ds],[infectives removes susceptible],[y(1) y(2) y(3)])),tvalues, [initial_infectives initial_removes initial_susceptible]);

    cost(i,3) = cost_remove * initial_removes + sum(cost_infective * Y3(:,1));
    df = contagion_rate*radius *infectives*(1-infectives-removes-dead)*total_population - recovery_rate*infectives;
    dr = immunization_rate*recovery_rate*infectives - lost_immunity_rate*removes;
    dd = infectives*fatalality_rate*total_population;
    ds = -df - dr - dd;
    
    FixPtsD = vpasolve([df == 0; dr == 0; dd == 0; susceptible+removes+infectives == 1], [infectives, removes, dead, susceptible]);
    
    
    [T4, Y4] = ode45(@(t,y) double(subs([df; dr; dd; ds],[infectives removes dead susceptible],[y(1) y(2) y(3) y(4)])),tvalues, [initial_infectives initial_removes initial_dead initial_susceptible]);
    
    cost(i,4) = cost_remove * initial_removes + sum(cost_infective * Y4(:,1));

end
