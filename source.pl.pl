connect(a, b, 5).
connect(a, d, 10).
connect(b, d, 2).
connect(b, e, 9).
connect(c, a, 8).
connect(c, f, 5).
connect(d, c, 4).
connect(d, e, 6).
connect(d, g, 4).
connect(d, f, 11).
connect(e, g, 2).
connect(g, f, 1).

findPath(X, Y, W, [X,Y], _) :- connect(X, Y, W).

findPath(X, Y, W, [X|P], V) :- \+ member(X, V),
                                 connect(X, Z, W1),
                                 findPath(Z, Y, W2, P, [X|V]),
                                 W is W1 + W2.

stack(E, S, [E|S]).

pathLength([X,Y], W) :- connect(X, Y, W).

pathLength([X|List], W) :-
    stack(Y, _, List),
    connect(X, Y, W1),
    pathLength(List, W2),
    W is W1 + W2.

path(X, Y, Length, Path) :-
    findPath(X, Y, Length, P, []),
    atomic_list_concat(P, Path).
