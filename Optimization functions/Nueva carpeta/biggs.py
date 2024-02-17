import numpy as np
from scipy.optimize import minimize

def biggs_exp6_function(x, t, y):
    return np.sum((np.exp(-t * x[0]) - y)**2)

# Define example values for a and y
a_values = np.array([0.1, 0.2, 0.2])
y_values = np.array([1.0, 2.0, 3.0])

# Define an initial guess for x
initial_guess = np.array([1.0, 1.0, 1.0])

# Use scipy's minimize to find the minimum of the function
result = minimize(biggs_exp6, initial_guess, args=(a_values, y_values), method='trust-constr')

# Print the result
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
