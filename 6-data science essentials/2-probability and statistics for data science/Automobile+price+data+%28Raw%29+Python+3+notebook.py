
# coding: utf-8

# In[1]:

from azureml import Workspace

ws = Workspace()
ds = ws.datasets['Automobile price data (Raw)']
frame = ds.to_dataframe()


# In[2]:

frame


# In[3]:

import pandas as pd
import numpy as np


# In[4]:

cols = ['price', 'bore', 'stroke', 'horsepower', 'peak-rpm']


# In[5]:

## Convert the '?' to a nan
for column in cols:
    frame.loc[frame[column] == '?', column] = np.nan


# In[6]:

## Coerce columns to numeric
for col in cols:
    frame[col] = pd.to_numeric(frame[col])


# In[7]:

## Drop rows with missing values
frame.dropna(axis = 0, inplace = True)
print('dimensions = ' + str(frame.shape)) # print dimensions of the data frame
print(frame.dtypes) # print the data types of the columns


# In[8]:

def describe(df, col):
    ## Compute the summary stats
    desc = df[col].describe()
    
    ## Change the name of the 50% index to median
    idx = desc.index.tolist()
    idx[5] = 'median'
    desc.index = idx
    return desc


# In[9]:

describe(frame, 'price')


# In[10]:

def plotstats(df, col):
    import matplotlib.pyplot as plt
    
    ## Setup for plotting 2 charts one over the other
    fig, ax = plt.subplots(2, 1, figsize = (12, 8))
    
    ## Box plot
    df.dropna().boxplot(col, ax = ax[0], vert = False, return_type = 'dict')
    
    ## Histogram
    temp = df[col].as_matrix()
    ax[1].hist(temp, bins = 30, alpha = 0.7)
    plt.ylabel('Number of Cars')
    plt.xlabel(col)
    return [col]


# In[11]:

get_ipython().magic('matplotlib inline')
plotstats(frame, 'price')


# In[12]:

describe(frame, 'horsepower')


# In[13]:

plotstats(frame, 'horsepower')


# In[ ]:



