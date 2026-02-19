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

#include "xirand.h"

#include <array>
#include <cstddef>
#include <fstream>
#include <stdexcept>

// https://stackoverflow.com/a/45069417
#ifdef _WIN32

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#include <wincrypt.h>

auto acquire_context(HCRYPTPROV* ctx) -> bool
{
    if (!CryptAcquireContext(ctx, nullptr, nullptr, PROV_RSA_FULL, 0))
    {
        return CryptAcquireContext(ctx, nullptr, nullptr, PROV_RSA_FULL, CRYPT_NEWKEYSET);
    }

    return true;
}

auto sysrandom(void* dst, size_t dstlen) -> size_t
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

auto sysrandom(void* dst, size_t dstlen) -> size_t
{
    int bytes = syscall(SYS_getrandom, dst, dstlen, 0);
    if (bytes != dstlen)
    {
        throw std::runtime_error("Unable to read N bytes from CSPRNG.");
    }

    return dstlen;
}
#else // OSX
auto sysrandom(void* dst, size_t dstlen) -> size_t
{
    char*         buffer = reinterpret_cast<char*>(dst);
    std::ifstream stream("/dev/urandom", std::ios_base::binary | std::ios_base::in);
    stream.read(buffer, dstlen);

    return dstlen;
}
#endif

void xirand::seed()
{
    // 4096 bits of entropy (128 * 32-bit words)
    //
    // Mersenne Twister engines (std::mt19937 and std::mt19937_64) have a large internal state
    // (~2.5KB). Seeding with a single 32-bit value leaves the state sparsely populated, which
    // can lead to statistical artifacts in the first outputs. Using a larger pool of entropy
    // combined with std::seed_seq ensures the state is thoroughly mixed.
    //
    // While engines like PCG or Squirrel5 require much less state, providing this amount of
    // entropy is inexpensive (once per thread) and ensures a high-quality start for any
    // selected engine. This is overkill, but cheap to do once per thread anyway.
    std::array<uint32_t, 128> seedData{};
    sysrandom(seedData.data(), seedData.size() * sizeof(uint32_t));

    std::seed_seq seq(seedData.begin(), seedData.end());
    rng().seed(seq);
}

auto xirand::rng() -> SelectedRandomEngine&
{
    // We use thread_local to give every thread its own independent RNG instance.
    // This avoids the need for locks which would otherwise cause significant
    // contention in a multi-threaded environment.
    //
    // The static 'initialized' flag ensures that every new thread automatically
    // seeds itself exactly once upon its first request for a random number.

    static thread_local bool                 initialized{ false };
    static thread_local SelectedRandomEngine engine{};

    if (!initialized)
    {
        initialized = true;
        seed();
    }

    return engine;
}
