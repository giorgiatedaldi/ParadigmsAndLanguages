-- Write a Haskell calculate function 
-- Params: a string and two numbers
    -- The string param represents the operation to perform on the two numbers
    -- Any of +, -, *, /
-- Result: a string
    -- Return the result, as a textual message
-- In case of division by 0, return a textual error message
-- Use patterns (and guards, if really needed)
-- Define appropriate type constraints

calculate :: (Num a, Show a, Fractional a, Eq a) => String -> a -> a -> String
calculate "/" a 0 = "Division by 0"
calculate "+" a b = show (a + b)
calculate "-" a b = show (a - b)
calculate "*" a b = show (a * b)
calculate "/" a b = show (a / b)
calculate _ a b = "Not supported"