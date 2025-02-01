/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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

#include "fishingcontest.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <time.h>

#include "common/vana_time.h"
#include "lua/luautils.h"
#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

namespace
{
    // Cache containers for Contest data
    FishingContest                   CurrentFishingContest; // Currently active contest
    std::vector<FishingContestEntry> FishingContestEntries; // Currently active contest entries
    std::vector<FishingContestEntry> FakeContestEntries;    // Pre-established vector of placeholder entries
} // namespace

namespace fishingcontest
{
    // Contest Data: Sets
    void SetContestStatus(FISHING_CONTEST_STATUS newStatus)
    {
        // Confirm status is valid
        if (newStatus > FISHING_CONTEST_STATUS::CLOSED)
        {
            ShowWarning("Tried to set invalid fishing contest status.");
            return;
        }

        CurrentFishingContest.status = newStatus;
    }

    void SetContestCriteria(FISHING_CONTEST_CRITERIA newCriteria)
    {
        CurrentFishingContest.criteria = newCriteria;
    }

    void SetContestMeasure(FISHING_CONTEST_MEASURE newMeasure)
    {
        CurrentFishingContest.measure = newMeasure;
    }

    void SetContestFish(uint16 newFish)
    {
        CurrentFishingContest.fishId = newFish;
    }

    void SetContestStartTime(uint32 startTime)
    {
        CurrentFishingContest.startTime = startTime;
    }

    void SetContestChangeTime(uint32 changeTime)
    {
        CurrentFishingContest.changeTime = changeTime;
    }

    // Contest Data: Gets
    auto GetContestStatus() -> FISHING_CONTEST_STATUS
    {
        return CurrentFishingContest.status;
    }

    auto GetContestCriteria() -> FISHING_CONTEST_CRITERIA
    {
        return CurrentFishingContest.criteria;
    }

    auto GetContestMeasure() -> FISHING_CONTEST_MEASURE
    {
        return CurrentFishingContest.measure;
    }

    uint16 GetContestFish()
    {
        return CurrentFishingContest.fishId;
    }

    uint32 GetContestStartTime()
    {
        return CurrentFishingContest.startTime;
    }

    uint32 GetContestChangeTime()
    {
        return CurrentFishingContest.changeTime;
    }

    // Contest Control
    void ProgressContest()
    {
        /***********************************************
         *  Update the phase of the fishing contest
         *  See enum FISHING_CONTEST_STATUS in fishingutils.h
         *  CALLED BY ZONE TICK IN SELBINA - DO NOT ADD TO FUNCTION
         ***********************************************/
        if (CurrentFishingContest.status == FISHING_CONTEST_STATUS::CLOSED)
        {
            // If we need to open a closed contest, we use the InitNewContest function.
            // If it was set to closed to pause it, use the SetContestStatus function.
            return;
        }

        uint32 currentTime = CVanaTime::getInstance()->getSysTime();
        if (currentTime > CurrentFishingContest.changeTime)
        {
            FISHING_CONTEST_STATUS newStatus = static_cast<FISHING_CONTEST_STATUS>((static_cast<int>(CurrentFishingContest.status) + 1) % static_cast<int>(FISHING_CONTEST_STATUS::CLOSED));

            // Score the contest as it closes. This will ensure data is up to date
            // History is unavailable to the player until in PRESENTING mode
            if (newStatus == FISHING_CONTEST_STATUS::RELEASING)
            {
                ScoreContest();
                UpdateRankingHistory();
            }

            if (newStatus == FISHING_CONTEST_STATUS::CONTESTING)
            {
                InitNewContest();
            }
            else
            {
                SetContestStatus(newStatus);
            }

            // When the contest goes into presenting mode, we need placeholder entries if there are fewer than 15 entries
            if (newStatus == FISHING_CONTEST_STATUS::PRESENTING)
            {
                FakeContestEntries.clear();
                BuildPlaceholderEntries();
            }

            SetContestChangeTime(GetStageChangeTime(newStatus, currentTime));

            auto onStageProgress = lua["xi"]["fishingContest"]["onStageProgress"];
            if (!onStageProgress.valid())
            {
                sol::error err = onStageProgress;
                ShowError("fishingcontest:onStageProgress: %s", err.what());
                return;
            }
            auto result = onStageProgress(newStatus);
            if (!result.valid())
            {
                sol::error err = result;
                ShowError("fishingcontest:ProgressContest:(onStageProgress): %s", err.what());
                return;
            }

            WriteContestData();
        }
    }

    void UpdateRankingHistory()
    {
        // This should only be run once per contest, once the contest progresses from "Releasing" to "Presenting"
        // Traverse the entries and update the database for each player
        for (auto& entry : FishingContestEntries)
        {
            // Get the Player ID
            uint32 charID = charutils::getCharIdFromName(entry.name);

            if (charID > 0)
            {
                // Get the rank for column header
                uint8 rankGroup = 0;
                if (entry.contestRank > 0 && entry.contestRank <= 4)
                {
                    rankGroup = entry.contestRank;
                }
                else if (entry.contestRank > 4 && entry.contestRank <= 10)
                {
                    rankGroup = 4;
                }

                // Set the rank value
                if (rankGroup > 0)
                {
                    const auto query = fmt::format("INSERT INTO char_fishing_contest_history (charid, contest_rank_{}) "
                                                   "VALUES ({}, 1) ON DUPLICATE KEY UPDATE contest_rank_{} = contest_rank_{} + 1",
                                                   rankGroup, charID, rankGroup, rankGroup);

                    auto rset = db::query(query);
                    if (!rset)
                    {
                        ShowWarning("Unable to update player [%s] fishing reward history.", entry.name);
                    }
                }
            }
        }
    }

    void ScoreContest()
    {
        TracyZoneScoped;

        // Sort the list first
        // clang-format off
        std::sort(FishingContestEntries.begin(), FishingContestEntries.end(), [](auto&& a, auto&& b) -> bool
        {
            if (CurrentFishingContest.measure == FISHING_CONTEST_MEASURE::GREATEST)
            {
                return a.score == b.score ? a.submitTime < b.submitTime : a.score > b.score;
            }
            else
            {
                return a.score == b.score ? a.submitTime < b.submitTime : b.score > a.score;
            }
        });
        // clang-format on

        // Apply Rankings
        // Iterate over the vector and apply the contestRank value
        uint8  contestRank = 1;
        uint8  prevrank    = 1;
        uint32 score       = 0;

        // Apply the rank scores to the list
        for (auto&& entry : FishingContestEntries)
        {
            if (entry.score != score) // Regardless of increasing or decreasing ... Vector already sorted
            {
                entry.contestRank = contestRank;
                prevrank          = contestRank;
                score             = entry.score; // Update the ongoing score "tally"
            }
            else // Scores are matches so we have to share rank values
            {
                entry.contestRank = prevrank;
            }

            // Set the number of times the score appears and copy it to dataset a and b
            // clang-format off
            entry.share   = std::count_if(FishingContestEntries.begin(), FishingContestEntries.end(), [&score](auto& a) -> bool
            {
                return a.score == score;
            });
            // clang-format on

            entry.dataset_b   = entry.share; // Duplicated.  Uncertain as to definition
            entry.resultCount = FishingRankEntryCount();
            contestRank++;

            // Update the database
            WriteContestEntryData(&entry);
        }
    }

    uint32 GetStageChangeTime(FISHING_CONTEST_STATUS stage, uint32 stageStartTime)
    {
        auto getStageTime = lua["xi"]["fishingContest"]["getStageChangeTime"];
        if (!getStageTime.valid())
        {
            sol::error err = getStageTime;
            ShowError("fishingcontest:GetStageChangeTime: %s", err.what());
            return 0xFFFFFFFF;
        }

        auto result = getStageTime(stage, stageStartTime);
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("fishingcontest:GetStageChangeTime:(getStageTime): %s", err.what());
            return 0xFFFFFFFF;
        }

        return (uint32)result;
    }

    // Contest Entries
    FishingContestEntry* GetFishRankEntry(uint8 position)
    {
        // We should only return a valid entry to a player if the contest is in a state of releasing results
        // But we can also return them for GMs or support requests if we want to see the current table entries

        // If we have an entry already included, use it
        if (position < FishingContestEntries.size())
        {
            return &FishingContestEntries[position];
        }
        else if (position >= FishingContestEntries.size() &&
                 !FakeContestEntries.empty())
        {
            // This entire block is used to pad the fishing entries table if there are fewer than 15 entries
            // Used modulo as a failsafe in case entry number exceeds the number of fake entries (should never happen)
            return &FakeContestEntries[(position - FishingContestEntries.size()) % FakeContestEntries.size()];
        }

        return nullptr;
    }

    FishingContestEntry* GetPlayerEntry(CCharEntity* PChar)
    {
        for (auto&& entry : FishingContestEntries)
        {
            // Set the rank value
            if (strcmp(PChar->name.c_str(), entry.name) == 0)
            {
                return &entry;
            }
        }

        return nullptr;
    }

    uint8 FishingRankEntryCount()
    {
        // Client allows for viewing of a max of 100 entries.
        return std::min(static_cast<int>(FishingContestEntries.size()), 100);
    }

    // Data storage
    bool WriteContestData()
    {
        // If any criteria are invalid, then do not update the db
        if (!CurrentFishingContest.isValid())
        {
            ShowDebug("Contest data invalid.  Ignoring database write.");
            return false;
        }

        // Update the DB with the current contest data (in case the contest is changed)
        const char* Query = "UPDATE `fishing_contest` SET "
                            "status = (?), "       // Status
                            "criteria = (?), "     // Criteria
                            "measure = (?), "      // Measure
                            "fishid = (?), "       // Fish ID
                            "starttime = (?), "    // Start Time
                            "nextstagetime = (?)"; // Stage Change Time

        auto rset = db::preparedStmt(Query, static_cast<uint8>(CurrentFishingContest.status),
                                     static_cast<uint8>(CurrentFishingContest.criteria),
                                     static_cast<uint8>(CurrentFishingContest.measure),
                                     CurrentFishingContest.fishId,
                                     CurrentFishingContest.startTime,
                                     CurrentFishingContest.changeTime);

        if (!rset)
        {
            ShowDebug("Error writing fishing contest data to database.");
            return false;
        }

        return true;
    }

    bool WriteInitialContestData()
    {
        // If any criteria are invalid, then do not update the db
        if (!CurrentFishingContest.isValid())
        {
            ShowDebug("Contest data invalid.  Ignoring database write.");
            return false;
        }

        // Update the DB with the current contest data (in case the contest is changed)
        std::string Query = "INSERT INTO `fishing_contest` VALUES ("
                            "(?), " // Status
                            "(?), " // Criteria
                            "(?), " // Measure
                            "(?), " // Fish ID
                            "(?), " // Start Time
                            "(?))"; // Stage Change Time

        auto rset = db::preparedStmt(Query, static_cast<uint8>(CurrentFishingContest.status),
                                     static_cast<uint8>(CurrentFishingContest.criteria),
                                     static_cast<uint8>(CurrentFishingContest.measure),
                                     CurrentFishingContest.fishId,
                                     CurrentFishingContest.startTime,
                                     CurrentFishingContest.changeTime);

        if (!rset)
        {
            ShowDebug("Error writing fishing contest data to database.");
            return false;
        }

        return true;
    }

    bool WriteContestEntryData(FishingContestEntry* entry)
    {
        if (entry == nullptr)
        {
            ShowWarning("Attemped to write fishing contest entry from a nullptr.");
            return false;
        }

        if (CurrentFishingContest.status >= FISHING_CONTEST_STATUS::PRESENTING)
        {
            // Do not allow these replacements once in presenting mode as it will remove tracking for claimed rewards
            ShowWarning("Attempted to add entry data after contest closure. Player: %s", entry->name);
            return false;
        }

        // Update the DB with the current contest entries
        const auto query = fmt::format("REPLACE INTO `fishing_contest_entries` "
                                       "(charid, mjob, sjob, mlevel, slevel, race, allegiance, fishRank, score, submitTime, contestRank, share) "
                                       "SELECT charid, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {} "
                                       "FROM chars WHERE charname = '{}'",
                                       entry->mjob,
                                       entry->sjob,
                                       entry->mlvl,
                                       entry->slvl,
                                       entry->race,
                                       entry->allegiance,
                                       entry->fishRank,
                                       entry->score,
                                       entry->submitTime,
                                       entry->contestRank,
                                       entry->share,
                                       entry->name);

        const auto rset = db::query(query);
        if (!rset)
        {
            ShowDebug("Error writing fishing contest data to database.");
            return false;
        }

        return true;
    }

    // Player Utils
    bool SubmitFish(CCharEntity* PChar, uint32 score)
    {
        // Check to see if the player has already submitted a fish
        for (int it = 0; it < (int)FishingContestEntries.size(); it++)
        {
            if (std::strcmp(PChar->name.c_str(), FishingContestEntries[it].name) == 0)
            {
                FishingContestEntries.erase(FishingContestEntries.begin() + it);
                break;
            }
        }

        // Fill out the entry with the current data
        FishingContestEntry entry;

        std::strncpy(entry.name, PChar->name.c_str(), PChar->name.size());
        entry.mjob        = (uint8)PChar->GetMJob();
        entry.sjob        = (uint8)PChar->GetSJob();
        entry.mlvl        = PChar->GetMLevel();
        entry.slvl        = PChar->GetSLevel();
        entry.race        = PChar->mainlook.race;
        entry.allegiance  = (uint8)PChar->allegiance;
        entry.fishRank    = PChar->RealSkills.rank[SKILLTYPE::SKILL_FISHING];
        entry.score       = score;
        entry.submitTime  = CVanaTime::getInstance()->getVanaTime();
        entry.contestRank = 0;
        entry.share       = 0;
        entry.dataset_b   = 0;

        // Update the database
        if (WriteContestEntryData(&entry))
        {
            FishingContestEntries.push_back(entry);
            return true;
        }

        return false;
    }

    bool WithdrawFish(CCharEntity* PChar)
    {
        FishingContestEntry* PEntry = GetPlayerEntry(PChar);

        if (PEntry != nullptr)
        {
            // Remove from the database
            const auto rset = db::preparedStmt("DELETE FROM fishing_contest_entries WHERE charid = ?", PChar->id);
            if (!rset)
            {
                ShowError("Failed to remove entry from fishing entry database.");
                return false;
            }

            // Remove from the in-memory vector
            // clang-format off
            auto it = std::find_if(FishingContestEntries.begin(), FishingContestEntries.end(), [&PChar](auto&& e) -> bool
            {
                return std::strcmp(PChar->name.c_str(), e.name) == 0;
            });
            // clang-format on

            if (it != FishingContestEntries.end())
            {
                int index = it - FishingContestEntries.begin();
                FishingContestEntries.erase(FishingContestEntries.begin() + index);
                return true;
            }
        }

        return false;
    }

    bool ClaimContestReward(CCharEntity* PChar)
    {
        if (PChar == nullptr)
        {
            ShowDebug("Attempted to issue contest reward to a null pointer character.");
            return false;
        }

        if (CurrentFishingContest.status != FISHING_CONTEST_STATUS::PRESENTING)
        {
            ShowDebug("Attempted to issue reward to player [%s] outside of 'Presenting' status.", PChar->getName());
            return false;
        }

        std::string Query = "UPDATE fishing_contest_entries "
                            "SET claimed = 1 "
                            "WHERE charid = (?)";

        auto rset = db::preparedStmt(Query, PChar->id);
        if (!rset)
        {
            ShowDebug("Unable to remove award on fishing contest for player %s.", PChar->getName());
            return false;
        }

        return true;
    }

    auto GetFishingContestHistory(CCharEntity* PChar) -> FishingContestHistory
    {
        // Build the struct, starting with an empty default of 0s if there are any issues
        FishingContestHistory history;

        if (PChar == nullptr)
        {
            ShowError("Attempted to retrieve Fishing Contest History on a null pointer.");
            return history;
        }

        std::string Query = "SELECT contest_rank_1, contest_rank_2, contest_rank_3, contest_rank_4 "
                            "FROM char_fishing_contest_history "
                            "WHERE charid = (?)";
        auto        rset  = db::preparedStmt(Query, PChar->id);

        if (rset && rset->rowsCount() > 0 && rset->next())
        {
            // If there is no char in the history table, this is fine
            // It means the player has never place, and will receive a table of 0s
            history.rank1 = rset->get<uint16>("contest_rank_1");
            history.rank2 = rset->get<uint16>("contest_rank_2");
            history.rank3 = rset->get<uint16>("contest_rank_3");
            history.rank4 = rset->get<uint16>("contest_rank_4");
        }

        return history;
    }

    // Initialization
    void InitNewContest()
    {
        // Select a random fish from the lua tables
        // This is only in lua to allow for flexibility in updating fish data
        auto selectContestFish = lua["xi"]["fishingContest"]["selectContestFish"];
        if (!selectContestFish.valid())
        {
            sol::error err = selectContestFish;
            ShowError("fishingcontest:InitNewContest: %s", err.what());
            return;
        }
        auto result = selectContestFish();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("fishingcontest:InitNewContest:(selectContestFish): %s", err.what());
            return;
        }

        // Randomize the criteria (length/weight/both) and measurement (greatest/smallest)
        FISHING_CONTEST_CRITERIA criteria = static_cast<FISHING_CONTEST_CRITERIA>(std::floor(xirand::GetRandomNumber(0, static_cast<int>(FISHING_CONTEST_CRITERIA::BOTH) + 1)));
        FISHING_CONTEST_MEASURE  measure  = static_cast<FISHING_CONTEST_MEASURE>(std::floor(xirand::GetRandomNumber(0, static_cast<int>(FISHING_CONTEST_MEASURE::SMALLEST) + 1)));

        InitNewContest((uint16)result, criteria, measure);
    }

    void InitNewContest(uint16 fishId, FISHING_CONTEST_CRITERIA criteria, FISHING_CONTEST_MEASURE measure)
    {
        // Clear any table data involving this contest
        {
            const auto rset = db::query("DELETE FROM `fishing_contest`");
            if (!rset)
            {
                ShowDebug("Error removing contest data.");
                return;
            }
        }

        // Clear the fishing contest entries from cache and database
        {
            FishingContestEntries.clear();
            const auto rset = db::query("DELETE FROM `fishing_contest_entries`");
            if (!rset)
            {
                ShowDebug("Error removing contest entry data.");
                return;
            }
        }

        // Clamp vars, just in case
        criteria = std::clamp(criteria, FISHING_CONTEST_CRITERIA::SIZE, FISHING_CONTEST_CRITERIA::BOTH);
        measure  = std::clamp(measure, FISHING_CONTEST_MEASURE::GREATEST, FISHING_CONTEST_MEASURE::SMALLEST);

        // Update the current contest data
        SetContestFish(fishId);
        SetContestCriteria(criteria);
        SetContestMeasure(measure);
        SetContestStartTime(CVanaTime::getInstance()->getSysTime());
        SetContestChangeTime(GetStageChangeTime(FISHING_CONTEST_STATUS::CONTESTING, CurrentFishingContest.startTime));
        SetContestStatus(FISHING_CONTEST_STATUS::CONTESTING);

        // Clear old data and store new data in the DB
        WriteInitialContestData();
    }

    void LoadContestParameters()
    {
        // load the overhead contest parameters
        std::string Query = "SELECT status, criteria, measure, fishid, starttime, nextstagetime "
                            "FROM fishing_contest";

        auto rset = db::preparedStmt(Query);

        if (rset && rset->rowsCount() > 0 && rset->next())
        {
            CurrentFishingContest.status     = static_cast<FISHING_CONTEST_STATUS>(rset->get<uint8>("status"));
            CurrentFishingContest.criteria   = static_cast<FISHING_CONTEST_CRITERIA>(rset->get<uint8>("criteria"));
            CurrentFishingContest.measure    = static_cast<FISHING_CONTEST_MEASURE>(rset->get<uint8>("measure"));
            CurrentFishingContest.fishId     = rset->get<uint16>("fishid");
            CurrentFishingContest.startTime  = rset->get<uint32>("starttime");
            CurrentFishingContest.changeTime = rset->get<uint32>("nextstagetime");
        }
        else if (rset->rowsCount() == 0)
        {
            // No contests found in the database, so we need to create one
            InitNewContest();
            ShowWarning("No Active Fishing Contest found in database.  Initializing new one.");
        }
    }

    void LoadContestEntries()
    {
        // load the current entry pool
        std::string Query = "SELECT "
                            "c.charname AS charname, "
                            "e.mjob AS mjob, "
                            "e.sjob AS sjob, "
                            "e.mlevel AS mlevel, "
                            "e.slevel AS slevel, "
                            "e.race AS race, "
                            "e.allegiance AS allegiance, "
                            "e.fishRank AS fishRank, "
                            "e.score AS score, "
                            "e.submitTime AS submitTime, "
                            "e.contestRank AS contestRank, "
                            "e.share AS share "
                            "FROM fishing_contest_entries e "
                            "LEFT JOIN chars c "
                            "ON c.charid = e.charid "
                            "ORDER BY contestRank";

        auto rset = db::preparedStmt(Query);

        if (rset && rset->rowsCount() > 0)
        {
            // Clear the current entry data
            FishingContestEntries.clear();

            while (rset->next())
            {
                FishingContestEntry entry;

                std::strncpy(entry.name, rset->get<std::string>("charname").c_str(), rset->get<std::string>("charname").size());

                entry.mjob        = rset->get<uint8>("mjob");
                entry.sjob        = rset->get<uint8>("sjob");
                entry.mlvl        = rset->get<uint8>("mlevel");
                entry.slvl        = rset->get<uint8>("slevel");
                entry.race        = rset->get<uint8>("race");
                entry.allegiance  = rset->get<uint8>("allegiance");
                entry.fishRank    = rset->get<uint8>("fishRank");
                entry.score       = rset->get<uint32>("score");
                entry.submitTime  = rset->get<uint32>("submitTime");
                entry.contestRank = rset->get<uint8>("contestRank");
                entry.share       = rset->get<uint8>("share");
                entry.dataset_b   = rset->get<uint8>("share");

                FishingContestEntries.push_back(entry);
            }
        }
    }

    void BuildPlaceholderEntries()
    {
        // This should only be built when the contest results are being presented
        if (CurrentFishingContest.status != FISHING_CONTEST_STATUS::PRESENTING)
        {
            return;
        }

        // The number of entries needed is always (max fake entries - num real entries)
        uint8 maxFakeEntries = settings::get<uint8>("main.MAX_FAKE_ENTRIES");
        uint8 numRealEntries = FishingRankEntryCount();

        if (numRealEntries >= maxFakeEntries)
        {
            // No fake entries required
            return;
        }

        uint8 entriesNeeded = maxFakeEntries - numRealEntries;
        int   jobLevels[]   = { 75, 60, 50, 40, 30 };

        // Fake entry number always starts at 1 and stops at # entries needed
        // The fake entries always score the worst possible values of either 1 or 9999 and work inwards
        // Fake Entry #1 always has the "best" possible score of these values
        // Smallest: (worst possible score - entries needed) + entry number
        // Largest:  (entries needed + 1) - entry number
        for (int fakeEntryNumber = 1; fakeEntryNumber <= maxFakeEntries; fakeEntryNumber++)
        {
            FishingContestEntry fakeEntry;

            // Build the entry based on generated data
            std::string fakeName = fmt::format(" SmallFisher{:02d} ", fakeEntryNumber);

            std::strncpy(fakeEntry.name, fakeName.c_str(), fakeName.size());
            fakeEntry.mjob        = ((fakeEntryNumber - 1) % 18) + 1;
            fakeEntry.sjob        = 0;
            fakeEntry.mlvl        = jobLevels[(fakeEntryNumber - 1) % 5];
            fakeEntry.slvl        = 0;
            fakeEntry.race        = ((fakeEntryNumber - 1) % 7) + 1;
            fakeEntry.allegiance  = ((fakeEntryNumber - 1) % 3);
            fakeEntry.fishRank    = 1; // Recruit
            fakeEntry.score       = CurrentFishingContest.measure == FISHING_CONTEST_MEASURE::SMALLEST ? (9999 - entriesNeeded + fakeEntryNumber) : (entriesNeeded + 1) - fakeEntryNumber;
            fakeEntry.submitTime  = 0;
            fakeEntry.contestRank = numRealEntries + fakeEntryNumber;

            FakeContestEntries.push_back(fakeEntry);
        }
    }

    void InitializeFishingContestSystem()
    {
        LoadContestParameters();
        LoadContestEntries();
        BuildPlaceholderEntries();
    }

} // namespace fishingcontest
