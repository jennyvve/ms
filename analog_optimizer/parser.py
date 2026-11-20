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


from . import ExpressionConvex
from . import List
from . import Real


class ParseTree:
    def __init__(self, circuit: Circuit):
        self.constant_map = {}
        self.parse_map = {
            Mul: self.parse_tree_mul,
            Pow: self.parse_tree_pow,
            Add: self.parse_tree_add,
            Symbol: self.parse_tree_symbol,
        }
        self.circuit = circuit
        self.map_ints = {}

    def parse_tree_pow(self, a, c, constant):
        l = a.args[0]
        r = a.args[1]

        if not isinstance(l, Symbol):
            raise ValueError("Exponents are only supported on symbols.")
        if not isinstance(r, Integer) and 0 < r and r <= 5:
            raise ValueError("Non integer exponents are not supported.")

        ic_r = ic_p = self.circuit.mul()
        self.circuit.connect(self.map_ints[l], ic_p.a)

        for _ in range(r - 2):
            ic_n = self.circuit.mul()
            self.circuit.connect(self.map_ints[l], ic_n.a)
            self.circuit.connect(ic_n, ic_p.b)
            ic_p = ic_n

        self.circuit.connect(self.map_ints[l], ic_p.b)
        self.circuit.connect(ic_r, c)

    def parse_tree_mul(self, a, c, constant):
        ic_r = None
        constant = 1
        if len(a.args) > 2:  # for example axy..
            ic_r = ic_p = self.circuit.mul()
            flag = False
            for arg in a.args:
                if isinstance(arg, Number):
                    constant = arg
                elif isinstance(arg, Symbol):
                    if flag:
                        ic_n = self.circuit.mul()
                        self.circuit.connect(ic_n, ic_p.b)
                        ic_p = ic_n
                        flag = False
                    else:
                        flag = True
                    self.circuit.connect(self.map_ints[arg], ic_p.a)
                elif isinstance(arg, Pow):
                    l = arg.args[0]
                    r = arg.args[1]

                    if not isinstance(l, Symbol):
                        raise ValueError("Exponents are only supported on symbols.")
                    if not isinstance(r, Integer) and 0 < r and r <= 5:
                        raise ValueError("Non integer exponents are not supported.")

                    for _ in range(r):
                        if flag:
                            ic_n = self.circuit.mul()
                            self.circuit.connect(ic_n, ic_p.b)
                            ic_p = ic_n
                            flag = False
                        else:
                            flag = True
                        self.circuit.connect(self.map_ints[l], ic_p.a)
                else:
                    raise ValueError("Invalid tree, unsupported.")
            self.circuit.connect(ic_r, c, constant)
        else:
            if not isinstance(a.args[0], Number):
                raise ValueError("Invalid tree, unsupported.")

            self.parse(a.args[1], c, a.args[0])

    def parse_tree_add(self, a, c, constant):
        for arg in a.args:
            self.parse(arg, c, constant)

    def parse_tree_symbol(self, a, c, constant):
        self.circuit.connect(self.map_ints[a], c, constant)

    def parse(self, a, c, constant):
        if type(a) not in self.parse_map:
            raise ValueError(
                f"Unable to parse this expression, not all operations are implemented: {type(a)}."
            )
        self.parse_map[type(a)](a, c, constant)

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
                print(expr)
                self.parse(expr, self.map_ints[v], 1)

        return self.circuit
