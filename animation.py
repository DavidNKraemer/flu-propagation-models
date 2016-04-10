from Person import *
import matplotlib.animation as animation
import matplotlib.pyplot as plt

plt.style.use('fivethirtyeight')

# populations
total_population = 100
percent_susceptible = 0.5
percent_infective = 0.4
percent_remove = 0.1
people = []

# simulation parameters
iterations = 10
iteration = 0
movement_speed = 2.5e-2
radius = 0.3

num_susceptibles = int(total_population * percent_susceptible)
num_infectives   = int(total_population * percent_infective)
num_removes      = int(total_population * percent_remove)

# plot configuration
fig = plt.figure()
ax = fig.add_subplot(111, autoscale_on = False, xlim = (-1,1), ylim = (-1,1))
susceptible_coords = ax.plot([], [], label='Susceptible')[0]
infective_coords= ax.plot([], [], label='Infective')[0]
remove_coords = ax.plot([], [], label='Remove')[0]

def init():
    susceptibles = [Person(SUSCEPTIBLE) for _ in range(num_susceptibles)]
    infectives = [Person(INFECTIVE) for _ in range(num_infectives)]
    removes = [Person(REMOVE) for _ in range(num_removes)]

    global people 
    people = susceptibles + infectives + removes

    susceptible_coords.set_data([], [])
    infective_coords.set_data([], [])
    remove_coords.set_data([], [])
    return susceptible_coords, infective_coords, remove_coords

def update_coordinates(coordinate_obj, data, color, legend):
    if len(np.shape(data)) == 2:
        coordinate_obj.set_data(data[:,0], data[:,1])
        coordinate_obj.set_label(legend)
        coordinate_obj.set_alpha(0.5)
        coordinate_obj.set_marker('o')
        coordinate_obj.set_markerfacecolor(color)
        coordinate_obj.set_markersize(10)
        coordinate_obj.set_linestyle('')
    else:
        coordinate_obj.set_data([], [])

def animate(iteration):
    global people
    susceptibles = np.array([person.loc for person in people \
            if person.status is SUSCEPTIBLE])
    infectives = np.array([person.loc for person in people \
            if person.status is INFECTIVE])
    removes = np.array([person.loc for person in people \
            if person.status is REMOVE])

    update_coordinates(susceptible_coords, susceptibles, 'green', 'Susceptible')
    update_coordinates(infective_coords, infectives, 'red', 'Infective')
    update_coordinates(remove_coords, removes, 'blue', 'Remove')
    ax.legend()

    for person in people:
        person.update_status(people, radius)
        person.update_location(movement_speed)

    return susceptible_coords, infective_coords, remove_coords
    
ani = animation.FuncAnimation(fig, animate, frames=iterations, interval=30, 
        blit=True, init_func=init)

plt.show()


