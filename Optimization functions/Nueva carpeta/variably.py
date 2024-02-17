import numpy as np

def variably_dimensioned_function(x):
    return np.sum(x**2)

from scipy.optimize import minimize

# Initial guess
initial_guess = np.array([10,5,1,15])
# Minimize the Three-Dimensional Box Function
result = minimize(variably_dimensioned_function, initial_guess, method='BFGS')

# Print the result
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
