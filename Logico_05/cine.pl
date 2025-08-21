/*
Predicado de la clase pasada:
pelicula(Pelicula, Genero).
*/

pelicula(viernes13, thriller).
pelicula(laLaLand, musical).
pelicula(backToTheFuture, cienciaFiccion).
pelicula(orgulloYPrejuicio, drama).
pelicula(dune, cienciaFiccion).
pelicula(starWars3, accion).
pelicula(terminator, accion).

trabajaEn(starWars3, nataliePortman, actor). % el actor es un átomo
trabajaEn(starWars3, ewanMcGregor, actor).
trabajaEn(terminator, arnoldSchwarzenegger, actor).
trabajaEn(laLaLand, emmaStonem, actor).
trabajaEn(laLaLand, ryanGosling, actor).
trabajaEn(orgulloYPrejuicio, keiraKnightley, actor).
trabajaEn(volverAlFuturo, michaelFox, actor).
trabajaEn(volverAlFuturo, christopherLoyd, actor).
trabajaEn(volverAlFuturo, rogerZemeckis, director()). % el director es un functor vacío, relaciona 0 individuos
trabajaEn(dune, timothyChamame, actor).
trabajaEn(viernes13, kevinBacon, actor).
trabajaEn(starWars3, georgeLucas, director()).
trabajaEn(starWars3, georgeLucas, guionista(250000)). % el guionista es un functor de aridad 1, relaciona 1 individuo
trabajaEn(starWars3, stevenSpielberg, productor(1000000)). % con el productor pasa lo mismo
trabajaEn(starWars3, johnWilliams, compositor([marchaImperial, dueloDelDestino], berkeley)). % el compositor tiene aridad 2, relaciona las piezas que compuso y la casa de estudios

premio(mejorActriz, nataliePortman).
premio(mejorActriz, emmaStone).
premiO(mejorDirector, rogerZemeckis).


critica(Pelicula, Estrellas) :-
    pelicula(Pelicula, _),
    findall(Puntaje, puntaje(Pelicula, Puntaje), Puntajes),
    sum_list(Puntajes, Estrellas).


puntaje(Pelicula, Puntaje) :-
    trabajaEn(Pelicula, Trabajador, Rol),
    puntajePorRol(Trabajador, Rol, Puntaje).


puntajePorRol(ryanGosling, _, 5).
puntajePorRol(Actor, actor, 5) :-
    premio(mejorActriz, Actor).
puntajePorRol(Actor, actor, 1) :-
    premio(_, Actor).
puntajePorRol(Director, director(), 2) :-
    premio(mejorDirector, Director).
puntajePorRol(Productor, productor(Presupuesto), Puntaje) :-
    Puntaje is Presupuesto * -0.01.
puntajePorRol(stevenSpielberg, productor(_), 10).
puntajePorRol(Guionista, guionista(CantidadDePalabras), Puntaje) :-
    Puntaje is CantidadDePalabras / 1000.
puntajePorRol(Compositor, compositor(Piezas, _), Puntaje) :-
    length(Piezas, CantidadDePiezas),
    Puntaje is CantidadDePiezas * 0.25.
