from sklearn.cluster import KMeans
from sklearn.metrics import mean_squared_error
import pandas as pd
import kmeans
import kmeansIris 
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.mixture import GaussianMixture

t=range(2,5)
F=[]
S=[]
for i in t:
    s = GaussianMixture(n_components=i, random_state=0,covariance_type="spherical").fit(kmeansIris.iris)
    f = GaussianMixture(n_components=i, random_state=0,covariance_type='full').fit(kmeansIris.iris)
    S.append(s.bic(kmeansIris.iris))
    F.append(f.bic(kmeansIris.iris))
plt.grid()
plt.plot(t,S,'r')
plt.plot(t,F,'b')
