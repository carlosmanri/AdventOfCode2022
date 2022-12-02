
data Move = Rock | Paper | Scissors deriving (Show, Eq)

data Result = Win | Lose | Draw deriving (Show, Eq)

reverseMyMove :: Move -> Result -> Move
reverseMyMove Rock Lose = Scissors
reverseMyMove Rock Win = Paper
reverseMyMove Scissors Win = Rock
reverseMyMove Scissors Lose = Paper
reverseMyMove Paper Win = Scissors
reverseMyMove Paper Lose = Rock
reverseMyMove Rock Draw = Rock
reverseMyMove Scissors Draw = Scissors
reverseMyMove Paper Draw = Paper

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
    let inputs = map parseMoves $ map words $ lines file
    let myMoves = map (\(x, y) -> reverseMyMove x y) inputs
    let results = map snd inputs
    putStrLn $ show . score $ zip results myMoves

parseMoves :: [String] -> (Move, Result)
parseMoves (x:y:_) = (parseMove x, parseResult y)

parseMove :: String -> Move
parseMove "A" = Rock
parseMove "B" = Paper
parseMove "C" = Scissors
parseMove _ = error "Invalid move"

parseResult :: String -> Result
parseResult "X" = Lose 
parseResult "Y" = Draw 
parseResult "Z" = Win 
parseResult _ = error "Invalid result"