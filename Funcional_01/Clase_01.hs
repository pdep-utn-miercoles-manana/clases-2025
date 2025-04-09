edadDeFede :: Int
edadDeFede = 37

alturaDeLuchito :: Float
alturaDeLuchito = 1.64

nombreDeNacho :: String
nombreDeNacho = "Ignacio"

arroba :: Char
arroba = '@'

existenLosPunteros :: Bool
existenLosPunteros = False

masDos x = siguiente (siguiente x)

dobleDelSiguiente unNumero = doble (siguiente unNumero)
dobleDelSiguiente2 unNumero = (doble . siguiente) unNumero
dobleDelDobleDelSiguiente unNumero = (doble . doble . siguiente) unNumero

-- El tipo de un dato es el conjunto de valores asociados a sus operaciones
-- siguiente : Z -> Z
-- siguiente :: Int -> Int
siguiente x = x + 1

-- doble : R -> R
doble :: Float -> Float
doble x = x * 2

-- mitad : R -> R
mitad :: Float -> Float
mitad x = x / 2

-- multiplicar : R^2 -> R
multiplicar :: Float -> Float -> Float
multiplicar unNumero otroNumero =
  unNumero * otroNumero

identidad :: algo -> algo
identidad x = x