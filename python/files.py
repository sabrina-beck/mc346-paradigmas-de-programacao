def characterPercentages(filename):
    if type(filename) is not str:
        raise TypeError("Parameter should be a string")

    percentages = {}
    total = 0
    with open(filename) as file:
        for line in file:
            for character in line:
                percentages[character] = percentages.get(character, 0) + 1
                total += 1
    for key, value in percentages.items():
            percentages[key] = percentages[key] / total
    return percentages