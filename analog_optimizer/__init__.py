from typing import List
from typing import Tuple

from numbers import Number
from numbers import Real
from numbers import Rational


from .domain import Domain
from .domain import DomainLineRR
from .domain import DomainBoundaryType

DOMAIN_RR_LINE = Domain([DomainLineRR()])
DOMAIN_RR_PLANE = Domain([DomainLineRR()] * 2)

from .expression import ExpressionConvex
from .expression import Expression

from .r0mod import R0Module

from .parser import ParseTree
from .parser import Circuit
