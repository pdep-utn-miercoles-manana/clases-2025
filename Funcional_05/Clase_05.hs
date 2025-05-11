

longitud []     = 0
longitud (x:xs) = (+) 1 (longitud xs)

sumatoria []     = 0
sumatoria (x:xs) = (+) x (sumatoria xs)

productoria []     = 1
productoria (x:xs) = (*) x (productoria xs)

concatenacion []     = []
concatenacion (x:xs) = (++) x (concatenacion xs)

plegar :: (a -> b -> b) -> b -> [a] -> b
plegar f vb []     = vb
plegar f vb (x:xs) = f x (plegar f vb xs)

longitud2      lista = plegar (\_ b -> 1 + b) 0 lista
sumatoria2     lista = plegar (+) 0 lista
productoria2   lista = plegar (*) 1 lista
concatenacion2 lista = plegar (++) [] lista

sumatoria3     = plegar (+) 0
productoria3   = plegar (*) 1
concatenacion3 = plegar (++) []

filtrar :: (a -> Bool) -> [a] -> [a]

filtrar condicion [] = []
filtrar condicion (x:xs)
  | condicion x = x : filtrar condicion xs
  | otherwise   = filtrar condicion xs

mapear :: (a -> b) -> [a] -> [b]
mapear funcion []     = []
mapear funcion (x:xs) = funcion x : mapear funcion xs

todosCumplen :: (a -> Bool) -> [a] -> Bool
todosCumplen condicion [] = True
todosCumplen condicion (x:xs) =
  condicion x && todosCumplen condicion xs

algunoCumple :: (a -> Bool) -> [a] -> Bool
algunoCumple condicion [] = False
algunoCumple condicion (x:xs) =
  condicion x || algunoCumple condicion xs