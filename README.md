This project contains all of the scripts for the MAT 306 Project on Disease
Propagation. Contributors:

* Evan Christianson
* David Kraemer
* Caleb Leedy
* Will Royle

# Using the Matlab Simulation

We use four files to conduct the deterministic model results in Matlab:

* [`Baseline_Model.m`][mat1]
* [`cost_consideration.m`][mat2]
* [`Sensitivity.m`][mat3]
* [`Sensitivity_Script.m`][mat4]


## [`Baseline_Model.m`][mat1]

This file contains the simulations of the deterministic model. It creates plots for the population-type proportions over the course of a provided lengthof time. 

## [`cost_consideration.m`][mat2]

This file contains the variations of our deterministic model. The script simulates the models with parameters that are initialized at the beginning of the file. While the `Baseline_Model.m` plots the population levels of each model over time the `cost_consideration.m` file allows for an easier comparison between net costs to the college.

After completing the simulation one is able to plot how making more people immune to the disease alters the total cost to the college. 

## [`Sensitivity.m`][mat3]

This function conducts a sensitivity analysis for each parameter on each population type. 

## [`Sensitivity_Script.m`][mat4]

This script calls the `Sensitivity.m` function for different initial values of parameters.

# Using the Python Simulation

The simulation files can be found in the `simulation` directory. The files are:

* [`Person.py`][py1]
* [`setup.py`][py0]
* [`animation_simulation.py`][py2]
* [`plot_simulation.py`][py3]
* [`data_simulation.py`][py4]
* [`analysis.py`][py5]

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

[py1]: simulation/Person.py
[py2]: simulation/animation.py
[py3]: simulation/simulation.py

[mat1]: Baseline_Model.m
[mat2]: cost_consideration.m
[mat3]: Sensitivity.m
[mat4]: Sensitivity_Script.m
