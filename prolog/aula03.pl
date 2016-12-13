%%% Prolog - Aula 03 - 29/11/2016

%% fibonacci ingenuo
% fib 0 -> 0
% fib 1 -> 1
% fib n -> (fib n-1) + (fib n-2)

fib(0, 0).
fib(1, 1).
fib(N, F) :- N >= 0,
             N1 is N-1,
             N2 is N-2,
             fib(N1, F1),
             fib(N2, F2),
             F is F1 + F2.

%% O(n)
faux(0, Acc, Acc, _).
faux(1, Acc, _, Acc).
faux(N, F, Acc, Acc2) :-
        Acc3 is Acc + Acc2,
        N2 is N-1,
        faux(N2, F, Acc2, Acc3).

fibonacci(N, F) :- N >= 0,
             faux(N, F, 0, 1).

%% Dado um grafo e n cores, colorir todos os vértices do grafo de 
%% forma que nenhum vértice adjacente tenha a mesma cor.
%% definicao do formato de um grafo
%% [
%%  [v1, v2, v3, ...],
%%  [[v1, v2], [v3, v6], ...]
%% ]
color(red).
color(blue).
color(green).
color(yellow).

%% DESISTO DÁ MUITO TRABALHOO

