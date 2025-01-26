# KeyCrack

**KeyCrack** is a project that implements cryptographic attack techniques, focusing on the Low Exponent Attack on RSA and other cryptographic vulnerabilities using the **Sage** mathematical software.

## Features

- Implementation of **Low Exponent Attack** on RSA encryption.
- Usage of the **Sage** library for cryptographic computations.
- Sample scripts and resources for practical cryptanalysis.

The **KeyCracks** project covers the following cryptographic attacks and implementations:

1. **Low Public Exponent Attack on RSA**
   - Exploits RSA encryption with a small public exponent (`e = 3`) to recover plaintext messages.
   - Involves multiple ciphertexts encrypted with different modulus values but the same exponent.
2. **Common Factor Attack on RSA**
   - Analyzes public keys with shared prime factors, allowing recovery of private keys through factorization.
3. **Simplified DES (SDES) Cryptanalysis**
   - Investigates vulnerabilities in the SDES encryption algorithm by analyzing weaknesses in key scheduling and encryption patterns.
4. **AES CBC-MAC Padding Attack**
   - Explores attacks against AES encryption using the CBC-MAC mode and padding vulnerabilities to forge valid ciphertexts.

## Project Structure

```
KeyCrack/
│-- Crypto_Handson/           
│-- README.md                 
│-- crypto_v2.0.pdf            # Detailed explanations of cryptographic techniques
│-- low-public-exp-attck.pdf   # Research material on Low Exponent Attack
│-- rsa_gen.sage               # Sage script for RSA key generation
│-- rsa_gen.sage.py            # Python version of the RSA generation script
│-- sec12-final228.pdf          # Additional cryptography research document
```

## Installation

1. Ensure you have SageMath installed:

   ```bash
   sudo apt install sagemath
   ```

## Requirements

- SageMath for cryptographic operations
- Python  3 (for script automation)
- Basic understanding of RSA encryption

## License

This project is licensed under the MIT License.
