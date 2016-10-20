def cesar(text):
    return ''.join([chr((ord(c) + 3) % 256) for c in list(text)])

def uncesar(text):
    return ''.join([chr((ord(c) - 3) % 256) for c in list(text)])

