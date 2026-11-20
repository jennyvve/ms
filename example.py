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


from sympy import symbols
from sympy import srepr


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


linear_expr_1 = ExpressionPolynomialLinear(5, 10)
print(linear_expr_1([5]))
quadradic_expr_1 = ExpressionQuadradicBivariate(1, 5, 5, 5, 5, 5, 5)
quadradic_expr_2 = ExpressionQuadradicBivariate(1, 5.1, 5, 5, 5, 5, 5)

quadradic_addition = R0Module.add(quadradic_expr_1, quadradic_expr_2)
print(quadradic_addition([5, 5]))
quadradic_scale = R0Module.scale(0.5, quadradic_expr_2)
print(quadradic_scale([5, 5]))
print(srepr(quadradic_expr_2.gradient()))


g = ExpressionQuarticBivariate(1)

c = Circuit(mac="bla")
p = ParseTree(c)
c = p.make_circuit(g, [1, 2])
