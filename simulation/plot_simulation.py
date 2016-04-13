print("Running plot_simulation.py")
from setup import *
from Person import *
import matplotlib.animation as animation
import matplotlib.pyplot as plt

susceptibles = [Person(SUSCEPTIBLE) for _ in range(num_susceptibles)]
infectives = [Person(INFECTIVE) for _ in range(num_infectives)]
removes = [Person(REMOVE) for _ in range(num_removes)]

people = susceptibles + infectives + removes

def plot_people(people):
    susceptibles = [person for person in people if person.status is SUSCEPTIBLE]
    infectives = [person for person in people if person.status is INFECTIVE]
    removes = [person for person in people if person.status is REMOVE]
    susceptible_locs = np.array([person.loc for person in susceptibles])
    infective_locs = np.array([person.loc for person in infectives])
    remove_locs = np.array([person.loc for person in removes])

    fig, ax = plt.subplots(figsize=(8,8))
    plot_args = {'markersize': 8, 'alpha': 0.6}
    ax.set_axis_bgcolor('azure')
    ax.plot(susceptible_locs[:,0], susceptible_locs[:,1], 'o', markerfacecolor='red', **plot_args)
    ax.plot(infective_locs[:,0], infective_locs[:,1], 'o', markerfacecolor='green', **plot_args)
    ax.plot(remove_locs[:,0], remove_locs[:,1], 'o', markerfacecolor='blue', **plot_args)
    ax.set_ylim([-1,1])
    ax.set_xlim([-1,1])
    plt.show()


while iteration < iterations:

    plot_people(people)

    for person in people:
        person.update_status(people, radius)
        person.update_location(movement_speed)

    iteration += 1


