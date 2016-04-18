%Outputs sensitivity tables for each population parameter in the
%Baseline_Model. The format for entering intial conditions is:
%Sensitivity(contagion_rate, recovery_rate, resistance_rate, lost_immunity_rate, fatality_rate, infectives, susceptibles, removes)
%The sensitivity tests compare compares variations 0, 10 and 20 percent
%variations on each parameter to each population level by holding all other
%givens and stepping from .8, .9, 1, 1.1, 1.2 for each.


Sensitivity(.02, .1, .5, .1, .0003, 2, 998, 1000)

Sensitivity(.001, .1, .999, .01, 2, 998, 1000)

Sensitivity(.001, .1, .999, .01, 2, 1998, 0)


