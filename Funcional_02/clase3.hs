import Text.Show.Functions

billeteraDeEduardo :: Int
billeteraDeEduardo = 300

comprarCaramelo :: Int -> Int
comprarCaramelo dinero = dinero - 50

encontrarBilleteDe100 :: Int -> Int
encontrarBilleteDe100 dinero = dinero + 100

venirAUTN :: Int -> Int
venirAUTN dinero = comprarCaramelo . encontrarBilleteDe100 $ dinero

venirAUBA :: Int -> Int
venirAUBA dinero = comprarCaramelo (encontrarBilleteDe100 dinero)

pesos :: (a -> b) -> a -> b 
pesos funcion parametro = funcion parametro

hacerDosVeces ::  (a -> a) -> (a -> a)
hacerDosVeces f = f . f

encontrarBillete :: Int -> Int -> Int
encontrarBillete dinero billete = dinero + billete

diaDeSuerte :: Int -> Int
diaDeSuerte dinero = hacerDosVeces comprarCaramelo . encontrarBillete 20000 . encontrarBillete 10000 $ dinero

-- Función aplicada parcialmente: una función que espera N > 1 parámetros
-- y se le pasan, como máximo, N - 1 

-- Función totalmente aplicada: con todos sus parámetros aplicados
-- Función sin aplicar: sin ningún parámetro aplicado
