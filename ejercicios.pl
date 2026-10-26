%Escribe un predicado mcd/3 que reciba dos enteros positivos 
%y retorne su máximo común divisor mediante el algoritmo de Euclides.

% Caso base: Si el segundo número es 0, el MCD es el primer número.
mcd(A, 0, A) :- 
    number(A),
    A > 0.

% Caso recursivo: Calcula el residuo y vuelve a llamarse a sí mismo.
mcd(A, B, R) :-
    number(A),
    number(B),
    B > 0,
    Residuo is A mod B,
    mcd(B, Residuo, R).

% Escribe almacenar/2, que transforme un número entero positivo 
% en una lista de sus dígitos, desde el último hasta el primero.
% Si el número es 0, su lista de dígitos es [0]
almacenar(0, []).

almacenar(N, [D|L]) :-
    N > 0,
    D is N mod 10, %obtiene el último dígito.
    Resto is N // 10, %elimina el último dígito mediante división entera.
    almacenar(Resto, L).

% Escribe sumardigitos/2 para sumar todos los dígitos 
% de un número entero positivo.
% ?- sumardigitos(837, R).
% R = 18.

sumardigitos(0, 0).

sumardigitos(N, S) :-
    N > 0,
    D is N mod 10,
    Resto is N // 10,
    sumardigitos(Resto, S1),
    S is D + S1.

% Escribe crearSecuencia/3 que reciba X y N, y genere una lista 
%desde X hasta X+N, incluyendo ambos extremos.

crearSecuencia(X, 0, [X]) :- !.
crearSecuencia(X, N, [X|L]) :-
    N > 0,
    X1 is X + 1,
    N1 is N - 1,
    crearSecuencia(X1, N1, L).
    
% Escribe intercalar/3 
% para combinar dos listas de igual longitud alternando sus elementos.

intercalar([],L,L):- !.
intercalar([X1|L1], L2 ,[X1|L3]):-
    intercalar(L2,L1,L3).

% Escribe pasar_a_lista/2 para convertir un árbol binario 
% en una lista con sus elementos en recorrido Inorden.
% La representación es [Izquierdo, Raíz, Derecho] y 
% el árbol vacío es [].
pasar_a_lista([], []):- !. % El árbol vacío genera una lista vacía
pasar_a_lista([SubI, Raíz, SubD], L):-
    pasar_a_lista(SubI, L1),  % 1. Recorre subárbol izquierdo
    pasar_a_lista(SubD, L2),  % 2. Recorre subárbol derecho
    append(L1, [Raiz|L2], L). % 3. Unimos la L1 (izq), con la raiz y L2(der)

%sumar una lista
sumar([], 0).

sumar([Cabeza|Cola], Total) :-
    sumar(Cola, Parcial),
    Total is Parcial + Cabeza.
