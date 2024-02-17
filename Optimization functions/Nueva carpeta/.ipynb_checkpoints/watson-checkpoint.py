import numpy as np

def watson_function(x):
    n = len(x)
    result = 0

    for i in range(1, n):
        term1 = (x[i-1] - 1)**2 * (1 - np.exp(-x[i-1]**2))
        term2 = 10 * ((x[i-1] / np.sqrt(i)) - np.exp(-x[i-1]**2 / np.sqrt(i)))**2
        result += term1 + term2

    return result

# Example usage
dimension = 5
variables = np.random.rand(dimension)

result = watson_function(variables)

from scipy.optimize import minimize

# Initial guess
initial_guess = np.zeros(dimension)

# Minimize the Watson function
result = minimize(watson_function, initial_guess, method='BFGS')

print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)

