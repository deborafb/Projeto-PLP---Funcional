-- Animal (Id, Tamanho, Genero, Cor, Tipo, Dono, Obs) 
data Animal = Animal Int String String String String String String

idAnimal :: Animal -> Int
idAnimal (Animal id _ _ _ _ _ _) = id

-------------- Igual ao idAnimal 
obsAnimal :: Animal -> String
obsAnimal (Animal _ _ _ _ _ _ obs) = obs


setTamanho (Animal id tam gen cor tipo dono obs) otherTam = Animal id otherTam gen cor tipo dono obs
setObs (Animal id tam gen cor tipo dono obs) otherObs = Animal id tam gen cor tipo dono otherObs

toString (Animal id tam gen cor tipo dono obs) = "Animal(" ++ "Id: " ++ show id ++ ", Tamanho: " ++ tam ++ ", Gênero: " ++ gen ++ ", Cor: " ++ cor ++ ", Tipo: " ++ tipo ++ ", Dono: " ++ dono ++ ", Obs: " ++ obs ++ ")"

existeAnimal :: [Animal] -> Int -> Bool
existeAnimal [] _ = False
existeAnimal animais id
	| (idAnimal (head animais) == id) = True
	| otherwise = existeAnimal (tail animais) id

adicionarAnimal :: [Animal] -> Animal -> [Animal]
adicionarAnimal animais animal 
	| existeAnimal animais (idAnimal animal) = animais
	| otherwise =  animais ++ [animal]

editarTamanhoAnimal :: [Animal] -> Int -> String -> [Animal]
editarTamanhoAnimal [animal] id tamanho
	| idAnimal animal == id = [setTamanho animal tamanho]
	| otherwise = [animal]

---------
{-editarObsAnimal :: [Animal] -> Int -> String -> [Animal]
editarObsAnimal [animal] id tamanho
	| idAnimal animal == id = [setObs animal observacao]
	| otherwise = [animal]
-}

editarTamanhoAnimal animais id tamanho
	| idAnimal (head animais) == id = [setTamanho (head animais) tamanho] ++ (tail animais)
	| otherwise = [head animais] ++ editarTamanhoAnimal (tail animais) id tamanho

listarAnimais :: [Animal] -> String
listarAnimais [] = "Nenhum animal cadastrado.\n"
listarAnimais [animal] = (toString animal ++ "\n")
listarAnimais animais = (toString (head animais) ++ "\n" ++ (listarAnimais (tail animais)))

buscarAnimal :: [Animal] -> Int -> String
buscarAnimal [] _ = "Animal inexistente.\n"
buscarAnimal animais id
	| (idAnimal (head animais) == id) = toString (head animais) ++ "\n"
	| otherwise = buscarAnimal (tail animais) id

animalCadastrado :: Bool -> String
animalCadastrado existe
    | existe == True = "ID de animal já cadastrado, tente novamente.\n"
    | otherwise = "Animal cadastrado com sucesso.\n"

executarOpcao '1' animais = do
    putStrLn ""
    putStr "Digite o ID do animal: " 
    id <- getLine
    putStr "Digite o tamanho do animal(em centímetros): " 
    tam <- getLine
    putStr "Digite o gênero do animal: " 
    gen <- getLine
    putStr "Digite a cor do animal: " 
    cor <- getLine
    putStr "Digite o tipo do animal: " 
    tipo <- getLine
    putStr "Digite o dono do animal: " 
    dono <- getLine
    putStr "Digite a observação do animal: " 
    obs <- getLine
    putStrLn ""   
    putStr (animalCadastrado (existeAnimal animais (read id :: Int)))
    menu (adicionarAnimal animais (Animal (read id :: Int) tam gen cor tipo dono obs))
----------- Se não der certo so apagar essas modificacoes(linhas 85,86,87) e deixar a linha 104
executarOpcao '2' animais = do
    putStrLn ""
    putStr "Digite o ID do animal: "
    id <- getLine
    putStrLn ""
    putStrLn "Escolha uma opção "
    putStrLn "1 - Atualizar Obs"
    putStrLn "2 - Atualizar tamanho"
 --   escolha <- getLine	
 --   atualizar escolha animais
    
{-   
atualizar '1' animais = do 
    putStr "Digite o nova obs do animal: "
    obs <- getLine
    putStrLn ""
    putStr (buscarAnimal animais (read id :: Int))
    menu (editarObsAnimal animais (read id :: Int) obs)

atualizar '2' animais = do 
    putStr "Digite o novo tamanho do animal: "
    tam <- getLine
    putStrLn ""
    putStr (buscarAnimal animais (read id :: Int))
    menu (editarTamanhoAnimal animais (read id :: Int) tam)
  
-}

executarOpcao '3' animais = do
	putStrLn ""
	putStr (listarAnimais animais)
	putStrLn ""
	menu animais
	
executarOpcao '4' animais = do
	putStrLn ""
	putStr "Digite o ID do animal: "
	id <- getLine
	putStrLn ""
	putStr (buscarAnimal animais (read id :: Int))
	putStrLn ""
	menu animais

executarOpcao _ animais = do
	menu animais

menu animais = do
	putStrLn "-------------------------------- Controle de Animais --------------------------------"
	putStrLn "Escolha uma opção "
	putStrLn "1 - Cadastrar Animal"
	putStrLn "2 - Atualizar Animal"
	putStrLn "3 - Listar Animais"
	putStrLn "4 - Buscar Animal"
	putStrLn ""
	putStrLn "Digite sua opção: "
	putStr "Opção: "
	op <- getChar
	putStrLn ""
	executarOpcao op animais
