import matplotlib.pyplot as plt
import numpy as np

# 1. Parameter setup
C = 80  # Arm length scale factor
C = 20  # Arm length scale factor

q1_vals = np.linspace(0, 2 * np.pi, 300)
q2_vals = np.linspace(0, np.pi / 2, 300)
q3_vals = np.linspace(0, np.pi / 2, 300)
q1, q2, q3 = np.meshgrid(q1_vals, q2_vals, q3_vals)

X = C * np.cos(q1) * np.cos(q2) + 10 * np.cos(q1 + ((3 * np.pi) / 2)) * np.cos(q2) * np.cos(q3)
Y = C * np.sin(q1) * np.cos(q2) + 10 * np.cos(q1 + ((3 * np.pi) / 2)) * np.sin(q2) * np.cos(q3)
Z = C * np.sin(q2) + 10 * np.sin(q1 + ((3 * np.pi) / 2)) * np.sin(q3)




fig = plt.figure(figsize=(15, 6))
ax1 = fig.add_subplot(1, 1, 1)
surf = ax1.plot_surface(X, Y, Z, cmap="viridis", alpha=0.8, edgecolor="none")
ax1.set_xlim([-100, 100])
ax1.set_ylim([-100, 100])
ax1.set_zlim([0, 100])
ax1.set_xlabel("X (units)")
ax1.set_ylabel("Y (units)")
ax1.set_zlabel("Z (units)")
ax1.set_title("3D Reach Surface of Robot Arm Tip ($C = 50$)")

plt.tight_layout()
plt.show()