import numpy as np

def wood_function(x):
    term1 = 100 * (x[1] - x[0]**2)**2
    term2 = (1 - x[0])**2
    term3 = 90 * (x[3] - x[2]**2)**2
    term4 = (1 - x[2])**2
    term5 = 10 * (x[1] + x[3] - 2)**2
    term6 = (1/10) * (x[1] - x[3])**2
    return term1 + term2 + term3 + term4 + term5 + term6

# Example usage
variables = np.array([-3, -1, -3, -1])

from scipy.optimize import minimize

# Initial guess
initial_guess = np.array([-3, -1, -3, -1])

# Minimize the Wood function
result = minimize(wood_function, initial_guess, method='BFGS')

# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
