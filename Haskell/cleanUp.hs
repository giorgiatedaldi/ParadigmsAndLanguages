import System.Random
cleanUp :: (Int, Int) -> [Bool] -> Int -> [Bool]
cleanUp (cols, rows) matrix i = 
    let (y,x) = divMod i cols
    in reverse $ fst $ foldl (\(res, currIdx) elem -> let (y', x') = divMod currIdx cols
                                                          deltax = abs (x'-x)
                                                          deltay = abs (y'-y)
                                                       in if (deltax+deltay == 1) then ((not elem):res, currIdx+1) else (elem:res, currIdx+1)) ([], 0) matrix


configureMatrix :: Int -> Int -> Int -> [Bool] -> StdGen -> [Bool]
configureMatrix _ _ 0 matrix _ = matrix 
configureMatrix w h m matrix gen =
    let (num, gen') = randomR (0,w*h) gen
        newMatrix = cleanUp (w, h) matrix num 
    in configureMatrix w h (m-1) newMatrix gen'   

isCompletelyCleanedUp :: [Bool] -> Bool
isCompletelyCleanedUp matrix
 | elem True matrix = False
 | otherwise = True

isInRange :: Int -> Int -> Bool
isInRange max x = x >= 0 && x < max

playCleanUpGame :: (Int, Int) -> [Bool] -> Int -> IO()
playCleanUpGame (w, h) grid tries = do
    if isCompletelyCleanedUp grid
        then putStrLn $ "Matrix completely cleaned up with " ++ show tries ++ " moves :P."
        else do 
            putStrLn $ "Choose index to make the move"
            index <- readLn
            if isInRange (w*h) index
                then do
                    let newGrid = cleanUp (w, h) grid index
                    print newGrid
                    playCleanUpGame (w, h) newGrid (tries+1)
                else do 
                    putStrLn $ "Index out of range. Try again"
                    playCleanUpGame (w, h) grid (tries)

main :: IO()
main = do
    putStrLn $ "Choose w"
    w <- readLn
    putStrLn $ "Choose h"
    h <- readLn
    putStrLn $ "Choose m"
    m <- readLn

    let grid = configureMatrix w h m (replicate (w*h) False) (mkStdGen 123456)
    print grid
    
    playCleanUpGame (w, h) grid 0
    







