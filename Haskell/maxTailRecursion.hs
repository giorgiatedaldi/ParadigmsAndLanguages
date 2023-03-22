
-- Find the maximum in a list, in Haskell
-- Define a tail recursive function
    -- Parameters: the list and an accumulator
    -- The accumulator holds the maximum so far

maxTailRecursion [] acc = acc
maxTailRecursion (x:xs) acc = maxTailRecursion xs (max x acc)

maxInList [] = error "empty list"
maxInList x = maxTailRecursion x 0