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

#include "common/utils.h"
#include "common/logging.h"
#include "common/md52.h"
#include "common/stdext.h"

#include <algorithm>
#include <cctype>
#include <charconv>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <regex>
#include <string>

#ifdef _MSC_VER
#include <intrin.h>
#endif

int32 checksum(unsigned char* buf, uint32 buflen, char checkhash[16])
{
    unsigned char hash[16];

    md5(buf, hash, buflen);

    if (memcmp(hash, checkhash, 16) == 0)
    {
        return 0;
    }
    return -1;
}

/// Produces the hexadecimal representation of the given input.
/// The output buffer must be at least count*2+1 in size.
/// Returns true on success, false on failure.
///
/// @param output Output string
/// @param input Binary input buffer
/// @param count Number of bytes to convert
bool bin2hex(char* output, unsigned char* input, size_t count)
{
    char        toHex[] = "0123456789abcdef";
    std::size_t i       = 0;

    for (i = 0; i < count; ++i)
    {
        *output++ = toHex[(*input & 0xF0) >> 4];
        *output++ = toHex[(*input & 0x0F) >> 0];
        ++input;
    }
    *output = '\0';
    return true;
}

int32 intpow32(int32 base, int32 exponent)
{
    int32 power = 1;
    while (exponent)
    {
        if (exponent & 1)
        {
            power *= base;
        }
        exponent >>= 1;
        base *= base;
    }
    return power;
}

void getMSB(uint32* result, uint32 value)
{
    *result = 0;
    if (value == 0)
    {
        return;
    }
#ifdef __GNUC__
    *result = 31 - (unsigned)__builtin_clz(value);
#elif defined _MSC_VER
    _BitScanReverse((unsigned long*)result, value);
#else
    while (value >>= 1)
        (*result)++;
#endif
}

/*
Rotations of entities are saved in uint8s, which can only hold up to a value of 255. In order to properly calculate rotations you'll need these methods to
convert back and forth.
*/
float rotationToRadian(uint8 rotation)
{
    return (float)((rotation / 256.0f) * 2 * M_PI);
}

uint8 radianToRotation(float radian)
{
    return (uint8)((radian / (2 * M_PI)) * 256);
}

/****************************************************************************
 * Functions for entity-to-entity world angles, and facing differences.      *
 * Highly recommended to read our wiki page to understand these.             *
 *****************************************************************************/
// https://github.com/LandSandBoat/server/wiki/Spatial-Orientation-and-Relative-Positions

uint8 worldAngle(const position_t& A, const position_t& B)
{
    uint8 angle = (uint8)(atanf((B.z - A.z) / (B.x - A.x)) * -(128.0f / M_PI));

    return isWithinDistance(A, B, 0.1f, true) ? A.rotation : (A.x > B.x ? angle + 128 : angle);
}

uint8 relativeAngle(uint8 world, int16 diff)
{
    int16 angle = world + diff;
    if (angle < 0)
    {
        angle = 256 - abs(angle);
    }
    return static_cast<uint8>(angle);
}

int16 angleDifference(uint8 worldAngleA, uint8 worldAngleB)
{
    int16 degreeDiff   = worldAngleA - worldAngleB;
    uint8 absoluteDiff = abs(degreeDiff);
    if (absoluteDiff > 128)
    {
        degreeDiff = 256 - absoluteDiff;
    }
    return degreeDiff;
}

int16 facingAngle(const position_t& A, const position_t& B)
{
    uint8 cardinalAngle = worldAngle(A, B);
    return angleDifference(cardinalAngle, A.rotation);
}

bool facing(const position_t& A, const position_t& B, uint8 coneAngle)
{
    return infront(B, A, coneAngle); // If the target is in front of you, you're facing it!
}

bool infront(const position_t& A, const position_t& B, uint8 coneAngle)
{
    uint8 facingDiff = abs(facingAngle(B, A)); // Position swap intentional due to how angles are calculated
    uint8 halfAngle  = static_cast<uint8>(coneAngle / 2);
    return (facingDiff < halfAngle);
}

bool behind(const position_t& A, const position_t& B, uint8 coneAngle)
{
    uint8 facingDiff = abs(facingAngle(B, A));
    uint8 halfAngle  = static_cast<uint8>(coneAngle / 2);
    return (facingDiff > 128 - halfAngle); // Abs(Facing Angle) values are always less than 128
}

bool beside(const position_t& A, const position_t& B, uint8 coneAngle)
{
    uint8 facingDiff = abs(facingAngle(B, A));
    uint8 halfAngle  = static_cast<uint8>(coneAngle / 2);
    return (facingDiff > 64 - halfAngle) && (facingDiff < 64 + halfAngle);
}

/**
Returns a position near the given position.

offset - distance to be placed away from given Position.
radian - angle relative to given position to be placed at. Zero will be a position infront of the given position.
Pi will make the position behind the target (180 degrees).
*/
position_t nearPosition(const position_t& A, float offset, float radian)
{
    // PI * 0.75 offsets the rotation to the proper place
    float      totalRadians = rotationToRadian(A.rotation) + radian;
    position_t B;

    B.x = A.x + cosf((float)(2 * M_PI - totalRadians)) * offset;
    B.y = A.y;
    B.z = A.z + sinf((float)(2 * M_PI - totalRadians)) * offset;

    B.rotation = A.rotation;
    B.moving   = A.moving;

    return B;
}

/************************************************************************
 *                                                                       *
 *  Methods for working with bit arrays.                                 *
 *                                                                       *
 ************************************************************************/

int32 hasBit(uint16 value, const uint8* BitArray, uint32 size)
{
    if (value >= size * 8)
    {
        ShowError("hasBit: value (%u) is out of range", value);
        return 0;
    }
    return (BitArray[value >> 3] & (1 << (value % 8)));
}

int32 addBit(uint16 value, uint8* BitArray, uint32 size)
{
    if (!hasBit(value, BitArray, size) && (value < size * 8))
    {
        BitArray[value >> 3] |= (1 << (value % 8));
        return 1;
    }
    return 0;
}

int32 delBit(uint16 value, uint8* BitArray, uint32 size)
{
    if (hasBit(value, BitArray, size))
    {
        BitArray[value >> 3] &= ~(1 << (value % 8));
        return 1;
    }
    return 0;
}

uint32 packBitsBE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit)
{
    return packBitsBE(target, value, 0, bitOffset, lengthInBit);
}

uint32 packBitsBE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit)
{
    byteOffset += (bitOffset >> 3); // correct bitOffsets>=8
    bitOffset %= 8;

    uint64 bitmask = 0xFFFFFFFFFFFFFFFFLL; // Generate bitmask

    bitmask >>= (64 - lengthInBit);
    bitmask <<= bitOffset;

    value <<= bitOffset; // shift value
    value &= bitmask;

    bitmask ^= 0xFFFFFFFFFFFFFFFFLL; // invert bitmask

    if ((lengthInBit + bitOffset) <= 8) // write shifted value to target
    {
        uint8* dataPointer = &target[byteOffset];

        uint8 bitmaskUC = (uint8)bitmask;
        uint8 valueUC   = (uint8)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if ((lengthInBit + bitOffset) <= 16)
    {
        uint16* dataPointer = (uint16*)&target[byteOffset];

        uint16 bitmaskUC = (uint16)bitmask;
        uint16 valueUC   = (uint16)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if ((lengthInBit + bitOffset) <= 32)
    {
        uint32* dataPointer = (uint32*)&target[byteOffset];

        uint32 bitmaskUC = (uint32)bitmask;
        uint32 valueUC   = (uint32)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if ((lengthInBit + bitOffset) <= 64)
    {
        uint64* dataPointer = (uint64*)&target[byteOffset];

        *dataPointer &= bitmask;
        *dataPointer |= value;
    }
    else
    {
        ShowError("Pack Bits Error: packBitsBE(...) not implemented for targetsizes above 64 bits. Targetsize: %d", (lengthInBit + bitOffset));
    }
    return ((byteOffset << 3) + bitOffset + lengthInBit);
}

uint64 unpackBitsBE(uint8* target, int32 bitOffset, uint8 lengthInBit)
{
    return unpackBitsBE(target, 0, bitOffset, lengthInBit);
}

uint64 unpackBitsBE(uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit)
{
    byteOffset += (bitOffset >> 3);
    bitOffset %= 8;

    uint64 bitmask = 0xFFFFFFFFFFFFFFFFLL;

    bitmask >>= (64 - lengthInBit);
    bitmask <<= bitOffset;

    uint64 retVal = 0;

    if ((lengthInBit + bitOffset) <= 8)
    {
        uint8* dataPointer = &target[byteOffset];

        retVal = ((*dataPointer) & (uint8)bitmask) >> bitOffset;
    }
    else if ((lengthInBit + bitOffset) <= 16)
    {
        uint16* dataPointer = (uint16*)&target[byteOffset];

        retVal = ((*dataPointer) & (uint16)bitmask) >> bitOffset;
    }
    else if ((lengthInBit + bitOffset) <= 32)
    {
        uint32* dataPointer = (uint32*)&target[byteOffset];

        retVal = ((*dataPointer) & (uint32)bitmask) >> bitOffset;
    }
    else if ((lengthInBit + bitOffset) <= 64)
    {
        uint64* dataPointer = (uint64*)&target[byteOffset];

        retVal = ((*dataPointer) & bitmask) >> bitOffset;
    }
    else
    {
        ShowError("Unpack Bits Error: unpackBits(...) not implemented for targetsizes above 64 bits. Targetsize: %d", (lengthInBit + bitOffset));
        return 0;
    }
    return retVal;
}

uint32 packBitsLE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit)
{
    return packBitsLE(target, value, 0, bitOffset, lengthInBit);
}

uint32 packBitsLE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit)
{
    byteOffset += (bitOffset >> 3); // correct bitOffsets >= 8
    bitOffset %= 8;

    uint8 bytesNeeded = 0; // calculate how many bytes are needed
    if ((bitOffset + lengthInBit) <= 8)
    {
        bytesNeeded = 1;
    }
    else if ((bitOffset + lengthInBit) <= 16)
    {
        bytesNeeded = 2;
    }
    else if ((bitOffset + lengthInBit) <= 32)
    {
        bytesNeeded = 4;
    }
    else if ((bitOffset + lengthInBit) <= 64)
    {
        bytesNeeded = 8;
    }
    else
    {
        ShowError("Pack Bits Error: packBitsLE(...) not implemented for targetsizes above 64 bits. Targetsize: %d", (lengthInBit + bitOffset));
        return 0;
    }

    uint8* modifiedTarget = new uint8[bytesNeeded]; // convert byteOrder to Big Endian

    for (uint8 curByte = 0; curByte < bytesNeeded; ++curByte)
    {
        modifiedTarget[curByte] = target[byteOffset + (bytesNeeded - 1) - curByte];
    }

    int32 newBitOffset = (bytesNeeded << 3) - (bitOffset + lengthInBit); // calculate new bitOffset

    packBitsBE(&modifiedTarget[0], value, 0, newBitOffset, lengthInBit); // write data to modified array

    for (uint8 curByte = 0; curByte < bytesNeeded; ++curByte) // copy back to target
    {
        target[byteOffset + (bytesNeeded - 1) - curByte] = modifiedTarget[curByte];
    }

    {
        destroy_arr(modifiedTarget);
    }

    return ((byteOffset << 3) + bitOffset + lengthInBit);
}

uint64 unpackBitsLE(uint8* target, int32 bitOffset, uint8 lengthInBit)
{
    return unpackBitsLE(target, 0, bitOffset, lengthInBit);
}

uint64 unpackBitsLE(const uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit)
{
    byteOffset += (bitOffset >> 3);
    bitOffset %= 8;

    uint8 bytesNeeded = 0;
    if ((bitOffset + lengthInBit) <= 8)
    {
        bytesNeeded = 1;
    }
    else if ((bitOffset + lengthInBit) <= 16)
    {
        bytesNeeded = 2;
    }
    else if ((bitOffset + lengthInBit) <= 32)
    {
        bytesNeeded = 4;
    }
    else if ((bitOffset + lengthInBit) <= 64)
    {
        bytesNeeded = 8;
    }
    else
    {
        ShowError("Unpack Bits Error: packBitsLE(...) not implemented for targetsizes above 64 bits. Targetsize: %d", (lengthInBit + bitOffset));
        return 0;
    }

    uint64 retVal = 0;

    uint8* modifiedTarget = new uint8[bytesNeeded];

    for (uint8 curByte = 0; curByte < bytesNeeded; ++curByte)
    {
        modifiedTarget[curByte] = target[byteOffset + (bytesNeeded - 1) - curByte];
    }
    if (bytesNeeded == 1)
    {
        uint8 bitmask = 0xFF >> bitOffset;
        retVal        = (modifiedTarget[0] & bitmask) >> (8 - (lengthInBit + bitOffset));
    }
    else
    {
        int32 newBitOffset = (bytesNeeded * 8) - (bitOffset + lengthInBit);
        retVal             = unpackBitsBE(&modifiedTarget[0], 0, newBitOffset, lengthInBit);
    }

    {
        destroy_arr(modifiedTarget);
    }
    return retVal;
}

void EncodeStringLinkshell(const std::string& signature, char* target)
{
    uint8 encodedSignature[LinkshellStringLength] = {};
    uint8 chars                                   = 0;
    uint8 leftover                                = 0;
    auto  length                                  = std::min<size_t>(20u, signature.size());

    for (std::size_t currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = 0;
        if ((signature[currChar] >= '0') && (signature[currChar] <= '9'))
        {
            tempChar = signature[currChar] - '0' + 53;
        }
        else if ((signature[currChar] >= 'A') && (signature[currChar] <= 'Z'))
        {
            tempChar = signature[currChar] - 'A' + 27;
        }
        else if ((signature[currChar] >= 'a') && (signature[currChar] <= 'z'))
        {
            tempChar = signature[currChar] - 'a' + 1;
        }
        packBitsLE(encodedSignature, tempChar, static_cast<uint32>(6 * currChar), 6);
        chars++;
    }
    leftover = (chars * 6) % 8;
    leftover = 8 - leftover;
    leftover = (leftover == 8 || leftover == 2 ? 6 : leftover);
    packBitsLE(encodedSignature, 0xFF, 6 * chars, leftover);

    strncpy(target, reinterpret_cast<const char*>(encodedSignature), LinkshellStringLength);
}

void DecodeStringLinkshell(const std::string& signature, char* target)
{
    char decodedSignature[21] = {};
    auto length               = std::min<size_t>(20u, (signature.size() * 8) / 6);

    for (std::size_t currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = '\0';
        tempChar       = (uint8)unpackBitsLE((uint8*)signature.c_str(), static_cast<uint32>(currChar * 6), 6);
        if (tempChar >= 1 && tempChar <= 26)
        {
            tempChar = 'a' - 1 + tempChar;
        }
        else if (tempChar >= 27 && tempChar <= 52)
        {
            tempChar = 'A' - 27 + tempChar;
        }
        else if (tempChar >= 53 && tempChar <= 62)
        {
            tempChar = '0' - 53 + tempChar;
        }

        if (tempChar == '\0')
        {
            decodedSignature[currChar == 0 ? currChar : currChar - 1] = '\0';
            break;
        }
        if (tempChar == 63)
        {
            decodedSignature[currChar] = '\0';
            break;
        }
        else
        {
            decodedSignature[currChar] = tempChar;
        }
    }

    strncpy(target, decodedSignature, LinkshellStringLength);
}

std::string EncodeStringSignature(const std::string& signature, char* target)
{
    uint8 encodedSignature[SignatureStringLength] = {};
    auto  length                                  = std::min<size_t>(15u, signature.size());

    for (std::size_t currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = 0;
        if ((signature[currChar] >= '0') && (signature[currChar] <= '9'))
        {
            tempChar = signature[currChar] - '0' + 1;
        }
        else if ((signature[currChar] >= 'A') && (signature[currChar] <= 'Z'))
        {
            tempChar = signature[currChar] - 'A' + 11;
        }
        else if ((signature[currChar] >= 'a') && (signature[currChar] <= 'z'))
        {
            tempChar = signature[currChar] - 'a' + 37;
        }
        packBitsLE(encodedSignature, tempChar, static_cast<uint32>(6 * currChar), 6);
    }

    return strncpy(target, reinterpret_cast<const char*>(encodedSignature), SignatureStringLength);
}

void DecodeStringSignature(const std::string& signature, char* target)
{
    char decodedSignature[PacketNameLength + 1] = {};
    for (uint8 currChar = 0; currChar < PacketNameLength; ++currChar)
    {
        char tempChar = unpackBitsLE((uint8*)signature.c_str(), currChar * 6, 6);
        if (tempChar >= 1 && tempChar <= 10)
        {
            tempChar = '0' - 1 + tempChar;
        }
        else if (tempChar >= 11 && tempChar <= 36)
        {
            tempChar = 'A' - 11 + tempChar;
        }
        else if (tempChar >= 37 && tempChar <= 62)
        {
            tempChar = 'a' - 37 + tempChar;
        }

        decodedSignature[currChar] = tempChar;
    }
    strncpy(target, decodedSignature, SignatureStringLength);
}

// Take a regular string of 8-bit wide chars and packs it down into an
// array of 7-bit wide chars.
void PackSoultrapperName(std::string name, uint8 output[])
{
    // Before anything else, sanitize the name string
    // If contains underscore character
    if (std::find(name.begin(), name.end(), '_') != name.end())
    {
        // Remove underscores
        name.erase(std::remove(name.begin(), name.end(), '_'), name.end());
    }

    // Add a space at the end to help with name truncation
    // TODO: Remove the need for this
    if (name.length() > 7)
    {
        name += ' ';
    }

    uint8 current = 0;
    uint8 next    = 0;
    uint8 shift   = 1;
    uint8 loops   = 0;
    uint8 total   = (uint8)name.length();
    uint8 maxSize = 13; // capped at 13 based on examples like GoblinBountyH

    // Pack and shift 8-bit to 7-bit
    for (uint8 i = 0; i <= maxSize; ++i)
    {
        current        = i < total ? (uint8)name.at(i) : 0;
        next           = i + 1 < total ? (uint8)name.at(i + 1) : 0;
        uint8 tempLeft = current;
        for (int j = 0; j < shift; ++j)
        {
            tempLeft = tempLeft << 1;
            if (j + 1 != shift && tempLeft & 128)
            {
                tempLeft = tempLeft ^ 128;
            }
        }

        uint8 tempRight   = next >> (7 - shift);
        output[i - loops] = tempLeft | tempRight;

        if (shift == 7)
        {
            shift = 1;
            loops++;
            i++;
            total--;
        }
        else
        {
            shift++;
        }
    }
}

std::string UnpackSoultrapperName(uint8 input[])
{
    uint8       current   = 0;
    uint8       remainder = 0;
    uint8       shift     = 1;
    uint8       maxSize   = 13; // capped at 13 based on examples like GoblinBountyH
    char        indexChar = 0;
    std::string output    = "";

    // Unpack and shift 7-bit to 8-bit
    for (uint8 i = 0; i <= maxSize; ++i)
    {
        current         = input[i];
        uint8 tempLeft  = current;
        uint8 tempRight = current;

        for (int j = 0; j < shift; ++j)
        {
            tempLeft = tempLeft >> 1;
        }

        indexChar = (char)(tempLeft | remainder);
        if (indexChar >= '0' && indexChar <= 'z')
        {
            output += (char)(tempLeft | remainder);
        }

        remainder = tempRight << (7 - shift);
        if (remainder & 128)
        {
            remainder = remainder ^ 128;
        }

        if (shift == 7)
        {
            if (char(remainder) >= '0' && char(remainder) <= 'z')
            {
                output += char(remainder);
            }
            remainder = 0;
            shift     = 1;
        }
        else
        {
            shift++;
        }
    }

    return output;
}

std::string escape(std::string const& s)
{
    std::size_t n = s.length();
    std::string escaped;
    escaped.reserve(n * 2);
    for (std::size_t i = 0; i < n; ++i)
    {
        if (s[i] == '\\' || s[i] == '\'')
        {
            escaped += '\\';
        }
        escaped += s[i];
    }
    return escaped;
}

std::vector<std::string> split(std::string const& s, std::string const& delimiter)
{
    std::size_t pos_start = 0;
    std::size_t pos_end   = 0;
    std::size_t delim_len = delimiter.length();
    std::string token     = "";

    std::vector<std::string> res{};

    while ((pos_end = s.find(delimiter, pos_start)) != std::string::npos)
    {
        token     = s.substr(pos_start, pos_end - pos_start);
        pos_start = pos_end + delim_len;
        res.emplace_back(token);
    }

    res.emplace_back(s.substr(pos_start));
    return res;
}

std::string to_lower(std::string const& s)
{
    // clang-format off
    std::string data = s;
    std::transform(data.begin(), data.end(), data.begin(),
    [](unsigned char c)
    {
        return std::tolower(c);
    });
    // clang-format on
    return data;
}

std::string to_upper(std::string const& s)
{
    // clang-format off
    std::string data = s;
    std::transform(data.begin(), data.end(), data.begin(),
    [](unsigned char c)
    {
        return std::toupper(c);
    });
    // clang-format on
    return data;
}

// https://stackoverflow.com/questions/313970/how-to-convert-an-instance-of-stdstring-to-lower-case
std::string trim(std::string const& str, std::string const& whitespace)
{
    const auto strBegin = str.find_first_not_of(whitespace);
    if (strBegin == std::string::npos)
    {
        return ""; // no content
    }

    const auto strEnd   = str.find_last_not_of(whitespace);
    const auto strRange = strEnd - strBegin + 1;

    return str.substr(strBegin, strRange);
}

// trim from end (in place)
void rtrim(std::string& s)
{
    // clang-format off
    s.erase(std::find_if(s.rbegin(), s.rend(),
    [](unsigned char ch)
    {
        return !std::isspace(ch) && ch != '\n';
    }).base(), s.end());
    // clang-format on
}

// Returns true if the given str matches the given pattern using standard regex
bool matches(std::string const& target, std::string const& pattern)
{
    return std::regex_match(target, std::regex(pattern));
}

bool starts_with(std::string const& target, std::string const& pattern)
{
    return target.rfind(pattern, 0) != std::string::npos;
}

std::string replace(std::string const& target, std::string const& search, std::string const& replace)
{
    try
    {
        return std::regex_replace(target, std::regex(search), replace);
    }
    catch (std::exception& ex)
    {
        ShowError(ex.what());
    }
    return "";
}

look_t stringToLook(std::string str)
{
    look_t out{};

    // Sanity checks
    // Remove "0x" if found
    if (str.size() == 42 && str[0] == '0' && str[1] == 'x')
    {
        str = str.substr(2);
    }

    // Only support full-string looks
    if (str.size() != 40)
    {
        return out;
    }

    // A 16-bit number is represented by *4* string characters
    // Iterate in groups of 4
    std::vector<uint16> hex(str.size() / 4, 0);
    uint16              value = 0;
    for (std::size_t i = 0; i < str.size() / 4; i++)
    {
        auto begin = str.data() + (i * 4);
        auto end   = str.data() + (i * 4) + 4;
        auto base  = 16; // Hex
        std::from_chars(begin, end, value, base);
        hex[i] = value;
    }

    for (auto& entry : hex)
    {
        // Swap endian-ness
        auto top    = entry << 8;
        auto bottom = entry >> 8;
        entry       = top | bottom;
    }

    out.size = hex[0];

    out.face = hex[1] & 0x00FF;
    out.race = hex[1] >> 8;

    out.head   = hex[2] &= ~0x1000;
    out.body   = hex[3] &= ~0x2000;
    out.hands  = hex[4] &= ~0x3000;
    out.legs   = hex[5] &= ~0x4000;
    out.feet   = hex[6] &= ~0x5000;
    out.main   = hex[7] &= ~0x6000;
    out.sub    = hex[8] &= ~0x7000;
    out.ranged = hex[9] &= ~0x8000;

    return out;
}

bool approximatelyEqual(float a, float b)
{
    constexpr float epsilon = std::numeric_limits<float>::epsilon();
    return fabs(a - b) <= ((fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool essentiallyEqual(float a, float b)
{
    constexpr float epsilon = std::numeric_limits<float>::epsilon();
    return fabs(a - b) <= ((fabs(a) > fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool definitelyGreaterThan(float a, float b)
{
    constexpr float epsilon = std::numeric_limits<float>::epsilon();
    return (a - b) > ((fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

bool definitelyLessThan(float a, float b)
{
    constexpr float epsilon = std::numeric_limits<float>::epsilon();
    return (b - a) > ((fabs(a) < fabs(b) ? fabs(b) : fabs(a)) * epsilon);
}

void crash()
{
    int* volatile ptr = nullptr;
    // cppcheck-suppress nullPointer
    *ptr = 0xDEAD;
}

std::unique_ptr<FILE> utils::openFile(std::string const& path, std::string const& mode)
{
    return std::unique_ptr<FILE>(fopen(path.c_str(), mode.c_str()));
}

auto utils::isPrintableASCII(unsigned char ch, ASCIIMode mode) -> bool
{
    if (mode == ASCIIMode::IncludeSpace)
    {
        return ch >= 0x20 && ch < 0x7F;
    }
    else // ASCIIMode::ExcludeSpace
    {
        return ch > 0x20 && ch < 0x7F;
    }
}

auto utils::isStringPrintable(const std::string& str, ASCIIMode mode) -> bool
{
    // clang-format off
    return std::all_of(str.begin(), str.end(), [mode](unsigned char ch) { return isPrintableASCII(ch, mode); });
    // clang-format on
}

std::string utils::toASCII(std::string const& target, unsigned char replacement)
{
    std::string out;
    out.reserve(target.size());
    for (unsigned char ch : target)
    {
        out += isPrintableASCII(ch, ASCIIMode::IncludeSpace) ? ch : replacement;
    }
    return out;
}
