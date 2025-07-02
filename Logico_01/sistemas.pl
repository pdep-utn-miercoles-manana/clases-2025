% materia/2
% materia(Nombre, Año).

materia(paradigmas, 2).
materia(sintaxis, 2).
materia(analisis2, 2).
materia(analisis1, 1).
materia(desarolloSW, 3).

% profesor/3
% profesor(Profesor, Materia, Curso).
profesor(fede, paradigmas, k2103).
profesor(feli, paradigmas, k2103).
profesor(fede, desarolloSW, k3053).
profesor(bruno, sintaxis, k2103).

% esFacil/1
% una materia es fácil si está después de tercer año, si la da el profesor lautaro, o si es ingeniería y sociedad.

esFacil(NombreMateria) :- 
  materia(NombreMateria, Anio),
  Anio > 3.

esFacil(NombreMateria) :-
  profesor(lautaro, NombreMateria, _).

esFacil(ingenieriaYSociedad).

% profeDe/2
% relaciona a un profesor con los años en los que da clase.

profeDe(Profe, Anio) :-
  profesor(Profe, NombreMateria, _),
  materia(NombreMateria, Anio).

% correlativa/2
% correlativa(Materia, MateriaMadre).

correlativa(paradigmas, discreta).
correlativa(paradigmas, algoritmos).
correlativa(analisis2, analisis1).

% sonCorrelativas/2
% se cumple si dos materias son correlativas directa o indirectamente.

sonCorrelativas(Materia, MateriaMadre):-
  correlativa(Materia, MateriaMadre).

sonCorrelativas(Materia, MateriaMadre):-
  correlativa(Materia, MateriaEnElMedio),
  sonCorrelativas(MateriaEnElMedio, MateriaMadre).

% expertoEnElTema/1
% se cumple para un profesor que da dos materias correlativas.

expertoEnElTema(Profesor):-
  profesor(Profesor, Materia1, _),
  profesor(Profesor, Materia2, _),
  sonCorrelativas(Materia1, Materia2).

% masDeUnCursoDe/2
% relaciona a un profesor y una materia si da más de un curso de esa materia

masDeUnCursoDe(Profesor, NombreMateria):-
  profesor(Profesor, NombreMateria, Curso1),
  profesor(Profesor, NombreMateria, Curso2),
  Curso1 \= Curso2.


%legajo(nombre, legajo)
legajo(fede, 1231662).
legajo(ale, 1595465).
legajo(joaco, 2026399).
legajo(mili, 2140998).
legajo(francisco, 2223326).

cursada(fede, k2026, 6, 6).
cursada(ale, k2003, 6, 6).
cursada(joaco, k2003, 10, 6).
cursada(fede, k2126, 2, 4).
cursada(fede, k2126, 8, 8).
cursada(ale, k4003, 2, 2).

curso(k2126, sintaxis, 2007).
curso(k2126, sintaxis, 2010).
curso(k2026, paradigmas, 2010).
curso(k2003, paradigmas, 2017).
curso(k2003, paradigmas, 2022).
curso(k4003, adr, 2022).

% existe alguna cursada donde promedia 6 o más
aprueba(Alumno, Materia) :-
  promediaMasDe(Alumno, Materia, 6).

promociona(Alumno, Materia) :-
  promediaMasDe(Alumno, Materia, 8).

% no devuelve!!!!!!!
promedio(Alumno, Materia, Promedio) :-
  cursada(Alumno, CodigoCurso, Nota1, Nota2),
  Promedio is (Nota1 + Nota2) / 2,
  curso(CodigoCurso, Materia, _).

promediaMasDe(Alumno, Materia, NotaMinima) :-
  promedio(Alumno, Materia, Promedio),
  Promedio >= NotaMinima.

recursa(Alumno, Materia) :-
  haCursado(Alumno, Materia),
  not(aprueba(Alumno, Materia)).

haCursado(Alumno, Materia) :-
  curso(Codigo, Materia, _),
  cursada(Alumno, Codigo, _, _).

ingresante(Alumno) :-
  legajo(Alumno, _),
  not(haCursado(Alumno, _)).













