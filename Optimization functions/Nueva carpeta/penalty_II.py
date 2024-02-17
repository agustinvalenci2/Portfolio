import numpy as np

def penalty_function_II(x, constraints, k=2):
    """
    x: numpy array, representing the vector of variables
    constraints: list of constraint functions
    k: penalty exponent (default is 2)
    """
    penalty = 0
    for constraint in constraints:
        penalty += max(0, constraint(x))**k
    return penalty

# Example usage with a simple constraint
def constraint1(x):
    return x[0] + x[1] - 2  # Example constraint: x + y - 2 >= 0

# Example usage
variables = np.array([1, 1])  # Example vector of variables

constraints = [constraint1]

result = penalty_function_II(variables, constraints)
print(f"The value of Penalty Function II is: {result}")
from scipy.optimize import minimize

# Define the negative of the Gaussian function (since minimize finds the minimum)
negative_penalti= lambda x: penalty_function_II(x, constraints)

# Initial guess
initial_guess = np.zeros(len(variables))

# Minimize the negative Gaussian function
result = minimize(negative_penalti, initial_guess, method='BFGS')

# Print the result
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
