def reverse(string):
    if type(string) is not str:
        raise TypeError("Invalid parameter type, expected string")

    reversedStr = ""
    words = string.split(" ")
    i = len(words) - 1
    while i >= 0:
        reversedStr += words[i] + " "
        i -= 1
    return reversedStr;