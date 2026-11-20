from sympy import Mul
from sympy import Pow
from sympy import Add
from sympy import Symbol
from sympy import Number
from sympy import Integer
from sympy import Float
from sympy import simplify
from sympy import srepr
from sympy import evaluate

from pybrid.lucipy import Circuit
from pybrid.lucipy.elements import _MulInput


from . import ExpressionConvex
from . import List
from . import Real


class ParseTree:
    def __init__(self, circuit: Circuit):
        self.constant_map = {}
        self.parse_map = {
            Mul: self.parse_tree_mul,
            Add: self.parse_tree_add,
            Symbol: self.parse_tree_symbol,
        }
        self.connected_map = []
        self.circuit = circuit
        self.map_ints = {}

    def connect(self, component1, component2, weight=1):
        if isinstance(component2, _MulInput) and component2 in self.connected_map:
            raise ValueError("Cannot reconnect multiplier.")
        print(f"self.circuit.connect({component1},{component2},weight={weight})")
        self.circuit.connect(component1, component2, weight=float(weight))
        self.connected_map.append(component2)

    def parse_tree_mul(self, expr, component, constant=1):
        args = expr.args
        if isinstance(args[0], Number):
            constant = args[0]
            args = args[1:]

        if len(args) == 1:
            return self.parse(args[0], component, constant)

        mul_prev = self.circuit.mul()
        self.connect(mul_prev, component, weight=constant)
        for arg in args[:-1]:
            if mul_prev.a in self.connected_map:
                mul_new = self.circuit.mul()
                self.connect(mul_new, mul_prev.b)
                mul_prev = mul_new
            self.parse(arg, mul_prev.a, 1)
        self.parse(args[-1], mul_prev.b, 1)

    def parse_tree_add(self, expr, component, constant=1):
        for arg in expr.args:
            self.parse(arg, component, constant)

    def parse_tree_symbol(self, expr, component, constant=1):
        self.connect(self.map_ints[expr], component, weight=constant)

    def parse(self, expr, component, constant=1):
        if type(expr) not in self.parse_map:
            raise ValueError(
                f"Unable to parse this expression, not all of its operations are implemented: {type(expr)}."
            )
        self.parse_map[type(expr)](expr, component, constant)

    def make_circuit(self, f: ExpressionConvex, initial_condition: List[Real]):
        if not f.is_strong_convex():
            raise ValueError("f is not strong convex.")

        gradient = f.gradient()
        for i, (v, _) in enumerate(gradient.items()):
            self.map_ints.update({v: self.circuit.int(ic=initial_condition[i])})

        for i, (v, e) in enumerate(gradient.items()):
            expr = simplify(e)
            with evaluate(False):
                expr = expr.replace(
                    lambda x: x.is_Pow and x.exp > 0,
                    lambda x: Mul(*[x.base] * x.exp),
                )
                self.parse(expr, self.map_ints[v], 1)

        return self.circuit
