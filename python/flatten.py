# sabrina
def flatten(l):
    if type(l) is not list:
        raise Exception("Tipo inesperado, esperava-se uma lista")

    result = []
    for element in l:
        if type(element) is list:
            subresult = flatten(element)
            for subelement in subresult:
                result.append(subelement)
        else:
            result.append(element)
    return result

# caio s
def flat(l):
    if type(l) is not list:
        return []
    aux = []

    for i in l:
        aux.extend(flat(i))
        if type(i) is not list:
            aux.append(i)

    return aux
