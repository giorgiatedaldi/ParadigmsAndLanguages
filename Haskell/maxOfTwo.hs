-- Write a Haskell maxOfTwo function, with guards
    -- Two parameters
    -- Return the maximum of the two
    -- Generic parameters
    -- What's the needed type constraint?

getMax :: (Ord a) => a -> a -> a 
getMax a b
 | a >= b = a
 | otherwise = b