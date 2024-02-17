import numpy as np

def beale_function(X):
    x,y=X
    term1 = (1.5 - x + x*y)**2
    term2 = (2.25 - x + x*y**2)**2
    term3 = (2.625 - x + x*y**3)**2
    return term1 + term2 + term3

# Example usage
from scipy.optimize import minimize

# Initial guess
initial_guess = np.array([1.0, 1.0])

# Minimize the Beale function
result = minimize(beale_function, initial_guess, method='BFGS')

# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
