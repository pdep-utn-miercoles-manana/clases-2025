-- en este módulo tenemos la función toUpper que usamos más abajo
-- toUpper :: Char -> Char
-- > toUpper 'a'
-- 'A'
import Data.Char

-- le dice "hola" a una persona
saludar persona = "hola " ++ persona
-- podemos agregarle un apóstrofe (anda a buscarla Joaco) a las funciones en haskell, como en matemática
saludar' persona = ("hola" ++) persona
saludar'' = ("hola " ++)

-- toma una frase y devuelve la frase en mayuscula
-- y le agrega 3 signos de admiracion al final
gritar frase = map toUpper frase ++ "!!!"
gritar' frase = (++ "!!!") (map toUpper frase)
gritar'' frase = ((++ "!!!") . map toUpper) frase 
gritar''' = (++ "!!!") . map toUpper

esParNatural n = even n && (n > 0)

-- hidrogeno = "hidrogeno" ++ "h" ++ 1

-- hidrogeno :: Elemento
-- hidrogeno = ("Hidrogeno", "H", 1)
-- oxigeno = ("Oxigeno", "O", 8)

-- agua = ("Agua", [(hidrogeno, 2), (oxigeno, 1), (luchito, 3)])

-- type Elemento = (String, String, Integer)
-- type Persona = (String, String, Integer)

-- luchito :: Persona
luchito = ("Luchito", "Nuñez", 1775005)

-- lotr :: Persona
-- lotr = ("El señor de los Anillos", "J.R.R Tolkien", 10000000)

data Sustancia
    = Elemento String String Int Grupo
    | Compuesto String [(Sustancia, Int)]
    deriving (Show, Eq)

data Persona = Persona String String Int
    deriving (Show, Eq)

hidrogeno = Elemento "Hidrógeno" "H" 1 NoMetal
helio = Elemento "Helio" "He" 2 GasNoble
oxigeno = Elemento "Oxígeno" "O" 8 NoMetal

agua = Compuesto "Agua" [(hidrogeno, 2), (oxigeno, 1)]

-- nombreDeUnion :: Elemento -> String
nombreDeUnion elemento
    = sinVocalesAlFinal (nombre elemento) ++ "uro"

-- nombre :: Elemento -> String
nombre (Elemento unNombre _ _ _) = unNombre


sinVocalesAlFinal :: String -> String
sinVocalesAlFinal palabra
    = reverse . dropWhile esVocal . reverse $ palabra

esVocal 'a' = True
esVocal 'e' = True
esVocal 'i' = True
esVocal 'o' = True
esVocal 'u' = True
esVocal  _  = False

-- una forma más razonable de definir esVocal
esVocal' = elem "aeiouAEIOU"

-- conduceBienCalor :: Elemento -> Bool
conduceBienCalor (Elemento _ _ _ grupo) = grupo == Metal
-- esto está incompleto, porque los Compuestos solo conducen bien el calor si son halógenos
conduceBienCalor (Compuesto _ _) = True
conduceBienCalor _ = False

-- esMetal (Elemento nombre simbolo numero grupo)
--      = grupo == "metal" 

-- conduceBienElectricidad :: Elemento -> Bool
conduceBienElectricidad _ = False

-- tenemos 4 grupos nomás, es un conjunto finito
data Grupo
    = Metal
    | NoMetal
    | GasNoble
    | Halogeno
    deriving (Show, Eq)

