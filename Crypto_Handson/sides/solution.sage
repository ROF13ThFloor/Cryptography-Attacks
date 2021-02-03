from output import enc
from sage.crypto.block_cipher.sdes import SimplifiedDES



CtectBinary = format(enc, "b")

key = format(514, "b").zfill(10)

sides = SimplifiedDES()


#assert len(CtectBinary) % 8 == 0

plaitext = sides(CtectBinary , key , algorithm = "decrypt")