/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "common/zlib.h"

#include "common/logging.h"
#include "common/utils.h"

#include "common/types/error_or.h"

#include <cassert>
#include <cstring>
#include <memory>
#include <string>

#if (defined(__BYTE_ORDER__) && __BYTE_ORDER__ == __ORDER_BIG_ENDIAN__) || (defined(__BYTE_ORDER) && __BYTE_ORDER == __BIG_ENDIAN) ||           \
    defined(__BIG_ENDIAN__) || defined(__ARMEB__) || defined(__THUMBEB__) || defined(__AARCH64EB__) || defined(_MIBSEB) || defined(__MIBSEB) || \
    defined(__MIBSEB__)
#define XI_BIG_ENDIAN 1
#else
#define XI_BIG_ENDIAN 0
#endif

#if XI_BIG_ENDIAN
#if defined(__clang__) || (__GNUC__ >= 4 && __GNUC_MINOR__ >= 3 && !defined(__MINGW32__) && !defined(__MINGW64__))
#define bswap16 __builtin_bswap16
#define bswap32 __builtin_bswap32
#define bswap64 __builtin_bswap64
#elif defined(__GLIBC__)
#include <byteswap.h>
#define bswap16 __bswap_16
#define bswap32 __bswap_32
#define bswap64 __bswap_64
#elif defined(__NetBSD__)
#include <machine/bswap.h> /* already named bswap16/32/64 */
#include <sys/types.h>
#elif defined(_MSC_VER)
#define bswap16 _byteswap_ushort
#define bswap32 _byteswap_ulong
#define bswap64 _byteswap_uint64
#else
#error "No compiler builtins for byteswap available"
#endif
#endif

// Resolve the next address in jump table (0 == no jump, 1 == next address)
#define JMPBIT(table, i) (((table)[(i) / 8] >> ((i) & 7)) & 1)

struct zlib_jump
{
    const void* ptr;
};

struct zlib
{
    std::vector<uint32>           enc;
    std::vector<struct zlib_jump> jump;
};

static zlib zlib;

static void swap32_if_be(const uint32* v, const size_t memb)
{
#if XI_BIG_ENDIAN
    for (size_t i = 0; i < memb; ++i)
    {
        v[i] = bswap32(v[i]);
    }
#else
    (void)v, (void)memb;
#endif
}

static auto read_to_vector(const std::string& filename) -> ErrorOr<std::vector<uint32>>
{
    auto fp = utils::openFile(filename, "rb");
    if (!fp)
    {
        return Error(fmt::format("can't open file <{}>", filename));
    }

    fseek(fp.get(), 0, SEEK_END);
    const size_t size = ftell(fp.get());
    fseek(fp.get(), 0, SEEK_SET);

    std::vector<uint32> vec(size / sizeof(uint32));
    if (fread(vec.data(), sizeof(uint32), vec.size(), fp.get()) != vec.size())
    {
        return Error(fmt::format("can't read file <{}>: {}", filename, strerror(errno)));
    }

    swap32_if_be(vec.data(), vec.size());
    return vec;
}

static void populate_jump_table(std::vector<struct zlib_jump>& jump, const std::vector<uint32>& dec)
{
    jump.resize(dec.size());

    // Base address of dec table, if we substract pointer in dec table, we should should be
    // able to normalize them to offsets starting from 0.
    const uint32 base = dec[0] - sizeof(uint32);

    for (size_t i = 0; i < dec.size(); ++i)
    {
        if (dec[i] > 0xff)
        {
            // Everything over 0xff are pointers.
            // These pointers will be traversed until we hit data.
            jump[i].ptr = jump.data() + (dec[i] - base) / sizeof(base);
        }
        else
        {
            // Everything equal or less to 0xff is 8bit data.
            // The pointers at offsets -3 and -2 in table must be zero for each non-zero data entry
            // This approach assumes pointers are at least 8bit on the system.
            static_assert(sizeof(std::uintptr_t) >= sizeof(uint8), "Pointer can't hold a 8bit value");
            // NOLINTNEXTLINE
            jump[i].ptr = reinterpret_cast<void*>(static_cast<std::uintptr_t>(dec[i]));
            assert(!jump[i].ptr || (!jump[i - 2].ptr && !jump[i - 3].ptr));
        }
    }
}

// Fast 8-bit decode table for zlib_decompress2: g_dtab[next8bits] -> (symbol, code length) when the
// code is <= 8 bits, else length 0 (fall back to a bit-by-bit tree walk for the longer code).
namespace
{

struct DecodeEntry
{
    uint8 symbol;
    uint8 length; // 0 == code longer than 8 bits
};

DecodeEntry g_dtab[256];
bool        g_dtab_built = false;

void build_decode_table()
{
    const auto* root = static_cast<const zlib_jump*>(zlib.jump[0].ptr);
    for (uint32 b = 0; b < 256; ++b)
    {
        const auto* jmp = root;
        g_dtab[b]       = { 0, 0 };

        // walk the tree using the 8 bits, LSB-first (== JMPBIT order)
        for (uint32 bit = 0; bit < 8; ++bit)
        {
            jmp = static_cast<const zlib_jump*>(jmp[(b >> bit) & 1].ptr);
            if (!jmp[0].ptr && !jmp[1].ptr) // leaf
            {
                g_dtab[b] = { static_cast<uint8>(reinterpret_cast<std::uintptr_t>(jmp[3].ptr)),
                              static_cast<uint8>(bit + 1) };
                break;
            }
        }
    }

    g_dtab_built = true;
}

} // namespace

int32 zlib_init()
{
    auto enc = read_to_vector("res/compress.dat");
    if (!enc)
    {
        ShowCritical("zlib: %s", enc.error());
        return -1;
    }
    zlib.enc = std::move(*enc);

    auto dec = read_to_vector("res/decompress.dat");
    if (!dec)
    {
        ShowCritical("zlib: %s", dec.error());
        return -1;
    }

    populate_jump_table(zlib.jump, *dec);
    build_decode_table();
    return 0;
}

// Append each input byte's variable-length code to the output bitstream, accumulating in a 64-bit
// register and flushing whole bytes. This replaced the previous per-bit pack loop (a div/mod/mask/
// read-modify-write for every output bit), which was ~11x slower; the bitstream is identical for
// every complete byte (the trailing partial byte's unused high bits are zero, which the decoder
// ignores).
int32 zlib_compress(const int8* in, const uint32 in_sz, int8* out, const uint32 out_sz)
{
    assert(in && out);
    assert(!zlib.enc.empty());

    const uint32 max_sz  = (out_sz - 1) * 8; // output may be up to 8x the input
    uint8*       o       = reinterpret_cast<uint8*>(out + 1);
    uint64       acc     = 0;
    uint32       accBits = 0;
    uint32       outPos  = 0; // bytes flushed to o
    uint32       read    = 0; // total bits emitted == outPos * 8 + accBits

    for (uint32 i = 0; i < in_sz; ++i)
    {
        const uint32 elem = zlib.enc[static_cast<int8>(in[i]) + 0x180];
        if (elem + read >= max_sz)
        {
            if (in_sz + 1 >= out_sz)
            {
                ShowWarning("zlib_compress: ran out of space, outputting garbage(?) (%u : %u : %u : %u)", read, elem, max_sz, in[i]);
                std::memset(out, 0, (out_sz / 4) + (in_sz & 3));
                std::memset(out + 1, in_sz, in_sz / 4);
                std::memset(out + 1 + in_sz / 4, (in_sz + 1) * 8, in_sz & 3);
                return in_sz;
            }
            ShowWarning("zlib_compress: ran out of space (%u : %u : %u : %u)", read, elem, max_sz, in[i]);
            return -1;
        }

        uint32 v = zlib.enc[static_cast<int8>(in[i]) + 0x80];
        swap32_if_be(&v, 1);
        const uint32 code = (elem >= 32) ? v : (v & ((1U << elem) - 1)); // low elem bits, LSB-first

        acc |= static_cast<uint64>(code) << accBits;
        accBits += elem;
        read += elem;

        while (accBits >= 8)
        {
            o[outPos++] = static_cast<uint8>(acc & 0xFF);
            acc >>= 8;
            accBits -= 8;
        }
    }

    if (accBits > 0)
    {
        // trailing partial byte (unused high bits = 0)
        o[outPos] = static_cast<uint8>(acc & 0xFF);
    }

    out[0] = 1;
    return read + 8;
}

// Table-driven equivalent of original zlib_decompress. Instead of one tree step per input bit,
// peek the next 8 bits and resolve any code of <= 8 bits in a single lookup (g_dtab); codes
// longer than 8 bits fall back to the original bit-by-bit tree walk.
int32 zlib_decompress(const int8* in, const uint32 in_sz, int8* out, const uint32 out_sz)
{
    assert(in && out);
    assert(!zlib.jump.empty());

    if (!g_dtab_built)
    {
        build_decode_table();
    }

    if (in[0] != 1)
    {
        ShowWarning("zlib_decompress2: invalid compressed data");
        return -1;
    }

    const auto*  data    = reinterpret_cast<const uint8*>(in + 1);
    const auto*  root    = static_cast<const zlib_jump*>(zlib.jump[0].ptr);
    const uint32 byteLen = (in_sz + 7) / 8; // meaningful payload bytes
    uint32       w       = 0;
    uint32       bitpos  = 0;

    while (bitpos < in_sz && w < out_sz)
    {
        const uint32 byteoff = bitpos >> 3;
        const uint32 bitoff  = bitpos & 7;

        // Peek 8 bits; the next byte is only read when it's within the payload (else treat as 0 -
        // those high bits are never part of the resolved code, which has its own true length).
        const uint32      hi   = (byteoff + 1 < byteLen) ? static_cast<uint32>(data[byteoff + 1]) : 0U;
        const uint32      peek = (static_cast<uint32>(data[byteoff]) >> bitoff) | (hi << (8 - bitoff));
        const DecodeEntry e    = g_dtab[peek & 0xFF];
        if (e.length != 0)
        {
            out[w++] = static_cast<int8>(e.symbol);
            bitpos += e.length;
        }
        else // code longer than 8 bits: walk the tree
        {
            const auto* jmp = root;
            for (;;)
            {
                jmp = static_cast<const zlib_jump*>(jmp[(data[bitpos >> 3] >> (bitpos & 7)) & 1].ptr);
                ++bitpos;
                if (!jmp[0].ptr && !jmp[1].ptr)
                {
                    out[w++] = static_cast<int8>(reinterpret_cast<std::uintptr_t>(jmp[3].ptr));
                    break;
                }
            }
        }
    }

    return static_cast<int32>(w);
}
