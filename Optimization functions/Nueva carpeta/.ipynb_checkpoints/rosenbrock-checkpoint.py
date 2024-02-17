import numpy as np
from scipy.optimize import minimize
def extended_rosenbrock_function(x):
    n = len(x)
    result = 0

    for i in range(n-1):
        term1 = 100 * (x[i+1] - x[i]**2)**2
        term2 = (1 - x[i])**2
        result += term1 + term2

    return result

# Example usage
dimension = 3
variables = np.array([1, 1, 1])

result = extended_rosenbrock_function(variables)
print(f"The value of the Extended Rosenbrock Function is: {result}")

result = minimize(extended_rosenbrock_function, variables, method='Powell')

print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
