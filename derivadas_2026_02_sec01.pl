% DERIVADAS PLENAMENTE SIMBOLICS:

% Derivada de una constante:

d(Var, Exp1, 0):-
    atomic(Var), number(Exp1),  !.


% Derivara de una variable respecto a sí misma:

d(Var, Exp1, 1):-
    atomic(Var), ==(Exp1, Var), !.


% Derivada de una constante por una variable:

d(Var, N*Var, N):-
    atomic(Var),  !.


% Derivada de una variable elevada a la N:

d(Var, Var^N, N*Var^Nm1):-
    atomic(Var),  is(Nm1, -(N, 1)), !.


% Derivada de una constante por una variable elevada a la N:

d(Var, K*Var^N, C*Var^Nm1):-
    atomic(Var), number(N), is(C, K*N), is(Nm1, -(N, 1)), !.


% Derivada del logaritmo natural de una variable:

d(Var, log(Var), 1/Var):-
    atomic(Var), !.


% Drivada del seno de una varable:

d(Var, sen(Var), cos(Var)):-
    atomic(Var), !.


% Drivada del coseno de una varable:

d(Var, cos(Var), -sen(Var)):-
    atomic(Var), !.


% Drivada de la tagente de una varable:

d(Var, tan(Var), (sec(Var))^2):-
    atomic(Var), !.


% Derivada de la suma de pos funcione:

d(Var, F+G, DF+DG):-
    atomic(Var), d(Var, F, DF), d(Var, G, DG).


% DERIVADAS PARA SU POSTERIOR EVALUACION:

% Derivada de una constante:

d(Var, N, 0):-
    var(Var), number(N),  !.


% Derivara de una variable respecto a sí misma:

d(Var, Var, 1):-
    var(Var), !.


% Derivada de una constante por una variable:

d(Var, N*Var, N):-
    var(Var),  !.


% Derivada de una variable elevada a la N:

d(Var, Var^N, N*Var^Nm1):-
    var(Var),  is(Nm1, -(N, 1)), !.


% Derivada de una constante por una variable elevada a la N:

d(Var, K*Var^N, C*Var^Nm1):-
    var(Var), number(N), is(C, K*N), is(Nm1, -(N, 1)), !.


% Derivada del logaritmo natural de una variable:

d(Var, log(Var), 1/Var):-
    var(Var), !.


% Drivada del seno de una varable:

d(Var, sen(Var), cos(Var)):-
    var(Var), !.


% Drivada del coseno de una varable:

d(Var, cos(Var), -sen(Var)):-
    var(Var), !.


% Drivada de la tagente de una varable:

d(Var, tan(Var), (sec(Var))^2):-
    var(Var), !.


% Derivada de la suma de pos funcione:

d(Var, F+G, DF+DG):-
    var(Var), d(Var, F, DF), d(Var, G, DG).


