-- Define a merge function in Haskell
    -- Takes two sorted lists
    -- Returns a sorted list, with all the elems
-- Define a mergeSort function in Haskell
    -- Takes a list
    -- Splits it at half
    -- Sorts each part, recursively
    -- Merges the two sorted parts
merge :: (Ord a) => [a] ->[a] -> [a]
merge [] [] = []
merge l1 [] = l1
merge [] l2 = l2
merge (x:xs) (y:ys)
 |  x < y = x:merge xs (y:ys)
 | otherwise = y:merge (x:xs) ys  

divide :: [a] -> ([a],[a])
divide xs = (take half xs, drop half xs)
    where half = div (length xs) 2

msort :: Ord a => [a] -> [a]
msort [] = []
msort [x] = [x]
msort xs = merge (msort (fst l1)) (msort (snd l1))
    where l1 = divide xs