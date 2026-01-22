data Ejercicio
  = Ejercicio { aumentoFatiga :: Float, aumentoKi :: Float }
  | Descanso { minutos :: Float }

data Guerrero = Guerrero {
  fatiga       :: Float,
  ki           :: Float,
  personalidad :: Personalidad
}

flexionesDeBrazo :: Ejercicio
flexionesDeBrazo = Ejercicio 50 0

saltosAlCajon :: Float -> Ejercicio
saltosAlCajon altura = Ejercicio (altura / 5) (altura / 10)

snatch :: Guerrero -> Ejercicio
snatch guerrero
  | esExperimentado guerrero = Ejercicio (fatiga guerrero * 0.10) (ki guerrero * 0.05)
  | otherwise                = Ejercicio 100 0

esExperimentado :: Guerrero -> Bool
esExperimentado guerrero = ki guerrero > 22000

-- Punto 1 --

realizarEjercicio :: Ejercicio -> Guerrero -> Guerrero
realizarEjercicio (Descanso unosMinutos) guerrero = descansar unosMinutos guerrero
realizarEjercicio (Ejercicio cansancio gains) guerrero
  | estaExhausto guerrero = disminuirKi (ki guerrero * 0.02) guerrero
  | estaCansado  guerrero = aumentarFatiga (cansancio * 4) . aumentarKi (gains * 2) $ guerrero
  | otherwise             = aumentarFatiga cansancio . aumentarKi gains $ guerrero

aumentarFatiga :: Float -> Guerrero -> Guerrero
aumentarFatiga cantidad guerrero = cambiarFatiga (+ cantidad) guerrero

aumentarKi :: Float -> Guerrero -> Guerrero
aumentarKi cantidad guerrero = cambiarKi (+ cantidad) guerrero

disminuirKi :: Float -> Guerrero -> Guerrero
disminuirKi cantidad guerrero = cambiarKi (subtract cantidad) guerrero

cambiarKi :: (Float -> Float) -> Guerrero -> Guerrero
cambiarKi f guerrero = guerrero {
  ki = f (ki guerrero)
}

cambiarFatiga :: (Float -> Float) -> Guerrero -> Guerrero
cambiarFatiga f guerrero = guerrero {
  fatiga = (max 0 . f . fatiga) guerrero
}


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

descansoOptimo :: Guerrero -> Float
descansoOptimo guerrero = head (dropWhile (estaCansado . flip descansar guerrero) [0..])

-- Punto 4 --

type Personalidad = Rutina -> Rutina

type Rutina = [Ejercicio]

realizarRutina :: Rutina -> Guerrero -> Guerrero
realizarRutina rutina guerrero =
  foldr realizarEjercicio guerrero (rutinaPara guerrero rutina)

rutinaPara :: Guerrero -> Rutina -> Rutina
rutinaPara guerrero rutina = (personalidad guerrero) rutina

sacado :: Personalidad
sacado rutina = rutina

perezoso :: Personalidad
perezoso rutina = concatMap (: [Descanso 5]) rutina

tramposo :: Personalidad
tramposo rutina = []
