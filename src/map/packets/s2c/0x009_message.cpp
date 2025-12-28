/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "0x009_message.h"

#include "entities/charentity.h"
#include "enums/msg_std.h"

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const MsgStd messageID)
{
    this->setSize(0x10);
    auto& packet = this->data();

    packet.MesNo = static_cast<uint16>(messageID);
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const uint16 messageID)
{
    this->setSize(0x10);
    auto& packet = this->data();

    packet.MesNo = messageID;
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const uint32 param0, const MsgStd messageID)
{
    this->setSize(0x1C);
    auto& packet = this->data();

    packet.MesNo = static_cast<uint16>(messageID);

    snprintf(packet.Data, 16, "Para0 %u ", param0);
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const std::string& string2, const MsgStd messageID)
{
    this->setSize(0x1C);
    auto& packet = this->data();

    packet.MesNo = static_cast<uint16>(messageID);

    snprintf(packet.Data, 24, "string2 %s", string2.c_str());
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const uint32 param0, const uint32 param1, const uint16 messageID)
{
    this->setSize(0x48);
    auto& packet = this->data();

    packet.MesNo = messageID;
    snprintf(packet.Data, 24, "Para0 %u Para1 %u", param0, param1);
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(CCharEntity* PChar, const uint32 param0, const uint32 param1, const MsgStd messageID)
{
    this->setSize(0x24);
    auto& packet = this->data();

    packet.MesNo = static_cast<uint16>(messageID);
    if (PChar != nullptr)
    {
        packet.UniqueNo = PChar->id;
        packet.ActIndex = PChar->targid;

        if (messageID == MsgStd::Examine)
        {
            this->setSize(0x60);
            packet.Attr = 0x10;

            snprintf(packet.Data, 24, "string2 %s", PChar->getName().c_str());
        }
        else if (messageID == MsgStd::MonstrosityCheckIn || messageID == MsgStd::MonstrosityCheckOut)
        {
            this->setSize(0x20);

            snprintf(packet.Data, 24, "string2 %s", PChar->getName().c_str());
        }
    }
    else
    {
        snprintf(packet.Data, 24, "Para0 %u Para1 %u", param0, param1);
    }
}

GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const uint32 param0, const uint32 param1, const uint32 param2, const uint32 param3, const MsgStd messageID)
{
    this->setSize(0x10);
    auto& packet = this->data();
    packet.MesNo = static_cast<uint16>(messageID);

    snprintf(packet.Data, 100, "Para0 %u Para1 %u Para2 %u Para3 %u", param0, param1, param2, param3);

    this->setSize((this->getSize() + (strlen(packet.Data) >> 1)) & 0xFE);
}

// Only used with MsgStd::DiceRoll (/random)
GP_SERV_COMMAND_MESSAGE::GP_SERV_COMMAND_MESSAGE(const CCharEntity* PChar, const uint32 param0, const MsgStd messageID)
{
    this->setSize(0x34);
    auto& packet = this->data();
    packet.MesNo = static_cast<uint16>(messageID);

    snprintf(packet.Data, 40, "string2 %s string3 %u", PChar->getName().c_str(), param0);
}
