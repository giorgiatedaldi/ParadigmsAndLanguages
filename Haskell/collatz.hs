-- For all starting numbers between 1 and 100...
-- How many Collatz chains have a length greater than 15?

collatz :: (Integral a) => a -> [a]
collatz 1 = [1]
collatz n
 | even n = n:collatz (div n 2)
 | odd n = n:collatz(n*3 + 1)

chainCollatz :: Int
chainCollatz = length (filter greaterThan15 (map (collatz) [1..100]))
 where greaterThan15 list = length list > 15

--collatzSolutionsCount' = length (filter (\xs -> length xs > 15) (map chain [1..100]))