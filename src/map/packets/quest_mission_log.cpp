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

#include "common/socket.h"

#include <cstring>

#include "entities/charentity.h"
#include "quest_mission_log.h"

CQuestMissionLogPacket::CQuestMissionLogPacket(CCharEntity* PChar, uint8 logID, LOG_TYPE logType)
{
    this->setType(0x56);
    this->setSize(0x28);

    uint16 packetType = 0x00;

    // FFXI packs different TOAU information in the same packet as certain other content, so we'll have to work around it.
    // First, deal with all quest areas which aren't TOAU:
    if ((logType <= LOG_QUEST_COMPLETE) && (logID != QUESTS_TOAU))
    {
        // We're updating any non-TOAU quest log
        generateQuestPacket(PChar, logID, logType);
        packetType = (logType == LOG_QUEST_CURRENT ? questPacketBytes.at(logID).first : questPacketBytes.at(logID).second);
    }
    // Then get our mission log updates out of the way
    else if (logType >= LOG_MISSION_CURRENT)
    {
        if ((logID <= MISSION_ZILART) && (logType == LOG_MISSION_COMPLETE))
        {
            // Completed Nation and Zilart missions are updated in the same packet
            generateCompleteMissionPacket(PChar);
            packetType = MISSION_COMPLETE;
        }
        else if ((logID >= MISSION_TOAU) && (logID <= MISSION_CAMPAIGN) && (logID != MISSION_COP))
        {
            // Deal with compound TOAU/WOTG quest/mission packets
            switch (logType)
            {
                case LOG_MISSION_CURRENT:
                    // Current TOAU Quests, TOAU Mission, WOTG, Assault, and Campaign Mission all share a packet
                    generateQuestPacket(PChar, QUESTS_TOAU, LOG_QUEST_CURRENT); // "Base" of the packet
                    generateCurrentExpMissionPacket(PChar);                     // Writes 12 bytes in same packet
                    packetType = TOAU_WOTG_MISSION_CURRENT;
                    break;
                case LOG_MISSION_COMPLETE:
                    switch (logID)
                    {
                        case MISSION_TOAU:
                        case MISSION_WOTG:
                            // Completed TOAU and WOTG missions share a packet
                            generateCompleteExpMissionPacket(PChar);
                            packetType = TOAU_WOTG_MISSION_COMPLETE;
                            break;
                        case MISSION_ASSAULT:
                            // Completed Assault Missions share a packet with completed TOAU quests
                            generateQuestPacket(PChar, QUESTS_TOAU, LOG_QUEST_COMPLETE);
                            generateAssaultMissionPacket(PChar);
                            packetType = ASSAULT_COMPLETE;
                            break;
                        case MISSION_CAMPAIGN:
                            // Completed Campaign missions take up two packets. Second half will come in a follow-up packet.
                            generateCampaignMissionPacket(PChar, 0);
                            packetType = CAMPAIGN_MISSION_ONE;
                            break;
                    }
                    break;
                case LOG_CAMPAIGN_TWO:
                    // Second Campaign packet, summoned through logType
                    generateCampaignMissionPacket(PChar, 1);
                    packetType = CAMPAIGN_MISSION_TWO;
                    break;
                default:
                {
                    break;
                }
            }
        }
        else
        {
            // All other mission logs update current / completed with a standard "current mission" update
            generateCurrentMissionPacket(PChar);
            packetType = MISSION_CURRENT;
        }
    }
    else
    {
        // Now all that remains is TOAU quests.
        generateQuestPacket(PChar, QUESTS_TOAU, logType); // "Base" of the packet
        if (logType == LOG_QUEST_CURRENT)
        {
            // As before, current TOAU Quests share with TOAU Mission, WOTG, Assault, and Campaign Missions
            generateCurrentExpMissionPacket(PChar); // Writes 12 bytes in same packet
            packetType = questPacketBytes.at(logID).first;
        }
        else
        {
            // Completed TOAU Quests share a packet with completed Assault Missions
            generateAssaultMissionPacket(PChar); // Writes in same packet
            packetType = questPacketBytes.at(logID).second;
        }
    }

    // Write the byte that informs FFXI client what kind of Quest/Mission log update this packet is.
    ref<uint16>(0x24) = packetType;
}

void CQuestMissionLogPacket::generateQuestPacket(CCharEntity* PChar, uint8 logID, LOG_TYPE status)
{
    if (status == LOG_QUEST_CURRENT)
    {
        std::memcpy(buffer_.data() + 4, PChar->m_questLog[logID].current, 32);
    }
    else if (status == LOG_QUEST_COMPLETE)
    {
        std::memcpy(buffer_.data() + 4, PChar->m_questLog[logID].complete, 32);
    }
}

void CQuestMissionLogPacket::generateCurrentMissionPacket(CCharEntity* PChar)
{
    uint16 add_on_scenarios = 0;

    add_on_scenarios += PChar->m_missionLog[MISSION_ACP].current;
    add_on_scenarios += PChar->m_missionLog[MISSION_AMK].current << 0x04;
    add_on_scenarios += PChar->m_missionLog[MISSION_ASA].current << 0x08;
    // Not perfect, but they display and missions DO progress. TODO: Fix properly later. There is a delay before when the menu updates. Zoning will force it.

    uint32 soa = (PChar->m_missionLog[MISSION_SOA].current * 2) + 0x6E;
    uint32 rov = PChar->m_missionLog[MISSION_ROV].current + 0x6C;

    // While current National Missions + Zilart Mission are updated in this packet, completed missions are sent in a separate one.
    ref<uint8>(0x04)  = PChar->profile.nation;                              // Nation
    ref<uint16>(0x08) = PChar->m_missionLog[PChar->profile.nation].current; // National Missions
    ref<uint16>(0x0C) = PChar->m_missionLog[MISSION_ZILART].current;        // Rise of the Zilart

    // But for COP, Add-On Scenarios, SOA, and ROV, sending the current mission will also update that logs completed missions.
    ref<uint32>(0x10) = PChar->m_missionLog[MISSION_COP].current; // Chains of Promathia Missions
    ref<uint32>(0x14) = (PChar->m_missionLog[MISSION_COP].statusUpper << 16) | PChar->m_missionLog[MISSION_COP].statusLower;
    // ref<uint8>(data,(0x16)) = 0x30;                                                // Purpose Unknown
    ref<uint16>(0x18) = add_on_scenarios; // A Crystalline Prophecy, A Moogle Kupo d'Etat, A Shantotto Ascension
    ref<uint16>(0x1C) = soa;              // Seekers of Adoulin
    ref<uint16>(0x20) = rov;              // Rhapsodies of Vana'diel
}

void CQuestMissionLogPacket::generateCompleteMissionPacket(CCharEntity* PChar)
{
    // This packet simultaneously updates completed mission logs for Nation and Zilart missions.
    for (uint8 logID = MISSION_SANDORIA; logID <= MISSION_ZILART; logID++)
    {
        for (uint8 questMissionID = 0; questMissionID < 64; questMissionID++)
        {
            buffer_[(questMissionID / 8) + (logID * 0x08) + 4] ^= ((PChar->m_missionLog[logID].complete[questMissionID]) << (questMissionID % 8));
        }
    }
}

void CQuestMissionLogPacket::generateCurrentExpMissionPacket(CCharEntity* PChar)
{
    // This function writes the current Assault, TOAU, WOTG, and Campaign mission onto a packet already
    // being prepared by generateQuestPacket for TOAU quests, since they're all updated simultaneously.
    ref<uint16>(0x14) = PChar->m_assaultLog.current;               // Assault Missions
    ref<uint16>(0x18) = PChar->m_missionLog[MISSION_TOAU].current; // Treasures of Aht Urhgan
    ref<uint16>(0x1C) = PChar->m_missionLog[MISSION_WOTG].current; // Wings of the Goddess
    ref<uint16>(0x20) = PChar->m_campaignLog.current;              // Campaign Operations
}

void CQuestMissionLogPacket::generateCompleteExpMissionPacket(CCharEntity* PChar)
{
    // This packet simultaenously updates completed mission logs for TOAU and WOTG missions.
    uint8 logID = MISSION_TOAU;
    for (uint8 questMissionID = 0; questMissionID < 64; questMissionID++)
    {
        buffer_[(questMissionID / 8) + 4] ^= ((PChar->m_missionLog[logID].complete[questMissionID]) << (questMissionID % 8));
    }

    logID = MISSION_WOTG;
    for (uint8 questMissionID = 0; questMissionID < 64; questMissionID++)
    {
        buffer_[(questMissionID / 8) + 0x08 + 4] ^= ((PChar->m_missionLog[logID].complete[questMissionID]) << (questMissionID % 8));
    }
}

void CQuestMissionLogPacket::generateCampaignMissionPacket(CCharEntity* PChar, uint8 startQMID)
{
    for (uint16 questMissionID = startQMID; questMissionID < (startQMID + 256); questMissionID++)
    {
        buffer_[(questMissionID / 8) + 4] ^= ((PChar->m_campaignLog.complete[questMissionID]) << (questMissionID % 8));
    }
}

void CQuestMissionLogPacket::generateAssaultMissionPacket(CCharEntity* PChar)
{
    for (uint16 questMissionID = 0; questMissionID < 128; questMissionID++)
    {
        buffer_[(questMissionID / 8) + 0x10 + 4] ^= ((PChar->m_assaultLog.complete[questMissionID]) << (questMissionID % 8));
    }
}
