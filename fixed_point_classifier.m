function [deltas, taus, classifications] = fixed_pointer_classifier(fixed_points, jacobi)

len = length(fixed_points.infectives);

Jeval = @(inf, sus, rem, ded) double(subs(jacobi,[infectives susceptible removes dead],...
                                                 [inf, sus, rem, ded]);

classifications = cell(4,1);
deltas = zeros(4,1);
taus = zeros(4,1);

for i = 1:len

    % Compute delta and tau
    inf = fixed_points.infectives(i);
    sus = fixed_points.susceptible(i);
    rem = fixed_points.removes(i);
    ded = fixed_points.dead(i);



    delta(i) = double(det(Jeval(inf, sus, rem, ded)));
    tau(i) = double(trace(Jeval(inf, sus, rem, ded)));

    if delta(i) < 0
        cell(i) = 'Saddle point';
    elseif tau(i) > 0  
        if tau(i)^2 - 4 * delta(i) > 0
            cell(i) = 'Unstable node';
        else
            cell(i) = 'Unstable spiral';
        end
    else
        if tau(i)^2 - 4 * delta(i) > 0
            cell(i) = 'Stable node';
        else
            cell(i) = 'Stable spiral';
        end
    end
end
end
