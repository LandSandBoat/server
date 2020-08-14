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

#include "../common/utils.h"
#include "../common/md52.h"
#include "../common/showmsg.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifdef _MSC_VER
#	include <intrin.h>
#endif

//--------------------------------------------------
// Return numerical value of a switch configuration
// on/off, english, fran<E7>ais, deutsch, espa<F1>ol
//--------------------------------------------------
int config_switch(const char* str)
{
    if(strcmpi(str, "true") == 0 || strcmpi(str, "on") == 0 || strcmpi(str, "yes") == 0 || strcmpi(str, "oui") == 0 || strcmpi(str, "ja") == 0 || strcmpi(str, "si") == 0)
        return 1;
    if(strcmpi(str, "false") == 0 || strcmpi(str, "off") == 0 || strcmpi(str, "no") == 0 || strcmpi(str, "non") == 0 || strcmpi(str, "nein") == 0)
        return 0;

    return (int)strtol(str, NULL, 0);
}

int32 checksum(unsigned char *buf, uint32 buflen, char checkhash[16])
{
    unsigned char hash[16];

    md5((unsigned char *)buf, hash, buflen);

    if(memcmp(hash, checkhash, 16) == 0)
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
    char toHex[] = "0123456789abcdef";
    size_t i;

    for(i = 0; i < count; ++i)
    {
        *output++ = toHex[(*input & 0xF0) >> 4];
        *output++ = toHex[(*input & 0x0F) >> 0];
        ++input;
    }
    *output = '\0';
    return true;
}

float distance(const position_t& A, const position_t& B)
{
    return sqrt(distanceSquared(A, B));
}


float distanceSquared(const position_t& A, const position_t& B)
{
    float diff_x = A.x - B.x;
    float diff_y = A.y - B.y;
    float diff_z = A.z - B.z;
    return diff_x * diff_x + diff_y * diff_y + diff_z * diff_z;
}

int32 intpow32(int32 base, int32 exponent)
{
    int32 power = 1;
    while(exponent)
    {
        if(exponent & 1)
            power *= base;
        exponent >>= 1;
        base *= base;
    }
    return power;
}

void getMSB(uint32* result, uint32 value)
{
    *result = 0;
    if(value == 0)
        return;
#ifdef __GNUC__
    *result = 31 - (unsigned)__builtin_clz(value);
#elif defined _MSC_VER
    _BitScanReverse((unsigned long*)result, value);
#else
    while(value >>= 1)
        (*result)++;
#endif

}

/*
Rotations of entities are saved in uint8s, which can only hold up to a value of 255. In order to properly calculate rotations you'll need these methods to convert back and forth.
*/
float rotationToRadian(uint8 rotation)
{
    return (float)((rotation / 256.0f) * 2 * M_PI);
}

uint8 radianToRotation(float radian)
{
    return (uint8)((radian / (2 * M_PI)) * 256);
}

uint8 getangle(const position_t& A, const position_t& B)
{
    uint8 angle = (uint8)(atanf((B.z - A.z) / (B.x - A.x)) * -(128.0f / M_PI));

    return (A.x > B.x ? angle + 128 : angle);
}

/************************************************************************
*										       								                              *
*  Check whether the target is in the field of view (coneAngle)	       	*
*																		                                    *
************************************************************************/

bool isFaceing(const position_t& A, const position_t& B, uint8 coneAngle)
{
    int32 angle = getangle(A, B);
    return abs(int8(angle - A.rotation)) < (coneAngle >> 1);
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
    float totalRadians = rotationToRadian(A.rotation) + radian;
    position_t B;

    B.x = A.x + cosf((float)(2 * M_PI - totalRadians)) * offset;
    B.y = A.y;
    B.z = A.z + sinf((float)(2 * M_PI - totalRadians)) * offset;

    B.rotation = A.rotation;
    B.moving = A.moving;

    return B;
}

/************************************************************************
*                                                                       *
*  Methods for working with bit arrays.                 								*
*                                                                       *
************************************************************************/

int32 hasBit(uint16 value, uint8* BitArray, uint32 size)
{
    if(value >= size * 8)
    {
        ShowError(CL_RED"hasBit: value (%u) is out of range\n" CL_RESET, value);
        return 0;
    }
    return (int32)(BitArray[value >> 3] & (1 << (value % 8)));
}

int32 addBit(uint16 value, uint8* BitArray, uint32 size)
{
    if(!hasBit(value, BitArray, size) && (value < size * 8))
    {
        BitArray[value >> 3] |= (1 << (value % 8));
        return 1;
    }
    return 0;
}

int32 delBit(uint16 value, uint8* BitArray, uint32 size)
{
    if(hasBit(value, BitArray, size))
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
    byteOffset += (bitOffset >> 3);										//correct bitOffsets>=8
    bitOffset %= 8;

    uint64 bitmask = 0xFFFFFFFFFFFFFFFFLL;								//Generate bitmask

    bitmask >>= (64 - lengthInBit);
    bitmask <<= bitOffset;

    value <<= bitOffset;												//shift value
    value &= bitmask;

    bitmask ^= 0xFFFFFFFFFFFFFFFFLL;									//invert bitmask

    if((lengthInBit + bitOffset) <= 8)									//write shifted value to target
    {
        uint8* dataPointer = (uint8*)&target[byteOffset];

        uint8 bitmaskUC = (uint8)bitmask;
        uint8 valueUC = (uint8)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if((lengthInBit + bitOffset) <= 16)
    {
        uint16* dataPointer = (uint16*)&target[byteOffset];

        uint16 bitmaskUC = (uint16)bitmask;
        uint16 valueUC = (uint16)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if((lengthInBit + bitOffset) <= 32)
    {
        uint32* dataPointer = (uint32*)&target[byteOffset];

        uint32 bitmaskUC = (uint32)bitmask;
        uint32 valueUC = (uint32)value;

        *dataPointer &= bitmaskUC;
        *dataPointer |= valueUC;
    }
    else if((lengthInBit + bitOffset) <= 64)
    {
        uint64* dataPointer = (uint64*)&target[byteOffset];

        *dataPointer &= bitmask;
        *dataPointer |= value;
    }
    else
    {
        ShowError("Pack Bits Error: packBitsBE(...) not implemented for targetsizes above 64 bits.\n Targetsize: %d\n", (lengthInBit + bitOffset));
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

    uint64 retVal;

    if((lengthInBit + bitOffset) <= 8)
    {
        uint8* dataPointer = (uint8*)&target[byteOffset];

        retVal = ((*dataPointer)&(uint8)bitmask) >> bitOffset;
    }
    else if((lengthInBit + bitOffset) <= 16)
    {
        uint16* dataPointer = (uint16*)&target[byteOffset];

        retVal = ((*dataPointer)&(uint16)bitmask) >> bitOffset;
    }
    else if((lengthInBit + bitOffset) <= 32)
    {
        uint32* dataPointer = (uint32*)&target[byteOffset];

        retVal = ((*dataPointer)&(uint32)bitmask) >> bitOffset;
    }
    else if((lengthInBit + bitOffset) <= 64)
    {
        uint64* dataPointer = (uint64*)&target[byteOffset];

        retVal = ((*dataPointer)&(uint64)bitmask) >> bitOffset;
    }
    else
    {
        ShowError("Unpack Bits Error: unpackBits(...) not implemented for targetsizes above 64 bits.\n Targetsize: %d\n", (lengthInBit + bitOffset));
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
    byteOffset += (bitOffset >> 3);													//correct bitOffsets >= 8
    bitOffset %= 8;

    uint8 bytesNeeded;																//calculate how many bytes are needed
    if((bitOffset + lengthInBit) <= 8)
        bytesNeeded = 1;
    else if((bitOffset + lengthInBit) <= 16)
        bytesNeeded = 2;
    else if((bitOffset + lengthInBit) <= 32)
        bytesNeeded = 4;
    else if((bitOffset + lengthInBit) <= 64)
        bytesNeeded = 8;
    else
    {
        ShowError("Pack Bits Error: packBitsLE(...) not implemented for targetsizes above 64 bits.\n Targetsize: %d\n", (lengthInBit + bitOffset));
        return 0;
    }

    uint8* modifiedTarget = new uint8[bytesNeeded];									//convert byteOrder to Big Endian

    for(uint8 curByte = 0; curByte < bytesNeeded; ++curByte)
    {
        modifiedTarget[curByte] = target[byteOffset + (bytesNeeded - 1) - curByte];
    }

    int32 newBitOffset = (bytesNeeded << 3) - (bitOffset + lengthInBit); 			//calculate new bitOffset

    packBitsBE(&modifiedTarget[0], value, 0, newBitOffset, lengthInBit);			//write data to modified array

    for(uint8 curByte = 0; curByte < bytesNeeded; ++curByte)						//copy back to target
    {
        target[byteOffset + (bytesNeeded - 1) - curByte] = modifiedTarget[curByte];
    }

    if(modifiedTarget) delete[] modifiedTarget;
    return ((byteOffset << 3) + bitOffset + lengthInBit);
}

uint64 unpackBitsLE(uint8* target, int32 bitOffset, uint8 lengthInBit)
{
    return unpackBitsLE(target, 0, bitOffset, lengthInBit);
}

uint64 unpackBitsLE(uint8* target, int32 byteOffset, int32 bitOffset, uint8 lengthInBit)
{
    byteOffset += (bitOffset >> 3);
    bitOffset %= 8;

    uint8 bytesNeeded;
    if((bitOffset + lengthInBit) <= 8)
        bytesNeeded = 1;
    else if((bitOffset + lengthInBit) <= 16)
        bytesNeeded = 2;
    else if((bitOffset + lengthInBit) <= 32)
        bytesNeeded = 4;
    else if((bitOffset + lengthInBit) <= 64)
        bytesNeeded = 8;
    else
    {
        ShowError("Unpack Bits Error: packBitsLE(...) not implemented for targetsizes above 64 bits.\n Targetsize: %d\n", (lengthInBit + bitOffset));
        return 0;
    }

    uint64 retVal;

    uint8* modifiedTarget = new uint8[bytesNeeded];

    for(uint8 curByte = 0; curByte < bytesNeeded; ++curByte)
    {
        modifiedTarget[curByte] = target[byteOffset + (bytesNeeded - 1) - curByte];
    }
    if(bytesNeeded == 1)
    {
        uint8 bitmask = 0xFF >> bitOffset;
        retVal = (modifiedTarget[0] & bitmask) >> (8 - (lengthInBit + bitOffset));
    }
    else
    {
        int32 newBitOffset = (bytesNeeded * 8) - (bitOffset + lengthInBit);
        retVal = unpackBitsBE(&modifiedTarget[0], 0, newBitOffset, lengthInBit);
    }

    if(modifiedTarget) delete[]modifiedTarget;
    return retVal;
}

void EncodeStringLinkshell(int8* signature, int8* target)
{
    uint8 encodedSignature[16];
    memset(encodedSignature, 0, sizeof encodedSignature);
    uint8 chars = 0;
    uint8 leftover = 0;
    auto length = std::min<size_t>(20u, strlen((const char*)signature));

    for(uint8 currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = 0;
        if((signature[currChar] >= '0') && (signature[currChar] <= '9'))
            tempChar = signature[currChar] - '0' + 53;
        else if((signature[currChar] >= 'A') && (signature[currChar] <= 'Z'))
            tempChar = signature[currChar] - 'A' + 27;
        else if((signature[currChar] >= 'a') && (signature[currChar] <= 'z'))
            tempChar = signature[currChar] - 'a' + 1;
        packBitsLE(encodedSignature, tempChar, 6 * currChar, 6);
        chars++;
    }
    leftover = (chars * 6) % 8;
    leftover = 8 - leftover;
    leftover = (leftover == 8 || leftover == 2 ? 6 : leftover);
    packBitsLE(encodedSignature, 0xFF, 6 * chars, leftover);

    // TODO: -Wno-sizeof-pointer-memaccess - sizeof references source not destination
    strncpy((char*)target, (const char*)encodedSignature, sizeof encodedSignature);
}

void DecodeStringLinkshell(int8* signature, int8* target)
{
    uint8 decodedSignature[21];
    memset(decodedSignature, 0, sizeof decodedSignature);
    auto length = std::min<size_t>(20u, (strlen((const char*)signature) * 8) / 6);

    for(uint8 currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = '\0';
        tempChar = (uint8)unpackBitsLE((uint8*)signature, currChar * 6, 6);
        if(tempChar >= 1 && tempChar <= 26)
            tempChar = 'a' - 1 + tempChar;
        else if(tempChar >= 27 && tempChar <= 52)
            tempChar = 'A' - 27 + tempChar;
        else if(tempChar >= 53 && tempChar <= 62)
            tempChar = '0' - 53 + tempChar;

        if(tempChar == '\0')
        {
            decodedSignature[currChar == 0 ? currChar : currChar - 1] = '\0';
            break;
        }
        else if(tempChar == 63)
        {
            decodedSignature[currChar] = '\0';
            break;
        }
        else
            decodedSignature[currChar] = tempChar;
    }
    // TODO: -Wno-sizeof-pointer-memaccess - sizeof references source not destination
    strncpy((char*)target, (const char*)decodedSignature, sizeof decodedSignature);
}

int8* EncodeStringSignature(int8* signature, int8* target)
{
    uint8 encodedSignature[12];
    memset(encodedSignature, 0, sizeof encodedSignature);
    uint8 chars = 0;
    // uint8 leftover = 0;
    auto length = std::min<size_t>(15u, strlen((const char*)signature));

    for(uint8 currChar = 0; currChar < length; ++currChar)
    {
        uint8 tempChar = 0;
        if((signature[currChar] >= '0') && (signature[currChar] <= '9'))
            tempChar = signature[currChar] - '0' + 1;
        else if((signature[currChar] >= 'A') && (signature[currChar] <= 'Z'))
            tempChar = signature[currChar] - 'A' + 11;
        else if((signature[currChar] >= 'a') && (signature[currChar] <= 'z'))
            tempChar = signature[currChar] - 'a' + 37;
        packBitsLE(encodedSignature, tempChar, 6 * currChar, 6);
        chars++;
    }
    //leftover = (chars * 6) % 8;
    //leftover = 8 - leftover;
    //leftover = (leftover == 8 ? 6 : leftover);
    //packBitsLE(encodedSignature,0xFF,6*chars, leftover);

    // TODO: -Wno-sizeof-pointer-memaccess - sizeof references source not destination
    return (int8*)strncpy((char*)target, (const char*)encodedSignature, sizeof encodedSignature);
}

void DecodeStringSignature(int8* signature, int8* target)
{
    uint8 decodedSignature[PacketNameLength + 1] = { 0 };
    for(uint8 currChar = 0; currChar < PacketNameLength; ++currChar)
    {
        uint8 tempChar = (uint8)unpackBitsLE((uint8*)signature, currChar * 6, 6);
        if(tempChar >= 1 && tempChar <= 10)
            tempChar = '0' - 1 + tempChar;
        else if(tempChar >= 11 && tempChar <= 36)
            tempChar = 'A' - 11 + tempChar;
        else if(tempChar >= 37 && tempChar <= 62)
            tempChar = 'a' - 37 + tempChar;

        decodedSignature[currChar] = tempChar;
    }
    // TODO: -Wno-sizeof-pointer-memaccess - sizeof references source not destination
    strncpy((char*)target, (const char*)decodedSignature, sizeof decodedSignature);
}

std::string escape(std::string const &s)
{
    std::size_t n = s.length();
    std::string escaped;
    escaped.reserve(n * 2);
    for(std::size_t i = 0; i < n; ++i){
        if(s[i] == '\\' || s[i] == '\'')
            escaped += '\\';
        escaped += s[i];
    }
    return escaped;
}
