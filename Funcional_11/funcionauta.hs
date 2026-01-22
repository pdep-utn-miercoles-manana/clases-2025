import Text.Show.Functions

data Familiar 
    = Persona {
        valentia :: Int,
        familia :: Familia,
        inventario :: [Objeto]
      }
    | Cascarudo {
        familia :: Familia
      }
    deriving (Show)

type Valentia = Int
type Familia = [Familiar]
type Inventario = [Objeto]
type Objeto = Valentia -> Valentia

-- 1.
puedeSalirAlExterior (Persona _ [] _) = False
puedeSalirAlExterior persona = proteccionEfectiva persona > 80

proteccionEfectiva persona = foldr ($) (valentia persona) (inventario persona)

mascara = (+20)
rifle balas = (+balas)
camionetaViejaQueFunciona = (*2)
camionetaQueNoFunciona = id



-- 2.
type Lugar = Familiar -> Familiar

visitarLugar lugar persona
  | puedenSalirAlExterior (familia persona) = visitarConFamilia persona lugar
  | otherwise = persona

puedenSalirAlExterior = all puedeSalirAlExterior

visitarConFamilia (Persona valentia familia inventario) lugar =
    lugar (Persona valentia (map lugar familia) inventario)

centro (Persona valentia familia inventario) =
    (Persona valentia (cascarudo : familia) inventario)

cascarudo = Cascarudo (repeat cascarudo)

campoDeMayo persona = agregarAInventario (rifle 12) persona

agregarAInventario objeto (Persona valentia familia inventario) =
    (Persona valentia familia (objeto : inventario))

farmaciaSaqueada (Persona valentia familia _) =
    (Persona valentia familia [])

conferenciaProMercado persona = aumentarValentia (valentiaPorConferencia persona) persona

aumentarValentia aumento (Persona valentia familia inventario) =
    (Persona (valentia + aumento) familia inventario)

valentiaPorConferencia (Persona valentia familia inventario) =
    valentia + valentia * porcentualPara inventario familia
    
porcentualPara inventario familia = (length inventario + cuantosObjetosFamilia familia) `div` 100

cuantosObjetosFamilia = sum . map (length . inventario)

-- 3.
quiereVisitar persona = filter (esConveniente persona)

esConveniente persona lugar = proteccionEfectiva (lugar persona) > proteccionEfectiva persona

-- 4.
type Escuadron = (String, [Familiar])
nombreEscuadron = fst
miembrosEscuadron = snd

organizarse escuadron = map (pasosOrganizacion escuadron) (miembrosEscuadron escuadron)

pasosOrganizacion escuadron = visitarLugar campoDeMayo . agregarAInventario mascara . gritar (nombreEscuadron escuadron)

gritar nombre = aumentarValentia (length nombre * 3)