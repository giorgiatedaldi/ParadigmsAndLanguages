
-- Read one of the following files in Haskell
-- skyscrapers_games.zip
-- Represent data as a list of lists of ints, i.e., [[Int]]
-- The numbers on the borders are the *constraints* to satisfy
-- Check if data complies with the following rules
-- https://www.brainbashers.com/skyscrapershelp.asp
-- Check also uniqueness and range of values

import System.IO 
import Data.List

readFromTxtSolution :: FilePath -> IO [[Int]]
readFromTxtSolution filename = do
  contents <- readFile filename
  return $ map (map read . words) (lines contents)

-- checkZeroOnEdges :: [[Int]] -> Bool
-- checkZeroOnEdges grid 
--  | any (== 0) (removeFirstLast (grid !! 0)) = True --first row
--  | any (== 0) (removeFirstLast (grid !! ((length grid) - 1))) = True
--  | any (== 0) (removeFirstLast ((transpose grid) !! 0)) = True --first row
--  | any (== 0) (removeFirstLast ((transpose grid) !! ((length grid) - 1))) = True
--  | otherwise = False


--removeFirstLast :: [Int] -> [Int]
removeFirstLast list = (init . tail) list

getInternalGrid :: [[Int]] -> [[Int]]
getInternalGrid list = (removeFirstLast . transpose . removeFirstLast . transpose) list

--no duplicate numbers and each list contains each number from 1 to n
checkNumbersInList :: [Int] -> Int -> Bool
checkNumbersInList xs n = all (\x -> elem x xs) [1..n] && length xs == n

--If false there are no wrong constraints. Function checkNumbersInList is applied to each list of the grid
wrongConstraints :: [[Int]] -> Bool
wrongConstraints grid = elem False (map (\xs -> checkNumbersInList xs (length grid)) grid)

skyscrapersCountList :: (Num a, Ord a) => [a] -> a
skyscrapersCountList xs = fst (foldl (\ acc x -> if snd acc > x then acc else ((fst acc) + 1, x)) (0,0) xs)

checkSkyscrapersContraints :: Int -> [Int] -> Bool
checkSkyscrapersContraints 0 xs = True
checkSkyscrapersContraints constraint xs = constraint == (skyscrapersCountList xs)

skyscrapersCountGrid :: [[Int]] -> [Bool]
skyscrapersCountGrid grid = map (\xs -> checkSkyscrapersContraints (head xs) (removeFirstLast xs)) (removeFirstLast grid)

main :: IO ()
main = do
    grid <- readFromTxtSolution "skyscrapers-6x6.txt"
    --print grid

    let intGrid = getInternalGrid grid 
    --print intGrid

    let numInRows = wrongConstraints intGrid
    --print numInRows

    let numInCols = wrongConstraints $ transpose intGrid
    --print numInCols

    -- let zeroes = checkZeroOnEdges grid
    -- print zeroes
    --if numInRows == False && numInCols == False  && zeroes == False
    if numInRows == False && numInCols == False 
        then do 
        let checkLeftRight = skyscrapersCountGrid grid 
        print checkLeftRight

        let checkRightLeft = skyscrapersCountGrid (map (\xs -> reverse xs) grid) 
        print checkRightLeft

        let checkTopDown = skyscrapersCountGrid (transpose grid) 
        print checkTopDown

        let checkDownTop = skyscrapersCountGrid ((transpose . (\xs -> reverse xs)) grid) 
        print checkDownTop

        if elem True (map (\xs -> elem False xs) [checkLeftRight, checkRightLeft, checkTopDown, checkDownTop])
            then do
                print "Your solution is wrong try again."
            else do
                print "Right solution."
    else do
        print "Error. Each row and col must contain each number (from 1 to the grid size) only once."