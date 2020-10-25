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

#ifndef _UTILS_H_
#define _UTILS_H_
#define _USE_MATH_DEFINES

#include <math.h>
#include "../common/cbasetypes.h"
#include "../common/mmo.h"

constexpr size_t PacketNameLength = 15;


int32 checksum(uint8* buf,uint32 buflen,char checkhash[16]);
int config_switch(const char* str);
bool bin2hex(char* output, unsigned char* input, size_t count);

float distance(const position_t& A, const position_t& B);		// distance between positions
float distanceSquared(const position_t& A, const position_t& B);// squared distance between positions (use squared unless otherwise needed)
constexpr float square(float distance)                          // constexpr square (used with distanceSquared)
{
    return distance * distance;
}

int32 intpow32(int32 base, int32 exponent);						// Exponential power of integers
void getMSB(uint32* result,uint32 value);						// fast Most Significant Byte search under GCC or MSVC. Fallback included.
float rotationToRadian(uint8 rotation);
uint8 radianToRotation(float radian);
uint8 worldAngle(const position_t& A, const position_t& B);     // А - the main entity, B - target entity (vector projection onto the X-axis)
uint8 relativeAngle(uint8 world, int16 diff);                   // Returns a new world angle which is diff degrees in a given (signed) direction
int16 angleDifference(uint8 worldAngleA, uint8 aworldAngleB);   // Returns difference between two world angles (0~128), sign indicates direction
int16 facingAngle(const position_t& A, const position_t& B);    // А - the main entity, B - target entity
bool facing(const position_t& A, const position_t& B, uint8 coneAngle);   // true if A is facing B within coneAngle degrees
bool infront(const position_t& A, const position_t& B, uint8 coneAngle);  // true if A is infront of B within coneAngle degrees
bool behind(const position_t& A, const position_t& B, uint8 coneAngle);   // true if A is behind of B within coneAngle degrees
bool beside(const position_t& A, const position_t& B, uint8 coneAngle);   // true if A is to a side of B within coneAngle degrees
position_t nearPosition(const position_t& A, float offset, float radian); // Returns a position near the given position

int32 hasBit(uint16 value, uint8* BitArray, uint32 size);		// Check for the presence of a bit in the array
int32 addBit(uint16 value, uint8* BitArray, uint32 size);		// Adds a bit to the array
int32 delBit(uint16 value, uint8* BitArray, uint32 size);		// Deletes a bit from the array

	//(un)pack functions for Big Endian(BE) targets
uint32 packBitsBE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint32 packBitsBE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsBE(uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsBE(uint8* target, int32 bitOffset, uint8 lengthInBit);
	//(un)pack functions for Little Endian(LE) targets
uint32 packBitsLE(uint8* target, uint64 value, int32 byteOffset, int32 bitOffset, uint8 lengthInBit);
uint32 packBitsLE(uint8* target, uint64 value, int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsLE(uint8* target,int32 bitOffset, uint8 lengthInBit);
uint64 unpackBitsLE(uint8* target,int32 byteOffset, int32 bitOffset, uint8 lengthInBit);

    // Encode/Decode Strings to/from FFXI 6-bit format
void EncodeStringLinkshell(int8* signature, int8* target);
void DecodeStringLinkshell(int8* signature, int8* target);
int8* EncodeStringSignature(int8* signature, int8* target);
void DecodeStringSignature(int8* signature, int8* target);
std::string escape(std::string const &s);

#endif
