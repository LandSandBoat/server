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

#include "0x0dd_group_list.h"

#include "alliance.h"
#include "common/logging.h"
#include "entities/charentity.h"
#include "entities/trustentity.h"

GP_SERV_COMMAND_GROUP_LIST::GP_SERV_COMMAND_GROUP_LIST(const CCharEntity* PChar, const uint8_t MemberNumber, const uint16_t memberflags, const uint16_t ZoneID)
{
    if (PChar == nullptr)
    {
        ShowError("GP_SERV_COMMAND_GROUP_LIST::GP_SERV_COMMAND_GROUP_LIST() - PChar was null.");
        return;
    }

    auto& packet = this->data();

    packet.UniqueNo                = PChar->id;
    packet.GAttr.PartyNo           = (memberflags >> 0) & 0x03; // Bits 0-1: Party number (0-2 for parties, 3 for no party)
    packet.GAttr.PartyLeaderFlg    = (memberflags >> 2) & 0x01; // Bit 2: Party leader flag
    packet.GAttr.AllianceLeaderFlg = (memberflags >> 3) & 0x01; // Bit 3: Alliance leader flag
    packet.GAttr.PartyRFlg         = (memberflags >> 4) & 0x01; // Bit 4: Party recruiter flag
    packet.GAttr.AllianceRFlg      = (memberflags >> 5) & 0x01; // Bit 5: Alliance recruiter flag
    packet.GAttr.unknown06         = (memberflags >> 6) & 0x01; // Bit 6: MasterComFlg
    packet.GAttr.unknown07         = (memberflags >> 7) & 0x01; // Bit 7: SubMasterComFlg
    packet.GAttr.LevelSyncFlg      = (memberflags >> 8) & 0x01; // Bit 8: LevelSyncFlg

    if (PChar->getZone() != ZoneID)
    {
        packet.ZoneNo = PChar->getZone();
    }
    else
    {
        packet.Hp           = PChar->health.hp;
        packet.Mp           = PChar->health.mp;
        packet.Tp           = PChar->health.tp;
        packet.ActIndex     = PChar->targid;
        packet.MemberNumber = MemberNumber;
        packet.Hpp          = PChar->GetHPP();
        packet.Mpp          = PChar->GetMPP();

        if (!PChar->isAnon())
        {
            packet.mjob_no = PChar->GetMJob();
            packet.mjob_lv = PChar->GetMLevel();
            packet.sjob_no = PChar->GetSJob();
            packet.sjob_lv = PChar->GetSLevel();
        }
    }

    std::memcpy(packet.Name, PChar->getName().c_str(), std::min<size_t>(PChar->getName().size(), sizeof(packet.Name)));
}

GP_SERV_COMMAND_GROUP_LIST::GP_SERV_COMMAND_GROUP_LIST(const CTrustEntity* PTrust, const uint8_t MemberNumber)
{
    if (PTrust == nullptr)
    {
        ShowError("GP_SERV_COMMAND_GROUP_LIST::GP_SERV_COMMAND_GROUP_LIST() - PTrust was null.");
        return;
    }

    auto& packet = this->data();

    packet.UniqueNo     = PTrust->id;
    packet.Hp           = PTrust->health.hp;
    packet.Mp           = PTrust->health.mp;
    packet.Tp           = PTrust->health.tp;
    packet.ActIndex     = PTrust->targid;
    packet.MemberNumber = MemberNumber;
    packet.Hpp          = PTrust->GetHPP();
    packet.Mpp          = PTrust->GetMPP();
    packet.mjob_no      = PTrust->GetMJob();
    packet.mjob_lv      = PTrust->GetMLevel();
    packet.sjob_no      = PTrust->GetSJob();
    packet.sjob_lv      = PTrust->GetSLevel();

    std::memcpy(packet.Name, PTrust->packetName.c_str(), std::min<size_t>(PTrust->packetName.size(), sizeof(packet.Name)));
}

GP_SERV_COMMAND_GROUP_LIST::GP_SERV_COMMAND_GROUP_LIST(const uint32_t id, const std::string& name, const uint16_t memberFlags, const uint8_t MemberNumber, const uint16_t ZoneID)
{
    auto& packet = this->data();

    packet.UniqueNo                = id;
    packet.GAttr.PartyNo           = (memberFlags >> 0) & 0x03; // Bits 0-1: Party number (0-2 for parties, 3 for no party)
    packet.GAttr.PartyLeaderFlg    = (memberFlags >> 2) & 0x01; // Bit 2: Party leader flag
    packet.GAttr.AllianceLeaderFlg = (memberFlags >> 3) & 0x01; // Bit 3: Alliance leader flag
    packet.GAttr.PartyRFlg         = (memberFlags >> 4) & 0x01; // Bit 4: Party recruiter flag
    packet.GAttr.AllianceRFlg      = (memberFlags >> 5) & 0x01; // Bit 5: Alliance recruiter flag
    packet.GAttr.unknown06         = (memberFlags >> 6) & 0x01; // Bit 6: MasterComFlg
    packet.GAttr.unknown07         = (memberFlags >> 7) & 0x01; // Bit 7: SubMasterComFlg
    packet.GAttr.LevelSyncFlg      = (memberFlags >> 8) & 0x01; // Bit 8: LevelSyncFlg
    packet.ZoneNo                  = ZoneID;

    std::memcpy(packet.Name, name.c_str(), std::min<size_t>(name.size(), sizeof(packet.Name)));
}
