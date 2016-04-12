from Person import *
import matplotlib.animation as animation
import matplotlib.pyplot as plt

plt.style.use('fivethirtyeight')

# populations
total_population = 100
percent_susceptible = 0.5
percent_infective = 0.4
percent_remove = 0.1
percent_dead = 0.0
people = []

# simulation parameters
iterations = 1000
movement_speed = 1.00e-2
radius = 0.35

num_susceptibles = int(total_population * percent_susceptible)
num_infectives   = int(total_population * percent_infective)
num_removes      = int(total_population * percent_remove)
num_dead         = int(total_population * percent_dead)

# plot configuration
fig = plt.figure()
ax = fig.add_subplot(111, autoscale_on = False, xlim = (-1,1), ylim = (-1,1))
ax.set_xticklabels([])
ax.set_yticklabels([])
box = ax.get_position()
susceptible_coords = ax.plot([], [], label='Susceptible')[0]
infective_coords= ax.plot([], [], label='Infective')[0]
remove_coords = ax.plot([], [], label='Remove')[0]
dead_coords = ax.plot([], [], label='Dead')[0]

def init():
    # initialize the populations
    susceptibles = [Person(SUSCEPTIBLE) for _ in range(num_susceptibles)]
    infectives   = [Person(INFECTIVE)   for _ in range(num_infectives)]
    removes      = [Person(REMOVE)      for _ in range(num_removes)]
    dead         = [Person(DEAD)        for _ in range(num_dead)]

    # track the total population in one list (pointers to Person objects)
    global people 
    people = susceptibles + infectives + removes + dead

    # start with blank data
    susceptible_coords.set_data([], [])
    infective_coords.set_data([], [])
    remove_coords.set_data([], [])
    dead_coords.set_data([], [])

    return susceptible_coords, infective_coords, remove_coords, dead_coords

def update_coordinates(coordinate_obj, data, color, legend):

    # check to make sure that the data is not empty
    if len(np.shape(data)) == 2:
        coordinate_obj.set_data(data[:,0], data[:,1])
    else:
        coordinate_obj.set_data([], [])

    # data styling
    coordinate_obj.set_label(legend)
    coordinate_obj.set_alpha(0.5)
    coordinate_obj.set_marker('o')
    coordinate_obj.set_markerfacecolor(color)
    coordinate_obj.set_markersize(10)
    coordinate_obj.set_linestyle('')

def animate(iteration):
    global people, box

    # identify coordinates for each group of Person objects
    susceptibles = np.array([person.loc for person in people \
            if person.status is SUSCEPTIBLE])
    infectives = np.array([person.loc for person in people \
            if person.status is INFECTIVE])
    removes = np.array([person.loc for person in people \
            if person.status is REMOVE])
    dead = np.array([person.loc for person in people \
            if person.status is DEAD])

    # update the figure with new coordinates and statuses
    update_coordinates(susceptible_coords, susceptibles, 'green', 'Susceptible')
    update_coordinates(infective_coords, infectives, 'red', 'Infective')
    update_coordinates(remove_coords, removes, 'blue', 'Remove')
    update_coordinates(dead_coords, dead, 'black', 'Dead')

    # adjust the plot so that the legend is off to the bottom
    ax.set_position([box.x0, box.y0 + box.height * 0.1,
                         box.width, box.height * 0.9])
    ax.legend(loc='upper center', bbox_to_anchor=(0.5, -0.05),
                  fancybox=True, shadow=True, ncol=5)

    # actually update the simulation
    for person in people:
        person.update_status(people, radius)
        person.update_location(movement_speed)

    return susceptible_coords, infective_coords, remove_coords, dead_coords

# make an animation!
ani = animation.FuncAnimation(fig, animate, frames=iterations, interval=0, 
        blit=True, init_func=init)

plt.show()


