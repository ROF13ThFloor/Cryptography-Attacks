#!/usr/bin/env python3
import os, binascii, struct
from Crypto.Cipher import AES

op = lambda msg: msg + bytes([16 - len(msg) % 16] * (16 - len(msg) % 16))
def cryptocrypto(m):
    o0ps = AES.new(bytes(0x10), AES.MODE_CBC, bytes(0x10))
    return o0ps.encrypt(len(msg).to_bytes(0x10, 'big') + op(msg))[-0x10:]

pre = os.urandom(0x10)
print(binascii.hexlify(pre).decode())

post = binascii.unhexlify(input())

if post.startswith(b'I think cryptography is really cool, you?\0') \
        and cryptocrypto(post) == pre:
    print("Well done!!!")
