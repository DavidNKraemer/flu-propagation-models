from Person import *
PRINT_CONFIG = True

# populations
total_population    = 100
percent_susceptible = 0.4
percent_infective   = 0.4
percent_remove      = 0.2
percent_dead        = 0.0

num_susceptibles    = int(total_population * percent_susceptible)
num_infectives      = int(total_population * percent_infective)
num_removes         = int(total_population * percent_remove)
num_dead            = int(total_population * percent_dead)

initial_breakdown = [num_susceptibles, num_infectives, num_removes, num_dead]

# simulation parameters
iterations          = 101
movement_speed      = 1.00e-2
radius              = 1.0e+5
samples             = 20

# plot standardization
labels = ['Infective', 'Remove', 'Susceptible',  'Dead']
colors = ['red', 'blue', 'green', 'black']


if PRINT_CONFIG:
    print("\nSimulation Configuration Settings.\n")
    print("Iterations:\t{}".format(iterations))
    print("Population:\t{}\n".format(total_population))
    print("+-------------+------------+")
    print("| Category    | Population | ")
    print("+-------------+------------+")
    print("| Susceptible | {}\t   |".format(num_susceptibles))
    print("| Infective   | {}\t   |".format(num_infectives))
    print("| Removes     | {}\t   |".format(num_removes))
    print("| Dead        | {}\t   |".format(num_dead))
    print("+-------------+------------+")

    print("\nWalk speed:\t{}".format(movement_speed))
    print("Contagion ball:\t{}".format(radius))
    print("Sample sims:\t{}".format(samples))

    print("\nModel Parameters:\n")
    print("+------------------------+--------+")
    print("| Parameter              | Value  |")
    print("+------------------------+--------+")
    print("| Infection propensity   | {:1.4f} |".format(Person.infection_rate))
    print("| Recovery propensity    | {:1.4f} |".format(Person.recovery_threshold))
    print("| Immunization threshold | {:1.4f} |".format(Person.immunization_threshold))
    print("| Relapse threshold      | {:1.4f} |".format(Person.relapse_threshold))
    print("| Fatality propensity    | {:1.4f} |".format(Person.fatality_threshold))
    print("+------------------------+--------+")


