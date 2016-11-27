%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Definição de Regras Recursivas   %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parent(david, john).
parent(jim, david).
parent(steve, jim).
parent(nathan, steve).

grandparent(A, B) :-
    parent(A, X),
    parent(X, B).

%% Exercício
%%
%% Crie uma regra ancestor(A, B) que retorna
%% true quando A é um ancestral de B.

ancestor(A, B) :- parent(A, B).
acestor(A, B) :- parent(A, X), ancestor(X, B).

%% Escreva um predicado que calcula
%% o fatorial de um número
%% o caso base tem que vir antes por que ele percorre na ordem de declaração da regra
fat(X, Y) :- X <= 0, Y = "erro, X precisa ser > 0.".
fat(1, Y) :- Y is 1.
fat(X, Y) :- X2 is X - 1,
             fact(X2, Y2),
             Y is X * Y2.

%% Fazer o fatorial caudal utilizando o método do acumulador
fact2(X, Y) :- X <= 0, Y = "erro, X precisa ser > 0.".
fact2(X, Y) :- faux(X, 1, Y).

faux(0, _, 1).
faux(X, A, Y) :- A2 is X * A,
                 X2 is X - 1,
                 faux(X2, A2, Y).

fact3(X, Y) :- X <= 0, Y = "erro, X precisa ser > 0.".
fact3(X, Y) :- faux2(X, 1, Y).

faux2(0, Out, Out).
faux2(X, F, Out) :- 
        X2 is X - 1,
        F2 is X * F,
        faux2(X2, F2, Out).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Listas                           %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = [1, 2, 3, 4, 5].

[H | T] = [1, 2, 3, abc, "abc"].
|> H = 1
   T = [2, 3, abc, "abc"].

listsplit([H | T], H, T).

listsplit([1, 2, 3], 1, [2, 3])
|> true.

listsplit([1, 2, 3], H, T).
|> H = 1
   T = [2, 3]

listsplit(L, 1, [2, 3, 4, 5]).
|> [1, 2, 3, 4, 5].

[H1, H2 | T] = [1, 2, 3, 4, 5].
|> H1 = 1,
   H2 = 2,
   T = [3, 4, 5].

[H, H | T] = [1, 2, 3, 4, 5].
|> false.                      %% pq o primeiro e segundo elementos não são iguais

[H, H | T] = [1, 1, 3, 4, 5].
|> H = 1,
   T = [3, 4, 5]

[H | T] = [].
|> false

[H | T] = [1, 2].
|> H = 1,
   T = [2].

%% Escreva um predicado que dado um elemento identifique se ele está ou não na lista
%% chamar de member2 para não confundir com o que já existe
member2(E, [E | _]).
member2(E, [_ | T]) :- member(E, T).

member2(1, [1, 2, 3, 4]).
|> true.

member2(9, [1, 2, 3, 4]).
|> false.

member2(X, [1, 2, 3, 4]).
|> X = 1,
   X = 2,
   X = 3,
   X = 4.

%% se tentar achar todas as listas que contém 1 vira uma bagunça.
member2(1, L).
|> UM MONTE DE COISA.

%% Escreva o append(X, Y, Z)
%%  (append o Y no X e coloca no Z)
%% usar append2 para não dar conflito com o já definido
append2([], L2, L2).
append2([Xh | Xt], Y, [Xh | Z]) :- append2(Xt, Y, Z).

append2([1, 2, 3], [4, 5, 6], Z).
|> Z = [1, 2, 3, 4, 5, 6].

append2(X, Y, [a, b, c, d, e]).
%% vai retornar todas as maneiras possíveis de particionar em 2 listas.

%% Inverter uma lista
%% usar reverse2 para evitar conflito com o já existente
reverse2([], []).
reverse2([Xh | Xt], RevX) :-
                            reverse2(Xt, Yt),
                            append(Yt, [Xh], RevX).

%% Caudal com o método do acumulador
revappend([], Y, Y).
revappend([Xh, Xt], Y, Z) :-
                            revappend(Xt, [Xh | Y], Z).

reverse3(X, Y) :- revappend(X, [], Y).

%% Exercício
%% 
%% Escreva um predicado
%%   length(L, Sz)
%% que calcula o número de elementos de uma lista L.