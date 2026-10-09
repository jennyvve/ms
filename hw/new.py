import matplotlib.pyplot as plt
import numpy as np

def tx(d,q1,q2,q3):
    return d * np.cos(q1) * np.cos(q2) + 10 * np.cos(q1 + ((3 * np.pi) / 2)) * np.cos(q2) * np.cos(q3)

def ty(d,q1,q2,q3):
    return d * np.sin(q1) * np.cos(q2) + 10 * np.cos(q1 + ((3 * np.pi) / 2)) * np.sin(q2) * np.cos(q3)

def tz(d,q1,q2,q3):
    return d * np.sin(q2) + 10 * np.sin(q1 + ((3 * np.pi) / 2)) * np.sin(q3)

n = 50
D = np.linspace(20, 80, n) 
Q1 = np.linspace(-np.pi,  np.pi, n)
Q2 = np.linspace(0, np.pi / 2 , n)
Q3 = np.linspace(-np.pi,  np.pi, n)

X = np.arange(-100, 100)
Y = np.arange(-100, 100)
X, Y = np.meshgrid(X,Y)
Z = np.empty([200, 200])
Z[:] = np.nan
Z2 = np.empty([200, 200])
Z2[:] = np.nan

for d in D:
    for q1 in Q1:
        for q2 in Q2:
            for q3 in Q3:
                x = round(tx(d,q1,q2,q3))
                y = round(ty(d,q1,q2,q3))
                z = round(tz(d,q1,q2,q3))
                Z[y+100][x+100] = z
                Z2[z+100][x+100] = y

from matplotlib import colors as c
cMap = c.ListedColormap(['black'])

plt.pcolormesh(X, Y, Z, cmap=cMap)
plt.tight_layout()
plt.axis([-100, 100, -100, 100])
plt.xlabel("x")
plt.ylabel("y")
plt.show()

X = np.arange(-100, 100)
Y = np.arange(-100, 100)
X, Y = np.meshgrid(X,Y)
plt.pcolormesh(X, Y, Z2, cmap=cMap)
plt.tight_layout()
plt.axis([-100, 100, -20, 100])
plt.xlabel("x")
plt.ylabel("z")
plt.show()