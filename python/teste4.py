def contaOcorrencias(string):
    if type(string) is not str:
        raise TypeError("Tipo inesperado.")
    regex = "[A-Za-zàÀáÁäÄâÂãÃèÈéÉëËêÊẽẼìÌíÍïÏîÎĩĨòÒóÓöÖôÔõÕùÙúÚüÜûÛũŨçÇ]{6,}(?\.|,|!|?|\.\.\.)?"
    import re
    palavras = re.findall(regex, string)
    ocorrencias = {}
    for palavra in palavras:
        palavra = palavra.replace(".", "").replace(",", "").replace("!", "").replace("?", "")
        ocorrencias[palavra] = ocorrencias.get(palavra, 0)
    return ocorrencias