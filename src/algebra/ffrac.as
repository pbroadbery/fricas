\documentclass{article}
\usepackage{axiom}
\begin{document}
\title{\$SPAD/src/algebra ffrac.as}
\author{Michael Richardson}
\maketitle
\begin{abstract}
\end{abstract}
\eject
\tableofcontents
\eject
\begin{verbatim}

-- FormalFraction

-- N.B. ndftip.as inlines this, must be recompiled if this is.

-- To test:
-- sed '1,/^#if NeverAssertThis/d;/#endif/d' < ffrac.as > ffrac.input
-- axiom
-- )set nag host <some machine running nagd>
-- )r ffrac.input

\end{verbatim}
\section{FormalFraction}
<<FormalFraction>>=

#include "axiom.as"

FFRAC ==> FormalFraction ;

OF    ==> OutputForm ;
SC    ==> SetCategory ;
FRAC  ==> Fraction ;
ID    ==> IntegralDomain ;

+++ Author: M.G. Richardson
+++ Date Created: 1996 Jan. 23
+++ Date Last Updated:
+++ Basic Functions:
+++ Related Constructors: Fraction
+++ Also See:
+++ AMS Classifications:
+++ Keywords:
+++ References:
+++ Description:
+++ This type represents formal fractions - that is, pairs displayed as
+++ fractions with no simplification.
+++
+++ If the elements of the pair have a type X which is an integral
+++ domain, a FFRAC X can be coerced to a FRAC X, provided that this
+++ is a valid type.  A FRAC X can always be coerced to a FFRAC X.
+++ If the type of the elements is a Field, a FFRAC X can be coerced
+++ to X.
+++
+++ Formal fractions are used to return results from numerical methods
+++ which determine numerator and denominator separately, to enable
+++ users to inspect these components and recognise, for example,
+++ ratios of very small numbers as potentially indeterminate.

FormalFraction(X : SC) : SC with {

-- Could generalise further to allow numerator and denominator to be of
-- different types, X and Y, both SCs.  "Left as an exercise."

  / : (X,X) -> % ;
++ / forms the formal quotient of two items.

  numer : % -> X ;
++ numer returns the numerator of a FormalFraction.

  denom : % -> X ;
++ denom returns the denominator of a FormalFraction.

  if X has ID then {

    coerce : % -> FRAC(X pretend ID) ;
++ coerce x converts a FormalFraction over an IntegralDomain to a
++ Fraction over that IntegralDomain.

    coerce : FRAC(X pretend ID) -> % ;
++ coerce converts a Fraction to a FormalFraction.

  }

  if X has Field then coerce : % -> (X pretend Field) ;

} == add {

  import from Record(num : X, den : X) ;

  Rep == Record(num : X, den : X) ; -- representation

  ((x : %) = (y : %)) : Boolean ==
    ((rep(x).num = rep(y).num) and (rep(x).den = rep(y).den)) ;

  ((n : X)/(d : X)) : % == per(record(n,d)) ;

  coerce(r : %) : OF == (rep(r).num :: OF) / (rep(r).den :: OF) ;

  numer(r : %) : X == rep(r).num ;

  denom(r : %) : X == rep(r).den ;

  if X has ID then {

    coerce(r : %) : FRAC(X pretend ID)
      == ((rep(r).num)/(rep(r).den)) @ (FRAC(X pretend ID)) ;

    coerce(x : FRAC(X pretend ID)) : % == x pretend % ;

  }

  if X has Field then coerce(r : %) : (X pretend Field)
    == ((rep(r).num)/(rep(r).den)) $ (X pretend Field) ;

}

#if NeverAssertThis

)lib ffrac

f1 : FormalFraction Integer
f1 := 6/3

--       6
--       -
--       3

f2 := (3.6/2.4)$FormalFraction Float

--       3.6
--       ---
--       2.4

numer f1

--       6

denom f2

--       2.4

f1 :: FRAC INT

--       2

% :: FormalFraction Integer

--       2
--       -
--       1

f2 :: Float

--       1.5

output "End of tests"

#endif
@
\section{License}
<<license>>=
--Copyright (c) 1991-2002, The Numerical ALgorithms Group Ltd.
--All rights reserved.
--
--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are
--met:
--
--    - Redistributions of source code must retain the above copyright
--      notice, this list of conditions and the following disclaimer.
--
--    - Redistributions in binary form must reproduce the above copyright
--      notice, this list of conditions and the following disclaimer in
--      the documentation and/or other materials provided with the
--      distribution.
--
--    - Neither the name of The Numerical ALgorithms Group Ltd. nor the
--      names of its contributors may be used to endorse or promote products
--      derived from this software without specific prior written permission.
--
--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
--IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
--TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
--PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER
--OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
--EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
--PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
--PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
--LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
--NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
@
<<*>>=
<<license>>

<<FormalFraction>>
@
\eject
\begin{thebibliography}{99}
\bibitem{1} nothing
\end{thebibliography}
\end{document}
