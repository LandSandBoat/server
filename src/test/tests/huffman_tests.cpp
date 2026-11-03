/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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
#include "common/xirand.h"

#include <catch2/catch_test_macros.hpp>

#include <algorithm>
#include <array>
#include <cstring>
#include <fstream>
#include <map>
#include <utility>
#include <vector>

namespace
{

struct CodeTable
{
    std::array<uint32, 256> values{};
    std::array<uint32, 256> lengths{};
};

// 256 codes then 256 lengths, indexed by (byte + 128) & 0xFF, the same layout as the client's table.
auto loadCodeTable() -> CodeTable
{
    auto file = std::ifstream("res/compress.dat", std::ios::binary);
    REQUIRE(file);

    auto table = CodeTable{};
    file.read(reinterpret_cast<char*>(table.values.data()), sizeof(table.values));
    file.read(reinterpret_cast<char*>(table.lengths.data()), sizeof(table.lengths));
    REQUIRE(file);

    return table;
}

auto tableIndex(const uint8 byte) -> uint32
{
    return (byte + 128) & 0xFF;
}

// Bit-at-a-time encoder, equivalent to the client's logic.
auto referenceEncode(const CodeTable& table, std::span<const uint8> in, std::span<uint8> out) -> Maybe<uint32>
{
    uint32 bitOffset = 0;
    for (const auto byte : in)
    {
        const auto index      = tableIndex(byte);
        const auto nextOffset = table.lengths[index] + bitOffset;
        if (nextOffset >= 8 * (out.size() - 1))
        {
            if (out.size() >= in.size() + 1)
            {
                std::ranges::fill(out, uint8{ 0 });
                std::memcpy(out.data() + 1, in.data(), in.size());
                out[0] = 0;
                return static_cast<uint32>(8 * (in.size() + 1));
            }

            return std::nullopt;
        }

        for (uint32 bit = 0; bit < table.lengths[index]; ++bit)
        {
            const auto dest   = bitOffset + bit;
            const auto set    = (table.values[index] >> bit) & 1;
            out[1 + dest / 8] = static_cast<uint8>((out[1 + dest / 8] & ~(1 << (dest & 7))) | (set << (dest & 7)));
        }

        bitOffset = nextOffset;
    }

    out[0] = 1;
    return bitOffset + 8;
}

// Bit-at-a-time decoder, equivalent to the client's logic.
auto referenceDecode(const CodeTable& table, std::span<const uint8> in, const uint32 bits, std::span<uint8> out) -> Maybe<uint32>
{
    if (in[0] != 1)
    {
        const auto size = (bits - 8) >> 3;
        std::memcpy(out.data(), in.data() + 1, size);
        return size;
    }

    auto codes = std::map<std::pair<uint32, uint32>, uint8>{};
    for (uint32 byte = 0; byte < 256; ++byte)
    {
        const auto index                                            = tableIndex(static_cast<uint8>(byte));
        const auto mask                                             = (1U << table.lengths[index]) - 1;
        codes[{ table.lengths[index], table.values[index] & mask }] = static_cast<uint8>(byte);
    }

    uint32 index  = 0;
    uint32 code   = 0;
    uint32 length = 0;
    for (uint32 bit = 0; bit < bits - 8; ++bit)
    {
        code |= ((in[1 + bit / 8] >> (bit & 7)) & 1) << length;
        ++length;

        const auto it = codes.find({ length, code });
        if (it != codes.end())
        {
            out[index++] = it->second;
            if (index >= out.size())
            {
                return std::nullopt;
            }

            code   = 0;
            length = 0;
        }
    }

    return index;
}

auto randomBytes(const size_t size) -> std::vector<uint8>
{
    auto bytes = std::vector<uint8>(size);
    for (auto& byte : bytes)
    {
        byte = static_cast<uint8>(xirand::GetRandomNumber<uint32>(256));
    }

    return bytes;
}

// Mostly zeroes, the way game packets look.
auto packetLikeBytes(const size_t size) -> std::vector<uint8>
{
    auto bytes = randomBytes(size);
    for (auto& byte : bytes)
    {
        if (xirand::GetRandomNumber<uint32>(4) != 0)
        {
            byte = 0;
        }
    }

    return bytes;
}

} // namespace

TEST_CASE("huffman table matches the client", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    const auto table = loadCodeTable();

    // Spot checks against the client's table
    CHECK(table.values[tableIndex(0x00)] == 0x001);
    CHECK(table.lengths[tableIndex(0x00)] == 1);
    CHECK(table.values[tableIndex(0x15)] == 0x004);
    CHECK(table.lengths[tableIndex(0x15)] == 3);
    CHECK(table.values[tableIndex(0x80)] == 0x016);
    CHECK(table.lengths[tableIndex(0x80)] == 5);
    CHECK(table.values[tableIndex(0xFF)] == 0x1A2);
    CHECK(table.lengths[tableIndex(0xFF)] == 12);

    // No code is the start of another, so a bit string decodes one way only
    for (uint32 a = 0; a < 256; ++a)
    {
        for (uint32 b = 0; b < 256; ++b)
        {
            if (a != b && table.lengths[a] <= table.lengths[b])
            {
                const auto mask = (1U << table.lengths[a]) - 1;
                CHECK((table.values[b] & mask) != (table.values[a] & mask));
            }
        }
    }

    // Each code takes 2^-length of the bit-string space. With no prefixes, a total of exactly 1 means
    // the decode tree has no dead branches, so any bits a client sends decode without walking off it.
    auto codeSpace = 0.0;
    for (const auto length : table.lengths)
    {
        codeSpace += 1.0 / static_cast<double>(1U << length);
    }

    CHECK(codeSpace == 1.0);
}

TEST_CASE("huffman encode is equivalent to the client's logic", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    const auto table = loadCodeTable();
    xirand::rng().seed(0x5EED);

    // 2400 random bytes overflow the codes and take the raw path
    for (const size_t size : { 0U, 1U, 7U, 64U, 300U, 1200U, 2400U })
    {
        for (const auto& input : { randomBytes(size), packetLikeBytes(size) })
        {
            auto ours      = std::vector<uint8>(2452, 0);
            auto reference = std::vector<uint8>(2452, 0);

            const auto ourBits       = huffman_encode(input, ours);
            const auto referenceBits = referenceEncode(table, input, reference);

            REQUIRE(ourBits.has_value());
            REQUIRE(ourBits == referenceBits);

            const auto bytes = huffman_byte_size(*ourBits);
            CHECK(std::equal(ours.begin(), ours.begin() + bytes, reference.begin()));
        }
    }
}

TEST_CASE("huffman decode is equivalent to the client's logic", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    const auto table = loadCodeTable();
    xirand::rng().seed(0xDEC0DE);

    for (const size_t size : { 1U, 7U, 64U, 300U, 1200U })
    {
        const auto input   = packetLikeBytes(size);
        auto       encoded = std::vector<uint8>(2452, 0);
        const auto bits    = huffman_encode(input, encoded);
        REQUIRE(bits.has_value());

        auto ours      = std::vector<uint8>(2472, 0);
        auto reference = std::vector<uint8>(2472, 0);

        const auto ourSize       = huffman_decode(encoded, *bits, ours);
        const auto referenceSize = referenceDecode(table, encoded, *bits, reference);

        REQUIRE(ourSize == referenceSize);
        REQUIRE(ourSize == size);
        CHECK(std::equal(input.begin(), input.end(), ours.begin()));
    }

    SECTION("on random bits, including codes cut short and full outputs")
    {
        xirand::rng().seed(0xBAD);
        for (uint32 i = 0; i < 2000; ++i)
        {
            auto noise = randomBytes(64);
            noise[0]   = 1;

            auto       ours      = std::vector<uint8>(128, 0);
            auto       reference = std::vector<uint8>(128, 0);
            const auto bits      = xirand::GetRandomNumber<uint32>(8, 64 * 8 + 1);

            CHECK(huffman_decode(noise, bits, ours) == referenceDecode(table, noise, bits, reference));
        }
    }
}

TEST_CASE("huffman round trips every byte value", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    auto input = std::vector<uint8>(256);
    for (uint32 i = 0; i < 256; ++i)
    {
        input[i] = static_cast<uint8>(i);
    }

    auto       encoded = std::vector<uint8>(1024, 0);
    const auto bits    = huffman_encode(input, encoded);
    REQUIRE(bits.has_value());
    REQUIRE(encoded[0] == 1);

    auto decoded = std::vector<uint8>(1024, 0);
    REQUIRE(huffman_decode(encoded, *bits, decoded) == 256U);
    CHECK(std::equal(input.begin(), input.end(), decoded.begin()));
}

TEST_CASE("huffman falls back to a raw payload when the codes don't fit", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    // Two 12-bit codes exactly fill 3 bytes, which the client already treats as full
    const auto input = std::vector<uint8>{ 0xFF, 0xFF };

    auto       encoded = std::vector<uint8>(4, 0xAA);
    const auto bits    = huffman_encode(input, encoded);
    REQUIRE(bits == 24U);
    CHECK(encoded[0] == 0);
    CHECK(encoded[1] == 0xFF);
    CHECK(encoded[2] == 0xFF);

    auto decoded = std::vector<uint8>(8, 0);
    REQUIRE(huffman_decode(encoded, *bits, decoded) == 2U);
    CHECK(decoded[0] == 0xFF);
    CHECK(decoded[1] == 0xFF);

    SECTION("raw copy that exactly fits the output")
    {
        auto exact = std::vector<uint8>(3, 0);
        CHECK(huffman_encode(input, exact) == 24U);
        CHECK(exact[0] == 0);
    }

    SECTION("fails when the raw copy doesn't fit either")
    {
        auto tooSmall = std::vector<uint8>(2, 0);
        CHECK_FALSE(huffman_encode(input, tooSmall).has_value());
    }
}

TEST_CASE("huffman decode stops at the bit count", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    const auto input = std::vector<uint8>{ 0x00, 0x15, 0x80, 0x00 };

    auto       encoded = std::vector<uint8>(16, 0);
    const auto bits    = huffman_encode(input, encoded);
    REQUIRE(bits == 8U + 1 + 3 + 5 + 1);

    // The bytes after the payload are the bit count on the wire, so they must not decode
    const auto payloadBytes = huffman_byte_size(*bits);
    std::fill(encoded.begin() + payloadBytes, encoded.end(), uint8{ 0xFF });
    encoded[payloadBytes - 1] |= static_cast<uint8>(0xFF << ((*bits - 8) & 7));

    auto decoded = std::vector<uint8>(16, 0);
    REQUIRE(huffman_decode(encoded, *bits, decoded) == 4U);
    CHECK(std::equal(input.begin(), input.end(), decoded.begin()));

    SECTION("a code cut short by the bit count decodes to nothing")
    {
        // Drops the final 0x00 and the last bit of 0x80's 5-bit code
        CHECK(huffman_decode(encoded, *bits - 2, decoded) == 2U);
    }
}

TEST_CASE("huffman decode checks its bounds", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    auto encoded = std::vector<uint8>(8, 0xFF);
    auto decoded = std::vector<uint8>(8, 0);

    // 0x00 encodes as a single 1 bit, so each set bit decodes to one byte
    encoded[0] = 1;

    SECTION("bit count below the flag byte")
    {
        CHECK_FALSE(huffman_decode(encoded, 7, decoded).has_value());
    }

    SECTION("bit count that exactly fills the input, as every packet on the wire does")
    {
        auto large = std::vector<uint8>(64, 0);
        CHECK(huffman_decode(encoded, 8 * 8, large) == 56U);
    }

    SECTION("bit count past the input")
    {
        auto large = std::vector<uint8>(64, 0);
        CHECK_FALSE(huffman_decode(encoded, 8 * 8 + 1, large).has_value());
    }

    SECTION("raw payload larger than the output")
    {
        encoded[0] = 0;
        CHECK_FALSE(huffman_decode(encoded, 8 * 8, std::span(decoded).first(6)).has_value());
    }

    SECTION("output exactly filled, which the client fails")
    {
        CHECK_FALSE(huffman_decode(encoded, 8 + 8, decoded).has_value());
        CHECK(huffman_decode(encoded, 8 + 7, decoded) == 7U);
    }
}

TEST_CASE("huffman encoded size is the client's per-packet estimate", "[huffman]")
{
    REQUIRE(huffman_init() == 0);

    const auto table = loadCodeTable();
    xirand::rng().seed(0xBA7C4);

    for (uint32 batch = 0; batch < 200; ++batch)
    {
        auto payload  = std::vector<uint8>{};
        auto estimate = size_t{ 0 };
        for (uint32 packet = 0; packet < 8; ++packet)
        {
            const auto size  = 4 * xirand::GetRandomNumber<size_t>(1, 65);
            const auto bytes = packetLikeBytes(size);

            uint32 bits = 0;
            for (const auto byte : bytes)
            {
                bits += table.lengths[tableIndex(byte)];
            }

            CHECK(huffman_encoded_size(bytes) == huffman_byte_size(bits));

            estimate += huffman_encoded_size(bytes);
            payload.insert(payload.end(), bytes.begin(), bytes.end());
        }

        // send_parse sums these estimates to size a batch, so they must never undershoot the encoder
        auto       encoded = std::vector<uint8>(4096, 0);
        const auto bits    = huffman_encode(payload, encoded);
        REQUIRE(bits.has_value());
        CHECK(huffman_byte_size(*bits) <= 1 + estimate);
    }
}
