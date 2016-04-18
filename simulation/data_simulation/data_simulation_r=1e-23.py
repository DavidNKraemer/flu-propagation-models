print("Running data_simulation.py")
from setup import *
from Person import *
import matplotlib.pyplot as plt
import numpy as np
people = []

susceptibles = [Person(SUSCEPTIBLE) for _ in range(num_susceptibles)]
infectives   = [Person(INFECTIVE)   for _ in range(num_infectives)]
removes      = [Person(REMOVE)      for _ in range(num_removes)]
dead         = [Person(DEAD)        for _ in range(num_dead)]

num_radii = 10
num_vaccine_levels = 10
num_fatality_thresholds = 10

radii = np.power(10, np.linspace(0, -5, num_radii))
vaccine_levels = np.linspace(0, 1, num_vaccine_levels) * total_population
fatality_thresholds = np.linspace(0, 1, num_fatality_thresholds)

populations = np.empty((iterations,4,samples,num_vaccine_levels,
    num_fatality_thresholds))

radius = 1e0
print("Transmission radius:\t{}".format(radius))
for (rem, num_removes) in enumerate(vaccine_levels):
    print("Initially vaccinated:\t{}".format(num_removes))
    num_infectives = percent_infective * (total_population - num_removes)
    num_susceptibles = percent_susceptible * (total_population - num_removes) 
    for (t, threshold) in enumerate(fatality_thresholds):
        print("Fatality rate:\t{}".format(threshold))
        Person.fatality_threshold = threshold
        for sim in range(samples):
            num_susceptibles, num_infectives, num_removes, num_dead = initial_breakdown
        
            print("Simulation {}".format(sim + 1), end="\r")
        
            for i in range(iterations):
                people = susceptibles + infectives + removes + dead
            
                susceptibles = [person for person in people if person.status is SUSCEPTIBLE]
                infectives   = [person for person in people if person.status is INFECTIVE]
                removes      = [person for person in people if person.status is REMOVE]
                dead         = [person for person in people if person.status is DEAD]
            
            
                populations[i,:,sim,rem,t] = np.array([num_infectives, num_removes, num_susceptibles,
                    num_dead]) / total_population
            
                # update the entire population positions and statuses
                for person in people:
                    person.update_status(people, radius)
                    person.update_location(movement_speed)
            
                num_susceptibles = len(susceptibles)
                num_infectives   = len(infectives)
                num_removes      = len(removes)
                num_dead         = len(dead)
        print("Simulation... done.")

print('Saving data...', end="", flush=True)
np.save('data/stochastic_data_01', populations)
print(" done.")
