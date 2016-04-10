from random import seed
import numpy as np

seed(1)

# status markers 
SUSCEPTIBLE = 0
INFECTIVE = 1
REMOVE = 2

class Person:
    infection_rate = 0.05
    recovery_threshold = 0.1
    immunization_threshold = 1.0
    relapse_threshold = 0.1

    def __init__(self, status):
        self.loc = -1 + np.random.rand(2) * 2
        #self.loc =  np.random.randn(2) / 2
        self.status = status

    def update_location(self, speed=1.0):
        velocity_vector = np.random.randn(2)
        self.loc += velocity_vector * speed

        # threshold out-of-bounds movements 
        # they just get stuck on the wall
        self.loc[self.loc > 1.0] = 1.0
        self.loc[self.loc < -1.0] = -1.0

    def distance(self, person):
        return np.linalg.norm(self.loc - person.loc)

    def neighbors(self, people, radius):
        neighbors = [person for person in people if self.distance(person) < radius]
        return neighbors

    def update_status(self, people, radius):
        neighbors = self.neighbors(people, radius)
        if self.status is SUSCEPTIBLE:
            self._update_as_susceptible(neighbors)
        elif self.status is INFECTIVE:
            self._update_as_infective()
        else:
            self._update_as_remove()

    def _update_as_susceptible(self, neighbors):
        for person in neighbors:
            if person.status is INFECTIVE and np.random.rand() <= self.infection_rate:
                self.status = INFECTIVE
                break
            else:
                continue

    def _update_as_infective(self):
        if np.random.rand() <= self.recovery_threshold:
            if np.random.rand() <= self.immunization_threshold:
                self.status = REMOVE
            else:
                self.status = SUSCEPTIBLE
        else:
            pass

    def _update_as_remove(self):
        if np.random.rand() <= self.relapse_threshold:
            self.status = SUSCEPTIBLE
        else:
            pass




