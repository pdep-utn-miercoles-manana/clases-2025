feli = 80
luan = 100
borja = 101

colonia :: Fractional a => [a]
colonia = [80, 100, 20, 250, 90]

-- La antfip nos pide saber cuántos obreros en blanco tenemos?
cantidadDeObreros ::  [Int] -> Int
cantidadDeObreros unaColonia = length unaColonia

coloniaVacia :: [a]
coloniaVacia = []

-- Quiero saber si existe alguna hormiga esplendida
algunaEsEsplendida :: [Int] -> Bool
algunaEsEsplendida unaColonia = any esEsplendida unaColonia
-- any  :: (a -> Bool) -> [a] -> Bool [Orden superior]

algunaEsEsplendidaV3 :: [Int] -> Bool
algunaEsEsplendidaV3            = any esEsplendida

--algunaEsEsplendidaV2 unaColonia = elem 100 unaColonia


esEsplendida  = (== 100)



-- elem :: Eq a => a -> [a] -> Bool

-- Condicion = (a -> Bool)

--Cuando hay fumigaciones la eficiencia de las hormigas disminuye en un 10%

fumigacion unaColonia = map (* 0.9) unaColonia

--map :: (a -> b) -> [a] -> [b]


-- Nos gustaría saber la cantidad de hormigas que son fuertes.
-- Una hormiga es fuerte si su eficiencia es mayor a 50.

cantidadHormigasFuertes unaColonia =
    length (filter esFuerte unaColonia)
--    f    (       g          ( x )     )
-- (  f    .       g        )    x
cantidadHormigasFuertesV2 unaColonia =
    (length . filter (\unaHormiga -> unaHormiga >= 50)) unaColonia

esFuerte unaHormiga = unaHormiga >= 50

-- filter :: (a -> Bool) -> [a] -> [a]


suma3 x y z = x + y + z
suma3 = (\x -> \y -> \z -> x + y + z)

identidad x = x

identidad = (\x -> x)


(\unaHormiga -> unaHormiga >= 50)