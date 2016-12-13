%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% length(List, Length).                 %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
length1([], 0).
length1([_ | Tail], Length) :- length1(Tail, SubLength),
                                Length is SubLength + 1.

%% caudal
laux([], Acc, Acc).
laux([_ | Tail], Length, Acc) :- Acc2 is Acc + 1,
                                    laux(Tail, Length, Acc2).

length2(List, Length) :- laux(List, Length, 0).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% append(List, Element, Result).        %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
appendElem([], E, [E]).
appendElem([H | Tail], E, R) :- appendElem(Tail, E, R1),
                                R = [H | R1].           %% 'is' won't work!

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% append(FirstList, SecondList, Result).%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
append1([], L, L).
append1([H | Tail], L, R) :- append1(Tail, L, R1),
                            R = [H | R1].

%% alternative
append2([], L, L).
append2([H | Tail], L, [H | R1]) :- append2(Tail, L, R1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% reverse(List, Reverse).               %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
reverse1([], []).
reverse1([H | Tail], R) :- reverse(Tail, R1),
                          appendElem(R1, H, R).

%% caudal
raux([], Acc, Acc).
raux([H | Tail], Y, Acc) :- raux(Tail, Y, [H | Acc]).

reverse2(List, Reverse) :- raux(List, Reverse, []).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% listsplit(List, Head, Tail).          %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
listsplit([H | Tail], H, Tail).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% last(List, Elem).                     %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
last([E], E).
last([_ | Tail], E) :- last(Tail, E).

last1(L, E) :- append(_, [E], L).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% member(Elem, List).                   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
member1(E, [E | _]).
member1(E, [_ | Tail]) :- member(E, Tail).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% split(List, Pivot, Left, Right).      %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% split([a,a,a,a,p,c,c,c,c,c], p, [a,a,a,a], [c,c,c,c,c]).
split(List, Pivot, Left, Right) :- append(Left, [Pivot | Right], List).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% flatten(List, Flattened).             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flatten([], []).
flatten([Head | Tail], [Head | F1]) :- atomic(Head),
                                       flatten(Tail, F1), !.
flatten([Head | Tail], F) :- flatten(Head, F1),
                             flatten(Tail, F2),
                             append(F1, F2, F).

%%caudal
flaux([], Out, Out).
%%flaux([[] | Tail], F, Out) :-x flaux(Tail, F, Out).
flaux([Head | Tail], F, Out) :- \+is_list(Head),
                                Out1 = [Head | Out],
                                flaux(Tail, F, Out1).
flaux([Head | Tail], F, Out) :- is_list(Head),
                                flaux(Head, F1, Out),
                                flaux(Tail, F, F1).

flatten2(L, F) :- flaux(L, F1, []),
                  reverse(F1, F).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% run_length(List, Result).             %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% [a, a, a, a, b, c, c, c, d, e, e, e]
%% [[4, a], [1, b], [3, c], [1, d], [3, e]]

rlaux([], R, Acc, Previous, Counter) :- ResultElement = [Counter | [Previous]],
                                        Acc2 = [ResultElement | Acc],
                                        reverse(Acc2, R).
rlaux([Head | Tail], R, Acc, Previous, Counter) :- Previous == Head,
                                                   C1 is Counter + 1,
                                                   rlaux(Tail, R, Acc, Head, C1), !.
rlaux([Head | Tail], R, Acc, Previous, Counter) :- Previous \= Head,
                                                   ResultElement = [Counter | [Previous]],
                                                   Acc2 = [ResultElement | Acc],
                                                   C1 is 1,
                                                   rlaux(Tail, R, Acc2, Head, C1).

run_length([], []).
run_length([Head | Tail], R) :- Counter is 1,
                                rlaux(Tail, R, [], Head, Counter).
