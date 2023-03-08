# Write a Pyhton funtion that given a list of positive integers values
# returns how many times the maximum change
from random import shuffle

def count_tops(values: list[int]) -> int:
    max = values[0]
    max_changes = 1
    for val in values:
        if val > max:
            max_changes += 1
            max = val
    
    return max_changes

def main():
    values = list(range(1,6))
    shuffle(values)
    print(values)
    print(count_tops(values))

if __name__ == "__main__":
    main()
    