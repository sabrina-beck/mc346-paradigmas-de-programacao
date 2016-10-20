def fibonacci(n):
    if type(n) is not int:
        raise TypeError("Parameter should be an integer")

    a, b = 0, 1
    for i in range(n):
        yield a
        a, b = b, a + b

def visit(l):
    if type(l) is not list:
        yield l
    else:
        for e in l:
            yield from visit(e)