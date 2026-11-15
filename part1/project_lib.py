from typing import List

from sympy import symbols, Function

import sympy as sym

""" This is just a start, nothing is finished here.

"""


class Domain:
    def __init__(self, left, left_closed, right, right_closed):
        self.left = left
        self.left_closed = left_closed
        self.right = right
        self.right_closed = right_closed

    def equals(self, domain) -> bool:
        return (
            self.left == domain.left
            and self.left_closed == domain.left_closed
            and self.right == domain.right
            and self.right_closed == domain.right_closed
        )

    def __str__(self):
        return f"{'[' if self.left_closed else '('} {self.left}, \
            {self.right}, {']' if self.right_closed else ')'}"


class DomainClosed(Domain):
    def __init__(self, left, right):
        Domain.__init__(self, left, True, right, True)


class DomainOpen(Domain):
    def __init__(self, left, right):
        Domain.__init__(self, left, False, right, False)


class Variable:
    def __init__(self, name: str, domain: Domain):
        self.symbol = sym.Symbol(name)
        self.domain = domain


class Function:
    def __init__(self, expression: str, variables: List[Variable]):
        self.expression = expression
        self.variables = variables


class FunctionConvex(Function):
    def __init__(self, strong: bool, *args, **kwargs):
        Function.__init__(self, args, kwargs)
        self.strong = strong


var_x = Variable("x", DomainClosed("R", "R"))

pol_1 = FunctionConvex(
    strong=True,
    expression=var_x.symbol**2,
    variables=[var_x],
)

e = 
print()
