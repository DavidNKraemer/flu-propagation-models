# Flu propagation models

This project contains all of the scripts for the MAT 306 Project on Disease
Propagation. Contributors:

* Evan Christianson
* David Kraemer
* Caleb Leedy
* Will Royle

# Overleaf links

* [Online LaTeX notes][1].
* [Executive Summary][2].
* [Technical Report][3].
* [Presentation][4].

# Using the Python simulation

The simulation files can be found in the `simulation` directory. The files are:

* [`Person.py`][py1]
* [`animation.py`][py2]
* [`simulation.py`][py3]

Basic usage for the animation is given by:

```
$ python3 simulation/animation.py 
```

Notice that this project is running on the Python 3 interpreter. The default
interpreter is Python 2. If you want to use an interactive interpreter, use:

```bash
$ ipython3 console
```

to launch the IPython console, and then

```bash
In [1]: run 'simulation/animation.py'
```

This allows you to access the environment variables used in the simulation. Not
that you have to manually close the simulation with `CTRL-C` a few times.

## [`Person.py`][py1]

This is the file that defines the `Person` class. The `Person` class has two
class attributes:

* `loc`, which is a Numpy ndarray with size (2,) that represents the class
  instance's location at any given time. Each coordinate is some number in
[-1,1].
* `status`, which is one of four options: SUSCEPTIBLE, INFECTIVE, REMOVE, DEAD.

Each person is represented by a point on a 2D grid. The model parameters, like
the infection rate, recovery rate, immunization probability, relapse rate, and
the fatality rate are specified as static class attributes (these are shared
across all Person objects, although you can alter the parameters for individual
objects).

## [`animation.py`][py2]

This file generates an animated plot of a Monte Carlo simulation with an array
of People objects interacting on a grid. 

 

[1]: https://www.overleaf.com/4824963fffdhs
[2]: https://www.overleaf.com/4853557jbmcvv
[3]: https://www.overleaf.com/4853603hjvrdn
[4]: https://www.overleaf.com/4872212fdpzyn

[py1]: simulation/Person.py
[py2]: simulation/animation.py
[py3]: simulation/simulation.py



<!--![](animation.gif)-->
