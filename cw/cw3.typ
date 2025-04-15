#set heading(numbering: "1.")
#set text(lang: "pl")

#align(top + center)[
  #text(size: 24pt, [Algorytmika \ Ćwiczenia 3])

  *Adrian Herda*

  #datetime.today().display()
]

$ mu = E[X] $
$ sigma^2 = "Var"(X) = E[X^2] - E[X]^2 $
$ sigma = "Std"(X) = sqrt("Var"(x)) = sqrt(E[X^2] - E[X]^2) $

= Zadanie 12 - losowanie monetą

Rzucamy monetą dwa razy:

- $Pr("Orzeł", "Reszka") = p dot q$ -- Orzeł monety normalnej
- $Pr("Reszka", "Orzeł") = q dot p$ -- Reszka monety normalnej

Oba wyniki są sobie równe, jeśli będziemy ignorować wyniki (Orzeł, Orzeł) oraz (Reszka, Reszka), dostajemy monetę uczciwą.

$ Pr("Orzeł") = Pr("Reszka") = (p q) / (p q + p q) = 1 / 2 $

= Zadanie 13 - jednostajnie losowane $[0,dots.c,6]$
+ Mamy generator liczb losowych ze zbioru ${0,dots.c,4}$, niech wynik tego generatora będzie oznaczony literą $X$.
+ Tworzymy generator liczb losowych ze zbioru ${1, dots.c, 24}$
  $ Y = 5 a + b $
  gdzie $a, b in {0,dots.c,4}$ są generowane przez generator z punktu 1. Z tego wynika że:
  $ Pr(Y = y) = Pr(Y = 5a + b) = Pr(X = a) dot Pr(X = b) = 1 / 5 dot 1 / 5 = 1 / 25 $
+ Zbiór liczb ${0, dots.c,20 }$ ma $3 dot 7$ liczb co pozwoli nam na dopasowanie równej ilości liczb do zbioru ${0, dots.c,6}$ za pomocą operacji $mod 7$.
+ Jeśli $Y gt 20$ odrzucamy wynik i ponownie losujemy dwie liczby, powtarzamy dopóki nie wylosujemy $Y lt.eq 20$, w takim przypadku wylosowaną zmienną liczymy $ Z = Y mod 7 $ i w ten sposób dostajemy liczbę ze zbioru ${0, dots.c , 6}$ z prawdopodobieństwem:
  $ forall_(z in {0, dots.c,6}) (Pr(Y mod 7 = z) = 3 / 25) ==> Pr(Z = z) = 1 / 7 $

= Zadanie 14 - pole koła z Monte Carlo

== Var(X)

Losujemy $n$ punktów $(x_i, y_i) in [0,1]^2$ \
Niech:

$
  Z_i = cases(
    1 "jeśli" x_i^2 + y_i^2 lt.eq 1,
    0 "w przeciwnym razie"
  ) \
  (forall_(i in [n]))( Pr(Z_i = 1) = "Area"_(circle) / 4 / Omega = pi / 4 / (1 dot 1) = pi / 4 => E[Z_i] = pi / 4 dot 1 + (1 - pi / 4) dot 0 = pi / 4)
$
Mamy do czynienia z rozkładem Bernouliego z prawdopodobieństwem wynoszącym tyle co pole ćwiartki koła czyli $p = pi / 4$. Zatem wiemy od razu że $ (forall_(i in [n])) (E[Z_i] = p = pi / 4) $ oraz że $ (forall_(i in [n])) ("Var"(Z_i) = p(1 - p)) $

Wtedy pole:
$ A_n = 1 / n sum_(i=1)^n Z_i $
Wiemy że wybierane punkty są od siebie niezależne więc $(forall_(i, j in [n], i eq.not j)) ("Cov"(Z_i, Z_j) = 0)$. Ze wzoru na wariancje z mnożnikiem stałym oraz ze wzoru na wariancje sumy zmiennych niezależnych:
$
  sigma_n^2 = "Var"(A_n) = "Var"(1 / n sum_(i=1)^n Z_i) = 1 / n^2 "Var"(sum_(i = 1)^n Z_i) = 1 / n^2 sum_(i = 1)^n "Var"(Z_i) = 1 / n^2 dot n dot p(1-p) = p(1-p) / n
  \ arrow.b.double \
  sigma_n^2 = (pi / 4(1 - pi / 4)) / n = (pi / 4 dot (4 - pi) / 4) / n = (4 pi - pi^2) / (16n)
$

== Minimalne n potrzebne do dokładności 0.01 z prawdopodobieństwem 0.99

Nierówność Czebyszewa: $ Pr(X gt.eq epsilon) lt.eq E[X] / epsilon $
Z Treści zadania chcemy żeby $Pr(|A_n - E[A_n]| gt.eq 0.01) lt.eq 0.01$
$
  Pr(|A_n - E[A_n]| gt.eq 0.01) = Pr(|A_n - E[A_n]|^2 gt.eq 0.01^2) lt.eq sigma_n^2 / 0.01^2 \
  arrow.b.double \
  0.01 = sigma_n^2 / 0.01^2 = (4 pi - pi^2) / (16n dot 0.01^2) \
  arrow.b.double \
  n = ceil((4 pi - pi^2) / (0.01^3 dot 16)) approx ceil(168547.888329363395938) = 168548
$

== To samo ale z nierównością Chernoffa

Nierówność Chernoffa: $ X = sum_(i=1)^n Z_i \ mu_n = E[X] = (n pi) / 4 \ Pr(|X - mu_n| > epsilon mu) lt.eq 2exp(- epsilon^2 / (2 + epsilon) mu) $
Z treści zadania chcemy żeby $Pr(|A_n - E[A_n]| gt.eq 0.01) lt.eq 0.01$
$
  Pr(|A_n - E[A_n]| gt.eq 0.01) = Pr(1/ n |X - mu_n| gt.eq 0.01) = Pr(|X - mu_n| gt.eq 0.01n) lt.eq 2exp(- epsilon^2 / (2 + epsilon) mu_n) \
  0.01n = epsilon mu_n = epsilon (n pi) / 4 arrow.double epsilon = 0.04 / pi \
  arrow.b.double \
  0.01 / 2 = 0.005 = exp(- epsilon^2 / (2 + epsilon) mu_n) = exp(- (0.04 / pi)^2 / (2 + 0.04 / pi) dot (n pi) / 4) = \
  = exp(- (0.0016 dot n pi) / (pi^2 dot (2pi + 0.04) / pi dot 4)) = exp(- (0.0016n) / (8 pi + 0.16)) = e^(- (0.0016n) / (8 pi + 0.16)) \
  arrow.b.double \
  -ln(0.005) = (0.0016n) / (8 pi + 0.16) => (pi + 0.02) dot ln(0.005^(-1)) = 0.0002n \
  arrow.b.double \
  n = ceil((pi + 0.02) dot ln(200) dot 5000) approx ceil(83755.6063123274) = 83756
$

= Zadanie 15 - Standardowe odchylenia przy obliczaniu ćwiartek koła

== Metoda losowania z $[0, 1]^2$

Niech: $ X_i = cases(1 "jeśli" x_i^2 + y_i^2 lt.eq 1, 0 "w przeciwnym wypadku") $ Wtedy:
$
  A_X = 1 / n sum_(i = 1)^n X_i \
  arrow.b.double \
  sigma_X^2 = "Var"(A_X) = "Var"(1 / n sum_(i=1)^n X_i) = 1 / n^2 "Var"(sum_(i = 1)^n X_i) = \ = 1 / n^2 sum_(i = 1)^n "Var"(X_i) = 1 / n^2 dot n dot pi / 4 (1 - pi / 4) = (pi / 4 (1 - pi / 4)) / n \
  arrow.b.double \
  sigma_X = sqrt((pi / 4 (1 - pi / 4)) / n) approx sqrt(0.1685 / n) approx 0.4105 / sqrt(n)
$

== Metoda losowania z $[0,1]$

Niech:
$
  Y_i = sqrt(1- x_i^2) \
  arrow.b.double \
  E[Y_i] = integral_0^1 sqrt(1 - x_i^2) d x = pi / 4 \
  E[Y_i^2] = integral_0^1 1 - x_i^2 d x = x - x_i^3 / 3 bar_0^1 = 1 - 1 / 3 = 2 / 3 \
  sigma_Y^2 = E[Y_i^2] - E[Y_i]^2 = 2 / 3 - (pi / 4)^2 approx 0.0498
$
Wtedy:
$
  A_Y = 1 / n sum_(i = 1)^n Y_i \
  arrow.b.double \
  sigma_Y^2 = "Var"(A_Y) = 1 / n^2 sum_(i = 1)^n "Var"(Y_i) = 1 / n^2 sum_(i = 1)^n 2 / 3 - (pi / 4)^2 = (2 / 3 - (pi / 4)^2) / n \
  sigma_Y = sqrt((2 / 3 - (pi / 4)^2) / n) approx sqrt(0.0498 / n) approx 0.2232 / sqrt(n)
$

== Wnioski

$ sigma_X gt sigma_Y $
Metoda losowania na jednej osi daje lepsze wyniki (o mniejszej wariancji) i zbiega do wartości oczekiwanej szybciej niż metoda losowania z dwóch osi

= Zadanie 16

Niech:
$
  X in [0, 1] \
  Y = cases(X "jeśli" X in [1 / 2, 1], 1 - X "jeśli" X in [0, 1 / 2]) => Y in [1 / 2, 1]
$
Dystrybuanta Y: $ F_Y (y) = Pr(Y <= y) = Pr(max{X, 1 - X} <= y) = Pr(X in [1 - y, y]) "dla" y in [1 / 2, 1] $
Jako że X jest losowane z rozkładem jednostajnym to:
$ F_Y (y) = (y - (1 - y)) / 1 = 2y - 1 "dla" y in [1 / 2, 1] $
Gęstość prawdopodobieństwa:
$ f_Y (y) = d / (d y) F_Y (y) = d / (d y) 2y - 1 = 2 \ arrow.b.double $
Y ma rozkład jednostajny $=> E[Y] = 0.75$
$
  E[Y^2] = integral_(1 / 2)^1 y^2 dot f_Y (y) d y = integral_(1 / 2)^1 2y^2 d y = [2y^3 / 3]_(1 / 2)^1 = 2 / 3 - 2 dot 1 / 8 dot 1 / 3 = 16 / 24 - 2 / 24 = 14 / 24 = 7 / 12 \
  arrow.b.double \
  sigma_Y^2 = E[Y^2] - E[Y]^2 = 7 / 12 - (3 / 4)^2 = 18 / 48 - 27 / 48 = 1 / 48
$

= Zadanie 17


X ma rozkład jednostajny na $[0, 1]$ więc:
$
  f_X (x) = 1 \
  E[X] = 1 / 2 \
  E[X^2] = integral_0^2 x^2 d x = [x^3 / 3]_0^1 = 1 / 3 \
  sigma_X^2 = 1 / 3 - 1 / 4 = 1 / 12 \
  arrow.b.double \
  "Cov"(X, Y) = "Cov"(X, 1 - X) = "Cov"(X, -X) = -"Cov"(X, X) = - sigma_X^2 = - 1 / 12
$
