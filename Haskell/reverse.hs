-- reverse' :: [a] -> [a]
-- reverse' [] = []
-- reverse' (x:xs) = reverse' xs ++ [x]
    -- Inefficient
    -- Define reverse with tail recursion

rev :: [a] -> [a] -> [a]
rev acc []  =  acc
rev acc (x:xs) = rev (x:acc) xs