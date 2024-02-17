from sklearn.cluster import KMeans
from sklearn.metrics import mean_squared_error
import pandas as pd
import kmeans
import kmeansIris 
import numpy as np
import matplotlib.pyplot as plt

def kernelKmeans(kernel,k,X,maxIterations=100):
    K=[]
    
    for i in range(len(X)):
        aux=[]
        for j in range(len(X)):
            aux.append(kernel(np.dot(X[i],X[j])))
        K.append(list(aux))
    K=np.array(K)
    X_train, X_test, R_train, R_test = K[::2],K[1::2],X[::2],X[1::2]
    model = kmeans.kmeans(k, X_train)
    model.kmeanstrain(X_train,maxIterations)
    
    return model,X_train, X_test, R_train, R_test
kmIris,X_train,X_test, R_train, R_test=kernelKmeans(lambda x:(x),3,kmeansIris.iris)


cluster = np.ravel(kmIris.kmeansfwd(X_test))
#%% Scatter plot of sepal length and width colored by cluster estimate
plt.figure()
clu0 = np.where(cluster==0)
clu1 = np.where(cluster==1)
clu2 = np.where(cluster==2)
plt.plot(R_test[clu0,0],R_test[clu0,1],'go')
plt.plot(R_test[clu1,0],R_test[clu1,1],'bo')
plt.plot(R_test[clu2,0],R_test[clu2,1],'ro')
plt.title('Colored by estimated cluster')
plt.tight_layout()
from sklearn.metrics.cluster import rand_score
rand_score(kmeansIris.testt,cluster)
