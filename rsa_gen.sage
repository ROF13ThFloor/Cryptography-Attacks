import binascii

def str_to_int(msg):
    return int(binascii.hexlify(msg).decode(),16)

def int_to_str(msg):
    return (binascii.unhexlify(hex(msg)))

def generate_RSA_key_pair(N):
    n = 0
    p = 0
    q = 0
    while n.nbits() != N:
        p = random_prime(2^(N//2), lbound = 2^(N//2 -1))
        q = random_prime(2^(N//2), lbound = 2^(N//2 -1))
        n = p*q
    phi = (p-1)*(q-1)
    e=0
    while true:
        e = ZZ.random_element(1,phi)
        if gcd(e,phi) == 1:
            break
    d = inverse_mod(e,phi)
    return (n,e), (n,d), (p,q)
pub, priv, pq = generate_RSA_key_pair(100)

def encrypt(m,public):
    n = public[0]
    e = public[1]
    #print("here:", str_to_int(m))
    #print(power_mod(str_to_int(m), e, n))
    return power_mod(str_to_int(m), e, n)

def decrypt(c, private):
    n = private[0]
    d = private[1]    
    print(binascii.unhexlify(hex(power_mod(c, d,n))))

print(pub, priv, pq)    
decrypt(encrypt("solmaz",pub), priv)