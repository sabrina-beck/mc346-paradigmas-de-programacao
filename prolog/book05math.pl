%% plus
plus(A, B, C) :- C is A + B.

%% sigma
sigma(A, A, A).
sigma(A, B, N) :- A < B,
                  A1 is A + 1,
                  sigma(A1, B, N1),
                  N is A + N1.