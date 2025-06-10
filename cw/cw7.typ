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
  date: "June 10, 2025",
  content: false,
)

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

= Zadanie 33 - wyznacznik Vandermonda

== Treść

Pokazać że $ V(x_1, dots,x_n) = product_(i<j)(x_j - x_i) $

== Rozwiązanie

Macierz Vandermonda jest zdefiniowana jako:
$
  mat(
    1,x_0,x_0^2,dots,x_0^n;
    1,x_1,x_1^2,dots,x_1^n;
    1,x_2,x_2^2,dots,x_2^n;
    dots.v,dots.v,dots.v, dots.down, dots.v;
    1,x_n,x_n^2,dots,x_n^n;
  )\
$
A jej wyznacznik to
$
  V(x_1, dots,x_n) &= mat(delim: "|",
    1,x_0,x_0^2,dots,x_0^n;
    1,x_1,x_1^2,dots,x_1^n;
    1,x_2,x_2^2,dots,x_2^n;
    dots.v,dots.v,dots.v, dots.down, dots.v;
    1,x_n,x_n^2,dots,x_n^n;
  )
$

*Główna idea dowodu:* Jeśli do kolumny macierzy dodamy (lub od niej odejmiemy) inną kolumnę pomnożoną przez pewien skalar, to wyznacznik macierzy nie zmienia się.

A więc w każdej kolumnie oprócz pierwszej odejmujemy poprzednią pomnożoną przez $x_0$. To daje nam macierz:
$
  V &= mat(
    1,0,0,dots,0;
    1,x_1 - x_0,x_1(x_1 - x_0),dots,x_1^(n-1)(x_1 - x_0);
    1,x_2 - x_0,x_2(x_2 - x_0),dots,x_2^(n-1)(x_2 - x_0);
    dots.v,dots.v,dots.v, dots.down, dots.v;
    1,x_n - x_0,x_n (x_n - x_0),dots,x_n^(n-1)(x_n - x_0);
  )\
$

Teraz wykonując rozwinięcie Laplace'a względem pierwszego wiersza otrzymujemy $det(V) = det(B)$ gdzie:
$
  B &= mat(
    x_1 - x_0,x_1(x_1 - x_0),dots,x_1^(n-1)(x_1 - x_0);
    x_2 - x_0,x_2(x_2 - x_0),dots,x_2^(n-1)(x_2 - x_0);
    dots.v,dots.v, dots.down, dots.v;
    x_n - x_0,x_n (x_n - x_0),dots,x_n^(n-1)(x_n - x_0);
  )\
$

Jako że wszystkie wartości na $i$-tym wierszu mają współczynnik w postaci $x_(i+1) - x_0$ możemy je wyciągnąć przed macierz i otrzymać równość:
$
  det(V) &= (x_1 - x_0)(x_2 - x_0)dots.c(x_n - x_0)
  mat(delim: "|",
    1,x_1,x_1^2,dots,x_1^(n-1);
    1,x_2,x_2^2,dots,x_2^(n-1);
    1,x_3,x_3^2,dots,x_3^(n-1);
    dots.v,dots.v,dots.v, dots.down, dots.v;
    1,x_n,x_n^2,dots,x_n^(n-1);
  ) \
  &=product_(1 lt.eq i lt.eq n)(x_i - x_0)det(V')
$

gdzie $V'$ jest macierzą Vandermonda dla $x_1,dots,x_n$. powtarzając ten proces na coraz mniejszych macierzach Vandermonda otrzymujemy produkt:
$
  det(V) &= product_(0 lt i lt.eq n)(x_i - x_0) dot product_(1 lt i lt.eq n)(x_i - x_1) dot dots dot product_(n-1 lt i lt.eq n)(x_i - x_(n-1))\
  &= product_(0lt.eq j lt n) (product_(j lt i lt.eq n)(x_i - x_j)) \
  &= product_(0 lt.eq j lt i lt.eq n)(x_i - x_j) & "Zamieniając \nnotacje "i - j\
  &= product_(0 lt.eq i lt j lt.eq n)(x_j - x_i)
$

#h(1fr) #sym.qed

= Zadanie 36 - maksymalne sparowanie dzięki specyfikacji

== Treść

Należy udowodnić że jeśli w grafie $G= (V,E)$ zachodzą warunki specyfikacji $S$ albo _single_ to zbiór $M = {(p, "pref"_p): "pref"_p eq.not "NULL"}$ jest sparowaniem maksymalnym.
$ S = (forall_(p in V)) ("married"(p) or "single"(p)) $

== Dowód

Dowód będzie nie wprost

Załóżmy przeciwnie, że zbiór $M$ nie jest maksymalnym sparowaniem, to znaczy że istnieje $M'$ taki że $M subset M'$.

+ $M$ jest poprawnym sparowaniem. Z definicji _married_:
  $ "married"(p) eq.triple "pref"_p = q in N(p) and "pref"_q = p in N(q) $

  Zatem jeśli $"pref"_q eq.not "NULL"$ to żeby dodać $(p, "pref"_p)$ do $M$, musimy mieć:
  - $"pref"_p = q$
  - $"pref"_q = p$

  A więc jako że każdy wierzchołek może być albo _married_ albo _single_ to żaden wierzchołek nie może być częścią obu par.

+ Załóżmy że $M$ nie jest maksymalne

  Jako że $M$ nie jest maksymalne to znaczy że istnieje para $(p,q) in M' without M$ którą można by dodać do $M$. Oznacza to, że:
  - $"pref"_p = "NULL"$,
  - $"pref"_q = "NULL"$,
  - $p in N(q) and q in N(p)$,

  To oznacza że oba wierzchołki są _free_ co zaprzecza warunkom specyfikacji.

Zatem $M$ musi być sparowaniem maksymalnym.\
#h(1fr) #sym.qed

= Zadanie 37 - specyfikacja kończy jakąkolwiek pracę w algorytmie

== Treść

Należy udowodnić że jeśli zachodzą warunki specyfikacji $S$ to konfiguracja jest ostateczna (żaden krok algorytmu nie zmieni konfiguracji)

$ S = (forall_(p in V)) ("married"(p) or "single"(p)) $

=== Algorytm
```julia

do forever
  if pref_p == NULL && (exists q in N(p))(pref_q == p)
    pref_p ← q
  end if
  if pref_p == NULL
    && (forall q in N(p))(pref_q != p)
    && (exists q in N(p))(pref_q == NULL)
    pref_p ← q
  end if
  if pref_p == q && pref_q != p && pref_q != NULL
    pref_p ← NULL
  end if
end do
```

== Dowód

Jeśli zachodzą warunki specyfikacji $S$ to znaczy że nie ma żadnych wierzchołków w stanach _free_, _wait_ oraz _chain_.

+ Pierwsza klauzula `if` sprawdza czy istnieje wierzchołek $p$ taki że $"pref"_p = "NULL"$ oraz istnieje wierzchołek $q in N(p)$ taki że $"pref"_q = p$ a to znaczyłoby że wierzchołek $q$ musi być w stanie _wait_. Jako że nie ma już takich wierzchołków dzięki warunkom specyfikacji, ta klauzula nie może zostać wykonana.
+ Druga klauzula `if` sprawdza istnienie wierzchołka $p$ takiego że $"pref"_p = "NULL"$ oraz takiego wierzchołka $q in N(p)$ że $"pref"_q = "NULL"$. Taka klauzula spełniona byłaby tylko gdyby $"free"(p) and "free"(q)$. Jako że nie ma już takich wierzchołków dzięki warunkom specyfikacji, ta klauzula nie może zostać wykonana.
+ Trzecia klauzula `if` sprawdza istnienie wierzchołka $p$ takiego że $"pref"_p = q$ oraz takiego wierzchołka $q in N(p)$ że $"pref"_q eq.not p and "pref"_q eq.not "NULL"$ to znaczy że $"pref"_q = r and r eq.not p$. To znaczyłoby że raka klauzula byłaby spełniona tylko dla wierzchołka $"chain"(p)$. Jako że nie ma już takich wierzchołków dzięki warunkom specyfikacji, ta klauzula nie może zostać wykonana.


Z punktów powyższych klauzul wynika że algorytm nie może wykonać żadnego kroku, a więc konfiguracja jest ostateczna. \
#h(1fr) #sym.qed
