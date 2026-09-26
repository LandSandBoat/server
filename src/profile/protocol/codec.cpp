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

#include "protocol/codec.h"

#include "protocol/bytes.h"

#include <algorithm>
#include <cstring>
#include <openssl/evp.h>
#include <ranges>

namespace profile
{

namespace
{

constexpr std::string_view kBase64Alphabet   = "TSG8IncW3HFKokOg79qzeCmZs2yBYEQVAUxR5rbwi4P@jMDLtpvad0f_J1hlN6uX";
constexpr std::string_view kStandardAlphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
constexpr std::string_view kBase32Alphabet   = "N43OVHBJ1Y2C0WSXED5QFILRZMUTAPGK";
constexpr std::string_view kPolIdDigits      = "EFKAOYMJVNGTDSWBQLPCIRHZXU6328401795";
constexpr std::size_t      kPolIdLength      = 8;
constexpr uint32           kPolIdBase        = 36;
constexpr uint64           kNickPolIdMask    = 0x1FFFFFFFFFFull; // 41 bits
constexpr uint64           kNickMarker       = 0xC00000000000ull;
constexpr char             kNickPrefix       = 'U';

// unknown characters map to '!' so OpenSSL rejects them
constexpr auto translation(const std::string_view from, const std::string_view to) -> std::array<char, 256>
{
    auto table = std::array<char, 256>{};
    table.fill('!');
    for (std::size_t digit = 0; digit < from.size(); ++digit)
    {
        table[static_cast<uint8>(from[digit])] = to[digit];
    }

    return table;
}

// polcore pads a short group with its zero digit instead of '='
constexpr auto kToPolcore = []
{
    auto table                     = translation(kStandardAlphabet, kBase64Alphabet);
    table[static_cast<uint8>('=')] = kBase64Alphabet.front();
    return table;
}();

constexpr auto kFromPolcore = translation(kBase64Alphabet, kStandardAlphabet);

auto base64(const std::span<const uint8> bytes, const bool unpadded) -> std::string
{
    auto text = std::string((bytes.size() + 2) / 3 * 4 + 1, '\0');
    text.resize(EVP_EncodeBlock(reinterpret_cast<unsigned char*>(text.data()), bytes.data(), static_cast<int>(bytes.size())));
    if (unpadded)
    {
        text.erase(text.find_last_not_of('=') + 1);
    }

    std::ranges::transform(text, text.begin(), [](const char character)
                           {
                               return kToPolcore[static_cast<uint8>(character)];
                           });
    return text;
}

// 8 digits, polcore's alphabet
auto base36(uint64 value) -> std::string
{
    auto digits = std::string(kPolIdLength, kPolIdDigits[0]);
    for (auto& digit : digits | std::views::reverse)
    {
        digit = kPolIdDigits[value % kPolIdBase];
        value /= kPolIdBase;
    }

    return digits;
}

} // namespace

auto checksum(const std::span<const uint8> bytes) -> uint32
{
    auto sum    = uint32{};
    auto offset = std::size_t{};
    for (; offset + 4 <= bytes.size(); offset += 4)
    {
        auto word = uint32{};
        std::memcpy(&word, bytes.data() + offset, sizeof(word));
        sum += word;
    }

    auto tail = uint32{};
    for (; offset < bytes.size(); ++offset)
    {
        tail = (tail >> 8) | (static_cast<uint32>(bytes[offset]) << 24);
    }

    return sum + tail;
}

auto lineChecksum(const std::string_view line) -> std::string
{
    const auto sum = checksum(asBytes(line));

    auto result = std::string{};
    for (const int shift : { 26, 20, 14, 8 })
    {
        result += static_cast<char>(((sum >> shift) & 0x3F) + 0x3F);
    }

    return result;
}

auto base64Encode(const std::span<const uint8> bytes) -> std::string
{
    return base64(bytes, false);
}

auto base64EncodeUnpadded(const std::span<const uint8> bytes) -> std::string
{
    return base64(bytes, true);
}

auto base64Decode(const std::string_view text) -> Maybe<std::vector<uint8>>
{
    const auto standard = text | std::views::transform([](const char character)
                                                       {
                                                           return kFromPolcore[static_cast<uint8>(character)];
                                                       }) |
                          std::ranges::to<std::string>();

    // no padding, so every group is 3 bytes
    auto bytes = std::vector<uint8>(standard.size() / 4 * 3);
    if (EVP_DecodeBlock(bytes.data(), reinterpret_cast<const unsigned char*>(standard.data()), static_cast<int>(standard.size())) < 0)
    {
        return std::nullopt;
    }

    return bytes;
}

auto base32Encode(const std::span<const uint8> bytes) -> std::string
{
    auto result = std::string{};
    for (std::size_t bit = 0; bit + 5 <= bytes.size() * 8; bit += 5)
    {
        const auto byte = bit / 8;
        auto       word = static_cast<uint32>(bytes[byte]) << 8;
        if (byte + 1 < bytes.size())
        {
            word |= bytes[byte + 1];
        }

        result += kBase32Alphabet[(word >> (11 - bit % 8)) & 31];
    }

    return result;
}

auto scrambleNick(const uint64 polId) -> std::string
{
    auto value = (polId & kNickPolIdMask) | kNickMarker;
    for (const int byte : { 4, 3, 2, 1, 0 })
    {
        value ^= (value >> 8) & (0xFFull << (8 * byte));
    }

    return kNickPrefix + base36(value & ~kNickMarker);
}

auto characterKey(const uint32 characterId) -> uint32
{
    return (characterId & 0xFFFF) | ((characterId >> 16) & 0xFF) << 24;
}

auto characterIdFromKey(const uint32 key) -> uint32
{
    return (key & 0xFFFF) | ((key >> 24) & 0xFF) << 16;
}

} // namespace profile
