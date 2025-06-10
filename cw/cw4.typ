#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: [Algorytmika\ Ćwiczenia 7],
  authors: (
    (name: "Adrian Herda", affiliation: "Informatyka Algorytmiczna, Politechnika Wrocławska"),
  ),
  // Insert your abstract after the colon, wrapped in brackets.
  // Example: `abstract: [This is my abstract...]`
  abstract-pl: none, // also can be none
  abstract-en: none, // also can be none
  date: "May 7, 2025",
  content: false,
)

= Zadanie 18

Lemat Schwartza-Zippela:
$ P in R[x_1, dots.c , x_n] $
To niezerowy wielomian o stopniu całkowitym $deg(P) = d gt.eq 0$ nad domeną $R$. Jeśli $S$ jest skończonym podzbiorem $R$ to wybierając niezależnie i jednostajnie losowe $r_1, dots.c, r_n$ należące do $S^n$
$ Pr[P(r_1, dots. c, r_n) = 0] lt.eq d / (|S|) $

== Oszacowanie liczby zer
 Niech $f in k[x_1, dots.c, x_n]$ będzie wielomianem w którym każda zmienna występuję w stopniu co najwyżej $d$. Załóżmy, że $f eq.not 0$, oraz $A subset.eq k$ i $|A| > d$. Chcemy oszacować:
$
  |{a in A^n: f(a) = 0}| lt.eq d dot |A|^(n-1)
$

Z Lematu Schwartza-Zippela dla $a in A^n$:
$
  d / (|A|) gt.eq Pr[f(a) = 0] = (|{a in A^n: f(a) = 0}|) / (|A^n|) \ " mnożymy to przez " |A^n| = |A|^n \
  arrow.b.double \
  |{a in A^n: f(a) = 0}| lt.eq d dot |A|^(n-1)
$

== Prawdopodobieństwo dla $|A| = 2d$

Z Lematu Schwartza-Zippela wynika, że dla $|A| = 2d$ mamy:
$
  Pr[f(zeta) = 0] lt.eq d / (|A|) = d / (2d) = 1 / 2
$

== Dla Ciągu lsoowych punktów

$|A| = 2d$ oraz ${zeta_1, dots.c, zeta_40} subset.eq A$ to ciąg niezależnych oraz losowych punktów ze zbioru $A^n$.
$ forall_(n in [40]) Pr[f(zeta_n) = 0] lt.eq 1 / 2 $
Jako że $zeta$ są niezależne to:
$
  Pr[f(zeta_1) = dots.c = f(zeta_40) = 0] = Pr[f(zeta_1) = 0] dot dots. dot Pr[f(zeta_40) = 0] lt.eq (1 / 2)^(40) < 10^(-12)
$

== Zadanie 21

Rzucamy igłę długości $l$ na płaszczyznę z pionowymi liniami równoległymi w odległościach $k = 1$.

Parametry:
- $t = 1$ - odległość między liniami
- $l lt.eq t$ - długość igły
- $x tilde U[0, t / 2]$ - odległość środka igły od linii
- $theta tilde U[0, pi / 2]$ - kąt nachylenia igły do poziomu
$
  f_X (x) = cases(2 / t : 0 lt.eq x lt.eq t / 2, 0 : "gdziekolwiek indziej") \
  f_Theta (theta) = cases(2 / pi : 0 lt.eq theta lt.eq pi / 2, 0 : "gdziekolwiek indziej") \
  arrow.b.double \
  f_(X Theta)(x, theta) = f_x (x) dot f_Theta (theta)
  = cases(4 / (pi t) : 0 lt.eq x lt.eq t / 2"," 0 lt.eq theta lt.eq pi / 2, 0 : "gdziekolwiek indziej")
$

Igła przecina linię, gdy: $ x lt.eq l / 2 cos theta $

Teraz liczymy prawdopodobieństwo:
$
  Pr["Igła przecina linię"] = Pr[x lt.eq l / 2 cos theta] = integral_(theta=0)^(pi / 2) integral_(x=0)^(l / 2 cos theta) f_(X Theta)(x, theta) d x d theta = \
  integral_(theta=0)^(pi / 2) integral_(x=0)^(l / 2 cos theta) 4 / (pi t) d x d theta = integral_0^(pi / 2) [(4 x) / (pi t)]_0^(l / 2 cos theta) d theta = (4 l) / (2 pi t) integral_0^(pi / 2) cos theta d theta = (2 l) / (pi t) dot [sin theta]_0^(pi / 2) = 2l / (pi t)
$
