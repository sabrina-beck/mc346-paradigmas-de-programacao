parent(david, john).
parent(jim, david).
parent(steve, jim).
parent(nathan, steve).

grandparent(Grandparent, Grandson) :- parent(Parent, Grandson), parent(Grandparent, Parent).

ancestor(A, C) :- parent(A, C).
ancestor(A, C) :- parent(P, C), ancestor(A, P).

%% other option:
% ancestor(A, C) :- parent(A, X), ancestor(X, C).

%% factorial
fact(0, 1).
fact(X, Y) :- X > 0,
              X1 is X-1,
              fact(X1, Y1),
              Y is X * Y1.

% caudal
fact2(X, Y) :- faux(X, 1, Y).

faux(0, Acc, Acc).
faux(X, Acc, Y) :- Acc2 is Acc * X,
                   X2 is X-1,
                   faux(X2, Acc2, Y).


%% fibonacci
fib(0, 1).
fib(1, 1).
fib(N, F) :- N1 is N - 1,
             N2 is N - 2,
             fib(N1, F1),
             fib(N2, F2),
             F is F1 + F2.