# Bubble Sort

def bubblesort(l):
    swapped = true
    while swapped:
        swapped = false
        for i in range(len(l) - 1):
            if l[i] > l[i + 1]:
                l[i], l[i + 1] = l[i + 1], l[i]
                swapped = true
    return l

# melhorado

def bubblesort(l):
    n = len(l)
    while n > 0:
        newn = 0
        for i in range(n - 1):
            if l[i] > l[i + 1]:
                l[i], l[i + 1] = l[i + 1], l[i]
                newn = i
        n = newn
    return l

# Insertion Sort

def insertionsort(l):
    for i in range(len(l)):
        j = i - 1
        while j >= 0 and l[i] < l[j]:
            l[i], l[j] = l[j], l[i]
            j = j - 1
    return l

# Selection Sort

def selectionsort(l):
    for i in range(len(l)):
        for j in range(i, len(l)):
            if l[i] > l[j] :
                l[i], l[j] = l[j], l[i]
    return l

# Merge Sort
def mergesort(l):
    if len(l) == 0:
        return []
    if len(l) == 1:
        return l
    middle = len(l) // 2
    left = mergesort(l[0:middle])
    right = mergesort(l[middle: len(l)])
    return merge(left, right)

def merge(l1, l2):
    merged = []
    i = 0
    j = 0
    while i < len(l1) and j < len(l2):
        if l1[i] <= l2[j]:
            merged.append(l1[i])
            i = i + 1
        else:
            merged.append(l2[j])
            j = j + 1
    while i < len(l1):
        merged.append(l1[i])
        i = i + 1
    while j < len(l2):
        merged.append(l2[j])
        j = j + 1
    return merged

# Quick Sort

def quicksort(l):
    return quicksort(l, 0, len(l) - 1)

def quicksort(l, low, high):
    if low > high:
        return []
    pivot = partition(l, low, high)
    quicksort(l, low, pivot-1)
    quicksort(l, pivot+1, high)
    return l

def partition(l, low, high):
    import random
    r = random.randint(low, high)
    l[r], l[high] = l[high], l[r]
    pivot = l[high]
    i = low-1
    for j in range(low, high+1):
        if l[j] <= pivot:
            i = i + 1
            l[j], l[i] = l[i], l[j]
    return i
