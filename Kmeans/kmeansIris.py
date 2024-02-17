
# Code from Chapter 14 of Machine Learning: An Algorithmic Perspective (2nd Edition)
# by Stephen Marsland (http://stephenmonika.net)

# You are free to use, change, or redistribute the code in any way you wish for
# non-commercial purposes, but please maintain the name of the original author.
# This code comes with no warranty of any kind.

# Stephen Marsland, 2008, 2014

# Modified by Kevin S. Xu, 2021

# Examples of using the k-means algorithm on the Iris dataset

import numpy as np
import matplotlib.pyplot as plt

plt.rcParams.update({'font.size': 20, 'lines.markersize': 10,
                      'lines.linewidth': 3})

iris = np.loadtxt('iris_proc.csv',delimiter=',')
iris[:,:4] = iris[:,:4]-iris[:,:4].mean(axis=0)
imax = np.concatenate((iris.max(axis=0)*np.ones((1,5)),
                       iris.min(axis=0)*np.ones((1,5))),axis=0).max(axis=0)
iris[:,:4] = iris[:,:4]/imax[:4]

target = iris[:,4]

order = list(range(np.shape(iris)[0]))
np.random.shuffle(order)
iris = iris[order,:]
target = target[order]

train = iris[::2,0:4]
traint = target[::2]
test = iris[1::2,0:4]
testt = target[1::2]

#%% Cluster the training data and predict cluster on test data
import kmeans as km
kmIris = km.kmeans(3,train)
kmIris.kmeanstrain(train)
cluster = np.ravel(kmIris.kmeansfwd(test))

#%% Scatter plot of sepal length and width colored by cluster estimate
plt.figure()
clu0 = np.where(cluster==0)
clu1 = np.where(cluster==1)
clu2 = np.where(cluster==2)
plt.plot(test[clu0,0],test[clu0,1],'go')
plt.plot(test[clu1,0],test[clu1,1],'bo')
plt.plot(test[clu2,0],test[clu2,1],'ro')
plt.title('Colored by estimated cluster')
plt.tight_layout()

#%% Scatter plot of sepal length and width colored by actual classes
plt.figure()
class0 = np.where(testt==0)
class1 = np.where(testt==1)
class2 = np.where(testt==2)
plt.plot(test[class0,0],test[class0,1],'go')
plt.plot(test[class1,0],test[class1,1],'bo')
plt.plot(test[class2,0],test[class2,1],'ro')
plt.title('Colored by actual classes')
plt.tight_layout()
