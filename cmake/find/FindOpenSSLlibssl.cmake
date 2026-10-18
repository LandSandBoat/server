xi_find_bundled_library(OpenSSLlibssl OpenSSLlibssl libssl
    NAMES ssl ssl_64 libssl libssl_64
    LIBRARY_DIR openssl
    INCLUDE_DIR ext/openssl/include
    EXTRA_PATHS /usr/local/opt/openssl/lib/ # macOS brew
)
