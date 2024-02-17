import numpy as np

def gulf_function(x):
    term1 = 0.5 * (np.exp(-((x[0]-25)/4)**2)/2.5 + np.exp(-((x[0]-16)/2)**2))
    term2 = 0.5 * (np.exp(-((x[1]-15)/4)**2)/2.5 + np.exp(-((x[1]-20)/2)**2))
    term3 = 0.5 * (np.exp(-((x[2]-45)/4)**2)/2.5 + np.exp(-((x[2]-36)/2)**2))
    term4 = 0.5 * (np.exp(-((x[3]-50)/4)**2)/2.5 + np.exp(-((x[3]-25)/2)**2))
    return term1 + term2 + term3 + term4

# Example usage
variables = np.array([0, 0, 0, 0])

result = gulf_function(variables)
print(f"The value of the Gulf Function is: {result}")
from scipy.optimize import minimize

# Initial guess
initial_guess = np.zeros(4)

# Minimize the Gulf Function
result = minimize(gulf_function, initial_guess, method='BFGS')

# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)

