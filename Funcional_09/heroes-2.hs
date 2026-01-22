-------------
--Punto 1 --
-------------

data Heroe = Heroe {
  epiteto :: String,
  reconocimiento :: Int,
  artefactos :: [Artefacto],
  tareas :: [Tarea]
}

type Artefacto = (String, Int)

type Tarea = Heroe -> Heroe

-------------
-- Punto 2 --
-------------

pasarALaHistoria :: Heroe -> Heroe
pasarALaHistoria heroe
  | reconocimiento heroe > 1000 = setEpiteto "El mítico" heroe
  | reconocimiento heroe >  500 = setEpiteto "El magnífico" . agregarArtefacto lanzaDelOlimpo $ heroe
  | reconocimiento heroe >  100 = setEpiteto "Hoplita" . agregarArtefacto xiphos $ heroe
  | otherwise                   = heroe

lanzaDelOlimpo :: Artefacto
lanzaDelOlimpo = ("Lanza del Olimpo", 100)

xiphos :: Artefacto
xiphos = ("Xiphos", 50)

setEpiteto :: String -> Heroe -> Heroe
setEpiteto unEpiteto unHeroe = unHeroe {
  epiteto = unEpiteto
}

agregarArtefacto :: Artefacto -> Heroe -> Heroe
agregarArtefacto unArtefacto unHeroe = mapArtefactos (unArtefacto :) unHeroe

mapArtefactos :: ([Artefacto] -> [Artefacto]) -> Heroe -> Heroe
mapArtefactos unaFuncion unHeroe = unHeroe {
  artefactos = unaFuncion $ artefactos unHeroe
}

-------------
-- Punto 3 --
-------------

-- a --

encontrarArtefacto :: Artefacto -> Tarea
encontrarArtefacto unArtefacto = ganarReconocimiento (rareza unArtefacto) . agregarArtefacto unArtefacto

rareza :: Artefacto -> Int
rareza = snd

ganarReconocimiento :: Int -> Heroe -> Heroe
ganarReconocimiento unReconocimiento unHeroe = unHeroe {
  reconocimiento = unReconocimiento + reconocimiento unHeroe
}

-- b --

escalarOlimpo :: Tarea
escalarOlimpo =
  agregarArtefacto relamagoDeZeus . desecharComunes . triplicarRarezas . ganarReconocimiento 500

relamagoDeZeus :: Artefacto
relamagoDeZeus = ("Relámpago de Zeus", 500)

desecharComunes :: Heroe -> Heroe
desecharComunes = mapArtefactos (filter esComun)

triplicarRarezas :: Heroe -> Heroe
triplicarRarezas = mapArtefactos triplicarRarezaArtefactos

triplicarRarezaArtefactos :: [Artefacto] -> [Artefacto]
triplicarRarezaArtefactos unosArtefactos = map (mapRareza (*3)) unosArtefactos

mapRareza :: (Int -> Int) -> Artefacto -> Artefacto
mapRareza unaFuncion (nombre, rareza) = (nombre, unaFuncion rareza)

esComun :: Artefacto -> Bool
esComun = (> 1000) . rareza

-- c --

aydarACruzarLaCalle :: Int -> Tarea
aydarACruzarLaCalle unaCuadras = setEpiteto ("Gros" ++ replicate unaCuadras 'o')

-- d --

matar :: Bestia -> Tarea
matar unaBestia unHeroe
  | (debilidad unaBestia) unHeroe = setEpiteto ("El asesino de " ++ nombre unaBestia) unHeroe
  | otherwise                     = setEpiteto "El cobarde" . mapArtefactos (const []) $ unHeroe

data Bestia = Bestia {
  nombre :: String,
  debilidad :: Heroe -> Bool
}

-------------
-- Punto 4 --
-------------

heracles :: Heroe
heracles = Heroe "Guardián del Olimpo" 700 [pistola 100, relamagoDeZeus] [matarAlLeonDeNemea]

pistola :: Int -> Artefacto
pistola unCalibre = ("Pistola", unCalibre)

-------------
-- Punto 5 --
-------------

matarAlLeonDeNemea :: Tarea
matarAlLeonDeNemea = matar leonDeNemea

leonDeNemea :: Bestia
leonDeNemea = Bestia "León de Nemea" ((>= 20) . length . epiteto)

-------------
-- Punto 6 --
-------------

realizarTarea :: Tarea -> Heroe -> Heroe
realizarTarea unaTarea unHeroe = agregarTarea unaTarea (unaTarea unHeroe)

agregarTarea :: Tarea -> Heroe -> Heroe
agregarTarea unaTarea unHeroe = unHeroe {
  tareas = unaTarea : tareas unHeroe
}

-------------
-- Punto 7 --
-------------

presumir :: Heroe -> Heroe -> (Heroe, Heroe)
presumir heroe1 heroe2
  | leGana heroe1 heroe2 = (heroe1, heroe2)
  | leGana heroe2 heroe1 = (heroe2, heroe1)
  | otherwise            = presumir (realizarTareasDe heroe1 heroe2) (realizarTareasDe heroe2 heroe1)

leGana :: Heroe -> Heroe -> Bool
leGana ganador perdedor =
  reconocimiento ganador >  reconocimiento perdedor ||
  reconocimiento ganador == reconocimiento perdedor && sumaRarezas ganador > sumaRarezas perdedor

sumaRarezas :: Heroe -> Int
sumaRarezas = sum . map rareza . artefactos

realizarTareasDe :: Heroe -> Heroe -> Heroe
realizarTareasDe heroeRealizador heroeProveedor =
  realizarTareas heroeRealizador (tareas heroeProveedor)

realizarTareas :: Heroe -> [Tarea] -> Heroe
realizarTareas unHeroe unasTareas =
  foldr realizarTarea unHeroe unasTareas

-------------
-- Punto 8 --
-------------

---- Se va a quedar en un loop infinito

-------------
-- Punto 9 --
-------------

type Labor = [Tarea]

realizarLabor :: Labor -> Heroe -> Heroe
realizarLabor unaLabor unHeroe = realizarTareas unHeroe unaLabor

--------------
-- Punto 10 --
--------------

---- No se va a poder conocer el estado final de héroe
