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

#include "0x056_mission_other.h"

#include "entities/charentity.h"
#include "enums/mission_log.h"
#include "enums/quest_log.h"

GP_SERV_COMMAND_MISSION::OTHER::OTHER(const CCharEntity* PChar, QuestOffer log)
{
    auto& packet = this->data();

    packet.Port = static_cast<uint16_t>(log);
    switch (log)
    {
        case QuestOffer::Sandoria:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Sandoria)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Bastok:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Bastok)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Windurst:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Windurst)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Jeuno:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Jeuno)].current, sizeof(packet.Data));
            break;
        case QuestOffer::OtherAreas:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::OtherAreas)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Outlands:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Outlands)].current, sizeof(packet.Data));
            break;
        case QuestOffer::AhtUrghan:
        {
            // Special case: TOAU quests also update current Assault, TOAU, WOTG, and Campaign missions
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::AhtUrghan)].current, sizeof(packet.Data));
            packet.Data[4] = PChar->m_assaultLog.current;
            packet.Data[5] = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ToAU)].current;
            packet.Data[6] = PChar->m_missionLog[static_cast<uint8_t>(MissionLog::WoTG)].current;
            packet.Data[7] = PChar->m_campaignLog.current;
            break;
        }
        case QuestOffer::CrystalWar:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::CrystalWar)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Abyssea:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Abyssea)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Adoulin:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Adoulin)].current, sizeof(packet.Data));
            break;
        case QuestOffer::Coalition:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Coalition)].current, sizeof(packet.Data));
            break;
        default:
            break;
    }
}

GP_SERV_COMMAND_MISSION::OTHER::OTHER(const CCharEntity* PChar, QuestComplete log)
{
    auto& packet = this->data();

    packet.Port = static_cast<uint16_t>(log);
    switch (log)
    {
        case QuestComplete::Sandoria:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Sandoria)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Bastok:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Bastok)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Windurst:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Windurst)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Jeuno:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Jeuno)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::OtherAreas:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::OtherAreas)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Outlands:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Outlands)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::AhtUrghan:
        {
            // Special case: ToAU quests also update completed Assault missions
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::AhtUrghan)].complete, sizeof(packet.Data));
            for (uint16 missionID = 0; missionID < 128; missionID++)
            {
                if (PChar->m_assaultLog.complete[missionID])
                {
                    packet.Data[4 + missionID / 32] |= (1u << (missionID % 32));
                }
            }
            break;
        }
        case QuestComplete::CrystalWar:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::CrystalWar)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Abyssea:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Abyssea)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Adoulin:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Adoulin)].complete, sizeof(packet.Data));
            break;
        case QuestComplete::Coalition:
            std::memcpy(packet.Data, PChar->m_questLog[static_cast<uint8_t>(QuestLog::Coalition)].complete, sizeof(packet.Data));
            break;
        default:
            break;
    }
}

GP_SERV_COMMAND_MISSION::OTHER::OTHER(const CCharEntity* PChar, MissionComplete log)
{
    auto& packet = this->data();

    packet.Port = static_cast<uint16_t>(log);
    switch (log)
    {
        case MissionComplete::Campaign1:
        {
            for (uint16 missionID = 256; missionID < 256; missionID++)
            {
                if (PChar->m_campaignLog.complete[missionID])
                {
                    packet.Data[(missionID % 256) / 32] |= (1u << (missionID % 32));
                }
            }
            break;
        }
        case MissionComplete::Campaign2:
        {
            for (uint16 missionID = 256; missionID < 512; missionID++)
            {
                if (PChar->m_campaignLog.complete[missionID])
                {
                    packet.Data[(missionID % 256) / 32] |= (1u << (missionID % 32));
                }
            }
            break;
        }
        case MissionComplete::Nations:
        {
            for (uint8 logID = static_cast<uint8_t>(MissionLog::Sandoria); logID <= static_cast<uint8_t>(MissionLog::Zilart); logID++)
            {
                for (uint8 questMissionID = 0; questMissionID < 64; questMissionID++)
                {
                    if (PChar->m_missionLog[logID].complete[questMissionID])
                    {
                        packet.Data[(logID * 2) + questMissionID / 32] |= (1u << (questMissionID % 32));
                    }
                }
            }
            break;
        }
        case MissionComplete::ToAU_WoTG:
        {
            // Pack TOAU missions
            for (uint8 missionID = 0; missionID < 64; missionID++)
            {
                if (PChar->m_missionLog[static_cast<uint8_t>(MissionLog::ToAU)].complete[missionID])
                {
                    packet.Data[missionID / 32] |= (1u << (missionID % 32));
                }
            }

            // Pack WOTG missions (offset by 2 uint32s)
            for (uint8 missionID = 0; missionID < 64; missionID++)
            {
                if (PChar->m_missionLog[static_cast<uint8_t>(MissionLog::WoTG)].complete[missionID])
                {
                    packet.Data[2 + missionID / 32] |= (1u << (missionID % 32));
                }
            }

            break;
        }
        default:
            break;
    }
}
