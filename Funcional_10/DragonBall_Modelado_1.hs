type Ejercicio = Guerrero -> Guerrero

data Guerrero = Guerrero {
  fatiga       :: Float,
  ki           :: Float,
  personalidad :: Personalidad
}

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = aumentarFatiga 50

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon altura =
  aumentarKi (altura / 10) . aumentarFatiga (altura / 5)

aumentarFatiga :: Float -> Guerrero -> Guerrero
aumentarFatiga cantidad guerrero = cambiarFatiga (+ cantidad) guerrero

aumentarKi :: Float -> Guerrero -> Guerrero
aumentarKi cantidad guerrero = cambiarKi (+ cantidad) guerrero

snatch :: Ejercicio
snatch guerrero
  | esExperimentado guerrero = (cambiarKi (* 1.05) . cambiarFatiga (* 1.10)) guerrero
  | otherwise                = aumentarFatiga 100 guerrero


cambiarKi :: (Float -> Float) -> Guerrero -> Guerrero
cambiarKi f guerrero = guerrero {
  ki = f (ki guerrero)
}

cambiarFatiga :: (Float -> Float) -> Guerrero -> Guerrero
cambiarFatiga f guerrero = guerrero {
  fatiga = max 0 . f . fatiga $ guerrero
}

esExperimentado :: Guerrero -> Bool
esExperimentado = (> 22000) . ki

-- Punto 1 --

realizarEjercicio :: Ejercicio -> Guerrero -> Guerrero
realizarEjercicio ejericio guerrero
  | estaExhausto guerrero = cambiarKi (* 0.98) guerrero
  | estaCansado  guerrero = aumentarFatiga (cansancio * 4) . aumentarKi (gains * 2) $ guerrero
  | otherwise             = aumentarFatiga cansancio . aumentarKi gains $ guerrero
  where
    gains = ki (ejericio guerrero) - ki guerrero
    cansancio = fatiga (ejericio guerrero) - fatiga guerrero

estaCansado :: Guerrero -> Bool
estaCansado guerrero = relacionCansancioKiMayorA 44 guerrero

estaExhausto :: Guerrero -> Bool
estaExhausto guerrero = relacionCansancioKiMayorA 72 guerrero

relacionCansancioKiMayorA :: Float -> Guerrero -> Bool
relacionCansancioKiMayorA porcentaje guerrero =
  fatiga guerrero > ki guerrero * (porcentaje / 100)

-- Punto 2 --

descansar :: Float -> Guerrero -> Guerrero
descansar minutos guerrero = disminuirFatiga (sum [0..minutos]) guerrero

disminuirFatiga :: Float -> Guerrero -> Guerrero
disminuirFatiga cantidad guerrero = cambiarFatiga (subtract cantidad) guerrero

-- Punto 3 --

descansoOptimo :: Guerrero -> Int
descansoOptimo guerrero =
  length . takeWhile estaCansado . map (flip descansar guerrero) $ [0..]

-- Punto 4 --

data Personalidad = Sacado | Perezoso | Tramposo

type Rutina = [Ejercicio]

realizarRutina :: Rutina -> Guerrero -> Guerrero
realizarRutina rutina guerrero =
  foldr realizarEjercicio guerrero (rutinaPara guerrero rutina)

rutinaPara :: Guerrero -> Rutina -> Rutina
rutinaPara guerrero rutina = rutinaSegun (personalidad guerrero) rutina

rutinaSegun :: Personalidad -> Rutina -> Rutina
rutinaSegun Sacado   rutina = rutina
rutinaSegun Perezoso rutina = concatMap (\ejercicio -> [ejercicio, descansar 5]) rutina
rutinaSegun Tramposo rutina = []
