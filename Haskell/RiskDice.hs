
-- Each of two players (attacker A and defender D) rolls three dice
-- Dice are compared in couples
    -- A's highest die against D's highest die... and so on
    -- In case of equal values, D's die wins
-- Repeat the game N times and create a list of N integer results
-- A wins with 3 dice... or 2, 1, 0
-- Optionally, also count the occurrences of each possible result (0-3)


-- Possibly, solve with mapping, filtering, folding, partial application…

-- Possibly, generalize with respect to the number of dice each player rolls (other than three).

import System.Random
import Data.List

sortDescending :: [Int] -> [Int]
sortDescending = reverse . sort

rollThreeDice :: StdGen -> [Int]
rollThreeDice gen = 
    let (first, newGen) = randomR (1,6) gen
        (second, newGen') = randomR (1,6) newGen
        (third, newGen'') = randomR (1, 6) newGen'
    in  sortDescending [first, second, third]

rollNDice ::StdGen -> [Int]
rollNDice gen = 
    let (size, gen') = randomR (1,3) gen -- Generate a random size for the list (between 1 and 3)
        randomNumbers = take size $ randomRs (1,6) gen' -- Generate a list of random numbers (between 1 and 6)
    in sortDescending randomNumbers

compareDices :: [Int] -> [Int] -> [Bool]
compareDices attackDice defendDice = zipWith (>) attackDice defendDice

countWinA :: [Bool] -> Int
countWinA xs = foldl (\ acc res -> if res == True then acc + 1 else acc) 0 xs

-- Int -> mkStdGen 
-- Int -> n matches to do (decreased at each round)
-- [Int] -> list of previous wins of A
-- [Int] -> updated list of A victories
playNtimes :: Int -> Int -> [Int] -> [Int]
playNtimes mkGen 0 wins = wins
playNtimes mkGen acc wins = 
    playNtimes (mkGen + 2) (acc-1) ((countWinA (compareDices (rollNDice (mkStdGen mkGen)) (rollNDice (mkStdGen (mkGen + 1))))):wins)

--[Int] list of playNtimes
--[Int] list of occurrences
countOccurrences :: [Int] -> [Int]
countOccurrences xs =
  let countZeros = length $ filter (== 0) xs
      countOnes = length $ filter (== 1) xs
      countTwos = length $ filter (== 2) xs
      countThrees = length $ filter (== 3) xs
  in [countZeros, countOnes, countTwos, countThrees]

-- Int -> total matches to play
-- ([Int], [Int]) -> a tuple that contains in the first the result of playNtimes and in the second one the result
-- of countOccurrences
playRiskDice :: Int -> ([Int], [Int])
playRiskDice n = 
    let wins = playNtimes 123456 n []
        occurrences = countOccurrences wins
    in (wins, occurrences)

