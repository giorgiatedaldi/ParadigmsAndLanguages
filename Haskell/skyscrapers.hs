-- Given a list of unique positive integers values...
    -- How many times does the maximum change?
    -- Adapt to Haskell, with tail recursion

skyscrapers :: (Num a, Ord a) => [a] -> a
skyscrapers [] = error "empty list"
skyscrapers x = skyscraperRecursion x []

skyscraperRecursion :: (Num a, Ord a) => [a] -> [a] -> a
skyscraperRecursion [] acc = fromIntegral (length acc)
skyscraperRecursion (x:xs) [] = skyscraperRecursion xs [x]
skyscraperRecursion (x:xs) acc 
 | x > (head acc) = skyscraperRecursion xs (x:acc)
 | otherwise = skyscraperRecursion xs acc

