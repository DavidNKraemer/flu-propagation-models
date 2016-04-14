
# coding: utf-8

# In[1]:

import numpy as np
import matplotlib.pyplot as plt
plt.style.use('fivethirtyeight')


# In[ ]:




# In[2]:

get_ipython().magic('matplotlib inline')


# In[3]:

run simulate_data.py


# In[7]:

monte_carlo = np.load('simulation_data.npy')
dynamical = np.loadtxt('poplevels.csv',dtype=np.double,delimiter=',')


# In[8]:

mean_mc = np.mean(monte_carlo,axis=2)


# In[9]:

for i in range(3):
    plt.plot(dynamical[:,i],label=labels[i],color=colors[i])
    plt.plot(mean_mc[:,i], label=labels[i], color=colors[i])

plt.legend()


# $$
# f' = \alpha f \cdot s 
# $$

# In[ ]:



