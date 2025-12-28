/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include <fstream>
#include <stddef.h>

// https://stackoverflow.com/a/45069417
#ifdef _WIN32

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <wincrypt.h>

bool acquire_context(HCRYPTPROV* ctx)
{
    if (!CryptAcquireContext(ctx, nullptr, nullptr, PROV_RSA_FULL, 0))
    {
        return CryptAcquireContext(ctx, nullptr, nullptr, PROV_RSA_FULL, CRYPT_NEWKEYSET);
    }

    return true;
}

size_t sysrandom(void* dst, size_t dstlen)
{
    HCRYPTPROV ctx;
    if (!acquire_context(&ctx))
    {
        throw std::runtime_error("Unable to initialize Win32 crypt library.");
    }

    BYTE* buffer = reinterpret_cast<BYTE*>(dst);
    if (!CryptGenRandom(ctx, static_cast<DWORD>(dstlen), buffer))
    {
        throw std::runtime_error("Unable to generate random bytes.");
    }

    if (!CryptReleaseContext(ctx, 0))
    {
        throw std::runtime_error("Unable to release Win32 crypt library.");
    }

    return dstlen;
}
#elif defined(__linux__) || defined(linux) || defined(__linux)

#include <linux/random.h>
#include <sys/syscall.h>
#include <unistd.h>

size_t sysrandom(void* dst, size_t dstlen)
{
    int bytes = syscall(SYS_getrandom, dst, dstlen, 0);
    if (bytes != dstlen)
    {
        throw std::runtime_error("Unable to read N bytes from CSPRNG.");
    }

    return dstlen;
}
#else // OSX
size_t sysrandom(void* dst, size_t dstlen)
{
    char*         buffer = reinterpret_cast<char*>(dst);
    std::ifstream stream("/dev/urandom", std::ios_base::binary | std::ios_base::in);
    stream.read(buffer, dstlen);

    return dstlen;
}
#endif
