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

#ifndef _CQUESTMISSIONLOGPACKET_H
#define _CQUESTMISSIONLOGPACKET_H

#include "common/cbasetypes.h"
#include <unordered_map>

#include "basic.h"

// Quest/Mission Area Identifiers
#define QUESTS_SANDORIA  0
#define QUESTS_BASTOK    1
#define QUESTS_WINDURST  2
#define QUESTS_JEUNO     3
#define QUESTS_OTHER     4
#define QUESTS_OUTLANDS  5
#define QUESTS_TOAU      6
#define QUESTS_WOTG      7
#define QUESTS_ABYSSEA   8
#define QUESTS_ADOULIN   9
#define QUESTS_COALITION 10

#define MISSION_SANDORIA 0
#define MISSION_BASTOK   1
#define MISSION_WINDURST 2
#define MISSION_ZILART   3
#define MISSION_TOAU     4
#define MISSION_WOTG     5
#define MISSION_COP      6
#define MISSION_ASSAULT  7
#define MISSION_CAMPAIGN 8
#define MISSION_ACP      9
#define MISSION_AMK      10
#define MISSION_ASA      11
#define MISSION_SOA      12
#define MISSION_ROV      13

// Log Types
enum LOG_TYPE
{
    LOG_QUEST_CURRENT    = 1,
    LOG_QUEST_COMPLETE   = 2,
    LOG_MISSION_CURRENT  = 3,
    LOG_MISSION_COMPLETE = 4,
    LOG_CAMPAIGN_TWO     = 5,
};

// Quest Log Packet Values
static const std::unordered_map<uint8, std::pair<uint16, uint16>> questPacketBytes = {
    // Quest Log ID   , Current, Complete
    { QUESTS_SANDORIA, { 0x50, 0x90 } },
    { QUESTS_BASTOK, { 0x58, 0x98 } },
    { QUESTS_WINDURST, { 0x60, 0xA0 } },
    { QUESTS_JEUNO, { 0x68, 0xA8 } },
    { QUESTS_OTHER, { 0x70, 0xB0 } },
    { QUESTS_OUTLANDS, { 0x78, 0xB8 } },
    { QUESTS_TOAU, { 0x80, 0xC0 } },
    { QUESTS_WOTG, { 0x88, 0xC8 } },
    { QUESTS_ABYSSEA, { 0xE0, 0xE8 } },
    { QUESTS_ADOULIN, { 0xF0, 0xF8 } },
    { QUESTS_COALITION, { 0x0100, 0x0108 } },
};

// Mission Log Packet Bytes
#define MISSION_CURRENT            0xFFFF
#define MISSION_COMPLETE           0xD0
#define TOAU_WOTG_MISSION_CURRENT  0x80
#define TOAU_WOTG_MISSION_COMPLETE 0xD8
#define ASSAULT_COMPLETE           0xC0
#define CAMPAIGN_MISSION_ONE       0x30
#define CAMPAIGN_MISSION_TWO       0x38

class CCharEntity;

class CQuestMissionLogPacket : public CBasicPacket
{
public:
    CQuestMissionLogPacket(CCharEntity* PChar, uint8 logID, LOG_TYPE logType);

private:
    // I moved the formation of packages into separate functions, especially for those
    // who wants to understand what actually happens in switch(logID)

    void generateQuestPacket(CCharEntity* PChar, uint8 logID, LOG_TYPE logType);
    void generateCurrentMissionPacket(CCharEntity* PChar);
    void generateCompleteMissionPacket(CCharEntity* PChar);
    void generateCurrentExpMissionPacket(CCharEntity* PChar);
    void generateCompleteExpMissionPacket(CCharEntity* PChar);
    void generateCampaignMissionPacket(CCharEntity* PChar, uint8 startQMID);
    void generateAssaultMissionPacket(CCharEntity* PChar);
};

#endif
