from math import inf
from math import exp

from enum import Enum

from analog_optimizer import Expression
from analog_optimizer import ExpressionConvex
from analog_optimizer import Real
from analog_optimizer import List
from analog_optimizer import DOMAIN_RR_LINE
from analog_optimizer import DOMAIN_RR_PLANE
from analog_optimizer import R0Module
from analog_optimizer import Circuit
from analog_optimizer import ParseTree

from matplotlib.collections import LineCollection
from matplotlib import pyplot as plt

from pybrid.lucipy import LUCIDAC

from sympy import symbols

import numpy as np

def colored_line(x, y, c, ax=None, **lc_kwargs):
    xy = np.stack((x, y), axis=-1)
    xy_mid = np.concat(
        (xy[0, :][None, :], (xy[:-1, :] + xy[1:, :]) / 2, xy[-1, :][None, :]), axis=0
    )
    segments = np.stack((xy_mid[:-1, :], xy, xy_mid[1:, :]), axis=-2)
    lc_kwargs["array"] = c
    lc = LineCollection(segments, **lc_kwargs)
    ax = ax or plt.gca()
    ax.add_collection(lc)
    return lc

class ExpressionPolynomialLinear(Expression):
    """f(x) = a + b * x"""

    def __init__(self, a: Real, b: Real):
        super().__init__(DOMAIN_RR_LINE)
        self.a = a
        self.b = b

    def eval(self, x: List[Real]) -> Real:
        return self.a + x[0] * self.b

    def gradient(self):
        return NotImplementedError


Vec1 = List[Real]
Vec2 = List[Real]


class ExpressionQuadradicBivariate(ExpressionConvex):
    """f(x) = ax^2 + by^2 + cxy + dx + ey + f"""

    def __init__(
        self, alpha: Real, a: Real, b: Real, c: Real, d: Real, e: Real, f: Real
    ):
        super().__init__(DOMAIN_RR_PLANE, alpha)
        self.a = a
        self.b = b
        self.c = c
        self.d = d
        self.e = e
        self.f = f
        # H_f(x) =  (e_1, e_2) * (2a, 2b)^T + (e1, e_2) * (c, c)^T
        # at least some validation on whether the expression is convex.
        det = 2 * self.a * 2 * self.b + self.c**2
        if not ((2 * self.a) > 0) or not (det > 0):
            raise ValueError(
                "Expression is not convex, the hessian is not positive semidefinite. "
            )

    def eval(self, x: Vec2) -> Real:
        return (
            self.a * x[0] ** 2
            + self.b * x[1] ** 2
            + self.c * x[0] * x[1]
            + self.d * x[0]
            + self.e * x[1]
            + self.f
        )

    def _gradient(self) -> Vec2:
        x, y = symbols("x, y")
        return [
            (2 * self.a * x + self.c * y + self.d).simplify(),
            (2 * self.b * y + self.c * x + self.e).simplify(),
        ]


class ExpressionQuarticBivariate(ExpressionConvex):
    """f(x) = x^4 + y^4 - 4xy"""

    def __init__(self, alpha: Real):
        super().__init__(DOMAIN_RR_PLANE, alpha)

    def eval(self, x: Vec2) -> Real:
        return x[0] ** 4 + x[1] ** 4 - 4 * x[0] * x[1]

    def _gradient(self) -> Vec2:
        x, y = symbols("x, y")
        return {
            x: (4 * x**3 - 4 * y).simplify(),
            y: (4 * y**3 - 4 * x).simplify(),
        }


class ExpressionExponential(ExpressionConvex):
    """f(x) = e^(a * x + b)"""

    def __init__(self, alpha: Real, a: Real, b: Real):
        super().__init__(DOMAIN_RR_PLANE, alpha)
        self.a = a
        self.b = b

    def eval(self, x: Real) -> Real:
        return exp(self.a * x + self.b)

    def _gradient(self, x: Real) -> Vec1:
        return [self.a * (self.a * x + self.b) * self.eval(x)]


g = ExpressionQuarticBivariate(1)

luci = LUCIDAC("tcp://192.168.1.5:5732")
c = luci.create_circuit()
p = ParseTree(c)
c = p.make_circuit(g, [-0.6, -0.4])

sample_rate = 100_000
run_time = 0.0001
luci.set_daq(num_channels=2, sample_rate=sample_rate)
luci.set_run(op_time=int(run_time * 1_000_000_000))
run = luci.run()

fig, (ax1, ax2) = plt.subplots(1,2)
color = np.linspace(0, 2, len(run.data[0]))
lines = colored_line(run.data[0], run.data[1], color, ax1, linewidth=1, cmap='plasma')
ax1.set_xlabel("x")
ax1.set_ylabel("y")

t = np.arange(len(run.data[0])) / sample_rate
ax2.plot(t, run.data[0], label="x")
ax2.plot(t, run.data[1], label="y")
ax1.set_xlabel("t")
ax2.set_ylabel("amplitude")
ax2.legend()

fig.suptitle("Plot of the gradient flow of g(x).")
fig.tight_layout()
plt.show()
