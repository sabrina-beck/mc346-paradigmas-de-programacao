%%% family tree
woman(edwirges).
woman(neli).
woman(tania).
woman(mirna).
woman(corina).
woman(larissa).
woman(sabrina).

man(edvin).
man(luis).
man(felipe).
man(tito).
man(paulo).
man(carlos).
man(pedro).
man(newton).

parent(edwirges, neli).
parent(edwirges, tania).
parent(edwirges, mirna).
parent(edwirges, luis).
parent(edvin, neli).
parent(edvin, tania).
parent(edvin, mirna).
parent(edvin, luis).
parent(neli, sabrina).
parent(neli, newton).
parent(tania, larissa).
parent(tania, carlos).
parent(tania, pedro).
parent(mirna, tito).
parent(mirna, paulo).
parent(luis, corina).
parent(luis, felipe).

%%List the women in the database
% woman(W).
%%List the children in the database
% parent(_, Child).
%%List all combinations of a father and his son.
% parent(Father, Son), man(Father), man(Son).
%%which women have both a father and a son in the database?
% woman(W), parent(Father, W), parent(W, Son), man(Father), man(Son).

syster_of(S, P) :- woman(S),
                   dif(S, P),
                   parent(X, S),
                   parent(X, P).