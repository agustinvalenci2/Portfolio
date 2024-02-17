import numpy as np

def brown_badly_scaled(x):
    n = len(x)
    result = 0

    for i in range(n-1):
        term1 = (x[i]**2)**(x[i+1]**2 + 1)
        term2 = (x[i+1]**2)**(x[i]**2 + 1)
        result += term1 + term2

    return result

# Example usage
dimension = 3
variables = np.array([1, 20, 3])

result = brown_badly_scaled(variables)
print(f"The value of the Brown Badly Scaled Function is: {result}")

from scipy.optimize import minimize

# Initial guess
initial_guess = np.ones(dimension)

# Minimize the Brown Badly Scaled Function
result = minimize(brown_badly_scaled, initial_guess, method='BFGS')



print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
