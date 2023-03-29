# Given a list of unique positive integers values...
# How many times does the maximum change?
# Can you compute it with a single fold, using reduce?
# From left to right, how many “rooftops” are visible? (In the example: 6)

from functools import reduce

def isChanged(acc, x):
    count, curr_max = acc
    if (curr_max > x):
        return acc
    else:
        curr_max = x
        count += 1
        return (count, curr_max)

count, max = reduce(isChanged, [3, 5, 2, 1, 8], (0,0))
print (count)

count, max = reduce(lambda acc, x: acc if acc[1] > x else (acc[0]+1, x), [3, 5, 2, 1, 8], (0,0))
print (count)
