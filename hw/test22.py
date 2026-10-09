import matplotlib.pyplot as plt
import numpy as np

# Parameters
C = 80
n = 40  # Lower value keeps the triangulation manageable

# Joint-angle grids
q1_vals = np.linspace(0, 2 * np.pi, n)
q2_vals = np.linspace(0, np.pi / 2, n)
q3_vals = np.linspace(0, np.pi / 2, n)

q1, q2, q3 = np.meshgrid(
    q1_vals,
    q2_vals,
    q3_vals,
    indexing="ij"
)

# Forward kinematics
X = (
    C * np.cos(q1) * np.cos(q2)
    + 10
    * np.cos(q1 + 3 * np.pi / 2)
    * np.cos(q2)
    * np.cos(q3)
)

Y = (
    C * np.sin(q1) * np.cos(q2)
    + 10
    * np.cos(q1 + 3 * np.pi / 2)
    * np.sin(q2)
    * np.cos(q3)
)

Z = (
    C * np.sin(q2)
    + 10
    * np.sin(q1 + 3 * np.pi / 2)
    * np.sin(q3)
)

# Flatten the coordinates
x = X.ravel()
y = Y.ravel()
z = Z.ravel()

# Optional subsampling to improve plotting speed
max_points = 30000

if len(x) > max_points:
    rng = np.random.default_rng(1)
    indices = rng.choice(len(x), max_points, replace=False)

    x = x[indices]
    y = y[indices]
    z = z[indices]

# Create two projection plots
fig = plt.figure(figsize=(16, 7))

# --------------------------------------------------
# Projection onto the XY plane
# --------------------------------------------------
ax1 = fig.add_subplot(1, 2, 1, projection="3d")

# The projected Z coordinate is zero
z_xy = np.zeros_like(z)

ax1.plot_trisurf(
    x,
    y,
    z_xy,
    cmap="viridis",
    edgecolor="none",
    alpha=0.85
)

ax1.set_xlabel("X (units)")
ax1.set_ylabel("Y (units)")
ax1.set_zlabel("Projected Z (units)")
ax1.set_title("Reachable Region Projected onto the XY Plane")

ax1.set_zlim(-1, 1)
ax1.view_init(elev=90, azim=-90)

# --------------------------------------------------
# Projection onto the XZ plane
# --------------------------------------------------
ax2 = fig.add_subplot(1, 2, 2, projection="3d")

# The projected Y coordinate is zero
y_xz = np.zeros_like(y)

ax2.plot_trisurf(
    x,
    y_xz,
    z,
    cmap="plasma",
    edgecolor="none",
    alpha=0.85
)

ax2.set_xlabel("X (units)")
ax2.set_ylabel("Projected Y (units)")
ax2.set_zlabel("Z (units)")
ax2.set_title("Reachable Region Projected onto the XZ Plane")

ax2.set_ylim(-1, 1)
ax2.view_init(elev=0, azim=-90)

plt.tight_layout()
plt.show()

print("Minimum Z:", np.min(z))
print("Maximum Z:", np.max(z))
