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

#include "../../common/socket.h"

#include "menu_unity.h"

#include "../entities/charentity.h"
#include "../utils/charutils.h"

CMenuUnityPacket::CMenuUnityPacket(CCharEntity* PChar)
{
    this->type = 0x63;

    // CMenuUnityPacket: Update Type 0x0000
    this->size = 0x8C;

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x00;
    ref<uint8>(0x09) = 0x00; // Type 0

    ref<uint8>(0x0A) = 0x07;
    ref<uint8>(0x0C) = 0x80;
    ref<uint8>(0x0D) = 0x48;
    ref<uint8>(0x0E) = 0xE6;
    ref<uint8>(0x0F) = 0x23;
    ref<uint8>(0x10) = 0x09;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0001
    // Full Unity Results: Total contributing members in Unity
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x01; // Type 1

    ref<uint32>(0x0C) = 0;
    ref<uint32>(0x10) = 10; // Pieuje
    ref<uint32>(0x14) = 10;
    ref<uint32>(0x18) = 10;
    ref<uint32>(0x1C) = 10;
    ref<uint32>(0x20) = 10;
    ref<uint32>(0x24) = 10;
    ref<uint32>(0x28) = 10;
    ref<uint32>(0x2C) = 10;
    ref<uint32>(0x30) = 10;
    ref<uint32>(0x34) = 10;
    ref<uint32>(0x38) = 10;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0002
    // Full Unity Results: Total Points gained this week per unity
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x02; // Type 2

    ref<uint8>(0x0A) = 0x00;
    ref<uint8>(0x0B) = 0x00;

    ref<uint32>(0x0C) = 0;
    ref<uint32>(0x10) = 4200;
    ref<uint32>(0x14) = 4100;
    ref<uint32>(0x18) = 4000;
    ref<uint32>(0x1C) = 3900;
    ref<uint32>(0x20) = 3800;
    ref<uint32>(0x24) = 3700;
    ref<uint32>(0x28) = 3600;
    ref<uint32>(0x2C) = 3500;
    ref<uint32>(0x30) = 3400;
    ref<uint32>(0x34) = 3300;
    ref<uint32>(0x38) = 3200;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0003
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x03; // Type 3

    ref<uint8>(0x0B) = 0xA0;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0004
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x04; // Type 4

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0005
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x05; // Type 5

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0006
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x06; // Type 6

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0007
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x07; // Type 7

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0008
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x08; // Type 8

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0009
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x09; // Type 9

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000A
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0A; // Type A

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000B
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0B; // Type B

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000C
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0C; // Type C

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000D
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0D; // Type D

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000E
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0E; // Type E

    ref<uint8>(0x0A) = 0xFD;
    ref<uint8>(0x0B) = 0xFF;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x000F
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x0F; // Type F

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0010
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x10; // Type 10

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0011
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x11; // Type 11

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0012
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x12; // Type 12

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0013
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x13; // Type 13

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0014
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x14; // Type 14

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0015
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x15; // Type 15

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0016
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x16; // Type 16

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0017
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x17; // Type 17

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0018
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x18; // Type 18

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0019
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x19; // Type 19

    ref<uint8>(0x0A) = 0x2B;
    ref<uint8>(0x0B) = 0x60;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001A
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1A; // Type 1A

    ref<uint8>(0x0B) = 0x30;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001B
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1B; // Type 1B

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001C
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1C; // Type 1C

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001D
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1D; // Type 1D

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001E
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1E; // Type 1E

    ref<uint8>(0x0A) = 0x30;
    ref<uint8>(0x0B) = 0xE9;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x001F
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x1F; // Type 1F

    ref<uint8>(0x0A) = 0x4B;
    ref<uint8>(0x0B) = 0x12;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0100
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x00; // Type 0100

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0101
    // Partial Unity Ranking: Total Members in Unity
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x01; // Type 0101

    ref<uint8>(0x0A) = 0xFF;
    ref<uint8>(0x0B) = 0;

    ref<uint32>(0x10) = 1;
    ref<uint32>(0x14) = 1;
    ref<uint32>(0x18) = 1;
    ref<uint32>(0x1C) = 1;
    ref<uint32>(0x20) = 1;
    ref<uint32>(0x24) = 1;
    ref<uint32>(0x28) = 1;
    ref<uint32>(0x2C) = 1;
    ref<uint32>(0x30) = 1;
    ref<uint32>(0x34) = 1;
    ref<uint32>(0x38) = 1;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0102
    // Partial Unity Ranking: Total Points this week in Unity
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x02; // Type 0102

    ref<uint8>(0x0A) = 0;
    ref<uint8>(0x0B) = 0;

    ref<uint32>(0x10) = 42;
    ref<uint32>(0x14) = 41;
    ref<uint32>(0x18) = 40;
    ref<uint32>(0x1C) = 39;
    ref<uint32>(0x20) = 38;
    ref<uint32>(0x24) = 37;
    ref<uint32>(0x28) = 36;
    ref<uint32>(0x2C) = 35;
    ref<uint32>(0x30) = 34;
    ref<uint32>(0x34) = 33;
    ref<uint32>(0x38) = 32;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0103
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x03; // Type 0103

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0104
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x04; // Type 0104

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0105
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x05; // Type 0105

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0106
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x06; // Type 0106

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0107
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x07; // Type 0107

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0108
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x08; // Type 0108

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0109
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x09; // Type 0109

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010A
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0A; // Type 010A

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010B
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0B; // Type 010B

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010C
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0C; // Type 010C

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010D
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0D; // Type 010D

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010E
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0E; // Type 010E

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x010F
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x0F; // Type 010F

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0110
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x10; // Type 0110

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0111
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x11; // Type 0111

    ref<uint8>(0x0A) = 0x0E;
    ref<uint8>(0x0B) = 0x01;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0112
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x12; // Type 0112

    ref<uint8>(0x0A) = 0x08;
    ref<uint8>(0x0B) = 0x00;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0113
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x13; // Type 0113

    ref<uint8>(0x0A) = 0x0E;
    ref<uint8>(0x0B) = 0x01;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0114
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x14; // Type 0114

    ref<uint8>(0x0A) = 0x1F;
    ref<uint8>(0x0B) = 0xFF;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0115
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x15; // Type 0115

    ref<uint8>(0x0A) = 0x1F;
    ref<uint8>(0x0B) = 0x7F;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0116
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x16; // Type 0116

    ref<uint8>(0x0A) = 0x03;
    ref<uint8>(0x0B) = 0x00;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0117
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x17; // Type 0117

    ref<uint8>(0x0A) = 0x0F;
    ref<uint8>(0x0B) = 0x00;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0118
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x18; // Type 0118

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x0119
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x19; // Type 0119

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011A
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1A; // Type 011A

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011B
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1B; // Type 011B

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011C
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1C; // Type 011C

    ref<uint8>(0x0A) = 0x0E;
    ref<uint8>(0x0B) = 0x01;

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011D
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1D; // Type 011D

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011E
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1E; // Type 011E

    PChar->pushPacket(new CBasicPacket(*this));

    // CMenuUnityPacket: Update Type 0x011F
    this->size = 0x8C;
    memset(data + 4, 0, sizeof(PACKET_SIZE - 4));

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x1F; // Type 011F

    ref<uint8>(0x0A) = 0x08;
    ref<uint8>(0x0B) = 0x00;

    PChar->pushPacket(new CBasicPacket(*this));
}
