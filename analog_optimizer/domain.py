from enum import Enum

from . import Real
from . import Number
from . import List


class DomainBoundaryType(Enum):
    OPEN = 1
    CLOSED = 2


class DomainLine:
    def __init__(
        self,
        left: Number,
        left_closed: DomainBoundaryType,
        right: Number,
        right_closed: DomainBoundaryType,
        instance: Number,
    ):
        if not isinstance(left, instance):
            raise AttributeError("Domain left boundary is not of the expected type!")
        if not isinstance(right, instance):
            raise AttributeError("Domain right boundary is not of the expected type!")
        self.left = left
        self.left_closed = left_closed
        self.right = right
        self.right_closed = right_closed
        self.instance = instance

    def equals(self, domain_line: "DomainLine"):
        return (
            self.left == domain_line.left
            and self.left_closed == domain_line.left_closed
            and self.right == domain_line.right
            and self.right_closed == domain_line.right_closed
            and self.instance == domain_line.instance
        )

    def contains(self, x: Number):
        if not isinstance(x, self.instance):
            return False

        if (
            self.left_closed is DomainBoundaryType.OPEN
            and self.right_closed is DomainBoundaryType.OPEN
        ):
            return self.left < x and x < self.right
        elif (
            self.left_closed is DomainBoundaryType.OPEN
            and self.right_closed is DomainBoundaryType.CLOSED
        ):
            return self.left < x and x <= self.right
        elif (
            self.left_closed is DomainBoundaryType.CLOSED
            and self.right_closed is DomainBoundaryType.OPEN
        ):
            return self.left <= x and x < self.right

        return self.left <= x and x <= self.right


class DomainLineClosed(DomainLine):
    def __init__(self, left: float, right: float):
        super().__init__(
            left, DomainBoundaryType.CLOSED, right, DomainBoundaryType.CLOSED, Real
        )


class DomainLineOpen(DomainLine):
    def __init__(self, left: float, right: float):
        super().__init__(
            left, DomainBoundaryType.OPEN, right, DomainBoundaryType.OPEN, Real
        )


class DomainLineRR(DomainLineOpen):
    def __init__(self):
        super().__init__(
            float("-inf"),
            float("inf"),
        )


class Domain:
    def __init__(self, domain: list[DomainLine]):
        if not domain:
            raise AttributeError("No domains provided.")
        self.domain = domain

    def equals(self, domain: "Domain") -> bool:
        if len(domain.domain) != len(self.domain):
            return False

        for i, d in enumerate(self.domain):
            if not d.equals(domain.domain[i]):
                return False

        return True

    def contains(self, x: List[Number]):
        if len(x) != len(self.domain):
            return False

        for i, d in enumerate(self.domain):
            if not d.contains(x[i]):
                return False

        return True
