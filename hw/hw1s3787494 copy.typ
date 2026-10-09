#import "hw/lib.typ": assignment

#show: assignment.with(
  title: "Homework 1",
  authors: (
    (
      name: "Jenny Vermeltfoort",
      email: "s3787494@vuw.leidenuniv.nl",
      student-no: "s3787494",
    ),
  ),
  course: "2627-S1 Mathmetical Structures for Computer Science",
  university-logo: image("./logo.svg"),
)

#set enum(numbering: "1. ")

= Exercise 1
Degrees of freedom is four, since:
- we have two angles for the base joint: one angle on the xy plane ($phi.alt_2$), one angle on vertical ($phi.alt_1$) plane, and one angle that depicts the rotation over the vertical axis ($phi.alt_3$).
- the length ($d$) of the upper arm segment which is bounded on the interval $[20, 100]$.

The configuration space $C$ is:
$C = RR^4$

We project the configuration space into a Cartesian coordinate space:
$X = RR^3$

The transformation function $t$ defined as:
#math.equation(
  $t_a: C arrow.r.long X, t_b: C arrow.r.long X$,
)
with $0 <= phi.alt_1 <= pi/2$.

#math.equation(
  $
    Alpha = t_a(phi.alt_1, phi.alt_2, d) =
    d dot.op vec(
      cos(phi.alt_1) * cos(phi.alt_2),
      cos(phi.alt_1) * sin(phi.alt_2),
      sin(phi.alt_1),
    )
  $,
)

#math.equation(
  $
    Beta = t_b(phi.alt_1, phi.alt_2, d, phi.alt_3) = Alpha +
    10 dot.op vec(
      cos(phi.alt_1} + (3p)/2) cos(phi.alt_2}) cos(phi.alt_3}),
      cos(phi.alt_1} + (3p)/2) sin(phi.alt_2}) cos(phi.alt_3}),
      sin(phi.alt_1} + (3p)/2) sin(phi.alt_3}),
    )
  $,
)

#figure(
  image("Figure_1.png", width: 50%),
  caption: [A curious figure.],
)

#figure(
  image("Figure_2.png", width: 50%),
  caption: [A curious figure.],
)

= Question 2

+
  - $u dot.op v = 0 -8 -3 = -11$
  - $norm(u)_2 = sqrt(14), norm(v)_2 = sqrt(17)$
  - $norm(u)_inf = 3, norm(v)_inf = 4$ \\
+
  - $u dot.op v = 4 -2 -6 = -4$ \\
  - $norm(u)_2 = sqrt(6), norm(v)_2 = 2sqrt(6)$
  - $norm(u)_inf = sqrt(3), norm(v)_inf = sqrt(12)$

+
  - $u dot.op v = cos theta sin theta + sin theta cos theta = 2 cos theta sin theta$ \\
  - $norm(u)_2 = sqrt(2), norm(v)_2 = 1$

= Question 3

1. $ integral_0^1 3x^3 -x^2 dif x = [ 3/4 x^4 - 1/3 x^3 ]^1_0 = 5/12 $

2. $
    integral_0^(1/2) x e^(2x) dif x = [ 1/2 x e^(2x)- 1/2 integral_0^(1/2) e^{2x} ]^(1/2)_0 = [ 1/2 x e^(2x)- 1/4 e^(2x)]^(1/2)_0 = 1/4
  $

3. $
     I & = integral_(-sqrt(3))^sqrt(3) cos(3x)sin(3x) dif x = 1/3 integral_(-sqrt(3))^sqrt(3) cos(t)sin(t) dif t \
       & = 1/3 sin^2(t) - 1/3 integral_(-sqrt(3))^sqrt(3) cos(t)sin(t) dif t \
    2I & = [ 1/3 sin^2(t) ]^sqrt(3)_(-sqrt(3)) \
     I & = [ 1/6 sin^2(t) ]^sqrt(3)_(-sqrt(3)) = 0
  $

= Question 4
1. With $x, y in V$

Non-negative: $0 <= norm(x)$.

Triangular equality: $$


