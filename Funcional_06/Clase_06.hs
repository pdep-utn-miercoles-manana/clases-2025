invertir :: [a] -> [a]
invertir [] = []
invertir (x : xs) = invertir xs ++ [x]

invertir' :: [a] -> [a]
invertir' xs =
    foldr (\x listaInvertida -> listaInvertida ++ [x]) [] xs

invertir'' :: [a] -> [a]
invertir'' = foldl (flip (:)) []

lista :: Integer -> Integer -> [Integer] 
lista cotaInferior cotaSuperior
    | cotaInferior == cotaSuperior = [cotaInferior]
    | otherwise = cotaInferior : lista (cotaInferior + 1) cotaSuperior

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x nuevosValores -> f x : nuevosValores) [] xs

cuadrado x = x * x

f x y  z = cuadrado x + y

g x
    | x > 10 = error "para loco, es demasiado grande!!"
    | otherwise = x + 1
