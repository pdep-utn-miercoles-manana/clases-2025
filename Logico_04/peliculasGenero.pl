/*
Predicado de la clase pasada:
pelicula(Pelicula, Genero).
*/

pelicula(viernes13, thriller).
pelicula(laLaLand, musical).
pelicula(backToTheFuture, cienciaFiccion).
pelicula(orgulloYPrejuicio, drama).
pelicula(seven, thriller).
pelicula(noRespires, thriller).
pelicula(dune, cienciaFiccion).

/* 
Se agregan nuevos predicados y queremos conocer:
    - De los musicales conocemos qué canciones la conforman.
    - De los thrillers conocemos los asesinatos que ocurren (el asesino y la víctima).
    - De las películas de ciencia ficción conocemos el año en el que se sitúan.
    - De los dramas se sabe los segmentos “dramáticos” que la componen. Puede ser “peleas”, “casorios”, “asesinatos”, “engaños”, “funerales” o “medio hermanos”.
    - De las películas de comedia y drama no importa nada más
*/

%cancion(Pelicula, Tema)
cancion(laLaLand, cityOfStars).
cancion(laLaLand, aLovelyNight).

%asesinato(Pelicula, Asesino, Víctima).
asesinato(viernes13, jason, fede).
asesinato(viernes13, jason, rama).
asesinato(viernes13, jason, dante).
asesinato(viernes13, jason, feli).
asesinato(viernes13, jason, lucho).
asesinato(viernes13, jason, joaco).
asesinato(noRespires, ciego, rocky).
asesinato(noRespires, money, ciego).

%año(Pelicula, Año)
anio(backToTheFuture, 2015).
anio(dune, 3001).

%segmento(Pelicula, Segmento)
segmento(orgulloYPrejuicio, peleas).
segmento(orgulloYPrejuicio, casorio).
segmento(orgulloYPrejuicio, enganio).
segmento(orgulloYPrejuicio, funeral).
segmento(orgulloYPrejuicio, mediosHermanos).

/* 
Se agregan nuevos predicados:
    - Saber si una peli de drama es un culebrón mexicano. Esto sucede cuando tiene una pelea, un casorio, un engaño y medio hermanos.
    - Saber si una peli de ciencia ficción es futurista, o sea que la peli ocurre en el año 3000 o más.
    - Saber si un thriller es de puro suspenso, o sea que no muere nadie.
    - Saber si un thriller es de un asesino serial. Esto se cumple si solo hay un asesino.
*/

%culebronMexicano(Pelicula)
culebronMexicano(Pelicula):-
    pelicula(Pelicula, drama),
    segmento(Pelicula, mediosHermanos),
    segmento(Pelicula, funeral),
    segmento(Pelicula, peleas).

%futurista(Pelicula)
futurista(Pelicula):-
    pelicula(Pelicula, cienciaFiccion),
    anio(Pelicula, Anio),
    Anio >= 3000.

%puroSuspenso(Pelicula)
puroSuspenso(Pelicula):-
    pelicula(Pelicula, thriller),
    not(asesinato(Pelicula, _, _)).

%asesinoSerial(Pelicula, Asesino) [Si lo pensamos como un forall donde para todos los asesinatos de una película se cumple que siempre los perpetra el mismo asesino]
asesinoSerial(Pelicula, Asesino) :-
    pelicula(Pelicula, thriller),
    asesinato(Pelicula, Asesino, _),
    forall(asesinato(Pelicula, OtroAsesino, _), sonElMismoAsesino(Asesino, OtroAsesino)).

sonElMismoAsesino(Asesino, Asesino).

%Como vimos la clase pasada, con la negación se puede llegar a una expresión equivalente al forall.
asesinoSerialBis(Pelicula, Asesino) :-
    pelicula(Pelicula, thriller),
    asesinato(Pelicula, Asesino, _),
    not(hayOtroAsesino(Pelicula, Asesino)).

hayOtroAsesino(Pelicula, Asesino) :-
    % asesinato(Pelicula, Asesino) -> Es importante entender que como este predicado fue pensado pura y exclusivamente para ser auxiliar no es necesaria esta línea, ya que no interesa que sea completamente inversible (Pelicula y Asesino siempre van a llegar ligadas).
    asesinato(Pelicula, OtroAsesino, _),
    not(sonElMismoAsesino(Asesino, OtroAsesino)).

%El not(sonElMismoAsesino(Asesino, OtroAsesino)) es equivalente a decir Asesino \= OtroAsesino

/* 
Por último, se agrega el requerimiento de saber un thriller es un slasher. Esto ocurre cuando hay 5 o más personas asesinadas.
*/
slayer(Pelicula):-
    pelicula(Pelicula, thriller),
	asesinatosTotales(Pelicula, Cantidad),
	Cantidad > 5.

/* 
Acuerdense que habíamos llegado a la conclusión de que la cantidad de víctimas para una película determinada es igual a la cantidad de respuestas para la consulta asesinato(Pelicula, _, Victima), donde Pelicula debería unificarse con la película en cuestión.
Y que no nos servía trabajar con las respuestas individuales de a dicha consulta, sino que lo que necesitabamos era poder trabajarlas como un conjunto para, por ejemplo, contarlas.
Con esto último en mente planteamos:

asesinatosTotales(Pelicula, CantidadDeVictimas):-
    * Algo que genere la lista de víctimas *
    length(Asesinatos, CantidadDeVictimas).
Y como vimos eso se lograba con un predicado "nuevo" -> findall
*/

asesinatosTotales(Pelicula, CantidadDeVictimas):-
    findall(Victima, asesinato(Pelicula, _, Victima), Asesinatos),
    length(Asesinatos, CantidadDeVictimas).

/* 
    Por último, es importante entender que asesinatosTotales está siendo utilizado como un predicado auxiliar al que llega ligada la película.
    Si si utilizara asesinatosTotales de forma independiente o no se ligara la película en slayer previamente a la aparición del precidado asesinatosTotales, funcionaría todo y sintáctiamente estaría perfecto.
    Sin embargo, la consulta que se estaría realizando sería totalmente distinta a la que pretendemos o creemos estar haciendo. Se estaría preguntando si la cantidad total de asesinatos para todas las películas es mayor a 5.
*/



