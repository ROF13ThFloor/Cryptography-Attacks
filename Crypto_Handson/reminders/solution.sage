from Crypto.PublicKey import RSA
from Crypto.Util.number import * 
from Crypto.PublicKey.RSA import *
from Crypto.Cipher import *
import binascii
import os
import itertools
import unicodedata
import rsa


def find_common_key(all_N):
    pubkeys = all_N
    q = 0
    for p1, p2 in itertools.permutations(pubkeys, int(2)):
        g = gcd(p1, p2)
        if g != 1:
            print("theese modules have common factor ",pubkeys.index(p1),pubkeys.index(p2))
            print("we have common factor with gcd ")
            print("modules is : ", pubkeys.index(p1), "   :" , p1)
            index_of_pubkey = pubkeys.index(p1)
            Q_factor = p1 / g 
            return g , Q_factor , index_of_pubkey
           #return p and Q_factor





count = 1
all_N = list()
for i in range(0,115):
    p_key = RSA.importKey(open('pkeys/pubkey_' + str(i).zfill(3) + '.pem','r').read())
    all_N.append(p_key.n)
    count = count + 1 


print('Step 1: Find common factor key .. . . ')    

attack_point = find_common_key(all_N)

e_factor = RSA.importKey(open('pkeys/pubkey_'+ str(attack_point[2]).zfill(3) + '.pem','r').read()).e 
Modules_factor = RSA.importKey(open('pkeys/pubkey_'+ str(attack_point[2]).zfill(3) + '.pem','r').read()).n

euler_num = (attack_point[0] - 1) * (attack_point[1] - 1)

d_fctor = inverse_mod(e_factor , euler_num)


with open('encs/secret_' + str(attack_point[2]).zfill(3) + '.enc' ,"rb" ) as file:
    enc_data = file.read()



print("encrypted msg in byte is " , enc_data)
print("encrypted msg in hex is :" ,enc_data.hex())
print("integer of cipher is " , int.from_bytes(enc_data, "big"))

print("p is : " , attack_point[0])
print("q is : " , attack_point[1])
print("modules is : " , Modules_factor)
print("multiple p * q is  : " , attack_point[0]*attack_point[1])
print("euler_num is : " , euler_num)
print("e is : " ,  e_factor)
print("d is : " , d_fctor)
print("e*d = " , mod(d_fctor*e_factor , euler_num))
plaintext = power_mod(int(enc_data.hex() , 16) , d_fctor, Modules_factor)
p = binascii.unhexlify(hex(plaintext)[2:])
print(p)

#print("d is " , d_fctor)

#print(" module is : " , Modules_factor)









#print(int_to_msg(plaintext))
#pretty_print(binascii.unhexlify(hex(plaintext)[2:]))







