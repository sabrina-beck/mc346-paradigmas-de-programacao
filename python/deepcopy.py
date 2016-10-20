import collections

def deepcopy(l):
    if not isinstance(l, collections.Iterable):
        raise TypeError("Can't deep copy non list object")

    clone = []
    for element in l:
        if type(element) is str:
            subclone = element[:]
        elif type(element) is dict:
            subclone = {}
            for key in element:
                if isinstance(element[key], collections.Iterable):
                    sc = deepcopy(element)
                else:
                    sc = element[key]
                subclone[key] = sc
        elif isinstance(element, collections.Iterable):
            subclone = deepcopy(element)
        else:
            subclone = element # we are unabled to create a copy of primitives type
        clone.append(subclone)
    return clone

#import deepcopy
#a = [1, 2, 3, [4, 5, 6], ["asdf", 5], {1: [34]}]
#b = deepcopy.deepcopy(a)
#print("a is b", a is b)
#print("a[1] is b[1]", a[1] is b[1])
#print("a[3] is b[3]", a[3] is b[3])
#print("a[3][0] is b[3][0]", a[3][0] is b[3][0])
#print("a[4] is b[4]", a[4] is b[4])
#print("a[4][0] is b[4][0]", a[4][0] is b[4][0])