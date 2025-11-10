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

#include "0x017_chat_std.h"

#include "common/ipc_structs.h"
#include "common/utils.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_CHAT_STD::GP_SERV_COMMAND_CHAT_STD(const CCharEntity* PChar, const CHAT_MESSAGE_TYPE MessageType, const std::string& message, const std::string& sender)
{
    auto& packet = this->data();

    const auto messageSize = static_cast<uint8_t>(std::min(message.size(), sizeof(packet.Mes)));
    const auto packetSize  = sizeof(GP_SERV_HEADER) + sizeof(packet.Kind) + sizeof(packet.Attr) + sizeof(packet.Data) + sizeof(packet.sName) + messageSize;
    this->setSize(roundUpToNearestFour(packetSize));

    const std::string& name = sender.empty() ? PChar->getName() : sender;
    packet.Kind             = MessageType;
    packet.Data             = PChar->getZone();
    if (PChar->visibleGmLevel >= 3 && sender.empty())
    {
        packet.Attr = 0x01;
    }

    std::memcpy(packet.sName, name.data(), std::min(name.size(), sizeof(packet.sName)));
    std::memcpy(packet.Mes, message.data(), messageSize);
}

GP_SERV_COMMAND_CHAT_STD::GP_SERV_COMMAND_CHAT_STD(const std::string& name, const uint16 zone, const CHAT_MESSAGE_TYPE MessageType, const std::string& message, const uint8 gmLevel)
{
    auto& packet = this->data();

    const auto messageSize = static_cast<uint8_t>(std::min(message.size(), sizeof(packet.Mes)));
    const auto packetSize  = sizeof(GP_SERV_HEADER) + sizeof(packet.Kind) + sizeof(packet.Attr) + sizeof(packet.Data) + sizeof(packet.sName) + messageSize;
    this->setSize(roundUpToNearestFour(packetSize));

    packet.Kind = MessageType;
    packet.Data = zone;
    if (gmLevel >= 3 && name.empty())
    {
        packet.Attr = 0x01;
    }

    std::memcpy(packet.sName, name.data(), std::min(name.size(), sizeof(packet.sName)));
    std::memcpy(packet.Mes, message.data(), messageSize);
}

GP_SERV_COMMAND_CHAT_STD::GP_SERV_COMMAND_CHAT_STD(const ipc::ChatMessageAssist& payload)
{
    auto& packet = this->data();

    const auto messageSize = static_cast<uint8_t>(std::min(payload.message.size(), sizeof(packet.Mes)));
    const auto packetSize  = sizeof(GP_SERV_HEADER) + sizeof(packet.Kind) + sizeof(packet.Attr) + sizeof(packet.Data) + sizeof(packet.sName) + messageSize;
    this->setSize(roundUpToNearestFour(packetSize));

    // Data field holds mastery rank (low byte) and mentor rank (high byte) for assist messages
    packet.Data = (payload.mentorRank ? payload.masteryRank : 0) | (static_cast<uint16>(payload.mentorRank) << 8);
    packet.Kind = payload.messageType;
    if (payload.gmLevel >= 3)
    {
        packet.Attr = 0x01;
    }

    std::memcpy(packet.sName, payload.senderName.data(), std::min(payload.senderName.size(), sizeof(packet.sName)));
    std::memcpy(packet.Mes, payload.message.data(), messageSize);
}
