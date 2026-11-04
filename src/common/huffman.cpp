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

#include "common/huffman.h"

#include "common/logging.h"
#include "common/utils.h"

#include "common/types/error_or.h"

#include <bit>
#include <cassert>
#include <cstring>
#include <memory>
#include <string>

namespace
{

// Resolve the next address in jump table (0 == no jump, 1 == next address)

struct huffman_jump
{
    const void* ptr;
};

struct huffman_tables
{
    std::vector<uint32>              enc;
    std::vector<struct huffman_jump> jump;
};

huffman_tables tables;

void swap32_if_be(uint32* v, const size_t memb)
{
    if constexpr (std::endian::native == std::endian::big)
    {
        for (size_t i = 0; i < memb; ++i)
        {
            v[i] = std::byteswap(v[i]);
        }
    }
}

auto read_to_vector(const std::string& filename) -> ErrorOr<std::vector<uint32>>
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

void populate_jump_table(std::vector<struct huffman_jump>& jump, const std::vector<uint32>& dec)
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
            const size_t index = (dec[i] - base) / sizeof(base);
            jump[i].ptr        = jump.data() + index;
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

} // namespace

namespace
{

// The table holds 256 codes then 256 lengths, indexed by the signed byte plus 128.
constexpr auto kEncodeTableSize = 512U;

auto code_value(const uint8 byte) -> uint32
{
    return tables.enc[static_cast<int8>(byte) + 0x80];
}

auto code_length(const uint8 byte) -> uint32
{
    return tables.enc[static_cast<int8>(byte) + 0x180];
}

// Fast 8-bit decode table for huffman_decode: g_dtab[next8bits] -> (symbol, code length) when the
// code is <= 8 bits, else length 0 (fall back to a bit-by-bit tree walk for the longer code).
struct DecodeEntry
{
    uint8 symbol;
    uint8 length; // 0 == code longer than 8 bits
};

DecodeEntry g_dtab[256];

void build_decode_table()
{
    const auto* root = static_cast<const huffman_jump*>(tables.jump[0].ptr);
    for (uint32 b = 0; b < 256; ++b)
    {
        const auto* jmp = root;
        g_dtab[b]       = { 0, 0 };

        // walk the tree using the 8 bits, LSB-first (== JMPBIT order)
        for (uint32 bit = 0; bit < 8; ++bit)
        {
            jmp = static_cast<const huffman_jump*>(jmp[(b >> bit) & 1].ptr);
            if (!jmp[0].ptr && !jmp[1].ptr) // leaf
            {
                g_dtab[b] = { static_cast<uint8>(reinterpret_cast<std::uintptr_t>(jmp[3].ptr)),
                              static_cast<uint8>(bit + 1) };
                break;
            }
        }
    }
}

} // namespace

auto huffman_init() -> int32
{
    auto enc = read_to_vector("res/compress.dat");
    if (!enc)
    {
        ShowCritical("huffman: %s", enc.error());
        return -1;
    }
    if (enc->size() != kEncodeTableSize)
    {
        ShowCritical("huffman: res/compress.dat holds %zu words, expected %u", enc->size(), kEncodeTableSize);
        return -1;
    }

    tables.enc = std::move(*enc);

    auto dec = read_to_vector("res/decompress.dat");
    if (!dec)
    {
        ShowCritical("huffman: %s", dec.error());
        return -1;
    }

    if (dec->empty())
    {
        ShowCritical("huffman: res/decompress.dat is empty");
        return -1;
    }

    populate_jump_table(tables.jump, *dec);
    build_decode_table();
    return 0;
}

auto huffman_encoded_size(std::span<const uint8> in) -> uint32
{
    assert(!tables.enc.empty());

    uint32 bits = 0;
    for (const auto byte : in)
    {
        bits += code_length(byte);
    }

    return static_cast<uint32>(huffman_byte_size(bits));
}

// Codes go into the bitstream LSB-first, accumulated in a 64-bit register and flushed a byte at a time.
auto huffman_encode(std::span<const uint8> in, std::span<uint8> out) -> Maybe<uint32>
{
    assert(!tables.enc.empty());

    if (out.empty())
    {
        return std::nullopt;
    }

    const auto maxBits = static_cast<uint32>(out.size() - 1) * 8;
    auto*      o       = out.data() + 1;
    uint64     acc     = 0;
    uint32     accBits = 0;
    uint32     outPos  = 0;
    uint32     bits    = 0;

    for (const auto byte : in)
    {
        const auto length = code_length(byte);
        if (bits + length >= maxBits)
        {
            // The codes don't fit, so send the payload raw behind a 0 flag
            if (out.size() < in.size() + 1)
            {
                return std::nullopt;
            }

            out[0] = 0;
            std::memcpy(out.data() + 1, in.data(), in.size());
            return static_cast<uint32>((in.size() + 1) * 8);
        }

        const auto code = uint64{ code_value(byte) } & ((uint64{ 1 } << length) - 1);

        acc |= code << accBits;
        accBits += length;
        bits += length;

        while (accBits >= 8)
        {
            o[outPos++] = static_cast<uint8>(acc & 0xFF);
            acc >>= 8;
            accBits -= 8;
        }
    }

    if (accBits > 0)
    {
        o[outPos] = static_cast<uint8>(acc & 0xFF);
    }

    out[0] = 1;
    return bits + 8;
}

// Resolves codes of up to 8 bits with one g_dtab lookup and walks the tree for longer ones.
auto huffman_decode(std::span<const uint8> in, const uint32 bits, std::span<uint8> out) -> Maybe<uint32>
{
    assert(!tables.jump.empty());

    if (bits < 8 || bits > in.size() * 8)
    {
        return std::nullopt;
    }

    const auto payloadBits = bits - 8;
    const auto payload     = in.subspan(1, huffman_byte_size(payloadBits));

    if (in[0] != 1)
    {
        const auto size = payloadBits / 8;
        if (size > out.size())
        {
            return std::nullopt;
        }

        std::memcpy(out.data(), payload.data(), size);
        return size;
    }

    const auto* root   = static_cast<const huffman_jump*>(tables.jump[0].ptr);
    uint32      w      = 0;
    uint32      bitpos = 0;

    while (bitpos < payloadBits)
    {
        const auto byteoff = bitpos >> 3;
        const auto bitoff  = bitpos & 7;

        // Bits past the payload are read as 0. They never belong to a code that fits in it.
        const auto hi = [&]
        {
            if (byteoff + 1 < payload.size())
            {
                return static_cast<uint32>(payload[byteoff + 1]);
            }

            return 0U;
        }();

        const auto peek  = (static_cast<uint32>(payload[byteoff]) >> bitoff) | (hi << (8 - bitoff));
        const auto entry = g_dtab[peek & 0xFF];

        uint8 symbol = 0;
        if (entry.length != 0)
        {
            // A code cut short by the end of the payload decodes to nothing
            if (bitpos + entry.length > payloadBits)
            {
                break;
            }

            symbol = entry.symbol;
            bitpos += entry.length;
        }
        else
        {
            const auto* jmp = root;
            for (;;)
            {
                if (bitpos >= payloadBits)
                {
                    return w;
                }

                jmp = static_cast<const huffman_jump*>(jmp[(payload[bitpos >> 3] >> (bitpos & 7)) & 1].ptr);
                ++bitpos;
                if (!jmp[0].ptr && !jmp[1].ptr)
                {
                    symbol = static_cast<uint8>(reinterpret_cast<std::uintptr_t>(jmp[3].ptr));
                    break;
                }
            }
        }

        // A decode that fills its output fails
        if (w + 1 >= out.size())
        {
            return std::nullopt;
        }

        out[w++] = symbol;
    }

    return w;
}
