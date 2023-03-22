-- Sum of all odd squares that are smaller than 10,000
-- Laziness: map over and filter an infinite list

oddSquares :: (Integral a) => a
oddSquares = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))