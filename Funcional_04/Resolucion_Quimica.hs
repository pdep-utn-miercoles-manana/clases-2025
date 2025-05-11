-- Punto 1

data Sustancia
  = Elemento String String Int Grupo
  | Compuesto String [Componente] Grupo
  deriving (Show)

data Grupo = Metal | NoMetal | Halogeno | GasNoble deriving (Show, Eq)

type Componente = (Sustancia, Int)

hidrogeno :: Sustancia
hidrogeno = Elemento "Hidrogeno" "H" 1 NoMetal

oxigeno :: Sustancia
oxigeno = Elemento "Oxigeno" "O" 8 NoMetal

agua :: Sustancia
agua = Compuesto "Agua" [(hidrogeno, 2), (oxigeno, 1)] NoMetal

-- Punto 2

nombreUnionElemento :: Sustancia -> String
nombreUnionElemento = nombreUnion . nombre

nombreUnion :: String -> String
nombreUnion nombre = sinVolcalesAlFinal nombre ++ "uro"

sinVolcalesAlFinal :: String -> String
sinVolcalesAlFinal = reverse . dropWhile esVocal . reverse

esVocal :: Char -> Bool
esVocal letra = elem letra "aeiou"

-- Punto 3

data Criterio = Calor | Electricidad

conduceBien :: Criterio -> Sustancia -> Bool
conduceBien criterio sustancia =
  es Metal sustancia || conduceBienCriterio criterio sustancia

conduceBienCriterio :: Criterio -> Sustancia -> Bool
conduceBienCriterio Calor = es Halogeno
conduceBienCriterio Electricidad = es GasNoble

es :: Grupo -> Sustancia -> Bool
es unGrupo sustancia = grupo sustancia == unGrupo

grupo :: Sustancia -> Grupo
grupo (Compuesto _ _ grupo) = grupo
grupo (Elemento _ _ _ grupo) = grupo

-- Punto 4

combinar :: String -> String -> String
combinar nombre1 nombre2 = nombreUnion nombre1 ++ " de " ++ nombre2

-- Punto 5

mezclar :: [Componente] -> Sustancia
mezclar componentes =
  Compuesto (nombreComponentes componentes) componentes NoMetal

nombreComponentes :: [Componente] -> String
nombreComponentes = combinarTodos . map (nombre . fst)

nombre :: Sustancia -> String
nombre (Elemento unNombre _ _ _) = unNombre
nombre (Compuesto unNombre _ _) = unNombre

combinarTodos :: [String] -> String
combinarTodos = foldl1 combinar

-- Punto 6

formula :: Sustancia -> String
formula (Elemento _ simbolo _ _) = simbolo
formula (Compuesto _ componentes _) = formulaComponentes componentes

formulaComponentes :: [Componente] -> String
formulaComponentes [] = ""
formulaComponentes ((sustancia, cantidad):resto) =
  formula sustancia ++ numeroSegun cantidad ++ formulaComponentes resto

numeroSegun :: Int -> String
numeroSegun 1 = ""
numeroSegun n = show n