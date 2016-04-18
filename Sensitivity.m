function [ ] = Sensitivity( contagion_rate, recovery_rate, resistance_rate, lost_immunity_rate, fatality_rate, infectives, susceptibles, removes )
%SENSITIVITY Prints sensitivity of df, dr, ds, and dd to given parameters.
%Uses raw numbers for infectives susceptibles and removes. Assumes the
%number of initial dead is zero. Output is designed for Overleaf.
df_contagion_rate = zeros(5);
df_infectives = zeros(5);
df_susceptibles = zeros(5);
df_recovery_rate = zeros(5);
dr_resistance_rate = zeros(5);
dr_recovery_rate = zeros(5);
dr_infectives = zeros(5);
dr_lost_immunity_rate = zeros(5);
dr_removes = zeros(5);
dd_infectives = zeros(5);
dd_fatality_rate = zeros(5);
ds_contagion_rate = zeros(5);
ds_infectives = zeros(5);
ds_susceptibles = zeros(5);
ds_recovery_rate = zeros(5);
ds_resistance_rate = zeros(5);
ds_lost_immunity_rate = zeros(5);
ds_removes = zeros(5);
ds_fatality_rate = zeros(5);
for i = 1:5
    df_contagion_rate(i) = ((.7 + .1 * i) * contagion_rate) * infectives * susceptibles - recovery_rate * infectives;
    df_infectives(i) =  contagion_rate *((.8 + .1 * i) * infectives) * susceptibles - recovery_rate * ((.8 + .1 * i) * infectives);
    df_susceptibles(i) = contagion_rate*infectives*((.8 + .1 * i) * susceptibles) - recovery_rate*infectives;
    df_recovery_rate(i) = contagion_rate*infectives*susceptibles - ((.8 + .1 * i) * recovery_rate) * infectives;
    dr_resistance_rate(i) = ((.8 + .1 * i)*resistance_rate)*recovery_rate*infectives - lost_immunity_rate*removes;
    dr_recovery_rate(i) = resistance_rate*((.8 + .1 * i)*recovery_rate)*infectives - lost_immunity_rate*removes;
    dr_infectives(i) = resistance_rate*recovery_rate*((.8 + .1 * i) * infectives) - lost_immunity_rate*removes;
    dr_lost_immunity_rate(i) = resistance_rate*recovery_rate*infectives - ((.8 + .1 * i) * lost_immunity_rate) * removes;
    dr_removes(i) = resistance_rate*recovery_rate*infectives - lost_immunity_rate*((.8  + .1 * i)* removes);
    dd_infectives(i) = ((.8 + .1 * i) * infectives) * fatality_rate;
    dd_fatality_rate(i) = ((.8 + .1 * i) * fatality_rate) * infectives;
    ds_contagion_rate(i) = - ((.8 + .1 * i)*contagion_rate)*infectives*susceptibles + recovery_rate*infectives - resistance_rate*recovery_rate*infectives + lost_immunity_rate*removes -infectives * fatality_rate;
    ds_infectives(i) = - contagion_rate*((.8 + .1 * i)*infectives)*susceptibles + recovery_rate*((.8 + .1 * i )* infectives) - resistance_rate*recovery_rate*((.8 + .1 * i)*infectives) + lost_immunity_rate*removes - ((.8 + .1 * i )*infectives) * fatality_rate;
    ds_susceptibles(i) = - contagion_rate*infectives*((.8 + .1 * i)*susceptibles) + recovery_rate*infectives - resistance_rate*recovery_rate*infectives + lost_immunity_rate*removes - infectives * fatality_rate;
    ds_recovery_rate(i) = - contagion_rate*infectives*susceptibles + ((.8 + .1 * i)*recovery_rate)*infectives - resistance_rate*((.8 + .1 * i)*recovery_rate)*infectives + lost_immunity_rate*removes - infectives * fatality_rate;
    ds_resistance_rate(i) = - contagion_rate*infectives*susceptibles + recovery_rate*infectives - ((.8 + .1 * i)*resistance_rate)*recovery_rate*infectives + lost_immunity_rate*removes - infectives * fatality_rate;
    ds_lost_immunity_rate(i) = - contagion_rate*infectives*susceptibles + recovery_rate*infectives - resistance_rate*recovery_rate*infectives + ((.8 + .1 * i )*lost_immunity_rate)*removes - infectives * fatality_rate;
    ds_removes(i) = - contagion_rate*infectives*susceptibles + recovery_rate*infectives - resistance_rate*recovery_rate*infectives + lost_immunity_rate*((.8 + .1 * i)*removes) - infectives * fatality_rate;
    ds_fatality_rate(i) = - contagion_rate*infectives*susceptibles + recovery_rate*infectives - resistance_rate*recovery_rate*infectives + lost_immunity_rate*removes - infectives * ((.8 + .1 * i)*fatality_rate);
end
fprintf( 'BEGINNING SENSITIVITY TESTS:\n\n');

fprintf( 'Sensitivity df_contagion_rate (contagion_rate & df) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', contagion_rate * (.7 + .1 * i), df_contagion_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity df_infectives (infectives & df) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', infectives * (.7 + .1 * i), df_infectives(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity df_susceptibles (susceptibles & df) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', susceptibles * (.7 + .1 * i), df_susceptibles(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity df_recovery_rate (recovery_rate & df) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5;
   fprintf('%.2d & %.2d\\\\ \n', recovery_rate * (.7 + .1 * i), df_recovery_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dr_resistance_rate (resistance_rate & dr) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', resistance_rate * (.7 + .1 * i), dr_resistance_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dr_recovery_rate (recovery_rate & dr) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', recovery_rate * (.7 + .1 * i), dr_recovery_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dr_infectives (infectives & dr) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', infectives * (.7 + .1 * i), dr_infectives(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dr_lost_immunity_rate (lost_immunity_rate & dr) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', lost_immunity_rate * (.7 + .1 * i), dr_lost_immunity_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dr_removes (removes & dr) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', removes * (.7 + .1 * i), dr_removes(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dd_infectives (infectives & dd) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', infectives * (.7 + .1 * i), dd_infectives(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity dd_fatality_rate (fatality_rate & dd) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', fatality_rate * (.7 + .1 * i), dd_fatality_rate(i));
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_contagion_rate (contagion_rate & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', contagion_rate * (.7 + .1 * i), ds_contagion_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_infectives (infectives & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', infectives * (.7 + .1 * i), ds_infectives(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_susceptibles (susceptibles & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', susceptibles * (.7 + .1 * i), ds_susceptibles(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_recovery_rate (ds_recovery_rate & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', recovery_rate * (.7 + .1 * i), ds_recovery_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_resistance_rate (resistance_rate & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', resistance_rate * (.7 + .1 * i), ds_resistance_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_lost_immunity_rate (lost_immunity_rate & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', lost_immunity_rate * (.7 + .1 * i), ds_lost_immunity_rate(i)); 
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_removes (removes & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', removes * (.7 + .1 * i), ds_removes(i));
end
fprintf('\\end{tabular}\n');

fprintf( 'Sensitivity ds_fatality_rate (ds_fatality_rate & ds) \n');
fprintf('\\begin{tabular}{ll}\n');
for i = 1:5
   fprintf('%.2d & %.2d\\\\ \n', fatality_rate * (.7 + .1 * i), ds_fatality_rate(i)); 
end
fprintf('\\end{tabular}\n');


