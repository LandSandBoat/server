xi_find_bundled_library(OpenSSLlibcrypto OpenSSLlibcrypto libcrypto
    NAMES crypto crypto_64 libcrypto libcrypto_64
    LIBRARY_DIR openssl
    INCLUDE_DIR ext/openssl/include
    EXTRA_PATHS /usr/local/opt/openssl/lib/ # macOS brew
)
