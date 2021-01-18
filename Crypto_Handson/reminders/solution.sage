from Crypto.PublicKey import RSA
from Crypto.Util.number import * 
from Crypto.PublicKey.RSA import *
from Crypto.Cipher import *
import binascii
import os
import unicodedata


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



#compute P
def calc_p(all_N):
    return prod(l[1] for l in all_N)

def calc_Z_i(Product_Moduls , all_N):
    all_z = list()
    Z = 0
    for l in all_N:
        powN = l[1] * l[1]
        #print(powN)
        Z = Product_Moduls % powN
        all_z.append(tuple((l[0],Z)))
    return all_z    

# in this function we have shared prime number factoring and therefor we can compute other N factor => q = N/p
def decrypt_commonfactor(index, prime_factor_shared_number , all_N):
    encrypted_content = ""
    N_modul = all_N[index][1]
    second_factor = N_modul // prime_factor_shared_number
    # now we have p and q     
    phi_n = (prime_factor_shared_number-1)*(second_factor-1)
    exponent = 0 
    while true:
        exponent = ZZ.random_element(1,phi_n)
        if gcd(exponent,phi_n) == 1:
            break
    d = inverse_mod(exponent,phi_n)
    # now we have e and d too :) 
    directory = r'encs/'
    count = 0
    for entry in os.scandir(directory):
        if (count == index):
            f = open(entry.path, "rb"  )
            encrypted_content = f.read()
        count = count + 1
    cipher = int(binascii.hexlify(encrypted_content).decode() , 16)

    decrypted_content = power_mod(cipher , d , N_modul)
    #decrypted_hex = hex(decrypted_content)
    print(hex(decrypted_content))
    #message = (binascii.unhexlify(hex(decrypted_content)))









directory = r'pkeys/'
count = 1
all_N = list()
for entry in os.scandir(directory):
    #print( entry.path  + "= contain")
    p_key = RSA.importKey(open(entry.path,'r').read())
    all_N.append(tuple((count, p_key.n)))
    count = count + 1 
   #print(p_key.n)


for l in all_N:
    print(l)
Product_Moduls = calc_p(all_N)

# we have all zi in algoithm 

all_z = calc_Z_i(Product_Moduls , all_N)

# now we shoul iterate on to see which one of gcd of (Ni , Zi / Ni) is not equal to = 1  ,,,  we have all_Z and all_N
prime_factor_shared_number = 0 
division_two_number = 0 
index = 0
count = 0 
for z , n in zip(all_z , all_N):
    division_two_number = z[1] // n[1]
    if (gcd(n[1], division_two_number) != 1):
        prime_factor_shared_number = gcd(n[1], division_two_number)
        index = count
        break  
    count = count + 1        

#print(index)

decrypt_commonfactor(index , prime_factor_shared_number , all_N)
#decrypted_msg =


