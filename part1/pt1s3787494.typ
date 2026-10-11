#import "lib.typ": assignment
#import "@preview/commute:0.3.0": arr, commutative-diagram, node

#let innerproduct(x, y) = $lr(chevron.l #x, #y chevron.r)$

#show: assignment.with(
  title: "Optimisation on Analog Computers: Part 1",
  authors: (
    (
      name: "Jenny Vermeltfoort",
      email: "s3787494@vuw.leidenuniv.nl",
      student-no: "s3787494",
    ),
  ),
  course: "2627-S1 Mathmetical Structures in Computer Science",
  university-logo: image("./logo.svg"),
)

Repository: #link("https://github.com/jennyvve/ms"), accessible using read-only token: "github_pat_11ATZJOHA0IdnnBz6t4FVo_c0qR3VNvxEUD5fWBKJ11 \ uksegrYTq7zMdVZImVIZKbdE5WW6U33ynf4L8nW"

#set enum(numbering: "1. ")

= Problem I.1
a. We show that $delta$ is injective, by showing that only the zero vector is in the kernel of $delta$:

$ delta(v)(w) = sum_(i=1)^n sum_(j=1)^n v_i w_i delta(b_i)(b_j) = 0 $
So, $ delta(v)(b_k) & = 0, forall b_k in V \
delta(v)(b_k) & = sum_(i=1)^n v_i delta(b_i)(b_k) $
Lets say that $v_i > 0$, then $delta(v)(b_k) > 0$ if $i = k$, contradicting $delta(v)(b_k) = 0$, thus $v_i = 0$.
This holds $forall b_k in B$, thus it also holds for $forall v_k in V$ concluding $v_1 = ... = v_n = 0$.

To show that $delta$ is surjective: $exists phi in V^*$ we show that: $exists v in V$ s.t. $delta(v) = phi$, thus our general vector can be constructed as such: $v = sum_(i=1)^n phi (b_i) b_i$. Since $delta(b_i)(b_j)$ is $1$ when $i = j$ we can simplify the linear extension:
$
  delta(v)(w) & = sum_(i=1)^n sum_(j=1)^n v_i w_j delta(b_i)(b_j) = sum_(i=1)^n v_i w_i \
$
and we write $phi$ over $w$ as:
$
  phi(w) & = phi(sum_(i=1)^n w_i b_i) = sum_(i=1)^n w_i phi(b_i) = sum_(i=1)^n v_i w_i \
$
Which shows that $delta(v)(w) = phi(w)$.

Since $delta$ is both injective and surjective, it is a bijection. We conclude that $delta$ is isomorphic.



b. We simplified $delta(v)(w) = sum^n_(i=1) v_i w_i$.

Since $V$ has a inner product, using the dot product as inner product, we write: $innerproduct(v, w) = innerproduct(sum^n_(i=1) v_i b_i, sum^n_(j=1) w_j b_j) = sum^n_(i=1)sum^n_(j=1) v_i w_j b_i b_j = sum^n_(i=1) v_i w_i = delta(v)(w)$. $b_i b_j$ vanish because $B$ is orthonormal, $delta$ over the basis basically acts the same way as the dot product over an orthonormal basis.

= Problem I.2
We show that $D$ is linear over the function argument by showing it has the properties of homogeneity and additivity. Thus:
$D(a f) = a D(f)$ and $D(f + g) = D f + D G$.

Let $f,g in C^0(U)$, $x in U$ and $v in RR^n$ with $a in RR$ then the limit exists and is 0:

$
  & limits(lim)_(v->0) norm(((a f)(x + v) - (a f)(x) - (a D f)(x)(v)))/norm(v) \
  & = limits(lim)_(v->0) norm(a f(x + v) - a f(x) - a D f(x)(v))/norm(v) \
  & = limits(lim)_(v->0) norm(a (f(x + v) - f(x) - D f(x)(v)))/norm(v) \
  & = |a| limits(lim)_(v->0) norm(f(x + v) - f(x) - D f(x)(v))/norm(v) \
  & = 0
$

Since $D f = L$ and thus by definition linear we can factor out $a$ from $(a D F)$.
$(a f)(x) = a f(x)$ defined by the exersice. The limit shows that $a D f$ is the limit of $a f$


$D(f + g) &= lim_(x->0) norm((f+g)(x + v) - (f+g)(x) - D (f+g)(x)(v))/norm(v) \
&=$

TODO

= Problem I.3

With $x in RR^n$ and $f(x) = norm(x)_2^2 = x_1^2 + ... + x_n^2$ the gradient is:

$ gradient f(x) = vec(D_1 f, ..., D_n f) = vec(2x_1, ..., 2 x_n) = 2 sum^n_(i=1) x_i e_i $

Then $D f(x)(v) = gradient f(x) (v) = 2 (sum^n_(i=1) x_i e_i) v = 2 innerproduct(x, v)$

TODO

= Problem I.4
TODO

= Problem I.5
$"Ob"("CVec"_n) = (V,X)$ with normed vector spaces $V$ and $X$ the convex sets of V.

$f in "Mor"("CVec"_n)$ with $f: (V, X) -> (W,Y)$ a linear, non-contractive map, s.t. the image of $X$ under $f$ is in $Y$.

Define $id_v: (V,X) -> (V,X)$, $id_v (v) = v$, for which homogeneity and additivy satisfies. It is non-contractive, with $x,y in V$: $norm(x - y) <= norm(id_v (x) - id_v (y)) <= norm(x - y)$.

Let $g,f in "Mor"("CVec"_n)$ and $U,V,W in "Ob"("CVec"_n)$. $f: (V, X) -> (W, Y), g: (W, Y) -> (U, Z)$. We define the composition, with $x, y in (V, X)$, as: $g compose f : (V, X) -> (U, Z)$, $(g compose f)(x) = g(f(x))$.

The composition of two linear maps is linear, therefore $g compose f$ is linear. They are both homogenic and additive, the proof seems redundant.

We show that the composition is non-contractive, $f$ and $g$ are both non-contractive meaning:
$norm(x - y) <= norm(f(x) - f(y))$ for all $x,y in V$. For all $x,y in V$:
$
  norm(x - y)_V & <= norm(f(x) - f(y))_W <= norm(g(f(x)) - g(f(y)))_U \
                & <= norm((g compose f)(x) - (g compose f)(y))_U
$

This shows that the identity map and composition of $f$ and $g$ is linear and non-contractive. Thus the category CVec exists.

= Problem I.6
a) The closed half space is given: $accent(H, -)^n_k subset.eq RR^n$, and $accent(H, -)^n_k = { x in RR^n | x_k >= 0}$.

For all $x,y in accent(H, -)^n_k$ then since $x_k,y_k >= 0$ we can say that $s x_k + (1-s)y_k >= 0$ for all $s in [0,1]$ thus $x_k +_s y_k in accent(H, -)^n_k$ making $accent(H, -)^n_k$ convex.

Concluding that the vector space $RR^n$ with the condition $accent(H, -)^n_k$ is $(RR^n, accent(H, -)^n_k) in "Ob"("CVec"_n)$.

b) Let $R_(pi/2) : RR^2 -> RR^2$, and $R_(pi/2) (x) = mat(0, 1; 1, 0) x$.
With $y in (RR^2, accent(H, -)^2_2)$ where $y_2 >= 0$, and $x in (RR^2, accent(H, -)^2_1)$ where $x_1 >= 0$.

Then $R_(pi/2) (vec(x_1, x_2)) = mat(0, 1; 1, 0) vec(x_1, x_2) = vec(x_2, x_1) tilde.equiv vec(y_1, y_2)$. Since $0 <= x_1 = y_2$, there exists the morphishm $(RR^2, accent(H, -)^2_1) -> (RR^2, accent(H, -)^2_2)$.

= Problem I.7
TODO

= Problem I.8
Let $accent("Sub"_a, -)(f) = {x in X | f(x) <= a}$ for $a in RR$ and $f$ being a convex function. Then $forall x,y in accent("Sub"_a, -)(f)$ we have that $f(x),f(y) <= a$.

To show that $accent("Sub"_a, -)(f)$ is a convex set we show that $x +_s y in accent("Sub"_a, -)(f)$, thus $f(x +_s y) <= a$ for all $s in [0,1]$.

$
  f(x +_s y) & <= s f(x) + (1-s) f(y) \
             & <= s a + (1 - s) a \
             & <= s a + a - s a = a \
$

Concluding that $x +_s y in accent("Sub"_a, -)(f)$, making $accent("Sub"_a, -)(f)$ a convex set.

= Problem I.9
Let $x,y in X$ be the minima for $f: X -> RR$ and $X subset.eq V$. This implies that $f(x +_s y) <= f(x) = f(y)$. Following the definition of strong convex functions, with $a>0$ and $a in RR$ and $forall s in [0,1]$:

$
  f(x +_s y) & <= (f(x) +_s f(y)) - a s (1 - s)norm(x - y)^2 \
        f(x) & <= s f(x) + f(x) - s f(x) - a s (1 - s)norm(x - y)^2 \
        f(x) & <= f(x) - a s (1 - s)norm(x - y)^2 \
             & => a s (1 - s) norm(x - y)^2 <= 0 \
             & => norm(x - y)^2 <= 0 => x = y                       & (a > 0 "and" 0 < exists s < 1)
$

Showing that the minima for a strong convex function is unique.

= Problem I.10
a) Let $f: RR^2 -> RR$ and $f(x_1,x_2) = x_1^2 + x_2^2$.

The convex combination simplifies to:
$
  f(x +_s y) & = (s x_1 + (1 - s) y_1)^2 + (s x_2 + (1-s) y_2) \
             & = 2 s (1 - s) x_1 y_1 + s^2 x_1^2 + (1-s)^2 y^2_1 + \
             & wide 2 s (1 - s) x_2 y_2 + s^2 x_2^2 + (1-s)^2 y^2_2 \
             & = s^2 f(x) + (1-s)^2 f(y) + 2s(1-s)(x_1 y_1 + x_2 y_2) \
             & = s^2 f(x) + (1-s)^2 f(y) + 2s(1-s)(x_1 y_1 + x_2 y_2) \
$

Strong convexity proof follows using the definition:

$
  f(x +_s y) & <= (f(x) +_s f(y)) - a s (1 - s)norm(x - y)^2 \
             & => s^2 f(x) + (1-s)^2 f(y) + 2s(1-s)(x_1 y_1 + x_2 y_2) \
             & wide <= s f(x) + (1-s)f(y) - a s (1 - s)norm(x - y)^2 \
             & => 2s(1-s)(x_1 y_1 + x_2 y_2) \
             & wide <= s f(x) - s^2 f(x) + (1-s)f(y) - (1-s)^2 f(y) - a s (1 - s)norm(x - y)^2 \
             & => 2s(1-s)(x_1 y_1 + x_2 y_2) \
             & wide <= s f(x) (1 - s) + (1-s)f(y)s - a s (1 - s)norm(x - y)^2 \
             & => 2(x_1 y_1 + x_2 y_2) \
             & wide <= f(x) + f(y) - a norm(x - y)^2 \
             & => 2(x_1 y_1 + x_2 y_2) \
             & wide <= x_1^2 + x_2^2 + y_1^2 + y_2^2 - a (x_1^2 + y_1^2 -2 x_1 y_1 +x_2^2 + y_2^2 -2 x_2 y_2) \
             & => 2(x_1 y_1 + x_2 y_2) \
             & wide <= x_1^2 + x_2^2 + y_1^2 + y_2^2 - 1 (x_1^2 + y_1^2 -2 x_1 y_1 +x_2^2 + y_2^2 -2 x_2 y_2) \
             & => 2(x_1 y_1 + x_2 y_2) \
             & wide <= 2 (x_1 y_1 + x_2 y_2) \
$
Thereby $f$ is strong convex.

b) The graph of $g$ is shown in the figure below. This function is not convex because the line drawn by the convex combination between the minima is not inside or above the graph of $g$.

c) If we where to take the open closed half space $accent(H, -)^2_1$ of the image then $g$ would be convex, i.e $g : RR^2_(>=0) -> RR$,



#figure(
  image("geogebra-export.png", width: 50%),
  caption: [A curious figure.],
)

= Problem I.11
a) Let $f in "Conv"_s (V,X)$ be the set of strongly convex functions over $X$ for a normed space $V$, $f: X -> RR$. We define the pointwise binary operations of $RR_(>0)$-module, with $f,g in "Conv"_s (V,X)$: $(f+g)(x) = f(x) + g(x)$ and $(lambda f)(x) = lambda f(x)$, with $lambda > 0$.

We show that the composition of $f$ and $g$ is strong convex, with $r = a s (s-1) ||x+y||^2$, $a > 0$, $a in RR$, and $s in [0,1]$:

$
           (f+g)(x +_s y) & <= (f+g)(x) +_s (f+g)(y) - r \
  f(x +_s y) + g(x +_s y) & <= (f(x) + g(x)) +_s (f(y) + g(y)) - r \
  f(x +_s y) + g(x +_s y) & <= s f(x) + s g(x) + (1 - s)f(y) + (1-s) g(y) - r \
  f(x +_s y) + g(x +_s y) & <= (f(x) +_s f(y)) + (g(x) +_s g(y) - r \
$

We know that $f(x +_s y) < (f(x) +_s f(y)) - r$ because $f$ is strong convex, same applies to g. Thus we substitude:

$
  (f(x) +_s f(y)) + (g(x) +_s g(y)) - 2r & <= (f(x) +_s f(y)) + (g(x) +_s g(y) - r \
                                       2 & >= 1 \
$

Then we show that the action of $f$ is strong convex:

$
  (lambda f)(x +_s y) & <= (lambda f)(x) +_s (lambda f)(y)) - r \
    lambda f(x +_s y) & <= lambda (f(x) +_s f(y)) - r \
           f(x +_s y) & <= f(x) +_s f(y) - 1/lambda r \
  (f(x) +_s f(y)) - r & <= f(x) +_s f(y) - 1/lambda r \
                    1 & >= 1/lambda \
$

Proving that the $RR_(>0)$-module of the strong convex morphism in $"Conv"_s (V,X)$ satisfy strong convexity.

Looking at the axioma of the $RR_(>0)$-module,

- Addition:
  - All function compositions are associative, therefore associativity also holds for the operation.
  - The operation is symmetric: $(f+g)(x) = f(x) + g(x) = g(x) + f(x) = (g+f)(x)$
- Action:
  - Take $lambda = 1$ and we have the identity.
  - It is distributive: $(lambda (f+g))(x) = lambda (f(x) + g(x)) = lambda f(x) + lambda g(x) = (lambda f)(x) + (lambda g) (x)$ and $((lambda_1 + lambda_2)f)(x) = (lambda_1 + lambda_2) f(x) = (lambda_1 f(x) + lambda_2 f(x)) = (lambda_1 f)(x) + (lambda_2 f)(x)$.
  - Associativity holds: $lambda_1(lambda_2f)(x) = lambda_1 lambda_2 f(x) = (lambda_1 lambda_2) f(x)$

Thus concluding that the set of strongly convex functions $"Conv"_s (V,X)$ are closed under the operations of an $RR_(>0)$-module.

b) TODO

= Problem I.12

Let $M, N in "Ob"(R_(>0)-"Mod")$ and:
$ "Mor"_(R_(>0)-"Mod")({f : M -> N cases(delim: "|", f(m + n) = f(m) + f(n), f(r m) = r f(m) " " r in RR_(>0)) }) $

Define the identity map as, with $m in M$ as $id_M: M -> M$ and $id_M (m) = m$. The identity map satisfies the two given properties of the morphisms.

Define the composition, with $f,g in R_(>0)-"Mod"$, $f: M->N$ and $g: N->O$ and $m in M$, as $g compose f : M -> O$ and $(g compose f)(m) = g(f(m))$.

This satisfies the two properties:
$
  (g compose f)(m + n) & = g(f(m+n)) \
                       & = g(f(m) + f(n)) \
                       & = g(f(m)) + g(f(n)) \
                       & = (g compose f)(m) + (g compose f)(n)
$
and
$
  (g compose f)(r m) & = g(f(r m)) \
                     & = g(r f(m)) \
                     & = r g(f(m)) \
                     & = r (g compose f)(m)
$

These functions satisfy associativity because all functions satisfy associativity. The total thus proving that $(R_(>0)-"Mod")$ is a category.

Now we show that $"Conv"_s: "CVec"^op_n -> (R_(>0)-"Mod")$ is a functor.

$F in "CVec"_n^"op"$ consists of morphism $F: (W,Y) -> (V,X)$, which are linear and non-contractive.
$G in RR_(>0)-"Mod"$ consists of morphism $G: M -> N$, which satisfy these properties: $f(m + n) = f(m) + f(n) and f(r m) = r f(m)$.
$H in "Conv"_s$ is the set of strongly convex functions over $X$ for a normed space $V$, $H: X->RR$

We define the functor on morphisms as:
$
  C : "CVec"^op_n (W,V) -> RR_(>0)-"Mod"(C (W), C (V)) \
  C = H compose F
$

With $f,g in "CVec"^op_n$ and $f: (W,Y) -> (V,X)$ and $g: (U,Z) -> (W,Y)$:
$
  C (g compose f) =
$

TODO.


= Problem I.13
TODO



