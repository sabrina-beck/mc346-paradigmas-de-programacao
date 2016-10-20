def remove_duplicate(l):
    if type(l) is not list:
        raise TypeError("Can't act on non list parameter")
    new_list = []
    for element in l:
        if element not in new_list:
            new_list.append(element)
    return new_list