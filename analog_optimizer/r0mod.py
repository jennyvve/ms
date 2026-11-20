from . import ExpressionConvex
from . import Real


class R0Module:

    @staticmethod
    def add(f: ExpressionConvex, g: ExpressionConvex):
        if not f.is_strong_convex():
            raise ValueError("f is not strong convex.")
        if not g.is_strong_convex():
            raise ValueError("g is not strong convex.")
        return f + g

    @staticmethod
    def scale(r: Real, f: ExpressionConvex):
        if not f.is_strong_convex():
            raise ValueError("f is not strong convex.")
        if not r > 0:
            raise ValueError("r should be greater than 0.")
        return r * f
