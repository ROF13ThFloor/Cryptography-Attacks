#!/usr/bin/env python3
import os, binascii, struct
from Crypto.Util import strxor
from Crypto.Cipher import AES

op = lambda msg: msg + bytes([16 - len(msg) % 16] * (16 - len(msg) % 16))
def enc(m, length):
    crypt0r = AES.new(bytes(0x10), AES.MODE_CBC, bytes(0x10))
    cipher = crypt0r.encrypt(length.to_bytes(0x10, 'big') + m)
    return cipher[-0x10:]

def cryptocrypto(m):
    o0ps = AES.new(bytes(0x10), AES.MODE_CBC, bytes(0x10))
    return o0ps.encrypt(len(m).to_bytes(0x10, 'big') + op(m))[-0x10:]

pre = os.urandom(0x10)
print(binascii.hexlify(pre).decode())

crypt1r = AES.new(bytes(0x10), AES.MODE_ECB)
tail  = crypt1r.decrypt(pre)

msg = b'I think cryptography is really cool, you?\0.....'

for i in range(256):
    b = bytes([i])
    block = enc(msg+b, len(msg+tail))
    if strxor.strxor(tail, block)[15] == 1:
        break
tail= strxor.strxor(tail, block)
msg = msg + b + tail[:-1]

post = msg

if post.startswith(b'I think cryptography is really cool, you?\0') \
        and cryptocrypto(post) == pre:
    print("Well done!!!")
