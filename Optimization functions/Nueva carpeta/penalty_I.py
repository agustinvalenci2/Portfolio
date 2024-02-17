import numpy as np

def penalty_function_I(x, constraints):
    """
    x: numpy array, representing the vector of variables
    constraints: list of constraint functions
    """
    penalty = 0
    for constraint in constraints:
        penalty += max(0, constraint(x))**2
    return penalty

# Example usage with a simple constraint
def constraint1(x):
    return x[0] + x[1] - 2  # Example constraint: x + y - 2 >= 0

# Example usage
variables = np.array([1, 1])  # Example vector of variables

constraints = [constraint1]

result = penalty_function_I(variables, constraints)
print(f"The value of Penalty Function I is: {result}")

dimension = 5
initial_guess = np.random.rand(dimension)



from scipy.optimize import minimize



# Minimize the Watson function
result = minimize(lambda x: penalty_function_I(x,constraints), initial_guess, method='BFGS')

print("Optimal x:", result.x)
print("Minimum value of the function:", result.fun)
