# Define a merge generator function in Python
    # Takes two sorted sequences
    # Produces a sorted sequence, with all the elems

from random import shuffle

def merge(v1: list, b1, e1,  # beg, end
          v2: list, b2, e2) -> list:
    result = []  # required extra memory
    while b1 < e1 or b2 < e2:
        if b1 < e1 and (b2 == e2 or v1[b1] <= v2[b2]):
            yield(v1[b1])
            b1 += 1

        else:
            yield(v2[b2])    
            b2 += 1                 
    
def main():
    values1 = [1,3,7]
    values2 = [2,9,10]
    print(values1)
    print(values2)
    mergedlist = merge(values1,0,len(values1),values2, 0,len(values2))
    print(list(mergedlist))

if __name__ == "__main__":
    main()