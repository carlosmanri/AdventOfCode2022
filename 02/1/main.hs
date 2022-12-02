
data Move = Rock | Paper | Scissors deriving (Show, Eq)

data Result = Win | Lose | Draw deriving (Show, Eq)

play :: Move -> Move -> Result
play Rock Scissors = Lose
play Rock Paper = Win
play Scissors Rock = Win
play Scissors Paper = Lose
play Paper Rock = Lose
play Paper Scissors = Win
play _ _ = Draw

score :: [(Result, Move)] -> Int
score (x:xs) = moveScore x + score xs
score [] = 0
   
moveScore :: (Result, Move) -> Int
moveScore (x,y) = resultScore x + resultMove y

resultScore:: Result -> Int
resultScore Win = 6
resultScore Lose = 0
resultScore Draw = 3

resultMove:: Move -> Int
resultMove Rock = 1
resultMove Paper = 2
resultMove Scissors = 3

main :: IO ()
main = do
    file <- readFile "input.txt"
    let movesLines = lines file
    let moves = parseGame $ map words movesLines
    let results = map (\(x, y) -> play x y) moves
    let myMoves = map snd moves
    let totalScore = score $ zip results myMoves
    putStrLn $ show totalScore

parseGame :: [[String]] -> [(Move, Move)]
parseGame (x:xs) = map parseMoves (x:xs)

parseMoves :: [String] -> (Move, Move)
parseMoves (x:y:_) = (parseMove x, parseMove y)

parseMove :: String -> Move
parseMove "A" = Rock
parseMove "B" = Paper
parseMove "C" = Scissors
parseMove "X" = Rock 
parseMove "Y" = Paper 
parseMove "Z" = Scissors 
parseMove _ = error "Invalid move"
