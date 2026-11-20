from . import Domain
from . import Real


class Expression:
    def __init__(self, domain: Domain):
        self.domain = domain

    def eval(self):
        raise NotImplementedError

    def _gradient(self):
        raise NotImplementedError

    def gradient(self, *args):
        for arg in args:
            if not self.domain.contains(arg):
                raise ValueError("Variable not in domain.")
        return self._gradient(*args)

    def __call__(self, *args) -> float:
        for arg in args:
            if not self.domain.contains(arg):
                raise ValueError("Variable not in domain.")
        return self.eval(*args)


class ExpressionConvex(Expression):
    """
    Let X ⊆ V be a convex set and f : X → R a function. We say that f is convex if for all x, y ∈ X
    and s ∈ [0, 1] the following inequality holds.
        f(x +s y) ≤ f(x) +s f(y)
    If V has a norm, then we say that f is strongly convex if there is an a ∈ RR with a > 0 and
        f(x +_s y) <= (f(x) +_s f(y)) - as(1 - s)||x - y||**2
    """

    def __init__(self, domain: Domain, alpha: Real):
        if alpha < 0:
            raise ValueError("Alpha should be non-negative.")
        super().__init__(domain)
        self.alpha = alpha

    def eval(self):
        raise NotImplementedError

    def _gradient(self):
        raise NotImplementedError

    def is_strong_convex(self):
        return self.alpha > 0

    def __call__(self, *args) -> float:
        for arg in args:
            if not self.domain.contains(arg):
                raise ValueError("Variable not in domain.")
        return self.eval(*args)

    def __add__(self, g: "ExpressionConvex") -> "ExpressionConvex":
        if not isinstance(g, ExpressionConvex):
            raise ValueError("The function g is not convex.")

        if not self.domain.equals(g.domain):
            raise ValueError("The domain of f and g are not equal.")

        expr = ExpressionConvex(
            self.domain,
            self.alpha + g.alpha,
        )
        expr.eval = lambda *args: self.eval(*args) + g.eval(*args)
        return expr

    def __rmul__(self, r: Real) -> "ExpressionConvex":
        if not r > 0:
            raise ValueError("r should be greater than 0.")
        expr = ExpressionConvex(
            self.domain,
            r * self.alpha,
        )
        expr.eval = lambda *args: r * self.eval(*args)
        return expr
