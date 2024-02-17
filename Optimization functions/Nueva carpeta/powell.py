import numpy as np
from scipy.optimize import minimize
def powell_badly_scaled(x):
    x1, x2, x3, x4 = x[0], x[1], x[2], x[3]
    term1 = (x1 + 10 * x2)**2
    term2 = 5 * (x3 - x4)**2
    term3 = (x2 - 2 * x3)**4
    term4 = 10 * (x1 - x4)**4
    return term1 + term2 + term3 + term4

# Example usage
variables = np.array([0, 1, 2, 3])
initial_guess = np.array([10, 1, 2, 3])

# Minimize the Powell Badly Scaled Function
result = minimize(powell_badly_scaled, initial_guess, method='BFGS')
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
