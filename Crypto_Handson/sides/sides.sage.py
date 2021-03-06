

# This file was *autogenerated* from the file sides.sage
from sage.all_cmdline import *   # import sage library

_sage_const_8 = Integer(8); _sage_const_0 = Integer(0); _sage_const_2 = Integer(2)#!/usr/bin/env sage
# Problem Set, Applied Cryptography I

from sage.crypto.block_cipher.sdes import SimplifiedDES
from top_secret import secret

sides = SimplifiedDES()
tobin = BinaryStrings()
ptext = tobin.encoding(secret)
print(type(ptext))

assert len(ptext) % _sage_const_8  == _sage_const_0 

key = sides.list_to_string(sides.random_key())
ciphertext = sides(ptext, key, algorithm = "encrypt")
#print(type(ciphertext))
print(ciphertext)
enc = int(str(ciphertext), _sage_const_2 )

print('enc =', enc)
print('key =', '?')

# You should find the secret message and the related key!

