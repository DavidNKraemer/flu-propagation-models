print("Running simulate_data.py")
from setup import *
from Person import *
import matplotlib.pyplot as plt
import numpy as np
try:
    print("Attempting to import the Seaborn module...", end="")
    import seaborn as sns
    sns.set_context('poster')
    sns.set_style('whitegrid')
    print(" success.")
except ImportError:
    print("\nNo such module exists! Using Matplotlib settings.")
    plt.style.use('fivethirtyeight')

people = []

susceptibles = [Person(SUSCEPTIBLE) for _ in range(num_susceptibles)]
infectives   = [Person(INFECTIVE)   for _ in range(num_infectives)]
removes      = [Person(REMOVE)      for _ in range(num_removes)]
dead         = [Person(DEAD)        for _ in range(num_dead)]

populations = np.empty((iterations,4,samples))

for sim in range(samples):
    num_susceptibles, num_infectives, num_removes, num_dead = initial_breakdown

    print("Simulation {}".format(sim + 1), end="\r")

    for i in range(iterations):
        people = susceptibles + infectives + removes + dead
    
        susceptibles = [person for person in people if person.status is SUSCEPTIBLE]
        infectives   = [person for person in people if person.status is INFECTIVE]
        removes      = [person for person in people if person.status is REMOVE]
        dead         = [person for person in people if person.status is DEAD]
    
    
        populations[i,:,sim] = np.array([num_infectives, num_removes, num_susceptibles,
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

np.save('simulation_data', populations)
        

print(" done.")
# print('Saving plot...', end="", flush=True)
# 
# labels = ['Infective', 'Remove', 'Susceptible',  'Dead']
# colors = ['red', 'blue', 'green', 'black']
# 
# fig, ax = plt.subplots(1,1, figsize=(8,8))
# box = ax.get_position()
# 
# for i in range(4):
#     ax.plot(populations[:,i], label=labels[i], color=colors[i])
#     ax.set_position([box.x0, box.y0 + box.height * 0.1,
#                          box.width, box.height * 0.9])
# ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.1), fancybox=False,
#         shadow=True, ncol=4)
# 
# ax.set_ylim([0,1])
# ax.set_xlabel('Time ($t$)', fontsize=12)
# ax.set_ylabel('Percent of population', fontsize=12)
# ax.set_title('{} iterations, ({},{},{},{}) initial, {} radius, {} speed'.
#         format(iterations, percent_susceptible, percent_infective,
#             percent_remove, percent_dead, radius, movement_speed))
# 
# 
# plt.savefig('simulation_plot.png',bbox_inches='tight')
# plt.close()

print(' done.')

