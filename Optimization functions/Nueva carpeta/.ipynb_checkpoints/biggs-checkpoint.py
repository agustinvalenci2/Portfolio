import numpy as np
from scipy.optimize import minimize

def biggs_exp6(x, a, y):
    m = len(a)
    result = 0.0
    
    for i in range(m):
        term = y[i] - np.exp(a[i] * x[0]) - np.exp(a[i] * x[1]) - 0.5 * x[2] * a[i]**2
        result += term**2
    
    return result

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
