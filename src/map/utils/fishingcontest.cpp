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

#include "fishingcontest.h"

#include <algorithm>
#include <cmath>
#include <cstring>
#include <time.h>

#include "charutils.h"
#include "itemutils.h"
#include "lua/luautils.h"
#include "vana_time.h"
#include "zoneutils.h"

namespace fishingcontest
{
    fishing_contest_t                FishingContest;        // Currently active contest
    std::vector<fish_ranking_entry*> FishingContestEntries; // Currently active contest entries

    // Contest Data: Sets
    void SetContestStatus(uint8 newStatus, bool isTest)
    {
        FishingContest.status = newStatus;

        if (isTest)
        {
            return; // Break here and don't udpate the changetimes
        }

        switch ((FISHINGCONTESTSTATUS)newStatus)
        {
            case CONTEST_STATUS_CONTESTING:
                if (FishingContest.startTime == 0)
                {
                    FishingContest.startTime = (uint32)time(NULL); // Sets the start time for contesting to "Now".
                }
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_CONTESTING;
                break;
            case CONTEST_STATUS_OPENING:
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_OPENING;
                break;
            case CONTEST_STATUS_ACCEPTING:
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_ACCEPTING;
                break;
            case CONTEST_STATUS_RELEASING:
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_RELEASING;
                break;
            case CONTEST_STATUS_PRESENTING:
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_PRESENTING;
                break;
            case CONTEST_STATUS_HIATUS:
                FishingContest.changeTime = FishingContest.startTime + CONTEST_INTERVAL_HIATUS;
                break;
            case CONTEST_STATUS_CLOSED:
                FishingContest.changeTime = 0xFFFFFFFF; // Ensures we never reach this time point to lock the status in place
                break;
        }
        WriteContestData();
    }

    void SetContestCriteria(uint8 newCriteria)
    {
        FishingContest.criteria = newCriteria;
    }

    void SetContestMeasure(uint8 newMeasure)
    {
        FishingContest.measure = newMeasure;
    }

    void SetContestFish(uint32 newFish)
    {
        if (fishingutils::GetFish(newFish))
        {
            FishingContest.fishId = newFish;
        }
        else
        {
            FishingContest.fishId = 0;
            ShowDebug("Attempted to apply invalid Fish ID to contest.");
        }

        WriteContestData();
    }

    void SetContestStartTime(uint32 startTime)
    {
        FishingContest.startTime = startTime;
    }

    // Contest Data: Gets
    uint16 GetContestID()
    {
        return FishingContest.contestId;
    }

    uint8 GetContestStatus()
    {
        return FishingContest.status;
    }

    uint8 GetContestCriteria()
    {
        return FishingContest.criteria;
    }

    uint8 GetContestMeasure()
    {
        return FishingContest.measure;
    }

    uint32 GetContestFish()
    {
        return FishingContest.fishId;
    }

    uint32 GetContestStartTime()
    {
        return FishingContest.startTime;
    }

    uint32 GetContestChangeTime()
    {
        return FishingContest.changeTime;
    }

    // Contest Control
    void ProgressContest()
    {
        /***********************************************
         *  Update the phase of the fishing contest
         *  See enum FISHINGCONTESTSTATUS in fishingutils.h
         *  CALLED BY ZONE TICK IN SELBINA - DO NOT ADD TO FUNCTION
         ***********************************************/
        uint32 currentTime = (uint32)time(NULL);
        if (currentTime > FishingContest.changeTime)
        {
            switch ((FISHINGCONTESTSTATUS)FishingContest.status)
            {
                case CONTEST_STATUS_CONTESTING:
                    SetContestStatus(CONTEST_STATUS_OPENING);
                    break;
                case CONTEST_STATUS_OPENING:
                    SetContestStatus(CONTEST_STATUS_ACCEPTING);
                    break;
                case CONTEST_STATUS_ACCEPTING:
                    SetContestStatus(CONTEST_STATUS_RELEASING);
                    break;
                case CONTEST_STATUS_RELEASING:
                    SetContestStatus(CONTEST_STATUS_PRESENTING);
                    break;
                case CONTEST_STATUS_PRESENTING:
                    SetContestStatus(CONTEST_STATUS_HIATUS);
                    break;
                case CONTEST_STATUS_HIATUS:
                    SetContestStatus(CONTEST_STATUS_CLOSED);
                    InitNewContest(GetNextAvailableContestID());
                    break;
                case CONTEST_STATUS_CLOSED: // If closed, then don't change anything automatically
                    break;
            }
        }
    }

    void ScoreContest()
    {
        TracyZoneScoped;

        // Sort the list first
        // clang-format off
        std::sort(FishingContestEntries.begin(), FishingContestEntries.end(),
                  [](fish_ranking_entry* a, fish_ranking_entry* b) -> bool
                  {
                      if (FishingContest.measure == (uint8)CONTEST_MEASURE_GREATEST)
                      {
                          return a->score == b->score ? a->submittime < b->submittime : a->score > b->score;
                      }
                      else
                      {
                          return a->score == b->score ? a->submittime < b->submittime : b->score > a->score;
                      }
                  });
        // clang-format on

        // Apply Rankings
        // Iterate over the vector and apply the contestrank value
        uint8  contestrank = 1;
        uint8  prevrank    = 1;
        uint32 score       = 0;

        // Apply the rank scores to the list
        for (fish_ranking_entry* it : FishingContestEntries)
        {
            if (it->score != score) // Regardless of increasing or decreasing ... Vector already sorted
            {
                it->contestrank = contestrank;
                prevrank        = contestrank;
                score           = it->score; // Update the ongoing score "tally"
            }
            else // Scores are matches so we have to share rank values
            {
                it->contestrank = prevrank;
            }

            // Set the number of times the score appears and copy it to dataset a and b
            // clang-format off
            it->dataset_a   = std::count_if(FishingContestEntries.begin(), FishingContestEntries.end(),
                                            [&score](auto& a) -> bool
                                            {
                                              return a->score == score;
                                          });
            // clang-format on

            it->dataset_b   = it->dataset_a; // Duplicated.  Uncertain as to definition
            it->resultcount = (uint8)FishingContestEntries.size();
            contestrank++;
        }

        WriteContestEntryData();
    }

    uint16 GetNextAvailableContestID()
    {
        const char* Query = "SELECT t1.contestid + 1 "
                            "FROM fishing_contest t1 "
                            "LEFT JOIN fishing_contest t2 "
                            "ON t1.contestid + 1 = t2.contestid "
                            "WHERE t2.contestid IS NULL "
                            "ORDER BY t1.contestid ASC "
                            "LIMIT 1;";
        int32       ret   = sql->Query(Query);
        if (ret != SQL_ERROR && sql->NumRows() == 0)
        {
            // Empty database - Use 1
            return 1;
        }
        else if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
        {
            return (uint16)sql->GetUIntData(0);
        }
        else
        {
            ShowError("fishingcontest::GetNextAvailableContestID() : Unable to determine new contest ID.");
            return 0;
        }
    }

    // Contest Entries
    fish_ranking_entry* GetFishRankEntry(uint8 entry)
    {
        // We should only return a valid entry to a player if the contest is in a state of releasing results
        // But we can also return them for GMs or support requests if we want to see the current table entries

        // If we have an entry already included, use it
        if (entry < FishingContestEntries.size())
        {
            return FishingContestEntries[entry];
        }
        else if (!FishingContestEntries.empty() && entry >= FishingContestEntries.size())
        {
            fish_ranking_entry* fakeEntry = new fish_ranking_entry;

            uint8 contestrank = entry + 1;
            uint8 fakeCounter = contestrank - (uint8)FishingContestEntries.size();
            int   step        = -1;
            int16 fakeScore   = 16;
            int   jobLevels[] = { 75,
                                  60,
                                  50,
                                  40,
                                  30 };
            if (FishingContest.measure == (uint8)CONTEST_MEASURE_SMALLEST)
            {
                step      = 1;
                fakeScore = 9984;
            }

            fakeScore += (fakeCounter * step);

            std::string fakeName = " SmallFisher ";
            if (fakeCounter < 10)
            {
                fakeName += "0";
            }

            fakeName += std::to_string(fakeCounter);
            strcpy(fakeEntry->name, fakeName.c_str());
            fakeEntry->mjob        = ((fakeCounter - 1) % 18) + 1;
            fakeEntry->sjob        = 0;
            fakeEntry->mlvl        = jobLevels[(fakeCounter - 1) % 5];
            fakeEntry->slvl        = 0;
            fakeEntry->race        = ((fakeCounter - 1) % 7) + 1;
            fakeEntry->allegiance  = ((fakeCounter - 1) % 3);
            fakeEntry->fishrank    = 1; // Recruit
            fakeEntry->score       = fakeScore;
            fakeEntry->submittime  = 0;
            fakeEntry->contestrank = contestrank;

            return fakeEntry;
        }

        return nullptr;
    }

    fish_ranking_entry* GetPlayerEntry(CCharEntity* PChar)
    {
        for (fish_ranking_entry* it : FishingContestEntries)
        {
            // Set the rank value
            if (strcmp(PChar->name.c_str(), it->name) == 0)
            {
                return it;
            }
        }

        return nullptr;
    }

    uint32 FishingRankEntryCount()
    {
        return (uint32)FishingContestEntries.size();
    }

    uint32 ScoreFish(CItemFish* PFish, fishing_contest_t* PCon)
    {
        uint32 score = 0;
        if (PCon->criteria == (uint8)CONTEST_CRITERIA_SIZE)
        {
            score = PFish->GetLength();
        }
        else if (PCon->criteria == (uint8)CONTEST_CRITERIA_WEIGHT)
        {
            score = PFish->GetWeight();
        }
        else
        {
            score = PFish->GetLength() + PFish->GetWeight();
        }

        return score;
    }

    // Data storage
    void WriteContestData()
    {
        if (FishingContest.contestId == 0)
        {
            return;
        }

        // Update the DB with the current contest data (in case the contest is changed)
        const char* Query = "REPLACE INTO `fishing_contest` VALUES ("
                            "%u, "  // Contest ID
                            "%u, "  // Status
                            "%u, "  // Criteria
                            "%u, "  // Measure
                            "%u, "  // Fish ID
                            "%u);"; // Start Time

        int32 ret = sql->Query(Query, FishingContest.contestId,
                               FishingContest.status,
                               FishingContest.criteria,
                               FishingContest.measure,
                               FishingContest.fishId,
                               FishingContest.startTime);

        if (ret == SQL_ERROR)
        {
            ShowDebug("Error writing fishing contest data to database.");
        }
    }

    void WriteContestEntryData()
    {
        // Update the DB with the current contest entries
        // This does not update the reward status of each line since it is not a part of the struct
        const char* Query = "REPLACE INTO `fishing_contest_entries` \
                             (contestid, name, mjob, sjob, mlevel, slevel, race, allegiance, fishrank, score, submittime, contestrank) \
                             VALUES %s;"; // String set
        std::string queryString;

        if (FishingContestEntries.size() > 0)
        {
            for (fish_ranking_entry* it : FishingContestEntries)
            {
                if (!queryString.empty())
                {
                    queryString += ", ";
                }
                queryString += "(" +
                               std::to_string(FishingContest.contestId) + ", " +
                               "'" + it->name + "', " +
                               std::to_string(it->mjob) + ", " +
                               std::to_string(it->sjob) + ", " +
                               std::to_string(it->mlvl) + ", " +
                               std::to_string(it->slvl) + ", " +
                               std::to_string(it->race) + ", " +
                               std::to_string(it->allegiance) + ", " +
                               std::to_string(it->fishrank) + ", " +
                               std::to_string(it->score) + ", " +
                               std::to_string(it->submittime) + ", " +
                               std::to_string(it->contestrank) + ")";
            }
            queryString += ";";

            int32 ret = sql->Query(Query, queryString);

            if (ret == SQL_ERROR)
            {
                ShowDebug("Error writing fishing contest data to database.");
            }
        }
    }

    void CleanDatabaseEntries()
    {
        // Ensure that only maximum one contest in the database has a value < 6
        // In other words, we can't create a new contest without closing old ones
        // This will leave only the highest contestId with a status < 6 open.
        const char* Query = "UPDATE fishing_contest "
                            "SET `status` = 6 "
                            "WHERE contestid IN( "
                            "    SELECT contestid "
                            "    FROM fishing_contest "
                            "    WHERE `status` < 6 EXCEPT "
                            "       SELECT MAX(contestid) "
                            "       FROM fishing_contest "
                            "       WHERE `status` < 6);";
        int32       ret   = sql->Query(Query);

        if (ret != SQL_ERROR)
        {
            sql->TransactionCommit();
        }
        else
        {
            sql->TransactionRollback();
            ShowError("fishingcontest::CleanDatabaseEntries() : Unable to process transaction.");
        }
    }

    // Player Utils
    void SubmitFish(CCharEntity* PChar, uint32 score)
    {
        // Placeholder for the entry
        fish_ranking_entry* entry = nullptr;

        // Check to see if the player has already submitted a fish
        for (int it = 0; it < (int)FishingContestEntries.size(); it++)
        {
            if (strcmp(PChar->name.c_str(), FishingContestEntries[it]->name) == 0)
            {
                entry = FishingContestEntries[it];
                break;
            }
        }

        if (!entry)
        {
            // Create a new entry
            entry = new fish_ranking_entry();
            strcpy(entry->name, PChar->name.c_str()); // Remember to truncate this to 16 chars max before sending packet
            FishingContestEntries.push_back(entry);
        }

        // Fill out the entry with the current data
        entry->mjob        = (uint8)PChar->GetMJob();
        entry->sjob        = (uint8)PChar->GetSJob();
        entry->mlvl        = PChar->GetMLevel();
        entry->slvl        = PChar->GetSLevel();
        entry->race        = PChar->mainlook.race;
        entry->allegiance  = (uint8)PChar->allegiance;
        entry->fishrank    = PChar->RealSkills.rank[SKILLTYPE::SKILL_FISHING];
        entry->score       = score;
        entry->submittime  = CVanaTime::getInstance()->getVanaTime();
        entry->contestrank = 0;
        entry->dataset_a   = 0;
        entry->dataset_b   = 0;

        // Update the fish to the database
        const char* Query = "REPLACE INTO `fishing_contest_entries` VALUES ("
                            "%u, "   // Contest ID
                            "'%s', " // Name
                            "%u, "   // MJob
                            "%u, "   // SJob
                            "%u, "   // MLevel
                            "%u, "   // SLevel
                            "%u, "   // Race
                            "%u, "   // Allegiance
                            "%u, "   // Fishing Rank
                            "%u, "   // Score
                            "%u, "   // Submit Time
                            "%u);";  // Contest Rank

        int32 ret = sql->Query(Query,
                               FishingContest.contestId,
                               entry->name,
                               entry->mjob,
                               entry->sjob,
                               entry->mlvl,
                               entry->slvl,
                               entry->race,
                               entry->allegiance,
                               entry->fishrank,
                               entry->score,
                               entry->submittime,
                               entry->contestrank);

        if (ret == SQL_ERROR)
        {
            ShowDebug("Error writing fishing contest data to database.");
        }
        ScoreContest();
    }

    void WithdrawFish(CCharEntity* PChar)
    {
        fish_ranking_entry* entry = GetPlayerEntry(PChar);
        if (entry)
        {
            // Remove from the database
            const char* Query = "DELETE FROM `fishing_contest_entries` \
                                 WHERE `contestid` = %u \
                                 AND `name` = '%s';";
            int32       ret   = sql->Query(Query, FishingContest.contestId, PChar->GetName());
            sql->TransactionCommit();

            if (ret == SQL_ERROR)
            {
                ShowError("Failed to remove entry from fishing entry database.");
                return;
            }

            // Remove from the in-memory vector
            // clang-format off
            auto it = std::find_if(FishingContestEntries.begin(), FishingContestEntries.end(),
                                [&PChar](fish_ranking_entry* e) -> bool
                                {
                                    return strcmp(PChar->name.c_str(), e->name) == 0;
                                });
            // clang-format on

            if (it != FishingContestEntries.end())
            {
                int index = it - FishingContestEntries.begin();
                FishingContestEntries.erase(FishingContestEntries.begin() + index);
            }

            ScoreContest(); // Re-score the contest
        }
    }

    bool HasRewardPending(CCharEntity* PChar, uint16 contestId)
    {
        XI_DEBUG_BREAK_IF(PChar == nullptr);
        const char* Query = "";
        int32       ret;

        if (!contestId)
        {
            Query = "SELECT MAX(contestid) "
                    "WHERE status < 6;";
            ret   = sql->Query(Query);

            if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
            {
                contestId = sql->GetUIntData(0);
            }
            else
            {
                return false;
            }
        }

        Query = "SELECT r.time "
                "FROM `fishing_contest_entries` e "
                "LEFT JOIN `fishing_contest_rewards` r "
                "ON e.contestid = r.contestid "
                "AND e.name = r.name "
                "WHERE e.contestid = %u "
                "AND e.contestrank > 0 "
                "AND e.contestrank <= 20 "
                "AND e.name = '%s';";

        // Should return at most 1 entry.  If the r.time value is null, then the reward has not been granted
        ret = sql->Query(Query, contestId, PChar->GetName());
        if (ret != SQL_ERROR)
        {
            if (sql->NumRows() > 0 && sql->NextRow() == SQL_SUCCESS)
            {
                if (sql->GetUIntData(0))
                {
                    return false; // Time value is present, so the reward was given out already.
                }

                return true;
            }
        }
        else
        {
            ShowDebug("Unable to retrieve award status on contest %u for player %s.", contestId, PChar->GetName());
        }

        return false;
    }

    void GiveContestReward(CCharEntity* PChar, uint16 contestId)
    {
        XI_DEBUG_BREAK_IF(PChar == nullptr);

        const char* Query = "REPLACE INTO `fishing_contest_rewards` (contestid, name, time) VALUES (%u, '%s', %u);";

        int32 ret = sql->Query(Query, contestId, PChar->GetName(), (uint32)time(NULL));
        if (ret != SQL_ERROR)
        {
            sql->TransactionCommit();
        }
        else
        {
            sql->TransactionRollback();
            ShowDebug("Unable to set award status on contest %u for player %s.", contestId, PChar->GetName());
        }
    }

    // Initialization
    void InitNewContest(uint16 contestId)
    {
        // If contestId is zero, find the next available value
        if (!contestId)
        {
            contestId = GetNextAvailableContestID();
        }

        // Select a random fish from the lua tables
        auto getRandomFish = lua["xi"]["fishing"]["contest"]["randomFish"];
        if (!getRandomFish.valid())
        {
            sol::error err = getRandomFish;
            ShowError("fishingcontest:InitNewContest: %s", err.what());
            return;
        }
        auto result = getRandomFish();
        if (!result.valid())
        {
            sol::error err = result;
            ShowError("fishingcontest:InitNewContest:(getRandomFish): %s", err.what());
            return;
        }
        uint8 criteria = (uint8)std::floor(xirand::GetRandomNumber(0, 3));
        uint8 measure  = (uint8)std::floor(xirand::GetRandomNumber(0, 2));

        InitNewContest(contestId, (uint32)result, (FISHINGCONTESTCRITERIA)criteria, (FISHINGCONTESTMEASURE)measure);
    }

    void InitNewContest(uint16 contestId, uint32 fishId, uint8 criteria, uint8 measure)
    {
        // If contestId is zero, find the next available value
        if (!contestId)
        {
            contestId = GetNextAvailableContestID();
        }

        // Clear any table data involving this contest
        const char* Query = "DELETE FROM `fishing_contest` WHERE contestId = %u;";
        int32       ret   = sql->Query(Query, contestId);

        if (ret == SQL_ERROR)
        {
            ShowDebug("Error removing past contest data.");
            return;
        }

        Query = "DELETE FROM `fishing_contest_entries` WHERE contestId = % u;";
        ret   = sql->Query(Query, contestId);

        if (ret == SQL_ERROR)
        {
            ShowDebug("Error removing past contest entry data.");
            return;
        }

        // Clamp vars
        if (criteria > (uint8)CONTEST_CRITERIA_BOTH)
        {
            criteria = 0;
        }
        if (measure > (uint8)CONTEST_MEASURE_SMALLEST)
        {
            measure = 0;
        }

        // Set the current active contest to CLOSED
        SetContestStatus(CONTEST_STATUS_CLOSED);

        // Clear the current entries in memory
        WriteContestEntryData();
        FishingContestEntries.clear();

        // Update the current contest data
        FishingContest.contestId = contestId;
        FishingContest.fishId    = fishId;
        FishingContest.criteria  = criteria;
        FishingContest.measure   = measure;
        FishingContest.startTime = (uint32)time(0);
        SetContestStatus(CONTEST_STATUS_CONTESTING);

        // Store new data in the DB
        WriteContestData();
    }

    void LoadCurrentContest()
    {
        // Only get the latest data of entries - We never need the past ones, but store them for later historical use
        const char* Query = "SELECT "
                            "contestid, " // 0
                            "status, "    // 1
                            "criteria, "  // 2
                            "measure, "   // 3
                            "fishid, "    // 4
                            "starttime "  // 5
                            "FROM `fishing_contest` f "
                            "WHERE contestid IN ( "
                            "   SELECT MAX(contestid) "
                            "    FROM `fishing_contest` "
                            "    WHERE `status` < 6);";

        int32 ret = sql->Query(Query);

        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                FishingContest.contestId = (uint8)sql->GetUIntData(0);
                FishingContest.status    = (uint8)sql->GetUIntData(1);
                FishingContest.criteria  = (uint8)sql->GetUIntData(2);
                FishingContest.measure   = (uint8)sql->GetUIntData(3);
                FishingContest.fishId    = sql->GetUIntData(4);
                FishingContest.startTime = sql->GetUIntData(5);
            }
        }
        else if (ret != SQL_ERROR && sql->NumRows() == 0)
        {
            // No contests found in the database, so we need to create one
            InitNewContest();
            ShowWarning("No Active Fishing Contest found in database.  Initializing new one.");
        }

        SetContestStatus(FishingContest.status);
        LoadContestEntries(FishingContest.contestId);
        ScoreContest();
    }

    void LoadContestEntries(uint16 contestId)
    {
        if (!contestId && FishingContest.contestId > 0)
        {
            // Get the current contest in memory
            contestId = FishingContest.contestId;
        }

        // Only get the latest data of entries - We never need the past ones, but store them for later historical use
        const char* Query = "SELECT "
                            "name, "       // 0
                            "mjob, "       // 1
                            "sjob, "       // 2
                            "mlevel, "     // 3
                            "slevel, "     // 4
                            "race, "       // 5
                            "allegiance, " // 6
                            "fishrank, "   // 7
                            "score, "      // 8
                            "submittime, " // 9
                            "contestrank " // 10
                            "FROM `fishing_contest_entries` "
                            "WHERE contestid = %u "
                            "ORDER BY contestrank;";

        int32 ret = sql->Query(Query, contestId);

        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            // Clear the current entry data
            FishingContestEntries.clear();

            while (sql->NextRow() == SQL_SUCCESS)
            {
                fish_ranking_entry* listing = new fish_ranking_entry();

                strcpy(listing->name, sql->GetStringData(0).c_str()); // Remember to truncate this to 16 chars max before sending packet
                listing->mjob        = (uint8)sql->GetUIntData(1);
                listing->sjob        = (uint8)sql->GetUIntData(2);
                listing->mlvl        = (uint8)sql->GetUIntData(3);
                listing->slvl        = (uint8)sql->GetUIntData(4);
                listing->race        = (uint8)sql->GetUIntData(5);
                listing->allegiance  = (uint8)sql->GetUIntData(6);
                listing->fishrank    = (uint8)sql->GetUIntData(7);
                listing->score       = sql->GetUIntData(8);
                listing->submittime  = sql->GetUIntData(9);
                listing->contestrank = (uint8)sql->GetUIntData(10);

                FishingContestEntries.push_back(listing);
            }
        }
    }

    void InitializeFishingContestSystem()
    {
        CleanDatabaseEntries();
        LoadCurrentContest();
        LoadContestEntries();
    }
} // namespace fishingcontest
