import numpy as np
import matplotlib.pyplot as plt

def tx(q1, q2, d):
    return d * np.sin(q2) * np.cos(q1)

def ty(q1, q2, d):
    return d * np.sin(q2) * np.sin(q1)

def tz(q1, q2, d):
    return d * np.cos(q1)


samples = 100
n = samples +1
x = np.arange(-100,100)
y = np.arange(-100,100)
X, Y = np.meshgrid(x,y)
Z = np.empty([200,200])
X, Y = np.meshgrid(x, y)

for i1 in range(1,n):
    for i2 in range(1,n):
        for i3 in range(1, n):
            d = (i3 / samples) * 80 + 20

            q2 = np.arcsin(i2/d)
            q1 = np.arccos(-i1/d + np.cos(q2))

            Z[i1][i2] = tz(q1, q2, d)

contours = plt.contour(X, Y, Z, levels=15, cmap="viridis")


plt.xlabel("X")
plt.ylabel("Y")
plt.title("Contour plot")
plt.axis("equal")

plt.show()