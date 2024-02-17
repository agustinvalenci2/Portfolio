import numpy as np

def three_dimensional_box(X):
    x,y,z=X
    term1 = (x**2 + y - 11)**2
    term2 = (x + y**2 - 7)**2
    term3 = z**2
    return term1 + term2 + term3

# Example usage
x_test, y_test, z_test = 0, 0, 0

result = three_dimensional_box([x_test, y_test, z_test])
print(f"The value of the Three-Dimensional Box Function is: {result}")
from scipy.optimize import minimize

# Initial guess
initial_guess = np.zeros(3)

# Minimize the Three-Dimensional Box Function
result = minimize(three_dimensional_box, initial_guess, method='BFGS')

# Print the result
print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
