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

#ifndef _FISHINGCONTEST_H
#define _FISHINGCONTEST_H

#include "../items/item_fish.h"
#include "../utils/fishingutils.h"

#include <cstring>
#include <list>
#include <map>
#include <vector>

class CBasicPacket;
class CCharEntity;

enum class FISHING_CONTEST_CRITERIA : uint8
{
    SIZE   = 0,
    WEIGHT = 1,
    BOTH   = 2,
};

enum class FISHING_CONTEST_MEASURE : uint8
{
    GREATEST = 0,
    SMALLEST = 1,
};

enum class FISHING_CONTEST_STATUS : uint8
{
    CONTESTING = 0,
    OPENING    = 1,
    ACCEPTING  = 2,
    RELEASING  = 3,
    PRESENTING = 4,
    HIATUS     = 5,
    CLOSED     = 6,
};

struct FishingContest
{
    FISHING_CONTEST_STATUS   status     = FISHING_CONTEST_STATUS::CONTESTING;
    FISHING_CONTEST_CRITERIA criteria   = FISHING_CONTEST_CRITERIA::SIZE;
    FISHING_CONTEST_MEASURE  measure    = FISHING_CONTEST_MEASURE::GREATEST;
    uint16                   fishId     = 0;
    uint32                   startTime  = 0;
    uint32                   changeTime = 0xFFFFFFFF; // Never change = default

    bool isValid()
    {
        return status <= FISHING_CONTEST_STATUS::CLOSED &&
               criteria <= FISHING_CONTEST_CRITERIA::BOTH &&
               measure <= FISHING_CONTEST_MEASURE::SMALLEST &&
               startTime > 0 &&
               fishId != 0;
    }
};

struct FishingContestEntry // Struct for packet transmission to client
                           // NOTE:  This struct MUST NOT change size and structure, as the fish ranking packets in packet_system rely on a 36U sized struct.
{
    char   name[16]    = { 0 }; // Character Name (16 bytes)
    uint8  mjob        = 0;     // Main Job
    uint8  sjob        = 0;     // Sub job
    uint8  mlvl        = 0;     // Main Level
    uint8  slvl        = 0;     // Sub Level
    uint8  race        = 0;     // Race
    uint8  padding     = 0;     // Padding (Always = 0)
    uint8  allegiance  = 0;     // Allegiance (0-2)
    uint8  fishRank    = 0;     // Fishing Rank (0-10)
    uint32 score       = 0;     // Fish Score
    uint32 submitTime  = 0;     // Timestamp of submission
    uint8  contestRank = 0;     // Contest Ranking
    uint8  resultCount = 0;     // Total # of entries - This will only be set at the end of a contest, but is part of the packet
    uint8  share       = 0;     // Number of entries sharing this rank
    uint8  dataset_b   = 0;     // Same as share?
};

static_assert(sizeof(FishingContestEntry) == 36, "Expected Fish Ranking Contest Entry size as 36.");

struct FishingContestHistory
{
    uint16 rank1 = 0;
    uint16 rank2 = 0;
    uint16 rank3 = 0;
    uint16 rank4 = 0;
};

/************************************************************************
 *                                                                       *
 *  All the methods necessary for the implementation of fishing contest  *
 *                                                                       *
 ************************************************************************/

namespace fishingcontest
{
    // Contest Data: Sets
    void SetContestStatus(FISHING_CONTEST_STATUS newStatus);
    void SetContestCriteria(FISHING_CONTEST_CRITERIA newCriteria);
    void SetContestMeasure(FISHING_CONTEST_MEASURE newMeasure);
    void SetContestFish(uint16 newFish);
    void SetContestStartTime(uint32 startTime);

    // Contest Data: Gets
    auto   GetContestStatus() -> FISHING_CONTEST_STATUS;
    auto   GetContestCriteria() -> FISHING_CONTEST_CRITERIA;
    auto   GetContestMeasure() -> FISHING_CONTEST_MEASURE;
    uint16 GetContestFish();
    uint32 GetContestStartTime();
    uint32 GetContestChangeTime();

    // Contest Control
    void   ProgressContest();
    void   ScoreContest();
    uint32 GetStageChangeTime(FISHING_CONTEST_STATUS stage, uint32 stageStartTime);
    void   UpdateRankingHistory();

    // Contest Entries
    auto  GetFishRankEntry(uint8 position) -> FishingContestEntry*;
    auto  GetPlayerEntry(CCharEntity* PChar) -> FishingContestEntry*;
    uint8 FishingRankEntryCount();

    // Data storage
    bool WriteContestData();
    bool WriteInitialContestData();
    bool WriteContestEntryData(FishingContestEntry* entry);

    // Player Utils
    bool SubmitFish(CCharEntity* PChar, uint32 score);
    bool WithdrawFish(CCharEntity* PChar);
    bool ClaimContestReward(CCharEntity* PChar);
    auto GetFishingContestHistory(CCharEntity* PChar) -> FishingContestHistory;

    // Initialization
    void InitNewContest();
    void InitNewContest(uint16 fishId, FISHING_CONTEST_CRITERIA criteria, FISHING_CONTEST_MEASURE measure);
    void LoadContestParameters();
    void LoadContestEntries();
    void BuildPlaceholderEntries();
    void InitializeFishingContestSystem();

}; // namespace fishingcontest

#endif // _FISHINGCONTEST_H
