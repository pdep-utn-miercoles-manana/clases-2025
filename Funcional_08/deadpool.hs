import Text.Show.Functions
import Data.List

data Auto = Auto {
  velocidadMaxima :: Float,
  estabilidad     :: Float,
  tuneos          :: [Tuneo],
  nitro           :: Auto -> Auto
} deriving (Show)

sortBy _ [ ] = []
sortBy _ [x] = [x]
sortBy f (x:y:xs)
  | f x > f y = x : sortBy f (y:xs)
  | otherwise = y : sortBy f (x:xs)


type Tuneo = (String, Float)

--1
esRapido :: Auto -> Bool
esRapido auto = velocidadMaxima auto > 150

--2
tieneFacha :: Auto -> Bool
tieneFacha auto = tieneTuneo auto "Luces de Neón" && tieneTuneo auto "Carrocería Deportiva"

tieneTuneo :: Auto -> Tuneo -> Bool
tieneTuneo unAuto unTuneo = elem unTuneo (nombresDeTuneos unAuto)

nombresDeTuneos :: Auto -> [String]
nombresDeTuneos auto = map fst (tuneos auto)

----otra opcion
tiene :: Auto -> Bool
tiene nombreTuneo = elem nombreTuneo . map fst . tuneos

--3
puedeCompetir :: Auto -> Bool
puedeCompetir auto = preciosTuneos auto > 1000

preciosTuneos :: Auto -> [Float]
preciosTuneos auto = sum . map snd . tuneos $ auto

--otra opcion
puedeCompetir2 auto = (>1000) . sum . map snd . tuneos

--4
tunear :: [Tuneo] -> Auto -> Auto
tunear unosTuneos unAuto = unAuto { tuneos = (++ unosTuneos).tuneos unAuto}

--5
modificarVelocidadMax :: (Float -> Float) -> Auto -> Auto 
modificarVelocidadMax modificacion unAuto = unAuto {velocidadMaxima = modificacion velocidadMaxima}

type Nitro = Auto -> Auto

nx :: Nitro
nx unAuto litros = modificarVelocidadMax unAuto (*2)

 --6
nos :: Float -> Nitro
--nos :: Float -> Auto -> Auto  //  por si lo ven más claro de esta manera
nos unAuto litros = (modificarEstabilidad (flip (-) $ litros) ). (modificarVelocidadMax (*litros)) $ unAuto


--7
nitroRacing :: Nitro
nitroRacing unAuto
    | tieneTuneo "Aeroventilas" unAuto = (modificarEstabilidad (*0.75)) . (tunear ("Paracaidas",0)) $ unAuto
    | otherwise = (Auto modificarVelocidadMax (*0.9 unAuto) 0 [] (nitro unAuto))

--8 Autos 
autoDeHector :: Auto
autoDeHector = Auto {
    velocidadMaxima = 120,
    estabilidad = 100,
    tuneos = [("altas shantas", 0 )],
    nitro = nx
 } 


 -- Para que vean que se puede modelar de esta forma también
autoDeToretto :: Auto
autoDeToretto = Auto 250 200 [("aeroventila" , 15000), ("aeroventila" , 15000)] nitroNulo

nitroNulo :: Auto -> Auto
nitroNulo unAuto = unAuto

autoDeBrian :: Auto
autoDeBrian = Auto {
    velocidadMaxima = 200,
    estabilidad = 40,
    tuneos = [("Luces de Neon", 30000 ), ("Turbo", 40000), ("Aire Acondicionado", 10000)],
    nitro = nitroRacing. (nitroNos 10)
 } 

--9 Conductores
brianConduce :: Auto -> Auto
brianConduce unAuto = nitro unAuto $ unAuto

torettoConduce :: Auto -> Auto
 torettoConduce unAuto = (modificarEstabilidad (*100)) . (modificarVelocidadMax (*2)) $ unAuto
 
hectorConduce :: Auto -> Auto
 hectorConduce unAuto = tunear ("Caracoles", 10)

data Conductor = Conductor {
  nombre :: String,
  auto :: Auto,
  formaConducir :: Auto -> Auto
 }

brian :: Conductor
brian = Conductor "Brian" autoDeBrian brianConduce
--otra opcion: 
brian' = Conductor "Brian" autoDeBrian (\auto -> nitro auto auto)
 
toretto :: Conductor
toretto = Conductor "Toretto" autoDeToretto torettoConduce
 
hector :: Conductor
hector = Conductor "Hector" autoDeHector hectorConduce


--10
conducirSuAuto :: Conductor -> Auto
conducirSuAuto unConductor = formaConducir unConductor . auto $ unConductor

--11
handicap :: Auto -> Float
handicap unAuto = ((*). velocidadMaxima . estabilidad $ unAuto) / (cantidadTuneos unAuto)

cantidadTuneos unAuto = lenght . tuneos $ auto

--12
correrUnaPicada :: [Conductor] -> [String]
correrUnaPicada = (map nombre). (sortBy handicapPiloto). conducir .(filter puedeCompetir . auto) $ Conductores

conducir :: Conductor -> Conductor
conducir unConductor = unConductor {auto= conducirSuAuto unConductor}

handicapPiloto :: Conductor -> Float
handicapPiloto unConductor = handicap . auto $ Conductor

--13
conducirColaborativamente :: [Conductor] -> Auto -> Auto
conducirColaborativamente unosConductores unAuto = foldr (conducirCualquierAuto unAuto) conductores

conducirCualquierAuto :: Auto -> Conductor -> Auto
conducirCualquierAuto unAuto unConductor = formaDeConducir unConductor $ unAuto