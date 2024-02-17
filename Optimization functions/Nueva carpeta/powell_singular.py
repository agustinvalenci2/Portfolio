import numpy as np

def extended_powell_singular_function(x):
    n = len(x)
    result = 0

    for i in range(0, n//4):
        term1 = (x[4*i-3] + 10*x[4*i-2])**2
        term2 = 5 * (x[4*i-1] - x[4*i])**2
        term3 = (x[4*i-2] - 2*x[4*i-1])**4
        term4 = 10 * (x[4*i-3] - x[4*i])**4
        result += term1 + term2 + term3 + term4

    return result

# Example usage
dimension = 4
variables = np.array([3, -1, 0, 1])

result = extended_powell_singular_function(variables)
print(f"The value of the Extended Powell Singular Function is: {result}")

from scipy.optimize import minimize

# Initial guess
initial_guess = np.ones(dimension)

# Minimize the Extended Powell Singular Function
result = minimize(extended_powell_singular_function, initial_guess, method='BFGS')

# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)

