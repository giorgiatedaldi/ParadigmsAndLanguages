# Write a Python iterator
#   - Instantiated over a list of ints
#   - Produced values: each new maximum
#   - Tops seen looking from left to right
# Run over a random list
#   - Print all produced values

from random import shuffle

class skyScraperIterator:

    def __init__(self, list):
        self._list = list

    def __iter__(self):
        self._max = 0
        self._count = 0
        return self

    def __next__(self):

        while True:
            if self._count >= len(self._list):
                raise StopIteration
            if self._list[self._count] > self._max:
                self._max = self._list[self._count]
                self._count += 1
                return self._max
            self._count += 1
    
def main():
    values = list(range(1,10))
    shuffle(values)
    print(values)
    tops = skyScraperIterator(values)
    print(list(tops))

if __name__ == "__main__":
    main()

