import System.Random
import Data.Array


cleanUp :: (Int, Int) -> (Int, Int) -> Array (Int, Int) Bool -> Array (Int, Int) Bool
cleanUp (row, col) (x, y) arr 
 | x >= 1 && x <= row && y >= 1 && y <= col = arr // [((x, y), not (arr ! (x, y)))]
 | otherwise = arr

createArray :: Int -> Int -> Array (Int, Int) Bool
createArray rows cols = array ((1,1),(rows,cols)) [((i,j),False) | i <- [1..rows], j <- [1..cols]]

makeMove :: (Int,Int) -> (Int,Int) -> Array (Int, Int) Bool -> Array (Int, Int) Bool
makeMove (row, col) (x,y) arr = 
    let one = cleanUp (row, col) (x + 1, y) arr
        two = cleanUp (row, col) (x - 1, y) one
        three = cleanUp (row, col) (x, y + 1) two
        four = cleanUp (row, col) (x, y - 1) three
    in four

setUpGrid :: (Int, Int) -> Int -> Array (Int, Int) Bool -> StdGen -> Array (Int, Int) Bool
setUpGrid (row,col) 0 matrix _ = matrix
setUpGrid (row,col) m matrix gen = 
    let (wrand, gen') = randomR (1,row) gen
        (hrand, gen'') = randomR (1, col) gen'
        newMatrix = makeMove (row, col) (wrand, hrand) matrix 
    in setUpGrid (row,col) (m-1) newMatrix gen''


isCompletelyCleanedUp :: Array (Int, Int) Bool -> Bool
isCompletelyCleanedUp matrix = all (== False) (elems matrix)

playCleanUpGame :: (Int, Int) -> Array (Int, Int) Bool -> Int -> IO()
playCleanUpGame (row, col) grid tries = do
    if isCompletelyCleanedUp grid
        then putStrLn $ "Matrix completely cleaned up with " ++ show tries ++ " moves :P."
        else do 
            putStrLn $ "Choose row and col to make the move"
            windex <- readLn
            hindex <- readLn
            if windex >= 1 && windex <= row && hindex >= 1 && hindex <= col
                then do
                    let newGrid = makeMove (row, col) (windex, hindex) grid
                    print newGrid
                    playCleanUpGame (row, col) newGrid (tries+1)
                else do 
                    putStrLn $ "Index out of range. Try again"
                    playCleanUpGame (row, col) grid (tries)
    

main :: IO()
main = do
    putStrLn $ "Choose row"
    row <- readLn
    putStrLn $ "Choose col"
    col <- readLn
    putStrLn $ "Choose m"
    m <- readLn
    let grid = createArray row col
    print grid
    let board = setUpGrid (row,col) m grid (mkStdGen 123456)
    print board

    playCleanUpGame (row,col) board 0

