import numpy as np

def brown_and_dennis(x, t, W):
    n = len(x)
    result = 0

    for i in range(n-1):
        term1 = (x[i]**2)**(x[i+1]**2 + 1)
        term2 = (x[i+1]**2)**(x[i]**2 + 1)
        result += term1 + term2

    quadratic_term = np.dot((x - t), np.dot(W, (x - t)))

    return result + quadratic_term

# Example usage
dimension = 3
variables = np.array([1, 2, 3])
target_vector = np.array([1, 20, 13])
weight_matrix = np.eye(dimension)  # Identity matrix in this example

result = brown_and_dennis(variables, target_vector, weight_matrix)
print(f"The value of the Brown and Dennis Function is: {result}")
from scipy.optimize import minimize

# Initial guess
initial_guess = np.ones(dimension)

# Minimize the Brown and Dennis Function
result = minimize(brown_and_dennis, initial_guess, args=(target_vector, weight_matrix), method='BFGS')

# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
