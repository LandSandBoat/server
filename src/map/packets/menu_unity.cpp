/*
===========================================================================

  Copyright (c) 2021 Topaz Dev Teams

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

#include "common/socket.h"

#include "menu_unity.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

CMenuUnityPacket::CMenuUnityPacket(CCharEntity* PChar)
{
    const char* Query = "SELECT leader, members_current, points_current, members_prev, points_prev FROM unity_system";
    int32       ret   = _sql->Query(Query);

    std::pair<int32, double> unity_current[11];
    std::pair<int32, double> unity_previous[11];

    if (ret != SQL_ERROR && _sql->NumRows() != 0)
    {
        while (_sql->NextRow() == SQL_SUCCESS)
        {
            int unity_leader = _sql->GetIntData(0) - 1;

            if (unity_leader >= 0 && unity_leader < 11)
            {
                unity_current[unity_leader].first   = _sql->GetIntData(1);
                unity_current[unity_leader].second  = _sql->GetIntData(2);
                unity_previous[unity_leader].first  = _sql->GetIntData(3);
                unity_previous[unity_leader].second = _sql->GetIntData(4);
            }
        }
    }

    this->setType(0x63);
    this->setSize(0x8C);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x00;
    ref<uint8>(0x09) = 0x00; // Type 0

    PChar->pushPacket(this->copy());

    // CMenuUnityPacket: Update Type 0x0001
    // Full Unity Results: Total contributing members in Unity
    this->setSize(0x8C);
    std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x01; // Type 1

    for (uint8 i = 0; i < 11; i++)
    {
        ref<uint32>(i * 4 + 0x10) = unity_previous[i].first;
    }

    PChar->pushPacket(this->copy());

    // CMenuUnityPacket: Update Type 0x0002
    // Full Unity Results: Total Points gained this week per unity
    this->setSize(0x8C);
    std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x09) = 0x02; // Type 2

    for (uint8 i = 0; i < 11; i++)
    {
        ref<uint32>(i * 4 + 0x10) = unity_previous[i].second;
    }

    PChar->pushPacket(this->copy());

    for (int i = 3; i < 32; i++)
    {
        this->setSize(0x8C);
        std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

        ref<uint8>(0x04) = 0x07; // Switch Block 7
        ref<uint8>(0x06) = 0x88; // Variable Data Size
        ref<uint8>(0x09) = i;    // Type 3

        PChar->pushPacket(this->copy());
    }

    // CMenuUnityPacket: Update Type 0x0100
    this->setSize(0x8C);
    std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x00; // Type 0100

    PChar->pushPacket(this->copy());

    // CMenuUnityPacket: Update Type 0x0101
    // Partial Unity Ranking: Total Members in Unity
    this->setSize(0x8C);
    std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x01; // Type 0101

    for (uint8 i = 0; i < 11; i++)
    {
        ref<uint32>(i * 4 + 0x10) = unity_current[i].first;
    }

    PChar->pushPacket(this->copy());

    // CMenuUnityPacket: Update Type 0x0102
    // Partial Unity Ranking: Total Points this week in Unity
    this->setSize(0x8C);
    std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

    ref<uint8>(0x04) = 0x07; // Switch Block 7
    ref<uint8>(0x06) = 0x88; // Variable Data Size
    ref<uint8>(0x08) = 0x01;
    ref<uint8>(0x09) = 0x02; // Type 0102

    for (uint8 i = 0; i < 11; i++)
    {
        ref<uint32>(i * 4 + 0x10) = unity_current[i].second;
    }

    PChar->pushPacket(this->copy());

    for (int i = 3; i < 32; i++)
    {
        this->setSize(0x8C);
        std::memset(buffer_.data() + 4, 0, PACKET_SIZE - 4);

        ref<uint8>(0x04) = 0x07; // Switch Block 7
        ref<uint8>(0x06) = 0x88; // Variable Data Size
        ref<uint8>(0x08) = 0x01;
        ref<uint8>(0x09) = i; // Type 0103

        PChar->pushPacket(this->copy());
    }
}
