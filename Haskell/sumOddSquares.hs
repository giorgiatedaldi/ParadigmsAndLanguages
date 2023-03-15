oddSquares :: (Integral a) => a
oddSquares = sum (takeWhile (<10000) (filter odd (map (^2) [1..])))