if [ ! -f server_ca.pem ] && [ ! -f server_cert.pem ] && [ ! -f server_key.pem ]; then
    echo "Generating server certificate"
    # Generate server private key
    openssl genpkey -algorithm RSA -out server_key.pem -pkeyopt rsa_keygen_bits:2048

    # Create a CSR
    openssl req -new -key server_key.pem -out server_csr.pem

    # Generate CA private key
    openssl genpkey -algorithm RSA -out ca_key.pem -pkeyopt rsa_keygen_bits:2048

    # Create a self-signed CA certificate
    openssl req -x509 -new -nodes -key ca_key.pem -sha256 -days 365 -out server_ca.pem

    # Sign the CSR with the CA certificate to get the server certificate
    openssl x509 -req -in server_csr.pem -CA server_ca.pem -CAkey ca_key.pem -CAcreateserial -out server_cert.pem -days 365 -sha256
else
    echo "Server certificate already exists"
fi