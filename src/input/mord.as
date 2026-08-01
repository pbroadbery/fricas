#include "fricas"
#pile

MyOrder: OrderedSet with 
    toOrder: Integer -> %
== add
    Rep == Integer
    import from Rep
    foo(x: %) == never
    (a : %) = (b : %) : Boolean == rep(a) = rep(b)

    (a : %) < (b : %): Boolean == rep(a) < rep(b)

    coerce(a : %) : OutputForm == coerce(rep(a))
    toOrder(n: Integer): % == per n

