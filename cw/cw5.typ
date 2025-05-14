#align(top + center)[
  #text(size: 24pt, [Algorytmika \ Ćwiczenia 5])

  *Adrian Herda*

  #datetime.today().display()
]

//#set heading(numbering: " ")
#show heading: set block(below: 1em, above: 2em)
#show figure: set block(below: 2em, above: 1em)
#set text(lang: "pl")
#set par(
  spacing: 0.8em,
  justify: true
)

= Zadanie 22

Zmienna losowa $ L~"Uni"{0, dots.c, n - 1} $
to znaczy że: $ Pr[L=k] = 1 / n, " dla" 0 lt.eq k lt n. $

Zmienna losowa
$
  X &= max{L, n - L - 1} \
  X &= cases(L ","&" jeśli" L gt (n-1) / 2 , n - L - 1","&" jeśli" L lt.eq (n-1) / 2)\
  X &= cases(k ","&" jeśli" k gt (n-1) / 2 , n - k - 1","&" jeśli" k lt.eq (n-1) / 2)
$
Dla $n = 2m$ czyli parzystego mamy $(n-1) / 2 = m - 1 / 2$ wtedy:
$
  sum_(k=0)^(2m - 1) max{k, 2m - k - 1} = sum_(k=0)^(m - 1) (2m - k - 1) + sum_(k=m)^(2m - 1) k =\
  m(2m - 1 + m) / 2 + m(m + 2m - 1) / 2 = (m(3m - 1) + m(3m - 1)) / 2 = 3m^2 - m
$
A więc wartość oczekiwana:
$
  E(X) = 1 / n sum_(k=0)^(2m - 1) max{k, 2m - k - 1} = 1 / (2m) dot (3m^2 - m) = (3m - 1) / 2 = 3/4 n - 1 / 2
$

Dla $n = 2m + 1$ czyli parzystego mamy $(n-1) / 2 = (2m) / 2 = m$ wtedy:
$
  sum_(k=0)^(2m) max{k, 2m - k} = sum_(k=0)^(m) (2m - k) + sum_(k=m+1)^(2m) k =\
  ((m + 1)(2m + m)) / 2 + m(m + 1 + 2m) / 2 = (3m^2 + 3m + 3m^2 + m) / 2 = (6m^2 + 4m) / 2 = 3m^2 + 2m
$
A więc wartość oczekiwana:
$
  E(X) = 1 / n sum_(k=0)^(2m) max{k, 2m - k} = m(3m + 2) / n = ((n-1) dot (3 dot ((n-1) / 2) + 2)) / (2n) = \
  ((n - 1) dot (3n + 1)) / (4n) = (3n^2 - 2n - 1) / (4n)
$
