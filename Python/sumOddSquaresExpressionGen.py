from functools import partial
from itertools import count, takewhile, repeat

pow2 = partial(pow, exp=2)

#print(sum(list(takewhile(lambda i: i < 10000, (filter(lambda num: num%2!=0,(map(pow2, count()))))))))

print(sum(list(x*x for x in count() if x*x % 2 != 0 and x*x < 1000)))