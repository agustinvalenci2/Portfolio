import numpy as np
from scipy.optimize import minimize

def trigonometric_function(x):
    return np.sum(np.cos(x))

# Example usage
dimension = 3
variables = np.array([0, 0, 0])

result = trigonometric_function(variables)
print(f"The value of the Trigonometric Function is: {result}")

result = minimize(trigonometric_function, variables, method='Powell')

print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
