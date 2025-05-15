tieneNombreLargo mascota = length (fst mascota) > 9 == True
tieneNombreLargo mascota = length (fst mascota) > 9
tieneNombreLargo mascota = ((>9) . length . fst) mascota
tieneNombreLargo mascota = (>9) . length . fst $ mascota
tieneNombreLargo = (>9) . length . fst

sumarEnergia (Persona nombre energia edad categoriaDeMonotributo) =
    (Persona nombre (energia + 5) edad categoriaDeMonotributo)

triplicarLosPares numeros = (map (*3) . filter even) numeros
triplicarLosPares numeros = map (*3) (filter even numeros)
triplicarLosPares = map (*3) . filter even

sonTodosMamiferos animales = all esMamifero animales
sonTodosMamiferos animales = (and . map esMamifero) animales

abrirVentanas :: Casa -> Casa
prenderEstufa :: Casa -> Casa
encenderElAireA ::  Int -> Casa -> Casa
mudarseA :: String -> Casa -> Casa
miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 26,
     reguladores = [abrirVentanas, prenderEstufa, mudarseA "Medrano 952", encenderElAireA 24]
   }

type Regulador = Casa -> Casa

abrirVentanas :: Regulador
prenderEstufa :: Regulador
encenderElAireA :: Casa -> Int -> Casa
mudarseA :: String -> Regulador
miCasaInteligente = Casa
   { direccion = "Medrano 951",
     temperatura = 26,
     reguladores = [abrirVentanas, prenderEstufa, mudarseA "Medrano 952", flip encenderElAireA 24]
   }

esBeatle "Ringo" = True
esBeatle "John" = True
esBeatle "George" = True
esBeatle "Paul" = True
esBeatle _ = False

sumaDeLasEdadesRecursiva [] = 0
sumaDeLasEdadesRecursiva (x:xs) =
   edad x + sumaDeLasEdadesRecursiva xs
sumaDeLasEdadesRecursiva = sum . map edad

abrirVentanas casa =
  casa { direccion = direccion casa,
         temperatura = temperatura casa - 2,
         reguladoresDeTemperatura = reguladoresDeTemperatura casa }
abrirVentanas (Casa direccion temperatura reguladores) = 
    (Casa direccion (temperatura - 2) reguladores)

agregarValor valor indice lista =
   take (indice - 1) lista ++ (valor : drop indice lista)

poneleUnNombre numeros = (sum (map (*3) (filter even numeros))) < 100
esMenorA100LaSumaDeLosTriplesDeLosPares = 
    (<100) . sum . map (*3) . filter even