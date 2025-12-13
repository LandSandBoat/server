/*
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

#include "roe.h"

#include "common/timer.h"
#include "enums/chat_message_type.h"
#include "lua/luautils.h"
#include "map_engine.h"
#include "packets/s2c/0x017_chat_std.h"
#include "packets/s2c/0x029_battle_message.h"
#include "utils/charutils.h"
#include "utils/zoneutils.h"

#include "packets/s2c/0x0aa_magic_data.h"
#include "packets/s2c/0x111_roe_activelog.h"
#include "packets/s2c/0x112_roe_log.h"

#define ROE_CACHETIME 15s

std::array<RoeCheckHandler, ROE_NONE> RoeHandlers;
RoeSystemData                         roeutils::RoeSystem;

void SaveEminenceDataNice(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (PChar->m_eminenceCache.lastWriteout < timer::now() - ROE_CACHETIME)
    {
        charutils::SaveEminenceData(PChar);
    }
}

void call_onRecordTrigger(CCharEntity* PChar, uint16 recordID, const RoeDatagramList& payload)
{
    TracyZoneScoped;
    // TODO: Move this Lua interaction into luautils
    auto onRecordTrigger = lua["xi"]["roe"]["onRecordTrigger"];
    if (!onRecordTrigger.valid())
    {
        sol::error err = onRecordTrigger;
        ShowError("roeutils::onRecordTrigger: record %d: %s.", recordID, err.what());
        return;
    }

    // Create param table
    auto params        = lua.create_table();
    params["progress"] = roeutils::GetEminenceRecordProgress(PChar, recordID);

    for (auto& datagram : payload) // Append datagrams to param table
    {
        if (auto value = std::get_if<uint32>(&datagram.data))
        {
            params[datagram.luaKey] = *value;
        }
        else if (auto PMob = std::get_if<CMobEntity*>(&datagram.data))
        {
            params[datagram.luaKey] = *PMob;
        }
        else if (auto text = std::get_if<std::string>(&datagram.data))
        {
            params[datagram.luaKey] = text;
        }
        else
        {
            ShowWarning("roeutils::onRecordTrigger: Unhandled payload type for '%s' with record #%d.", datagram.luaKey, recordID);
        }
    }

    // Call
    auto result = onRecordTrigger(PChar, recordID, params);
    if (!result.valid())
    {
        sol::error err = result;
        ShowError("roeutils::onRecordTrigger: %s", err.what());
    }
}

namespace roeutils
{

void ParseRecords(const sol::table& records_table)
{
    TracyZoneScoped;
    RoeHandlers.fill(RoeCheckHandler());
    roeutils::RoeSystem.ImplementedRecords.reset();
    roeutils::RoeSystem.RepeatableRecords.reset();
    roeutils::RoeSystem.RetroactiveRecords.reset();
    roeutils::RoeSystem.HiddenRecords.reset();
    roeutils::RoeSystem.DailyRecords.reset();
    roeutils::RoeSystem.DailyRecordIDs.clear();
    roeutils::RoeSystem.NotifyThresholds.fill(1);

    // TODO: Move this Lua interaction into luautils
    for (auto& entry : records_table)
    {
        // Set Implemented bit.
        uint16 recordID = entry.first.as<uint16>();
        auto   table    = entry.second.as<sol::table>();

        roeutils::RoeSystem.ImplementedRecords.set(recordID);

        // Register Trigger Handler
        if (table["trigger"].valid())
        {
            uint32 trigger = table["trigger"].get<uint32>();
            if (trigger > 0 && trigger < ROE_NONE)
            {
                RoeHandlers[trigger].bitmap.set(recordID);
            }
            else
            {
                ShowError("ROEUtils: Unknown Record trigger index %d for record %d.", trigger, recordID);
            }
        }

        // Set notification threshold
        if (table["notify"].valid())
        {
            roeutils::RoeSystem.NotifyThresholds[recordID] = table["notify"].get<uint32>();
        }

        // Set flags
        auto flags = table["flags"].get<sol::table>();
        if (flags.valid())
        {
            for (auto& flag_entry : flags)
            {
                // TODO: This only runs once on load, so it's okay for now, but it is
                //       getting kind of ugly and could probably be improved later.
                std::string flag = flag_entry.first.as<std::string>();
                if (flag == "daily")
                {
                    roeutils::RoeSystem.DailyRecords.set(recordID);
                    roeutils::RoeSystem.DailyRecordIDs.emplace_back(recordID);
                }
                else if (flag == "weekly")
                {
                    roeutils::RoeSystem.WeeklyRecords.set(recordID);
                    roeutils::RoeSystem.WeeklyRecordIDs.emplace_back(recordID);
                }
                else if (flag == "unity")
                {
                    roeutils::RoeSystem.UnityRecords.set(recordID);
                    roeutils::RoeSystem.UnityRecordIDs.emplace_back(recordID);
                }
                else if (flag == "timed")
                {
                    roeutils::RoeSystem.TimedRecords.set(recordID);
                }
                else if (flag == "repeat")
                {
                    roeutils::RoeSystem.RepeatableRecords.set(recordID);
                }
                else if (flag == "retro")
                {
                    roeutils::RoeSystem.RetroactiveRecords.set(recordID);
                }
                else if (flag == "hidden")
                {
                    roeutils::RoeSystem.HiddenRecords.set(recordID);
                }
                else
                {
                    ShowError("ROEUtils: Unknown flag %s for record #%d.", flag, recordID);
                }
            }
        }
    }
}

void ParseTimedSchedule(const sol::table& schedule_table)
{
    TracyZoneScoped;
    roeutils::RoeSystem.TimedRecords.reset();
    roeutils::RoeSystem.TimedRecordTable.fill(RecordTimetable_D{});

    for (auto& entry : schedule_table)
    {
        uint8 day       = entry.first.as<uint8>() - 1;
        auto  timeslots = entry.second.as<sol::table>();
        for (const auto& slot_entry : timeslots)
        {
            auto   block    = slot_entry.first.as<uint16>() - 1;
            uint16 recordID = slot_entry.second.as<uint16>();

            roeutils::RoeSystem.TimedRecordTable.at(day).at(block) = recordID;
        }
    }
}

bool event(ROE_EVENT eventID, CCharEntity* PChar, const RoeDatagramList& payload)
{
    TracyZoneScoped;
    if (!settings::get<bool>("main.ENABLE_ROE") || !PChar || PChar->objtype != TYPE_PC)
    {
        return false;
    }

    RoeCheckHandler& handler = RoeHandlers[eventID];

    // Bail if player has no records of this type.
    if ((PChar->m_eminenceCache.activemap & handler.bitmap).none())
    {
        return false;
    }

    // Call onRecordTrigger for each record of this type
    for (int i = 0; i < 31; i++)
    {
        // Check record is of this type
        if (uint16 recordID = PChar->m_eminenceLog.active[i]; handler.bitmap.test(recordID))
        {
            call_onRecordTrigger(PChar, recordID, payload);
        }
    }

    return true;
}

bool event(ROE_EVENT eventID, CCharEntity* PChar, const RoeDatagram& data) // shorthand for single-datagram calls.
{
    TracyZoneScoped;
    return event(eventID, PChar, RoeDatagramList{ data });
}

void SetEminenceRecordCompletion(CCharEntity* PChar, uint16 recordID, bool newStatus)
{
    TracyZoneScoped;
    uint16 page = recordID / 8;
    uint8  bit  = recordID % 8;
    if (newStatus)
    {
        PChar->m_eminenceLog.complete[page] |= (1 << bit);
    }
    else
    {
        PChar->m_eminenceLog.complete[page] &= ~(1 << bit);
    }

    for (int i = 0; i < 4; i++)
    {
        PChar->pushPacket<GP_SERV_COMMAND_ROE_LOG>(PChar, i);
    }

    charutils::SaveEminenceData(PChar);
}

bool GetEminenceRecordCompletion(const CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    const uint16 page = recordID / 8;
    const uint8  bit  = recordID % 8;
    return PChar->m_eminenceLog.complete[page] & (1 << bit);
}

uint16 GetNumEminenceCompleted(CCharEntity* PChar)
{
    TracyZoneScoped;
    uint16 completedCount{ 0 };

    for (uint16 page = 0; page < 512; page++)
    {
        unsigned long bitIndex{ 0 };
        uint8         pageVal = PChar->m_eminenceLog.complete[page];
        // Strip off and check only the set bits - Hidden records are not counted.
        while (pageVal)
        {
#ifdef _MSC_VER
            _BitScanForward(&bitIndex, pageVal);
#else
            bitIndex = __builtin_ctz(pageVal);
#endif
            completedCount += !RoeSystem.HiddenRecords.test(page * 8 + bitIndex);
            pageVal &= (pageVal - 1);
        }
    }

    return completedCount;
}

bool AddEminenceRecord(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    // We deny taking records which aren't implemented in the Lua
    if (!roeutils::RoeSystem.ImplementedRecords.test(recordID))
    {
        std::string message = "The record #" + std::to_string(recordID) + " is not implemented at this time.";
        PChar->pushPacket<GP_SERV_COMMAND_CHAT_STD>(PChar, MESSAGE_NS_SAY, message, "RoE System");
        return false;
    }

    // There used to be packet injection prevention code here, but it is now part of the packet handler

    for (int i = 0; i < 30; i++)
    {
        if (PChar->m_eminenceLog.active[i] == 0)
        {
            PChar->m_eminenceLog.active[i] = recordID;
            PChar->m_eminenceCache.activemap.set(recordID);

            PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);
            PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, recordID, 0, MsgBasic::ROE_START);
            charutils::SaveEminenceData(PChar);
            return true;
        }
        else if (PChar->m_eminenceLog.active[i] == recordID)
        {
            return false;
        }
    }
    return false;
}

bool DelEminenceRecord(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    for (int i = 0; i < 30; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            PChar->m_eminenceLog.active[i]   = 0;
            PChar->m_eminenceLog.progress[i] = 0;
            PChar->m_eminenceCache.activemap.reset(recordID);
            // Shift entries up so records are shown in retail-accurate order.
            for (int j = i; j < 29 && PChar->m_eminenceLog.active[j + 1] != 0; j++)
            {
                std::swap(PChar->m_eminenceLog.active[j], PChar->m_eminenceLog.active[j + 1]);
                std::swap(PChar->m_eminenceLog.progress[j], PChar->m_eminenceLog.progress[j + 1]);
            }
            PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);
            charutils::SaveEminenceData(PChar);
            return true;
        }
    }
    return false;
}

bool HasEminenceRecord(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    return PChar->m_eminenceCache.activemap.test(recordID);
}

uint32 GetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    for (int i = 0; i < 31; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            return PChar->m_eminenceLog.progress[i];
        }
    }
    return 0;
}

bool SetEminenceRecordProgress(CCharEntity* PChar, uint16 recordID, uint32 progress)
{
    TracyZoneScoped;
    for (int i = 0; i < 31; i++)
    {
        if (PChar->m_eminenceLog.active[i] == recordID)
        {
            if (PChar->m_eminenceLog.progress[i] == progress)
            {
                return true;
            }

            PChar->m_eminenceLog.progress[i] = progress;
            PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);
            SaveEminenceDataNice(PChar);
            return true;
        }
    }
    return false;
}

void UpdateUnityTrust(CCharEntity* PChar, bool sendUpdate)
{
    TracyZoneScoped;
    int32  curPoints        = charutils::GetPoints(PChar, "prev_accolades") / 1000;
    int32  prevPoints       = charutils::GetPoints(PChar, "current_accolades") / 1000;
    uint16 unityLeaderTrust = (PChar->profile.unity_leader > 0) ? ROE_TRUST_ID[PChar->profile.unity_leader - 1] : 0;

    if (unityLeaderTrust > 0)
    {
        if (curPoints >= 5 || prevPoints >= 5)
        {
            charutils::addSpell(PChar, unityLeaderTrust);
            charutils::SaveSpell(PChar, unityLeaderTrust);
        }
        else
        {
            charutils::delSpell(PChar, unityLeaderTrust);
            charutils::DeleteSpell(PChar, unityLeaderTrust);
        }
    }

    if (sendUpdate)
    {
        PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(PChar);
    }
}

void onCharLoad(CCharEntity* PChar)
{
    TracyZoneScoped;
    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    // Build eminence lookup map
    for (unsigned short record : PChar->m_eminenceLog.active)
    {
        if (record)
        {
            PChar->m_eminenceCache.activemap.set(record);
        }
    }

    // Only chars with First Step Forward complete can get timed/daily records
    if (GetEminenceRecordCompletion(PChar, 1))
    {
        auto currentTime     = earth_time::now();
        auto lastJstMidnight = earth_time::jst::get_next_midnight(currentTime) - 24h; // Most recent JST midnight

        { // Daily Reset
            if (PChar->lastOnline < lastJstMidnight)
            {
                ClearDailyRecords(PChar);
            }
        }

        { // Weekly Reset
            auto lastWeeklyReset = earth_time::get_next_game_week(currentTime) - std::chrono::days(7);
            if (PChar->lastOnline < lastWeeklyReset)
            {
                ClearWeeklyRecords(PChar);

                auto prevLastWeeklyReset = lastWeeklyReset - std::chrono::days(7);
                if (PChar->lastOnline < prevLastWeeklyReset)
                {
                    charutils::SetPoints(PChar, "prev_accolades", 0);
                }
            }
        }

        { // 4hr Reset
            uint8 currentBlock      = static_cast<uint8>(earth_time::jst::get_hour(currentTime) / 4);
            auto  lastJstTimedBlock = lastJstMidnight + std::chrono::hours(currentBlock * 4); // Start of the current 4-hr block

            if (PChar->lastOnline < lastJstTimedBlock || PChar->m_eminenceLog.active[30] != GetActiveTimedRecord())
            {
                PChar->m_eminenceCache.notifyTimedRecord = static_cast<bool>(GetActiveTimedRecord());
                AddActiveTimedRecord(PChar);
            }
        }
    }
}

void onRecordTake(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    if (RoeSystem.RetroactiveRecords.test(recordID))
    {
        call_onRecordTrigger(PChar, recordID, RoeDatagramList{});
    }
    return;
}

bool onRecordClaim(CCharEntity* PChar, uint16 recordID)
{
    TracyZoneScoped;
    if (roeutils::HasEminenceRecord(PChar, recordID))
    {
        call_onRecordTrigger(PChar, recordID, RoeDatagramList{ RoeDatagram("claim", 1) });
        return true;
    }
    return false;
}

uint16 GetActiveTimedRecord()
{
    TracyZoneScoped;
    auto  currentTime = earth_time::now();
    uint8 day         = static_cast<uint8>(earth_time::jst::get_weekday(currentTime));
    uint8 block       = static_cast<uint8>(earth_time::jst::get_hour(currentTime) / 4);
    return RoeSystem.TimedRecordTable[day][block];
}

void AddActiveTimedRecord(CCharEntity* PChar)
{
    TracyZoneScoped;
    // Clear old timed entries from log
    PChar->m_eminenceLog.progress[30] = 0;
    PChar->m_eminenceCache.activemap &= ~RoeSystem.TimedRecords;

    // Add current timed record to slot 31
    auto timedRecordID              = GetActiveTimedRecord();
    PChar->m_eminenceLog.active[30] = timedRecordID;
    PChar->m_eminenceCache.activemap.set(timedRecordID);
    PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);

    if (timedRecordID)
    {
        PChar->pushPacket<GP_SERV_COMMAND_BATTLE_MESSAGE>(PChar, PChar, timedRecordID, 0, MsgBasic::ROE_TIMED);
        SetEminenceRecordCompletion(PChar, timedRecordID, false);
    }
}

void ClearDailyRecords(CCharEntity* PChar)
{
    TracyZoneScoped;
    // Set daily record progress to 0
    for (int i = 0; i < 30; i++)
    {
        if (auto recordID = PChar->m_eminenceLog.active[i]; RoeSystem.DailyRecords.test(recordID))
        {
            PChar->m_eminenceLog.progress[i] = 0;
        }
    }
    PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);

    // Set completion for daily records to 0
    for (auto record : RoeSystem.DailyRecordIDs)
    {
        uint16 page = record / 8;
        uint8  bit  = record % 8;
        PChar->m_eminenceLog.complete[page] &= ~(1 << bit);
    }

    // Set completion for Unity Records, but maintain progress on active
    for (auto record : RoeSystem.UnityRecordIDs)
    {
        uint16 page = record / 8;
        uint8  bit  = record % 8;
        PChar->m_eminenceLog.complete[page] &= ~(1 << bit);
    }

    charutils::SaveEminenceData(PChar);

    for (int i = 0; i < 4; i++)
    {
        PChar->pushPacket<GP_SERV_COMMAND_ROE_LOG>(PChar, i);
    }
}

void CycleTimedRecords()
{
    TracyZoneScoped;
    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
                if (GetEminenceRecordCompletion(PChar, 1))
                {
                    AddActiveTimedRecord(PChar);
                }
            });
        });
    // clang-format on
}

void CycleDailyRecords()
{
    TracyZoneScoped;
    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
                ClearDailyRecords(PChar);
            });
        });
    // clang-format on
}

void ClearWeeklyRecords(CCharEntity* PChar)
{
    TracyZoneScoped;
    // Set daily record progress to 0
    for (int i = 0; i < 30; i++)
    {
        if (auto recordID = PChar->m_eminenceLog.active[i]; RoeSystem.WeeklyRecords.test(recordID))
        {
            PChar->m_eminenceLog.progress[i] = 0;
        }
    }
    PChar->pushPacket<GP_SERV_COMMAND_ROE_ACTIVELOG>(PChar);

    // Set completion for daily records to 0
    for (auto record : RoeSystem.WeeklyRecordIDs)
    {
        uint16 page = record / 8;
        uint8  bit  = record % 8;
        PChar->m_eminenceLog.complete[page] &= ~(1 << bit);
    }

    charutils::SaveEminenceData(PChar);
    PChar->setCharVar("weekly_sparks_spent", 0);
    PChar->setCharVar("weekly_accolades_spent", 0);
    PChar->setCharVar("unity_changed", 0);

    int32 currentAccolades = charutils::GetPoints(PChar, "current_accolades");
    charutils::SetPoints(PChar, "prev_accolades", currentAccolades);
    charutils::SetPoints(PChar, "current_accolades", 0);

    UpdateUnityTrust(PChar);

    for (int i = 0; i < 4; i++)
    {
        PChar->pushPacket<GP_SERV_COMMAND_ROE_LOG>(PChar, i);
    }
}

void CycleWeeklyRecords()
{
    TracyZoneScoped;
    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    // clang-format off
        zoneutils::ForEachZone([](CZone* PZone)
        {
            PZone->ForEachChar([](CCharEntity* PChar)
            {
                ClearWeeklyRecords(PChar);
            });
        });
    // clang-format on
}

// Weekly Ranking Reset
void CycleUnityRankings()
{
    TracyZoneScoped;

    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    db::preparedStmt("UPDATE unity_system "
                     "SET members_prev = members_current, points_prev = points_current, members_current = 0, points_current = 0");
}

void UpdateUnityRankings()
{
    TracyZoneScoped;

    if (!settings::get<bool>("main.ENABLE_ROE"))
    {
        return;
    }

    db::preparedStmt("UPDATE unity_system "
                     "JOIN (SELECT unity_leader, COUNT(*) AS members FROM char_profile GROUP BY unity_leader) "
                     "TMP ON unity_system.leader = unity_leader "
                     "SET unity_system.members_current = members");

    const auto rset = db::preparedStmt("SELECT leader, "
                                       "CASE WHEN members_prev = 0 THEN 0 ELSE FLOOR(points_prev/members_prev) END AS eval "
                                       "FROM unity_system "
                                       "ORDER BY eval DESC");

    uint8 currentRank = 1;
    uint8 rankGap     = 0;
    int32 prev_eval   = 0;

    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        auto new_eval = rset->get<int32>("eval");

        if (new_eval < prev_eval)
        {
            currentRank = currentRank + rankGap;
            rankGap     = 1;
        }
        else
        {
            rankGap++;
        }

        prev_eval = new_eval;

        roeutils::RoeSystem.unityLeaderRank[rset->get<int>("leader") - 1] = currentRank;
    }
}

} // namespace roeutils
