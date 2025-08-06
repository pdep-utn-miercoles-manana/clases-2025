% pelicula(Pelicula, Genero).
% trabajaEn(Pelicula, Actor/Actriz).
% premio(Premio, Actor/Actriz).

pelicula(starWars3, accion).
pelicula(terminator, accion).

trabajaEn(starWars3, nataliePortman).
trabajaEn(starWars3, ewanMcGregor).
trabajaEn(terminator, arnoldSchwarzenegger).

premio(mejorActriz, nataliePortman).


% imperdible/1: Si en la peli no hay actores que no ganaron premio.
imperdible(Pelicula) :-
  pelicula(Pelicula, _),
  not((trabajaEn(Pelicula, Actor), not(premio(_, Actor)))).

imperdible2(Pelicula) :-
  pelicula(Pelicula, _),
  not(actorSinPremio(Pelicula, _)).

actorSinPremio(Pelicula, Actor) :-
  trabajaEn(Pelicula, Actor),
  not((premio(_, Actor))).


%%    ∀ x :  p(x) =>  q(x)
%%    ∀ x : ~p(x)  v  q(x)
%% ~~(∀ x : ~p(x)  v  q(x))
%%  ~(∃ x :  p(x)  ^ ~q(x))


% (equivalente a los anteriores): si todos los actores ganaron algún premio
imperdible3(Pelicula) :-
  pelicula(Pelicula, _),
  forall(trabajaEn(Pelicula, Actor), premio(_, Actor)).


% Si en todas las pelis que trabaja son de drama
actorDramatico(Actor) :-
  trabajaEn(_, Actor),
  forall(trabajaEn(Pelicula, Actor), pelicula(Pelicula, drama)).


% unánime: si todas las críticas son el mismo puntaje

% critica(Pelicula, Estrellas).
critica(starWars3, 5).

unanime(Pelicula) :-
  critica(Pelicula, Puntaje),
  forall(critica(Pelicula, OtroPuntaje), sonIguales(Puntaje, OtroPuntaje)).

sonIguales(Puntaje, Puntaje).


% mejor crítica: la crítica más alta para una peli
mejorCritica(Pelicula, MejorCritica) :-
  critica(Pelicula, MejorCritica),
  forall(critica(Pelicula, OtraCritica), MejorCritica >= OtraCritica).


% Algunos otros predicados para practicar:
% aclamada/1: si todas las críticas de la peli son 4 ó 5 estrellas
% mala/1: si todas las críticas de la peli son 1 estrella
% selectivo/1: para un actor si todas las pelis en que trabaja son imperdibles 
