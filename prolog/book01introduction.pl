%%% humans
human(david).
human(john).
human(suzie).
human(eliza).

man(david).
man(john).

woman(suzie).
woman(eliza).

parent(david, john).
parent(john, eliza).
parent(suzie, eliza).

%%% public transport
transport(dresden, train).
transport(amsterdam, train).
transport(amsterdam, subway).
transport(new_york, subway).

%% rules
father(F, C) :- parent(F, C), man(F).
mother(M, C) :- parent(M, C), woman(M).

%% testing different
dif2(A, B) :- \+ A = B.

%% testing rest
rest(A, B, R) :- R is A mod B.