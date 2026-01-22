%% Punto 1 %%

tweet(1, '@elFedi',       fecha(2011, 12, 10), 'Viva Perón, carajo').
tweet(2, '@maiiiii',      fecha(2025,  9,  9), 'Prolog?').
tweet(3, '@luchitocabj',  fecha(2023, 11,  4), 'CABANI TE CRUSO Y SOS POYO').
tweet(4, '@cami_lazzati', fecha(2025,  9,  9), 'quién para un lol?').
tweet(5, '@felipeee',     fecha(2025,  9,  9), 'otorrinolaringología').

sigueA('@maiiiii',      '@elFedi').
sigueA('@catalapridaa', '@cami_lazzati').
sigueA('@maiiiii',      '@cami_lazzati').
sigueA('@cami_lazzati', '@maiiiii').

like('@maiiiii', 1).
like('@maiiiii', 4).
like('@cami_lazzati', 2).

dislike('@xXx_j0ac0_xXx', 3).

retweet('@luchitocabj', 15).

admin('@felipeee').
premium('@cami_lazzati').
premium('@maiiiii').

%% Punto 2 %%

tweetValido(TweetId) :-
  contenidoTweet(TweetId, Contenido),
  string_length(Contenido, Longitud),
  Longitud =< 140.

contenidoTweet(TweetId, Contenido) :-
  tweet(TweetId, _, _, Contenido).

%% Punto 3 %%

ratio(TweetId, Ratio) :-
  tweet(TweetId),
  cantidadLikes(TweetId, CantidadLikes),
  cantidadDislikes(TweetId, CantidadDislikes),
  Ratio is CantidadLikes - CantidadDislikes.

tweet(TweetId) :-
  tweet(TweetId, _, _, _).

cantidadLikes(TweetId, Cantidad) :-
  findall(_, like(_, TweetId), Likes),
  length(Likes, Cantidad).

cantidadDislikes(TweetId, Cantidad) :-
  findall(_, dislike(_, TweetId), Dislikes),
  length(Dislikes, Cantidad).

%% Punto 4 %%

troll(User) :-
  post(_, User),
  forall(post(TweetId, User), ragebaitOFacto(User, TweetId)).

post(TweetId, User) :-
  tweet(TweetId, User, _, _).

ragebaitOFacto(User, TweetId) :- facto(User, TweetId).
ragebaitOFacto(User, TweetId) :- ragebait(User, TweetId).

facto(User, TweetId) :-
  not(tweetValido(TweetId)),
  tieneRatioNegativo(TweetId),
  not(admin(User)).

ragebait(User, TweetId) :-
  premium(User),
  pregunta(TweetId).

tieneRatioNegativo(TweetId) :-
  ratio(TweetId, Ratio),
  Ratio < 0.

pregunta(TweetId) :-
  contenidoTweet(TweetId, Contenido),
  ends_with(Contenido, '?').

%% Punto 5 %%

entongados(User1, User2) :-
  entongadoCon(User1, User2),
  entongadoCon(User2, User1).

entongadoCon(User1, User2) :-
  troll(User1),
  sigueA(User1, User2),
  forall(post(TweetId, User2), like(User1, TweetId)).

%% Punto 6 %%

grokEstoEsPosta(TweetId, ficticio) :-
  tweetTroll(TweetId).

grokEstoEsPosta(TweetId, GradoCerteza) :-
  contenidoTweet(TweetId, Contenido),
  not(tweetTroll(TweetId)),
  gradoTotalCerteza(Contenido, GradoCerteza).

tweetTroll(TweetId) :-
  post(TweetId, User),
  troll(User).

gradoTotalCerteza(Contenido, GradoCerteza) :-
  promedioGradoCerteza(Contenido, PromedioGradoCerteza),
  gradoDeCertezaSegun(PromedioGradoCerteza, GradoCerteza).

promedioGradoCerteza(Contenido, PromedioGradoCerteza) :-
  findall(GradoCerteza, gradoCertezaPalabra(Contenido, _, GradoCerteza), GradosCerteza),
  promedio(GradosCerteza, PromedioGradoCerteza).

promedio([], 0).
promedio(Lista, Promedio) :-
  member(_, Lista),
  sumlist(Lista, Sumatioria),
  length(Lista, Cantidad),
  Promedio is Sumatioria // Cantidad.

gradoCertezaPalabra(Contenido, Palabra, GradoCertezaNumerico) :-
  words(Contenido, Palabras),
  member(Palabra, Palabras),
  gradoDeCerteza(Palabra, GradoCertezaNumerico).

gradoDeCertezaSegun(PromedioGradoCerteza, ficticio) :- PromedioGradoCerteza < 4.
gradoDeCertezaSegun(PromedioGradoCerteza, dudoso) :- between(4, 8, PromedioGradoCerteza).
gradoDeCertezaSegun(PromedioGradoCerteza, real) :- between(9, 10, PromedioGradoCerteza).

%% Punto 7 %%

resultadoDeBusqueda(User, Condicion, TweetId) :-
  post(User, TweetId),
  resultadoDeBusquedaValido(Condicion, TweetId).

resultadoDeBusquedaValido(anterior(Fecha), TweetId) :-
  fechaTweet(TweetId, FechaTweet),
  anteriorA(FechaTweet, Fecha).

resultadoDeBusquedaValido(posterior(Fecha), TweetId) :-
  fechaTweet(TweetId, FechaTweet),
  not(anteriorA(FechaTweet, Fecha)).

resultadoDeBusquedaValido(ratioNegativo, TweetId) :-
  ratio(TweetId, Ratio),
  Ratio < 0.

resultadoDeBusquedaValido(combinado(Condiciones), TweetId) :-
  forall(member(Condicion, Condiciones), resultadoDeBusquedaValido(Condicion, TweetId)).

anteriorA(fecha(AnioA, _   , _   ), fecha(AnioP, _  , _   )) :- AnioA < AnioP.
anteriorA(fecha(Anio , MesA, _   ), fecha(Anio, MesP, _   )) :- MesA  < MesP .
anteriorA(fecha(Anio , Mes , DiaA), fecha(Anio, Mes , DiaP)) :- DiaA  < DiaP .

fechaTweet(TweetId, Fecha) :-
  tweet(TweetId, _, Fecha, _).


%% Estos predicados no existen realmente y para que funcione los agregué %%

words(Contenido, Palabras) :-
  split_string(Contenido, ' ', '', Palabras).

ends_with(String, Sufijo) :-
  string_concat(_, Sufijo, String).

gradoDeCerteza(Palabra, GradoCerteza) :-
  string_length(Palabra, Longitud),
  GradoCerteza is max(0, min(10, Longitud)).
  %% Esto es chamuyo claramente.