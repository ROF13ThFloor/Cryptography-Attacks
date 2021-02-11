#!/usr/bin/env sage
# Problem Set, Applied Cryptography I

from sage.crypto.block_cipher.sdes import SimplifiedDES
from top_secret import secret

sides = SimplifiedDES()
tobin = BinaryStrings()
ptext = tobin.encoding(secret)
print(type(ptext))

assert len(ptext) % 8 == 0

key = sides.list_to_string(sides.random_key())
ciphertext = sides(ptext, key, algorithm = "encrypt")
#print(type(ciphertext))
print(ciphertext)
enc = int(str(ciphertext), 2)

print('enc =', enc)
print('key =', '?')

# You should find the secret message and the related key!