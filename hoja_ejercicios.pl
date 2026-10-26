/*
Resolver el problema del cálculo del máximo común divisor de dos números, 
utilizando el método de Euclides. Su regla debe ser de aridad 3, 
los primeros dos argumentos recibirán el mayor y el menos enteros, 
y el tercer argumento retornará el resultado. Por ejemplo, 
si se quiere calcular el mcd de 70 y 40 se consultará: 
?- mcd(70, 40, Resp). La respuesta sería 10.
*/

% Usamos el algoritmo de Euclides: si el residuo de dividir M entre N es cero, el MCD es N; de lo contrario, repetimos con N y el residuo.
mcd(M, 0, M) :-
    M > 0, !.

mcd(M, N, R) :-
    N > 0,
    Residuo is M mod N,
    mcd(N, Residuo, R).

/*
Dado un valor entero, mostrar cada uno de los dígitos que lo componen en una línea diferente. 
Por ejemplo, si se quiere mostrar los dígitos de 5497, podría consultarse: 
?- mostrarDigitos(5479). La respuesta sería: 7 9 4 5
*/

% El residuo es el último dígito y el cociente contiene los demás. 
% Como el ejemplo muestra los dígitos al revés, imprimimos primero el residuo.

% Caso base: N tiene un solo dígito (menor que 10)
mostrarDigitos(N) :-
    N >= 0,
    N < 10,
    writeln(N), !.

% Caso recursivo: N tiene dos o más dígitos (mayor o igual a 10)
mostrarDigitos(N) :-
    N >= 10,
    Digito is N mod 10,
    writeln(Digito),
    Resto is N // 10,
    mostrarDigitos(Resto).

/*
Dado un valor entero, almacenar cada uno de los dígitos que lo componen en una lista, un dígito por casilla. 
Por ejemplo, si se quiere almacenar el número 82671, podría consultarse: 
?- almacenar(82671, L). La respuesta sería: L = [1, 7, 6, 2, 8]
*/

almacenar(N, [N]) :-
    N >= 0,
    N < 10, !.

almacenar(N, [Digito|RestoLista]) :-
    N >= 10,
    Digito is N mod 10,
    Resto is N // 10,
    almacenar(Resto, RestoLista).

/*
Metamorfosis de las ranas: 
rana_adulta → huevo → embrion → renacuajo → renacuajo_dos_patas → renacuajo_cuatro_patas → rana_cola_corta → rana_adulta
*/

fase(rana_adulta).
fase(huevo).
fase(embrion).
fase(renacuajo).
fase(renacuajo_dos_patas).
fase(renacuajo_cuatro_patas).
fase(rana_cola_corta).

sigue(rana_adulta, huevo).
sigue(huevo, embrion).
sigue(embrion, renacuajo).
sigue(renacuajo, renacuajo_dos_patas).
sigue(renacuajo_dos_patas, renacuajo_cuatro_patas).
sigue(renacuajo_cuatro_patas, rana_cola_corta).
sigue(rana_cola_corta, rana_adulta).

/*
Ahora creamos una regla que muestre las fases siguientes hasta regresar a la fase inicial. 
Para evitar que el ciclo se repita infinitamente, llevamos una lista de fases visitadas.
*/
metamorfosis(Fase) :-
    var(Fase), !,
    writeln('Error: debe proporcionar una fase.'),
    fail.

metamorfosis(Fase) :-
    \+ fase(Fase), !,
    write('Error: la fase no existe: '),
    writeln(Fase),
    fail.

metamorfosis(Fase) :-
    writeln(Fase),
    metamorfosis_aux(Fase, Fase, [Fase]).

metamorfosis_aux(Inicio, Actual, Visitadas) :-
    sigue(Actual, Siguiente),
    (   Siguiente = Inicio
    ->  writeln(Siguiente),
        writeln('La metamorfosis ha completado el ciclo.')
    ;   member(Siguiente, Visitadas)
    ->  writeln('Ya no hay más fases.')
    ;   writeln(Siguiente),
        metamorfosis_aux(Inicio, Siguiente, [Siguiente|Visitadas])
    ).

/*
Elabore una regla que reciba una lista que contenga sublistas en las que se especifican carácteres 
y la cantidad de veces que se desea repetir cada uno. 
La regla debe retornar una lista con las secuencias de carácteres repetidos. Por ejemplo, si se realiza la consulta: 
?- crearSecuencia([[3, x], [4, y], [2, z]], W). El resultado será: W = [[x, x, x], [y, y, y, y], [z, z]]
*/
crearSecuencia([], []).

crearSecuencia([[N, Caracter]|Resto], [ListaCaracteres|Resultado]) :-
    repetir(N, Caracter, ListaCaracteres),
    crearSecuencia(Resto, Resultado).

repetir(0, _, []) :- !.

repetir(N, Caracter, [Caracter|Resto]) :-
    N > 0,
    N1 is N - 1,
    repetir(N1, Caracter, Resto).

/*
Dados dos números enteros, M y N, construir y retornar una lista 
que contenga los productos de los dígitos de las mismas potencias de diez de ambos números. 
Esto debe realizarlo si ambos números tienen la misma cantidad de dígitos. 
Si no tienen la misma cantidad de dígitos, muestre un mensaje indicando que la operación no se puede realizar y termine en fallo. 
Por ejemplo, si se digita: ?- generarLista(246, 357, W). El resultado será: W = [6, 20, 42].
*/
generarLista(M, N, W) :-
    almacenar(M, LM),
    almacenar(N, LN),
    length(LM, CantM),
    length(LN, CantN),
    (   CantM =:= CantN
    ->  multiplicarDigitos(LM, LN, ListaInvertida),
        reverse(ListaInvertida, W)
    ;   writeln('Error: los números deben tener la misma cantidad de dígitos.'),
        fail
    ).

multiplicarDigitos([], [], []).

multiplicarDigitos([A|RestoA], [B|RestoB], [P|RestoP]) :-
    P is A * B,
    multiplicarDigitos(RestoA, RestoB, RestoP).

/*
Elabore una cláusula de aridad 2 que reciba un número entero en el primer argumento 
y en el segundo indique la suma de los dígitos que contiene el número proporcionado. 
Por ejemplo, si se consulta: ?- sumardigitos(837, X), entonces Prolog responde: X = 18.
*/

sumardigitos(N, N) :-
    N >= 0,
    N < 10, !.

sumardigitos(N, Suma) :-
    N >= 10,
    Digito is N mod 10,
    Resto is N // 10,
    sumardigitos(Resto, SumaResto),
    Suma is Digito + SumaResto.

/*
Dados los valores enteros X y N, construya una regla de aridad tres que retorne la lista: L=[X, X+1, X+2, X+3, ..., X+N]. 
Por ejemplo, si se realiza la consulta: crearSecuencia(12, 5, L), la respuesta sería: L=[12, 13, 14, 15, 15, 16, 17].
*/

crearSecuencia(X, 0, [X]) :- !.

crearSecuencia(X, N, [X|Resto]) :-
    N > 0,
    X1 is X + 1,
    N1 is N - 1,
    crearSecuencia(X1, N1, Resto).

/*
Dado un árbol binario, recorrerlo en Inorden y guardar todos sus elementos en una lista lineal. 
Por ejemplo, si se realiza la consulta: 
pasar_a_lista([ [ [ [ ], 1, [ ] ], 3, [[ ], 4, [ ] ] ], 5, [ [ ], 9, [ [ ], 11, [ ] ] ] ], L). 
la respuesta sería: L=[1, 3, 4, 5, 9, 11].
*/

pasar_a_lista([], []).

pasar_a_lista([SubI, Raiz, SubD], L) :-
    pasar_a_lista(SubI, L1),
    pasar_a_lista(SubD, L2),
    append(L1, [Raiz|L2], L).