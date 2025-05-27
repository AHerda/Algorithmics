#import "template.typ": *

#show: project.with(
  title: [Algorytmika \ Ćwiczenia 6],
  authors: (
    ( name: "Adrian Herda", affiliation: "Politechnika Wrocławska" ),
  ),
  date: datetime.today().display("[year]/[month]/[day]"),
)

= Zadanie 27
Niech $X$ będzie licznikiem morrisa. Licznik rozpoczyna z wartością 0 i dla każdej operacji inkremetowany jest z prawdopodobieństwem $2^(-X)$. Estymator morrisa jest zdefiniowany jako:
$ hat(n) = 2^(X_n) - 1 \ hat(n) + 1 = 2^(X_n) $
gdzie $X_n$ jest licznikiem morrisa po $n$ operacjach. Wartość oczekiwana tego estymatora jest równa:
$ E[hat(n)] = n $

Dowód przez indukcję:
+ Dla $n = 0$ mamy $E[hat(n)] = 2^(X_0) - 1 = 2^0 - 1 = 0$.
+ Załóżmy, że dla dowolnego $n$ mamy $E[hat(n)] = n$.
+ Dla $ n + 1$ mamy:
  $
    E[hat(n + 1)] =& E[2^(X_(n + 1)) - 1] \
    =& sum_(i = 1)^infinity P(X_n = i) dot E[2^(X_(n+1)) | X_n = i] - 1 \
    =& sum_(i = 1)^infinity P(X_n = i) dot (underbrace(1 / 2^i dot 2^(i+1), "increment") + underbrace((1 - 1 / 2^i) dot 2^i, "no increment")) - 1 \
    =& sum_(i = 1)^infinity P(X_n = i) dot (2^i + 1) - 1 \
    =& sum_(i = 1)^infinity P(X_n = i) 2^i + sum_(i = 1)^infinity P(X_n = i) - 1 \
    =& E[2^(X_n)] + 1 - 1 \
    =& E[hat(n) + 1] = n + 1
  $
  #h(1fr) $qed$

== Wariancja
$
  E[2^(2X_n)] &= sum_(i = 1)^infinity P(X_n = i) dot 2^(2i) \
  &= sum_(i = 1)^infinity (P(X_(n-1) = i - 1) dot 1 / 2^(i - 1) + P(X_(n-1) = i) dot (1 - 1 / 2^(i - 1))) dot 2^(2i) \
  &= sum_(i = 1)^infinity 2^(i + 1) P(X_(n-1) = i - 1) + sum_(i = 1)^infinity 2^(2i) P(X_(n-1) = i) - sum_(i = 1)^infinity 2^i P(X_(n-1) = i)\
  &= 4 sum_(i = 1)^infinity 2^(i - 1) P(X_(n-1) = i - 1) + E[2^(2X_(n-1))] + E[2^(X_(n-1))] \
  &= 4 E[2^(X_(n-1))] + E[2^(2X_(n-1))] + E[2^(X_(n-1))] \
  &= 3 E[2^(X_(n-1))] + E[2^(2X_(n-1))] \
  &= 3 n + E[2^(2X_(n-1))]
$

Ta formuła jest rekurencyjna, więc możemy j rozwin i otrzymamy ciąg arytmetyczny: $ E[2^(2X_n)] = 1 + sum_(i = 1)^n 3i = 1 + 3/2 n(n + 1) $
A więc:

$
  "Var"(hat(n)) &= E[(2^(X_n) - 1)^2] - E[2^(X_n) - 1]^2 \
  &= E[2^(2X_n) - 2 dot 2^(X_n) + 1] - n^2 \
  &= E[2^(2X_n)] + 1 - 2E[2^(X_n)] - n^2 \
  &= 1 + 3/2 n(n + 1) + 1 - (2E[2^(X_n)] - 2) - n^2 - 2 \
  &= 3/2n^2 + 3/2n - (2E[2^(X_n) - 1]) - n^2 \
  &= 3/2n^2 + 3/2n - 2n - n^2 \
  &= 1/2n^2 - 1/2n \
  &= 1/2n(n - 1) \
$

== Błąd standardowy

Błąd standardowy estymatora morrisa jest równy pierwiastkowi z wariancji podzielonej przez liczbę operacji:
$
  "SE"[hat(n)] = sqrt("Var"(hat(n) / n)) = sqrt(1/2n(n - 1) / n^2) = sqrt((n - 1) / (2n))
$

= Zadanie 28

Niech $h(x)$ będzie funkcją hashującą, która dla każdego $x$ zwrca wartość z tablicy haszującej o długości $m$.

$ P("kolizja") = P(exists_(i eq.not j) (h(x_i) = h(x_j))) $

== Dowód wzoru

Załóżmy że wstawione zostało już $n$ elementów. To znaczy że pozstało $m - n$ miejsc w tablicy haszującej. Prawdopodobieństwo kolizji przy wstawianiu następnego elementu $x_{n + 1}$ jest równe:
$ P("kolizja") = n / m $
Przy wstawainiu kolejnch $n$ elementów prawdopodobieństwo kolizji liczone jesst w następujący sposób:

#set math.cases(reverse: true)
$
  cases(
    P("brak kolizji") = product_(i=0)^(n - 1) (m - i) / m approx exp(- n(n-1) / (2m)),
    1 / 2 lt.eq P("kolizja") arrow.double.r.long 1 / 2 gt.eq P("brak kolizji")
  ) arrow.double.r.long 1/2 approx exp(- n(n-1) / (2m))
$$
  ln(2) approx& n(n-1) / (2m) \
  n(n-1) approx& 2 ln(2) m \
  n^2 - n approx& 2 ln(2) m
$

Dla dostatecznie dużych $n$ możemy przyjąć, że $ n^2 - n approx n^2 $ więc:
$
  n^2 approx& 2 ln(2) m \
  n approx& sqrt(2 ln(2) m)
$
#h(1fr) $qed$

== Wartość $n$ dla $m = 2^16$

$
  n approx& sqrt(2 ln(2) 2^16) \
  approx& sqrt(2 * 0.693147 * 65536) \
  approx& sqrt(90852.18725) \
  approx& 301.417
$

= Zadanie 29
