#import "hw/lib.typ": assignment
#import "@preview/commute:0.3.0": arr, commutative-diagram, node

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
  $t_a: RR^3 arrow.r.long X, t_b: RR^4 arrow.r.long X$,
)
with $0 <= phi.alt_1 <= pi/2$.

$
  Alpha & = t_a(phi.alt_1, phi.alt_2, d) \
        & =
          d dot.op vec(
            cos(phi.alt_1) * cos(phi.alt_2),
            cos(phi.alt_1) * sin(phi.alt_2),
            sin(phi.alt_1),
          ) \
   Beta & = t_b(phi.alt_1, phi.alt_2, d, phi.alt_3) \
        & = Alpha +
          10 dot.op vec(
            cos(phi.alt_1 + (3p)/2) cos(phi.alt_2}) cos(phi.alt_3}),
            cos(phi.alt_1 + (3p)/2) sin(phi.alt_2}) cos(phi.alt_3}),
            sin(phi.alt_1 + (3p)/2) sin(phi.alt_3}),
          )
$

#figure(
  image("Figure_1.png", width: 50%),
  caption: [A curious figure.],
)

#figure(
  image("Figure_2.png", width: 50%),
  caption: [A curious figure.],
)

= Excercise 2

+
  - $u dot.op v = 0 -8 -3 = -11$
  - $norm(u)_2 = sqrt(14), norm(v)_2 = sqrt(17)$
  - $norm(u)_inf = 3, norm(v)_inf = 4$
+
  - $u dot.op v = 4 -2 -6 = -4$
  - $norm(u)_2 = sqrt(6), norm(v)_2 = 2sqrt(6)$
  - $norm(u)_inf = sqrt(3), norm(v)_inf = sqrt(12)$

+
  - $u dot.op v = cos theta sin theta + sin theta cos theta = 2 cos theta sin theta$
  - $norm(u)_2 = sqrt(2), norm(v)_2 = 1$

= Excercise 3

1. $ integral_0^1 3x^3 -x^2 dif x = [ 3/4 x^4 - 1/3 x^3 ]^1_0 = 5/12 $

2. $
    integral_0^(1/2) x e^(2x) dif x & = [ 1/2 x e^(2x)- 1/2 integral_0^(1/2) e^{2x} ]^(1/2)_0 \
                                    & = [ 1/2 x e^(2x)- 1/4 e^(2x)]^(1/2)_0 = 1/4
  $

3. $
     I & = integral_(-sqrt(3))^sqrt(3) cos(3x)sin(3x) dif x = 1/3 integral_(-sqrt(3))^sqrt(3) cos(t)sin(t) dif t \
       & = 1/3 sin^2(t) - 1/3 integral_(-sqrt(3))^sqrt(3) cos(t)sin(t) dif t \
    2I & = [ 1/3 sin^2(t) ]^sqrt(3)_(-sqrt(3)) \
     I & = [ 1/6 sin^2(t) ]^sqrt(3)_(-sqrt(3)) = 0
  $
#pagebreak()

= Excercise 4
+ With $forall x, y, z in V$ and $d(x, y) = norm(x - y)$

  (M1) $d(x,y) >= 0$ since $norm(x) >= 0$ (from N1)

  (M2) $      d(x,y) & = 0 &               \
  norm(x - y) & = 0 &               \
        x - y & = 0 & (=>"from N2") \
            x & = y &               $

  (M3) $ d(x,y) & = norm(x - y)         &               \
         & = norm(-(y - x))      &               \
         & = abs(-1) norm(y - x) & (=>"from N3") \
         & = d(y,x)              &               $

  (M4) $ norm(x - y + y - z) & <= norm(x - y) + norm(y - z) & (=> "from N4") \
          norm(x - z) & <= norm(x - y) + norm(y - z) &                \
               d(x,z) & <= d(x,y) + d(y,z)           &                $
+ Let $d(x,y) = cases(1 & "if" x != y, 0 & "if" x = y)$ and $forall x, y in V$.
This is a metric since:

(M1) $d(x,y) >= 0$, which is obvious.

(M2) $d(x,y) = 0 => x = y$, by definition.

(M3) $d(x,y) = d(y, x)$ concluded through the symmetry property of equality.

(M4) $d(x,z) <= d(x, y) + d(y, z)$ for some $z != x, y !=x$ which means that $d(x,z) = d(x,y) = d(y,z)= 1$ and $1 <= 2$.

This is not a norm because with $a > 1$ and $x != y$ we prove through contradiction: $d(a x, a y) = abs(a) d(x,y) > 1$ but $d(x,y) <= 1$.

#pagebreak()

= Excercise 5
+ $(V, bold("Lin"))$ with $f,g,h in bold("Lin")$: $f : V -> W$, $g : W -> U$, $h : U -> Z$, and $forall u,v in V$, and scalar $c in FF$. With $V,W, Z in bold("Vec")_f$ being vector spaces over some field $FF$.

  We can define the identity map as $i_v : V -> V$ and $i_v (u) = u$ which satisfies both addition and homogeneity. Proof follows similarly as to below.

  Addition: $ (g compose f)(u + v) & = g(f(u + v)) \
                       & = g(f(u) + f(v)) \
                       & = g(f(u)) + g(f(v)) \
                       & = (g compose f)(u) + (g compose f)(v) $.

  Homogeneity: $ (g compose f)(c u) & = g(f(c u)) \
                     & = c g(f(u)) \
                     & = c(g compose f)(u) $

  Showing that the composition of linear maps is also linear and therefore closing the class of linear maps under composition. Associativity naturally follows from linear maps being associative:
  $
    (h compose (g compose f))(u) & = h((g compose f)(u)) = h(g(f(u))) \
    ((h compose g) compose f)(u) & = (h compose g)(f(u)) = h(g(f(u)))
  $


#pagebreak()

2.
  $"Ob"(C) = U, W, V$ and $f,g in "Mor"_C (W,V)$ with $f: W -> V$ and $g: U -> W$.
  $"Ob"(C^"op") = U, V, W$ and $f^"op" in "Mor"_(C^"op") (V,W)$ with $f^"op": V -> W$.

  $F: "Mor"_C^"op" (V,W) -> "Mor"_C (F(V),F(W))$ defined as $F(f^"op")(v in V) = f(F(v in V)) = F(w in W)$
  with $F = (-)^*$. Then $f^*: V^* -> W^*$ and $forall v in V^*$: $f^*(v) = v compose f$.
  This holds because $v: V -> FF$, $f: W -> V$ therefore $f^* in W^*$.

  With this we show that this is closed under composition: $F(g compose f) = (g compose f)^*(v) = v compose (g compose f) = (v compose g) compose f = f^*(v) compose g = g^*(f^*(v)) = F(g) compose F(f)$

3. The definition of a dual basis gives us: $"for" v_1, ..., v_n in B "and" phi_1, ..., phi_n in V^*$, $phi_j (v_k) = cases(1 & "if" k = j, 0 & "if" k != j)$. Where B is a vector space over a field $FF$ and $v_1, ... , v_n$ are basis of B.

  We show that $B^* = {phi_1, ... , phi_n}$ is linearly independant by showing that $phi = a_1 phi_1 + ... + a_n phi_n = 0 => a_1 = ... = a_n = 0$ for $a_i in FF$. By iterating over all $b_k in B$: $phi(b_k) = a_1 phi_1 (b_k) + ... + a_n phi_n (b_k) = 0$, since for every $phi_j (b_k)$ where $k = j$, $phi_j (b_k) = 1$, $phi(b_k) > 0 "if" a_k != 0$, we must say that $a_1 = ... = a_n = 0$. Since the vectors of $B^*$ are linearly independant $phi$ is bijective because it maps all vectors of $B$ uniquely to $B^*$.

  $dim (B) = dim(B^*)$ is implied because $phi(b_k) = phi_1 (b_k) + ... + phi_n (b_k) = phi_k (b_k)$, therefore for every $phi in B^*$ there exists a $b in B$.

  $B$ and $B^*$ are thus isomoporphic because the preserve structure and there is a bijective morphism between the spaces.

4. No time.

#pagebreak()
#let innerproduct(x, y) = $lr(chevron.l #x, #y chevron.r)$

= Excercise 6
1. Propose the inner product $innerproduct(f, g)= integral_0^1 f(t)g(t)w(t) dif t$, with $w(t)$ being some weight at $t$ and $w(t) > 0$. ? is this cheating?

  Homogeneity: $innerproduct(a f, g) = integral_0^1 a f(t)g(t)w(t) dif t = a integral_0^1 f(t)g(t)w(t) dif t= a innerproduct(f, g)$

  Symmetry: $ innerproduct(f, g) = integral_0^1 f(t)g(t)w(t) dif t = integral_0^1 g(t)f(t)w(t) dif t= innerproduct(g, f) $

  Non-negative: $ innerproduct(f, f) = integral_0^1 f(t)^2w(t) dif t >= 0 $

  Zero: $ innerproduct(f, f) = 0 => integral_0^1 f(t)^2 w(t) = 0 => f(t) = 0 $
#pagebreak()


2. $norm(f) = sqrt(innerproduct(f, f))$

  Homogeneity:
  $ norm(a f) = sqrt(a^2 integral_0^1 f^2(t)w(t) dif t) = abs(a) sqrt(integral_0^1 f^2(t)w(t) dif t) = abs(a) norm(f) $

  Triangle inequality, using Cauchy-Schwarz inequality we say: $2innerproduct(f, g) <= 2norm(f)norm$:
  $
    norm(f + g)^2 & = integral_0^1 (f(t) + g(t))^2w(t) dif t                                          & \
                  & = integral_0^1 f^2(t)w(t) + 2f(t)g(t)w(t) + g^2(t)w(t) dif t                      & \
                  & = norm(f) + norm(g) + 2innerproduct(f, g)                                         & \
                  & => norm(f) + norm(g) + 2innerproduct(f, g) <= norm(f) + norm(g) + 2norm(f)norm(g) & \
                  & = (norm(f) + norm(g))^2 \
                  & => norm(f + g) <= norm(f) + norm(g)                                               & \
  $

  Non-zero and zero follow obviously. :)

3. No time.

= Excercise 7
No time.
