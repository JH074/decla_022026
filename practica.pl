% LISTAS

% Quemar listas:
mis_elementos([carro, casa, arbol, bici]).
numeros_prueba([1, 5, 6]).

% MEMBER: Comprueba si un elemento pertenece a una lista.
% para poder hacer la consulta a la lista quemada: mis_elementos(L), member(casa,L). y devuelve: L = [carro, casa, arbol, bici] .
% si no está quemada, se le pasa como lista en el segundo argumento: member(casa, [carro, casa, arbol, bici]). y devuelve true si está

%-------------------------------------------------------------
% OBTENER LA LONGITUD DE LA LISTA
%-------------------------------------------------------------
list_length([], 0). %caso base: lista vacia

%se le pasa la cola
list_length([_|Tail], N) :-
    list_length(Tail, TailLength),
    N is TailLength + 1.

%-------------------------------------------------------------
% MERGE SORT
%-------------------------------------------------------------
split([], [], []). 
split([A], [A], []). 
split([A,B|R], [A|Ra], [B|Rb]) :-
    split(R, Ra, Rb). 

merge(A, [], A). %Si una de las sublistas se queda vacía, simplemente se devuelven los elementos restantes de la otra
merge([], B, B).
%Compara los primeros elementos A y B de ambas sublistas ordenadas
merge([A|Ra], [B|Rb], [A|M]) :-  %Si A =< B, coloca A primero y continúa mezclando la cola Ra con [B|Rb]
    A =< B,
    merge(Ra, [B|Rb], M).

merge([A|Ra], [B|Rb], [B|M]) :- %Si A > B, coloca B primero y continúa mezclando [A|Ra] con la cola Rb
    A > B,
    merge([A|Ra], Rb, M).

% Ejemplo de consulta: mergesort([7, 9, 12-14], S).
mergesort([], []).
mergesort([A], [A]).

mergesort([A,B|R], S) :-
    split([A,B|R], L1, L2),
    mergesort(L1, S1),
    mergesort(L2, S2),
    merge(S1, S2, S).

%-------------------------------------------------------------
% WRITE
%-------------------------------------------------------------
ejemplo_escritura(X) :-
    is(W, *(4, **(X, 2))),
    write('El resultado es: '),
    write(W).

%-------------------------------------------------------------
% RECURSION DIRECTA E INDIRECTA
%-------------------------------------------------------------
% Directa
contar(0, 0).

contar(N, R) :-
    N > 0,
    N1 is N - 1,
    contar(N1, R1),
    R is R1 + 1.

% Indirecta
predicado_a :-
    predicado_b.

predicado_b :-
    predicado_a.

%-------------------------------------------------------------
% RECURSION DE COLA Y POR POSPOSICION
%-------------------------------------------------------------
% De cola - ejemplo de consulta: longitud_acum([a,b,c], 0, N). (es el mejor)
longitud_acum([], N, N).

longitud_acum([_|T], Acum, N) :-
    Acum1 is Acum + 1,
    longitud_acum(T, Acum1, N).

% Por posposicion - ejemplo de consulta: longitud([1,2,3], M).
longitud([], 0).

longitud([_|T], N) :-
    longitud(T, N1),
    N is N1 + 1.

%-------------------------------------------------------------
% RECORRIDOS: PREORDEN, INORDEN, POSTORDEN
%-------------------------------------------------------------
% Preorden: raiz, izq, der
mostrarArbolPreorden([]).
mostrarArbolPreorden([SubAI, DatoN, SubAD]) :-
    write(DatoN), write(' '),
    mostrarArbolPreorden(SubAI),
    mostrarArbolPreorden(SubAD).

% Inorden: izq, raiz, der
mostrarArbolInorden([]).
mostrarArbolInorden([SubAI, DatoN, SubAD]) :-
    mostrarArbolInorden(SubAI),
    write(DatoN), write(' '),
    mostrarArbolInorden(SubAD).

% Postorden: izq, der, raiz
mostrarArbolPostorden([]).
mostrarArbolPostorden([SubAI, DatoN, SubAD]) :-
    mostrarArbolPostorden(SubAI),
    mostrarArbolPostorden(SubAD),
    write(DatoN), write(' ').

%-------------------------------------------------------------
% ÁRBOL BINARIO DE BÚSQUEDA (ABB)
%-------------------------------------------------------------
% Caso 1: Árbol vacío o final del camino
buscarABB(Dato, []):-
    write('El dato: '), write(Dato), write(', NO se encuentra en el arbol'), !.

% Caso 2: Dato encontrado en la raíz actual
buscarABB(Dato, [_, Dato, _]):-
    write('Se ha ENCONTRADO el dato: '), write(Dato), !.

% Caso 3: El dato es menor que la raíz -> buscar a la izquierda
buscarABB(Dato, [SubAI, DatoN, _]):-
    Dato < DatoN,
    buscarABB(Dato, SubAI), !.

% Caso 4: El dato es mayor que la raíz -> buscar a la derecha
buscarABB(Dato, [_, DatoN, SubAD]):-
    Dato > DatoN,
    buscarABB(Dato, SubAD).

%-------------------------------------------------------------
% ALTURA DE UN ÁRBOL Y CANTIDAD DE NODOS DE UN ÁRBOL
%-------------------------------------------------------------
altura([], 0) :- !.

altura([SubAI, _, SubAD], H) :-
    altura(SubAI, HI),
    altura(SubAD, HD),
    H is 1 + max(HI, HD).

contarNodos([], 0).

contarNodos([SubAI, _, SubAD], N) :-
    contarNodos(SubAI, NI),
    contarNodos(SubAD, ND),
    N is NI + ND + 1.

% ESCRIBIR EN UN ARCHIVO - ESTE SE SOBREESCRIBE
%?- tell('misalida.txt'),
%   write('Te amo'),
%  told.

%-------------------------------------------------------------
% RECURSIÓN INFINITA SOLUCIÓN
%-------------------------------------------------------------
conoce(ana, bea).
conoce(bea, carlos).
conoce(carlos, ana).
conoce(carlos, diana).

desea_conocer_v4(X, Y, W):-
    desea_conocer_v4_rec(X, Y, [], L),
    append(L, [X], W).

desea_conocer_v4_rec(X, Y, L, [Y|L]):-
    conoce(X, Y),
    !.

desea_conocer_v4_rec(X, _, L, _):-
    conoce(X, Z),
    member(Z, L),
    fail.

desea_conocer_v4_rec(X, Y, L, Lfin):-
    conoce(X, Z),
    not(member(Z, L)),
    desea_conocer_v4_rec(Z, Y, [Z|L], Lfin).

%-------------------------------------------------------------
% atom/1: comprueba si el argumento es un átomo (indivisible o individual), solo palabras.
% atomic/1: comprueba si es un átomo o un número.
% float/1, integer/1: Comprueban si un valor es decimal de punto flotante o entero, respectivamente.
% number/1: comprueba si el argumento es un número, entero o decimal. 
% var/1: comprobar si una variable está libre
% nonvar/1: comprobar si no es una variable libre
% eval/1: evaluar una expresión
% 
%-------------------------------------------------------------

%-------------------------------------------------------------
% DERIVADAS: d(Variable, Funcion, Derivada).
%-------------------------------------------------------------
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

% Derivada de la suma de dos funciones:
d(Var, F+G, DF+DG):-
    atomic(Var), d(Var, F, DF), d(Var, G, DG).

% DERIVADAS PARA SU POSTERIOR EVALUACION:

% Derivada de una constante:
d(Var, N, 0):-
    var(Var), number(N),  !.

% Derivada de una variable respecto a sí misma:
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

%-------------------------------------------------------------
% INTEGRALES
%-------------------------------------------------------------
:- dynamic evalI/2.

% Integral de una constante:
s(Var, K, K*Var):-
    atomic(Var), number(K), !.

% Integral de una variable respecto a sí misma:
s(Var, Var, 1/2*Var^2):-
    atomic(Var), !.

% Integral de una variable elevada a la N (potencia):
s(Var, Var^N, 1/M*Var^M):-
    atomic(Var), number(N), is(M, +(N,1)), !.

% Integral de una constante por una variable elevada a la N:
s(Var, K*Var^N, K/M*Var^M):-
    atomic(Var), number(K), number(N), is(M, +(N,1)), !.

% INTEGRALES PARA EVALUACION:
% Integral de una variable elevada a la N:
s(Var, Var^N, 1/M*Var^M):-
    var(Var), number(N), is(M, +(N,1)), !.




