import matplotlib.pyplot as plt
import numpy as np

# 1. Parameter setup
C = 80  # Arm length scale factor

# Define joint angle grids for p and q in radians
p_vals = np.linspace(0, 2 * np.pi, 300)
q_vals = np.linspace(0, np.pi / 2, 300)
p, q = np.meshgrid(p_vals, q_vals)

# 2. Compute 3D vector coordinates
X = C * np.cos(p) * np.cos(q)
Y = C * np.sin(p) * np.cos(q)
Z = C * np.sin(q)

# 4. Visualization
fig = plt.figure(figsize=(15, 6))

# Left Plot: 3D Surface with Contour Projections in Cartesian Space (X, Y, Z)
ax1 = fig.add_subplot(1, 1, 1, projection="3d")
surf = ax1.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8, edgecolor="none")

C = 20  # Arm length scale factor

# Define joint angle grids for p and q in radians
p_vals = np.linspace(0, np.pi, 300)
q_vals = np.linspace(0, np.pi, 300)
p, q = np.meshgrid(p_vals, q_vals)

# 2. Compute 3D vector coordinates
X = C * np.cos(p) * np.cos(q)
Y = C * np.sin(p) * np.cos(q)
Z = C * np.sin(q)

surf = ax1.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8, edgecolor="none")

# Project contours onto base planes

ax1.set_xlim([-100, 100])
ax1.set_ylim([-100, 100])
ax1.set_zlim([0, 100])
ax1.set_xlabel("X (units)")
ax1.set_ylabel("Y (units)")
ax1.set_zlabel("Z (units)")
ax1.set_title("3D Reach Surface of Robot Arm Tip ($C = 50$)")




plt.tight_layout()
plt.show()