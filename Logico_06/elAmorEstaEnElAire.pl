% Agregar estos predicados a la base de conocimiento si lo querés correr
%
% persona(Nombre, Edad, Genero).
% interesEdad(Persona, EdadMinima, EdadMaxima).
% interesGenero(Persona, Genero).
% interesGustos(Personas, Gustos, Disgustos).


%% Registro

perfilIncompleto(Persona) :-
  persona(Persona, _, _),
  not(perfilCompleto(Persona)).

perfilCompleto(Persona) :-
  interesEdad(Persona, _, _),
  interesGenero(Persona, _),
  gustosParaPerfil(Persona),
  mayorDeEdad(Persona).

gustosParPerfil(Persona) :-
  interesGustos(Persona, Gustos, Disgustos),
  cincoOMas(Gustos),
  cincoOMas(Disgustos).

cincoOMas(Gustos) :-
  length(Gustos, Cantidad),
  Cantidad >= 5.

mayorDeEdad(Persona) :-
  persona(Persona, Edad, _),
  Edad >= 18.


%% Análisis

almaLibre(Persona) :-
  persona(Persona, _, _),
  interesPorTodosORangoAmplio(Persona).

interesPorTodosORangoAmplio(Persona) :-
  forall(genero(Genero), interesGenero(Persona, Genero)).

genero(Genero) :-
  persona(_, _, Genero).

interesPorTodosORangoAmplio(Persona) :-
  interesEdad(Persona, EdadMinima, EdadMaxima),
  diferenciaDe30(EdadMaxima, EdadMinima).

diferenciaDe30(EdadMayor, EdadMenor) :-
  Diferencia is EdadMayor - EdadMenor,
  Diferencia > 30.

quiereLaHerencia(Persona) :-
  persona(Persona, Edad, _),
  interesEdad(Persona, EdadMinima, _),
  diferenciaDe30(EdadMinima, Edad).

indeseable(Persona) :-
  persona(Persona, _, _),
  not(pretendienteDe(Persona, _)).


%% Matches

pretendienteDe(Persona, OtraPersona) :-
  coincideInteres(Persona, OtraPersona),
  gustoEnComun(Persona, OtraPersona).

coincideInteres(Persona, OtraPersona) :-
  persona(Persona, _, _),
  persona(OtraPersona, Edad, Genero),
  interesGenero(Persona, Genero),
  estaEnRangoDeEdadPara(Persona, Edad).

estaEnRangoDeEdadPara(Persona, Edad) :-
  interesEdad(Persona, EdadMinima, EdadMaxima),
  between(EdadMinima, EdadMaxima, Edad).

gustoEnComun(Persona, OtraPersona) :-
  gustoDe(Persona, Gusto),
  gustoDe(OtraPersona, Gusto).

gusto(Persona, Gusto) :-
  interesGustos(Persona, Gustos, _),
  member(Gusto, Gustos).

hayMatch(Persona, OtraPersona) :-
  pretendienteDe(Persona, OtraPersona),
  pretendienteDe(OtraPersona, Persona).

trianguloAmoroso(Persona1, Persona2, Persona3) :-
  leGustaSinMatch(Persona1, Persona2),
  leGustaSinMatch(Persona2, Persona3),
  leGustaSinMatch(Persona3, Persona1).

leGustaSinMatch(Persona, OtraPersona) :-
  pretendienteDe(Persona, OtraPersona),
  not(hayMatch(Persona, OtraPersona)).

amorDeSuVida(Persona, OtraPersona) :-
  hayMatch(Persona, OtraPersona),
  leGustaTodoSinDisgustarNada(Persona, OtraPersona),
  leGustaTodoSinDisgustarNada(OtraPersona, Persona).

leGustaTodoSinDisgustarNada(Persona, OtraPersona) :-
  forall(gustoDe(Persona), not(disgustoDe(OtraPersona))).

% si hacen la equivalencia, también puede resolverse sin forall:
%    ∀x ( p(x) => ~q(x))
%    ∀x (~p(x) v  ~q(x))
% ~~(∀x (~p(x) v  ~q(x)))
%  ~(∃x ( p(x) ^   q(x)))
% queda: not((gustoDe(Persona), disgustoDe(OtraPersona))).


%% Mensajes

% Agregar este predicado a la base de conocimiento si lo querés correr
% indiceDeAmor(Persona, OtraPersona, Indice).

desbalance(Persona, OtraPersona) :-
  promedioDeIndiceDeAmor(Persona, OtraPersona, Indice1),
  promedioDeIndiceDeAmor(OtraPersona, Persona, Indice2),
  masDelDoble(Indice1, Indice2).

promedioDeIndiceDeAmor(Persona, OtraPersona, Promedio) :-
  findall(Indice, indiceDeAmor(Persona, OtraPersona, Indice), Indices),
  length(Indices, Cantidad),
  sumlist(Indices, Suma),
  Promedio is Suma / Cantidad.

masDelDoble(Numero1, Numero2) :-
  Doble is Numero1 * 2,
  Doble < Numero2.

masDelDoble(Numero1, Numero2) :-
  Doble is Numero2 * 2,
  Doble < Numero1.

ghostea(Persona, OtraPersona) :-
  leEscribioPeroNoResponde(Persona, OtraPersona).

leEscribioPeroNoResponde(Persona, OtraPersona) :-
  indiceDeAmor(Persona, OtraPersona, _),
  not(indiceDeAmor(OtraPersona, Persona, _)).
