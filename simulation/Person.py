from random import seed
import numpy as np

seed(1)

# status markers 
SUSCEPTIBLE = 0
INFECTIVE = 1
REMOVE = 2
DEAD = 3

class Person:
    """
    This class models the behavior of a person in a grid world with disease 
    propagation. 

    Location and Movement
    ---
    A person spawns on the grid with a randomly chosen coordinate location. 
    Specifically, the xy-coordinate is sampled from a Uniform(-1,1) 
    distribution. Whenever the person moves in the grid, they get a random
    velocity vector and "walk" in that direction. This is based on how fast the
    person can walk, and the random velocity vector is sampled from a Norm(0,1)
    distribution. Movement is "bounded" to within the box [-1,1]x[-1,1], so a
    person can't just walk off the map.
    
    NOTE: A DEAD person does not move.

    Status
    ---
    A person is either one of four mutually exclusive statuses with respect to
    the disease:

        * SUSCEPTIBLE. This person does not have the disease, but can catch it.
        * INFECTIVE. This person has the disease and can infect others.
        * REMOVE. This person does not have the disease and is immune to it. 
        * DEAD. This person is dead.

    Disease transmission is stochastic, but the probability that a SUSCEPTIBLE 
    person contracts the disease is given by
    \[
        n_{r} \cdot c,
    \]
    where $n_{r}$ is the number of people within a radius $r$ from the person, 
    and $c$ is an underlying infectivity parameter. 

    Recovery from the disease, immunization, loss of immunization, and fatality
    are all stochastic as well, but this is determined exclusively by the 
    respective parameters given by the model.

    A note to folks new to Python. Every* object method passes an additional
    parameter, self, into the call. The parameter self is the object instance,
    which allows us to access its attributes (and other methods). In general, 
    when you see 
        def method(self):
            ...
    this means that in a script, you can write ClassObject.method()

    * This is not strictly true. Some methods do not need the self parameter,
    but every method here does.
    """

    # Underlying model parameters
    infection_rate = 0.02
    recovery_threshold = 0.1
    immunization_threshold = 1.0
    relapse_threshold = 0.1
    fatality_threshold = 1.0e-2

    def __init__(self, status):
        """
        The __init__ method is called whenever a new Person object is 
        initialized.
        
        Parameters:
            * self, the Person object
            * status, an initial disease status (int)
        Preconditions:
            * status is one of
                * SUSCEPTIBLE (1)
                * INFECTIVE (2)
                * REMOVE (3)
                * DEAD (4)
        Postconditions:
            * Person.loc is now a Numpy array of length 2
            * Person.status is now an int 
        """
        self.loc = -1 + np.random.rand(2) * 2
        self.status = status

    def update_location(self, speed=1.0):
        """
        Computes the new location for the Person object based off a given speed
        parameter.

        Parameters:
            * self, the Person object
            * speed, the "speed" of walking (float)
        Preconditions:
            * speed >= 0
        Postconditions:
            * Person.loc is updated to a new coordinate based off a randomly
              sampled velocity vector and the speed parameter.
            * Person.loc is still inside [-1,1]x[-1,1].
        """
        velocity_vector = np.random.randn(2)

        if self.status is DEAD:
            speed = 0

        self.loc += velocity_vector * speed

        # threshold out-of-bounds movements 
        # they just get stuck on the wall
        self.loc[self.loc > 1.0] = 1.0
        self.loc[self.loc < -1.0] = -1.0

    def distance(self, person):
        """
        Computes the standard Euclidean distance between the coordinates of the
        Person object and another Person object.

        Produces:
            distance, a float
        Parameters:
            * self, the Person object
            * person, another Person object
        Preconditions:
            * person is initialized
        Postconditions:
            * distance >= 0.0
        """
        return np.linalg.norm(self.loc - person.loc)

    def neighbors(self, people, radius):
        """
        Finds all of the neighbors of the Person object within a specified
        radius.

        Produces:
            neighbors, a list of Person objects
        Parameters:
            * self, the Person object
            * people, a list of Person objects
            * radius, a float
        Preconditions:
            * radius >= 0.0
        Postconditions:
            * for every Person p in neighbors, self.distance(p) < radius
        """
        neighbors = [person for person in people if self.distance(person) < radius]
        return neighbors

    def update_status(self, people, radius):
        """
        Updates the status of the Person object based off the other people in
        the simulation.

        Parameters:
            * self, the Person object
            * people, a list of Person objects
            * radius, a float
        Preconditions:
            * radius >= 0.0
        Postconditions:
            * Person.status is still one of
                * SUSCEPTIBLE (1)
                * INFECTIVE (2)
                * REMOVE (3)
                * DEAD (4)
        """
        if self.status is SUSCEPTIBLE:
            neighbors = self.neighbors(people, radius)
            self._update_as_susceptible(neighbors)
        elif self.status is INFECTIVE:
            self._update_as_infective()
        elif self.status is REMOVE:
            self._update_as_remove()
        else:
            self._update_as_dead()

    def _update_as_susceptible(self, neighbors):
        """
        Helper function for self.update_status for when the Person object is
        SUSCEPTIBLE.

        Parameters:
            * self, the Person object
            * neighbors, a list of Person objects
        Postconditions:
            * Person.status is either INFECTIVE or SUSCEPTIBLE
        """
        for person in neighbors:
            if person.status is INFECTIVE and np.random.rand() <= self.infection_rate:
                self.status = INFECTIVE
                break
            else:
                continue

    def _update_as_infective(self):
        """
        Helper function for self.update_status for when the Person object is
        INFECTIVE.

        Parameters:
            * self, the Person object
        Postconditions:
            * Person.status is either REMOVE, SUSCEPTIBLE, DEAD, or INFECTIVE
        """
        if np.random.rand() <= self.recovery_threshold:
            if np.random.rand() <= self.immunization_threshold:
                self.status = REMOVE
            else:
                self.status = SUSCEPTIBLE
        else:
            if np.random.rand() <= self.fatality_threshold:
                self.status = DEAD
            else:
                pass

    def _update_as_remove(self):
        """
        Helper function for self.update_status for when the Person object is
        REMOVE.

        Parameters:
            * self, the Person object
        Postconditions:
            * Person.status is either REMOVE or SUSCEPTIBLE
        """
        if np.random.rand() <= self.relapse_threshold:
            self.status = SUSCEPTIBLE
        else:
            pass

    def _update_as_dead(self):
        """
        Helper function for self.update_status for when the Person object is
        DEAD.

        Parameters:
            * self, the Person object
        Postconditions:
            * Person.status is DEAD. There ain't no zombies in this simulation!
        """
        pass
