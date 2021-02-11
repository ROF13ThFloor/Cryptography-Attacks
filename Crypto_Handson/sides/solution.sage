
from sage.crypto.block_cipher.sdes import SimplifiedDES
import binascii



def decryption(c , k):
    des = SimplifiedDES()
    counter = len(c) / 8
    n=8
    cipher = [c[i:i+n] for i in range(0, len(c), n)]
    decrypted_msg = ''

    for l in cipher:
        decrypted_msg = decrypted_msg +  str(sdes.list_to_string(sdes.decrypt(sdes.string_to_list(l),k)))

    return decrypted_msg          






f = open("output.txt", "r")
encs = f.readline().strip().split('=')[1].replace(" ","")



sdes = SimplifiedDES()

encrypted_binary = bin(int(encs))[2:]
print(encrypted_binary)
right_len  = len(encrypted_binary) + (8 - (len(encrypted_binary) % 8))

encrypted_binary = encrypted_binary.rjust(right_len , "0")
print("padding  enc is : ",encrypted_binary)
main_bin = encrypted_binary

decrypt_dta = ' '
p_text = ' ' 
f=open("decryptedmsg.txt", "a+b")
for i in range(0,1024):
    key = bin(int(i))[2:].zfill(10)
    key_list = [int(d) for d in key]
    dec_msg_bin = decryption(main_bin,key_list)
    str_ans = binascii.unhexlify(hex(int(dec_msg_bin , 2))[2:].zfill(176))
    try:
        data = str_ans.decode()
        print("encrypted message is : ==>" , data)
        print("message encrypted with key ==>" , key)
    except (UnicodeDecodeError, AttributeError):
        pass
   # if (str_ans.find('good') >0 ):
    #    print("answer is : " , str_ans)
     #   print("key is : " , key)

    #f.write(str(str_dec))
    #f.write("\n")
f.close()    
      
   