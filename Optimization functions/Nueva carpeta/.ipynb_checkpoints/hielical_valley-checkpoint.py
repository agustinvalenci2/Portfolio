import numpy as np

def helical_valley(x):
    t = np.arctan2(x[1], x[0]) / (2 * np.pi)
    z = x[2]
    return 100 * (z - 10 * t) ** 2 + (np.sqrt(x[0] ** 2 + x[1] ** 2) - 1) ** 2 + z ** 2

from scipy.optimize import minimize

# Initial guess
x0 = np.array([-10, 0, 10])

# Minimize the Helical Valley Function
result = minimize(helical_valley, x0, method='Powell')

print("Optimal solution:", result.x)
print("Optimal function value:", result.fun)

x = np.linspace(-15, 15, 100)
y = np.linspace(-15, 15, 100)
z = np.linspace(-15, 15, 100)

X, Y, Z = np.meshgrid(x, y, z)
W = np.zeros_like(X)

for i in range(len(x)):
    for j in range(len(y)):
        for k in range(len(z)):
            W[i, j, k] = helical_valley([X[i, j, k], Y[i, j, k], Z[i, j, k]])

# Plot the 3D surface plot
surface = ax.scatter(X, Y, Z, c=W, cmap='viridis', marker='o')
