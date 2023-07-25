/*
 * roe.h
 *      Author: Kreidos | github.com/kreidos
 *
===========================================================================

  Copyright (c) 2020 Topaz Dev Teams

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

#ifndef SRC_MAP_ROE_H_
#define SRC_MAP_ROE_H_

#include <array>
#include <bitset>
#include <utility>
#include <variant>
#include <vector>

#include "ai/helpers/event_handler.h"
#include "common/cbasetypes.h"
#include "packets/weather.h"

class CItemContainer;

class CBaseEntity;

enum ROE_EVENT
{
    ROE_MOBKILL             = 1,
    ROE_WSKILL_USE          = 2,
    ROE_LOOTITEM            = 3,
    ROE_SYNTHSUCCESS        = 4,
    ROE_DMGTAKEN            = 5,
    ROE_DMGDEALT            = 6,
    ROE_EXPGAIN             = 7,
    ROE_HEALALLY            = 8,
    ROE_BUFFALLY            = 9,
    ROE_LEVELUP             = 10,
    ROE_QUEST_COMPLETE      = 11,
    ROE_MISSION_COMPLETE    = 12,
    ROE_HELMSUCCESS         = 13,
    ROE_CHOCOBO_DIG_SUCCESS = 14,
    ROE_UNITY_CHAT          = 15,
    ROE_MAGICBURST          = 16,
    ROE_HEAL_UNITYALLY      = 17,
    ROE_TALK_NPC            = 18,
    ROE_NONE // End of enum marker and OOB checkpost. Do not move or remove, place any new types above.
};

const uint16 ROE_TRUST_ID[11] = {
    953,  // Pieuje
    1005, // Ayame
    954,  // Invincible Shield
    955,  // Apururu
    1006, // Maat
    1007, // Aldo
    956,  // Jakoh Wahcondalo
    1008, // Naja Salaheem
    957,  // Flaviria
    980,  // Yoran-Oran
    981   // Sylvie
};

typedef std::array<uint16, 6>            RecordTimetable_D;
typedef std::array<RecordTimetable_D, 7> RecordTimetable_W;
struct RoeSystemData
{
    RecordTimetable_W        TimedRecordTable;
    std::bitset<4096>        ImplementedRecords;
    std::bitset<4096>        RepeatableRecords;
    std::bitset<4096>        RetroactiveRecords;
    std::bitset<4096>        HiddenRecords;
    std::bitset<4096>        DailyRecords;
    std::vector<uint16>      DailyRecordIDs;
    std::bitset<4096>        WeeklyRecords;
    std::vector<uint16>      WeeklyRecordIDs;
    std::bitset<4096>        UnityRecords;
    std::vector<uint16>      UnityRecordIDs;
    std::bitset<4096>        TimedRecords;
    std::array<uint32, 4096> NotifyThresholds    = {};
    uint8                    unityLeaderRank[11] = {}; // 0..10 for Unity Leader, stores rank position

    RoeSystemData()
    {
        TimedRecordTable.fill(RecordTimetable_D{});
    }
};

struct RoeCheckHandler
{
    std::bitset<4096> bitmap;
};

extern std::array<RoeCheckHandler, ROE_NONE> RoeHandlers;

typedef std::variant<uint32, CMobEntity*, std::string> RoeDatagramPayload;

struct RoeDatagram
{
    std::string        luaKey;
    RoeDatagramPayload data;

    RoeDatagram(std::string const& param, uint32 payload)
    : luaKey{ param }
    , data{ payload }
    {
    }
    RoeDatagram(std::string const& param, CMobEntity* payload)
    : luaKey{ param }
    , data{ payload }
    {
    }
    RoeDatagram(std::string const& param, std::string const& payload)
    : luaKey{ param }
    , data{ payload }
    {
    }
};

typedef std::vector<RoeDatagram> RoeDatagramList;

namespace roeutils
{
    extern RoeSystemData RoeSystem;

    void init();
    void ParseRecords(sol::table const& records_table);
    void ParseTimedSchedule(sol::table const& schedule_table);

    bool event(ROE_EVENT eventID, CCharEntity* PChar, const RoeDatagramList& payload);
    bool event(ROE_EVENT eventID, CCharEntity* PChar, const RoeDatagram& payload);

    void   SetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID, bool newStatus);
    bool   GetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID);
    uint16 GetNumEminenceCompleted(CCharEntity* PChar);
    bool   AddEminenceRecord(CCharEntity* PChar, uint16 recordID);
    bool   DelEminenceRecord(CCharEntity* PChar, uint16 recordID);
    bool   HasEminenceRecord(CCharEntity* PChar, uint16 recordID);
    bool   SetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID, uint32 progress);
    uint32 GetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID);

    void onCharLoad(CCharEntity* PChar);
    bool onRecordClaim(CCharEntity* PChar, uint16 recordID);
    void onRecordTake(CCharEntity* PChar, uint16 recordID);

    void ClearDailyRecords(CCharEntity* PChar);
    void CycleDailyRecords();
    void ClearWeeklyRecords(CCharEntity* PChar);
    void CycleWeeklyRecords();
    void CycleUnityRankings();
    void UpdateUnityRankings();
    void UpdateUnityTrust(CCharEntity* PChar, bool sendUpdate = false);

    uint16 GetActiveTimedRecord();
    void   AddActiveTimedRecord(CCharEntity* PChar);
    void   CycleTimedRecords();

} // namespace roeutils

#endif /* SRC_MAP_ROE_H_ */
