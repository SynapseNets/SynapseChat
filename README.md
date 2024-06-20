# SynapseChat
Synapse Chat is an Electron-based chat client made using React.js and its server built in Python.

# Server
### Generate server private key
```bash
openssl genpkey -algorithm RSA -out server_key.pem -pkeyopt rsa_keygen_bits:2048
```

### Create a CSR
```bash
openssl req -new -key server_key.pem -out server_csr.pem
```

### Generate CA private key
```bash
openssl genpkey -algorithm RSA -out ca_key.pem -pkeyopt rsa_keygen_bits:2048
```

### Create a self-signed CA certificate
```bash
openssl req -x509 -new -nodes -key ca_key.pem -sha256 -days 365 -out server_ca.pem
```

### Sign the CSR with the CA certificate to get the server certificate
```bash
openssl x509 -req -in server_csr.pem -CA server_ca.pem -CAkey ca_key.pem -CAcreateserial -out server_cert.pem -days 365 -sha256
```