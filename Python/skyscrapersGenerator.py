# Write a Python generator
#   - Instantiated over a list of ints
#   - Produced values: each new maximum
#   - Tops seen looking from left to right
# Run over a random list
#   - Print all produced values

from random import shuffle

def count_tops(values: list[int]) -> int:
    max = values[0]
    max_changes = 1
    yield(max)
    for val in values:
        if val > max:
            max_changes += 1
            max = val
            yield(max)
            
            
    
def main():
    values = list(range(1,15))
    shuffle(values)
    print(values)
    tops = count_tops(values)
    print(list(tops))

if __name__ == "__main__":
    main()