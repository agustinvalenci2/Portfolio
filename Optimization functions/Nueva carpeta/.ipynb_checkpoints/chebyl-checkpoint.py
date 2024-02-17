import numpy as np
from numpy.polynomial import chebyshev

def chebyquad_function(x):
    n = len(x)
    chebyshev_polynomials = [chebyshev.Chebyshev([0] if i > 0 else [1], domain=[0, 1]) for i in range(n)]
    result = np.sum([poly(x) for poly in chebyshev_polynomials])**2
    return result

# Example usage
dimension = 5
from scipy.optimize import minimize

# Initial guess
initial_guess = np.random.rand(dimension)

# Minimize the Chebyquad function
result = minimize(chebyquad_function, initial_guess, method='BFGS')

# Print the result
# Print the result
print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)
