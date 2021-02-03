#!/usr/bin/env sage
# Cryptography Problem Set, I
# run with this command sage ethree.py

from sage.all import *
from top_secret import secret

def keygen(nbit):
	PRIMES = [random_prime(2**(nbit - 1), 2**nbit) for _ in range(6)]
	n_1, n_2, n_3 = [PRIMES[2*i]*PRIMES[2*i + 1] for i in range(3)]
	return (n_1, 3), (n_2, 3), (n_3, 3)

def bytes_to_long(msg):
	mhex = msg.encode('utf-8').hex()
	mint = int(mhex, 16)
	return mint

def encrypt(msg, pubkey):
	n, e = pubkey
	m = bytes_to_long(msg)
	assert m < n
	return pow(m, e, n)

nbit = 1024
pubkey_1, pubkey_2, pubkey_3 = keygen(nbit)

n_1, _ = pubkey_1
n_2, _ = pubkey_2
n_3, _ = pubkey_3

enc_1, enc_2, enc_3 = encrypt(secret, pubkey_1), encrypt(secret, pubkey_2), encrypt(secret, pubkey_3)

print('n_1 =', n_1)
print('n_2 =', n_2)
print('n_3 =', n_3)

print('enc_1 =', enc_1)
print('enc_2 =', enc_2)
print('enc_3 =', enc_3)

