--Find the right triangle that has integers for alla sides, all sides
--equal to or smaller than 10 and a perimeter of 24
getRightTriangle = [(a, b, c) | a <- [1..10], b <- [a..10], let c = 24-a-b, a^2+b^2==c^2]