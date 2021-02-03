from sage.all import *
import binascii

def LowExponent(encs,modules):
    
    M3=CRT_list([Integer(encs[0]) , Integer(encs[1]) , Integer(encs[2])], [Integer(modules[0]) , Integer(modules[1]) , Integer(modules[2])])
    M=(M3)^(1/3)
    print(M)
    print(hex(int(M)))
    print(type(hex(M)))
    pretty_print(binascii.unhexlify(hex(M)[2:]))
    return M


modules = list()
encs = list()
counter = 0
with open("output.txt", "r") as a_file:
  for line in a_file:
    if (counter >= 3):
        stripped_line = line.strip()
        encs.append(stripped_line.split('=')[1].replace(" " , ""))
        counter = counter + 1
    else:  
        stripped_line = line.strip()
        modules.append(stripped_line.split('=')[1].replace(" " , ""))
        counter = counter + 1

LowExponent(encs , modules)