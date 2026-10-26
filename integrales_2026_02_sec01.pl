% Integral de una constante:

s(Var, K, K*Var):-
    atomic(Var), number(K), !.


% Integral de una variable respecto a sí misma:

s(Var, Var, 1/2*Var^2):-
    atomic(Var), !.



% Integral de una variable elevada a la N:

s(Var, Var^N, 1/M*Var^M):-
    atomic(Var), number(N), is(M, +(N,1)), !.


% Integral de una constante por una variable elevada a la N:

s(Var, K*Var^N, K/M*Var^M):-
    atomic(Var), number(K), number(N), is(M, +(N,1)), !.


% INTEGRALES PARA EVALUACION:

% Integral de una variable elevada a la N:

s(Var, Var^N, 1/M*Var^M):-
    var(Var), number(N), is(M, +(N,1)), !.
