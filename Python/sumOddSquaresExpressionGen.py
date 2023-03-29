from functools import partial
from itertools import count, takewhile, repeat
from math import pow

pow2 = partial(pow, exp=2)

print(sum(takewhile(lambda x: x < 10000, (pow(x,2) for x in count() if pow(x,2) % 2 != 0))))
