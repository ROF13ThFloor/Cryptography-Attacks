from Crypto.PublicKey import RSA
from Crypto.Util.number import * 
from Crypto.PublicKey.RSA import *
from Crypto.Cipher import *
import binascii
import os
import itertools
import unicodedata
import rsa


#convert message to integer 
def msg_to_int(msg):
    int_msg = ""
    for ch in msg:
        pre = "{0:b}".format(ord(ch))
        if len(pre) < 7:
            pre = "0" * (7 - len(pre)) + pre
        int_msg += pre

    return int(int_msg, 2)

#convert int to msg 

def int_to_msg(i):
    bin_format = "{0:7b}".format(i)
    msg = ""

    for b in range(0, len(bin_format), 7):
        msg += chr(int(bin_format[b:b + 7], 2))

    return msg

def find_common_key(all_N):
    pubkeys = all_N
    q = 0
    for p1, p2 in itertools.permutations(pubkeys, int(2)):
        g = gcd(p1, p2)
        if g != 1:
            print("--------------",pubkeys.index(p1),pubkeys.index(p2))
            print("we have common factor with gcd ")
            print("modules is : ", pubkeys.index(p1), "   :" , p1)
            index_of_pubkey = pubkeys.index(p1)
            Q_factor = p1 / g 
            return g , Q_factor , index_of_pubkey
           #return p and Q_factor




def bytes_to_int(bytes):
    result = 0
    for b in bytes:
        result = result * 256 + int(b)
    return result



def decrypt(c, n , d):  
    print(binascii.unhexlify(hex(power_mod(c, d,n))[2:]))




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




print(type(Modules_factor))
print(type(e_factor))
print(type(int(d_fctor)))
print(type(int(attack_point[0])))
print(type(int(attack_point[1])))






print(attack_point[0])
print(attack_point[1])


#decrypt(bytes_to_int(enc_data) , Modules_factor , d_fctor)


print("cipher is " , int(binascii.hexlify(enc_data).decode(),16 ))

print("d is " , d_fctor)

print(" module is : " , Modules_factor)



plaintext = power_mod(int(enc_data.hex() , 16) , d_fctor, Modules_factor)






#print(int_to_msg(plaintext))
#pretty_print(binascii.unhexlify(hex(plaintext)[2:]))







