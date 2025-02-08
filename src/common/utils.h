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

#pragma once

#define _USE_MATH_DEFINES

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "common/mutex_guarded.h"
#include "common/stdext.h"

#include <filesystem>
#include <iostream>
#include <math.h>
#include <set>

constexpr size_t PacketNameLength = 16; // 15 + null terminator

constexpr size_t DecodeStringLength    = 21; // used for size of decoded strings of signature/linkshells
constexpr size_t SignatureStringLength = 16; // encoded signature string size // 15 characters + null terminator
constexpr size_t LinkshellStringLength = 20; // encoded linkshell string size // 19 characters + null terminator

int32 checksum(uint8* buf, uint32 buflen, char checkhash[16]);
int   config_switch(const char* str);
bool  bin2hex(char* output, unsigned char* input, size_t count);

constexpr float square(auto distance) // constexpr square (used with distanceSquared)
{
    return distance * distance;
}

inline float distanceSquared(const position_t& A, const position_t& B, bool ignoreVertical = false)
{
    float dX = A.x - B.x;
    float dY = ignoreVertical ? 0 : A.y - B.y;
    float dZ = A.z - B.z;
    return dX * dX + dY * dY + dZ * dZ;
}

inline float distance(const position_t& A, const position_t& B, bool ignoreVertical = false)
{
    return std::sqrt(distanceSquared(A, B, ignoreVertical));
}

inline bool isWithinDistance(const position_t& A, const position_t& B, float within, bool ignoreVertical = false)
{
    return distanceSquared(A, B, ignoreVertical) <= square(within);
}

int32      intpow32(int32 base, int32 exponent); // Exponential power of integers
void       getMSB(uint32* result, uint32 value); // fast Most Significant Byte search under GCC or MSVC. Fallback included.
float      rotationToRadian(uint8 rotation);
uint8      radianToRotation(float radian);
uint8      worldAngle(const position_t& A, const position_t& B);               // А - the main entity, B - target entity (vector projection onto the X-axis)
uint8      relativeAngle(uint8 world, int16 diff);                             // Returns a new world angle which is diff degrees in a given (signed) direction
int16      angleDifference(uint8 worldAngleA, uint8 aworldAngleB);             // Returns difference between two world angles (0~128), sign indicates direction
int16      facingAngle(const position_t& A, const position_t& B);              // А - the main entity, B - target entity
bool       facing(const position_t& A, const position_t& B, uint8 coneAngle);  // true if A is facing B within coneAngle degrees
bool       infront(const position_t& A, const position_t& B, uint8 coneAngle); // true if A is infront of B within coneAngle degrees
bool       behind(const position_t& A, const position_t& B, uint8 coneAngle);  // true if A is behind of B within coneAngle degrees
bool       beside(const position_t& A, const position_t& B, uint8 coneAngle);  // true if A is to a side of B within coneAngle degrees
position_t nearPosition(const position_t& A, float offset, float radian);      // Returns a position near the given position

int32 hasBit(uint16 value, const uint8* BitArray, uint32 size); // Check for the presence of a bit in the array
int32 addBit(uint16 value, uint8* BitArray, uint32 size);       // Adds a bit to the array
int32 delBit(uint16 value, uint8* BitArray, uint32 size);       // Deletes a bit from the array

//(un)pack functions for Big Endian(BE) targets
uint32 packBitsBE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint32 packBitsBE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsBE(uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsBE(uint8* target, int32 bitOffset, uint8 lengthInBit);

//(un)pack functions for Little Endian(LE) targets
uint32 packBitsLE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint32 packBitsLE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsLE(uint8* target, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsLE(const uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);

// Encode/Decode Strings to/from FFXI 6-bit format
void        EncodeStringLinkshell(const std::string& signature, char* target);
void        DecodeStringLinkshell(const std::string& signature, char* target);
std::string EncodeStringSignature(const std::string& signature, char* target);
void        DecodeStringSignature(const std::string& signature, char* target);
void        PackSoultrapperName(std::string name, uint8 output[]);
std::string UnpackSoultrapperName(uint8 input[]);

auto escape(std::string const& s) -> std::string;
auto split(std::string const& s, std::string const& delimiter = " ") -> std::vector<std::string>;
auto to_lower(std::string const& s) -> std::string;
auto to_upper(std::string const& s) -> std::string;
auto trim(const std::string& str, const std::string& whitespace = " \t") -> std::string;
void rtrim(std::string& s);
bool matches(std::string const& target, std::string const& pattern);
bool starts_with(std::string const& target, std::string const& pattern);
auto replace(std::string const& target, std::string const& search, std::string const& replace) -> std::string;

look_t stringToLook(std::string str);

// Float tools
// https://stackoverflow.com/a/253874
bool approximatelyEqual(float a, float b);
bool essentiallyEqual(float a, float b);
bool definitelyGreaterThan(float a, float b);
bool definitelyLessThan(float a, float b);

void crash();

template <typename T>
std::set<std::filesystem::path> sorted_directory_iterator(std::string path_name)
{
    std::set<std::filesystem::path> sorted_by_name;
    for (auto& entry : T(path_name))
    {
        sorted_by_name.insert(entry.path());
    }
    return sorted_by_name;
}

namespace utils
{
    auto openFile(std::string const& path, std::string const& mode) -> std::unique_ptr<FILE>;

    enum class ASCIIMode
    {
        IncludeSpace,
        ExcludeSpace,
    };

    auto isPrintableASCII(unsigned char ch, ASCIIMode mode) -> bool;
    auto isStringPrintable(const std::string& str, ASCIIMode mode) -> bool;
    auto toASCII(std::string const& target, unsigned char replacement = '\0') -> std::string;
} // namespace utils

// clang-format off
static mutex_guarded<std::unordered_map<std::string, time_point>> lastExecutionTimes;
#define RATE_LIMIT(duration, code)                                                    \
{                                                                                     \
    auto        currentTime = server_clock::now();                                    \
    std::string key         = std::string(__FILE__) + ":" + std::to_string(__LINE__); \
    lastExecutionTimes.write([&](auto& lastExecutionTimes)                            \
    {                                                                                 \
        if (lastExecutionTimes.find(key) == lastExecutionTimes.end() ||               \
            currentTime - lastExecutionTimes[key] > std::chrono::seconds(duration))   \
        {                                                                             \
            lastExecutionTimes[key] = currentTime;                                    \
            {                                                                         \
                code;                                                                  \
            }                                                                         \
        }                                                                             \
    });                                                                               \
}
// clang-format on
