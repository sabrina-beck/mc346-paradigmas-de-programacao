def toDict(l):
    if type(l) is not list:
        raise TypeError("Invalid parameter type, expected list")

    return {i: l[i] for i in range(0, len(l))}

def intersect(l1, l2):
    if type(l1) is not list or type(l2) is not list:
        raise TypeError("Parameter should be a list")

    result = []
    [result.append(e) for e in l1 if e in l2 and e not in result]
    return result

def printElements(l):
    if type(l) is not list:
        raise TypeError("Parameter should be a list")

    for element in l:
        if type(element) is not list:
            print(element)
        else:
            printElements(element)

def str2loi(phrase):
    if type(phrase) is not str:
        raise TypeError("Parameter should be a string")

    def convert(word):
        if word[0] == '+':
            signal = 1
            r = 0
        elif word[0] == '-':
            signal = -1
            r = 0
        elif '0' <= word[0] <= '9':
            signal = 1
            r = ord(word[0]) - ord('0')
        else:
            return None

        for c in word[1:]:
            if '0' <= c <= '9':
                r = (r*10) + ord(c) - ord('0')
            else:
                return None
        return r * signal

    words = phrase.split(" ")
    numbers = []
    for word in words:
        number = convert(word)
        if number is not None:
            numbers.append(number)
    return numbers