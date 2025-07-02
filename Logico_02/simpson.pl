padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).

madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).

% ti
tieneHijo(Personaje) :- padreDe(Personaje, _).
tieneHijo(Personaje) :- madreDe(Personaje, _).

hermanos(Hermano1, Hermano2) :-
    compartenPadre(Hermano1, Hermano2),
    compartenMadre(Hermano1, Hermano2).

medioHermano(Hermano1, Hermano2) :-
    compartenPadre(Hermano1, Hermano2),
    not(compartenMadre(Hermano1, Hermano2)).

medioHermano(Hermano1, Hermano2) :-
    compartenMadre(Hermano1, Hermano2),
    not(compartenPadre(Hermano1, Hermano2)).

compartenPadre(Hermano1, Hermano2) :-
    padreDe(Padre, Hermano1),
    padreDe(Padre, Hermano2),
    Hermano1 \= Hermano2.

compartenMadre(Hermano1, Hermano2) :-
    madreDe(Madre, Hermano1),
    madreDe(Madre, Hermano2),
    Hermano1 \= Hermano2.






