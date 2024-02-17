import numpy as np

def gaussian_function(x, A):
    """
    x: numpy array, representing the vector of variables
    A: numpy array, representing the positive definite matrix
    """
    exponent = -0.5 * np.dot(x, np.dot(A, x))
    return np.exp(exponent)

# Example usage
A_matrix = np.array([[1, 0.5], [0.5, 2]])  # Example positive definite matrix
variables = np.array([10, 2])  # Example vector of variables

result = gaussian_function(variables, A_matrix)
print(f"The value of the Gaussian function is: {result}")
from scipy.optimize import minimize

# Define the negative of the Gaussian function (since minimize finds the minimum)
negative_gaussian = lambda x: -gaussian_function(x, A_matrix)

# Initial guess
initial_guess = np.zeros(len(variables))

# Minimize the negative Gaussian function
result = minimize(negative_gaussian, initial_guess, method='BFGS')

# Print the result
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
