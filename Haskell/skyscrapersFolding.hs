-- Given a list of unique positive integers values...
-- How many times does the maximum change?
-- Can you compute it with a single fold?
-- From left to right, how many “rooftops” are visible? (In the example: 6)

skyscrapersFolding :: (Num a, Ord a) => [a] -> a
skyscrapersFolding xs = fst (foldl (\acc x -> changeMax acc x) (0,0) xs)
 where 
    changeMax (count, max) x
     | x > max = (count + 1, x)
     | otherwise = (count, max)


skyscrapersFoldingLambda :: (Num a, Ord a) => [a] -> a
skyscrapersFoldingLambda xs = fst (foldl (\ acc x -> if snd acc > x then acc else ((fst acc) + 1, x)) (0,0) xs)

