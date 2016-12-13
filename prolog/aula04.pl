%%ensinou cut !

maxunit(X, Y, Max) :- X > Y,
                    Max = X, !.
maxunit(X, Y, Max) :- X @=< Y,
                    Max = Y, !.

maxaux([], Acc, Acc).
maxaux([Head | Tail], Max, Acc) :- Head > Acc,
                                    maxaux(Tail, Max, Head), !.
maxaux([Head | Tail], Max, Acc) :- Head @=< Acc,
                                    maxaux(Tail, Max, Acc).

max([], 0).
max([Head | Tail], Max) :- maxaux(Tail, Max, Head).