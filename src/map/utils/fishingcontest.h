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

#ifndef _FISHINGCONTEST_H
#define _FISHINGCONTEST_H

#include "../items/item_fish.h"

#include <cstring>
#include <list>
#include <map>
#include <vector>

struct fish_ranking_entry // Struct for packet transmission to client
{
    char   name[16] = { 0 }; // Character Name (16 bytes)
    uint8  mjob;             // Main Job
    uint8  sjob;             // Sub job
    uint8  mlvl;             // Main Level
    uint8  slvl;             // Sub Level
    uint8  race;             // Race
    uint8  padding;          // Padding (Always = 0)
    uint8  allegiance;       // Allegiance (0-2)
    uint8  fishrank;         // Fishing Rank (0-10)
    uint32 score;            // Fish Score
    uint32 submittime;       // Timestamp of submission
    uint8  contestrank;      // Contest Ranking
    uint8  resultcount;      // Contest Rank - This will only be set at the end of a contest, but is part of the packet
    uint8  dataset_a;        // Number of entries sharing this rank
    uint8  dataset_b;        // Same as Dataset A?
    // NOTE:  This struct MUST NOT change size and structure, as the fish ranking packets in packet_system rely on a 36U sized struct.

    fish_ranking_entry()
    {
        mjob        = 0;
        sjob        = 0;
        mlvl        = 0;
        slvl        = 0;
        race        = 0;
        padding     = 0;
        allegiance  = 0;
        fishrank    = 0;
        score       = 0;
        submittime  = 0;
        contestrank = 0;
        resultcount = 0;
        dataset_a   = 0;
        dataset_b   = 0;
    }
};

enum FISHINGCONTESTCRITERIA : uint8
{
    CONTEST_CRITERIA_SIZE   = 0,
    CONTEST_CRITERIA_WEIGHT = 1,
    CONTEST_CRITERIA_BOTH   = 2
};

enum FISHINGCONTESTMEASURE : uint8
{
    CONTEST_MEASURE_GREATEST = 0,
    CONTEST_MEASURE_SMALLEST = 1
};

enum FISHINGCONTESTSTATUS : uint8
{
    CONTEST_STATUS_CONTESTING = 0,
    CONTEST_STATUS_OPENING    = 1,
    CONTEST_STATUS_ACCEPTING  = 2,
    CONTEST_STATUS_RELEASING  = 3,
    CONTEST_STATUS_PRESENTING = 4,
    CONTEST_STATUS_HIATUS     = 5,
    CONTEST_STATUS_CLOSED     = 6,
};

enum FISHINGCONTESTINTERVAL : uint32
{
    // All time intervals are relative to the BASE start time of the contest, not the previous phase
    // These intervals indicate how long each phase lasts before being automatically progressed.
    CONTEST_INTERVAL_CONTESTING = 300,     // 5 minutes
    CONTEST_INTERVAL_OPENING    = 1800,    // 30 minutes (Prev + 25 mins)
    CONTEST_INTERVAL_ACCEPTING  = 1211400, // 14 days, 30 minutes (Prev + 14 days)
    CONTEST_INTERVAL_RELEASING  = 1213200, // 14 days, 1 hour (Prev + 30 mins)
    CONTEST_INTERVAL_PRESENTING = 2419200, // 28 days (Prev + 13 days, 23 hours)
    CONTEST_INTERVAL_HIATUS     = 2421300, // 28 days, 35 minutes (Prev + 35 minutes)
};

struct fishing_contest_t
{
    uint16 contestId;
    uint8  status;
    uint8  criteria;
    uint8  measure;
    uint32 fishId;
    uint32 startTime;
    uint32 changeTime;

    fishing_contest_t()
    {
        contestId  = 0;
        status     = 0;
        criteria   = 0;
        measure    = 0;
        fishId     = 0;
        startTime  = 0xEFFFFFFF; // to allow for changetimes to not overflow
        changeTime = 0xFFFFFFFF;
    }
};

/************************************************************************
 *                                                                       *
 *  All the methods necessary for the implementation of fishing          *
 *                                                                       *
 ************************************************************************/

class CBasicPacket;
class CCharEntity;
class CMobEntity;
class CItemFish;
class CItemWeapon;

namespace fishingcontest
{
    // Contest Data: Sets
    void SetContestStatus(uint8 newStatus, bool isTest = false);
    void SetContestCriteria(uint8 newCriteria);
    void SetContestMeasure(uint8 newMeasure);
    void SetContestFish(uint32 newFish);
    void SetContestStartTime(uint32 startTime);

    // Contest Data: Gets
    uint16 GetContestID();
    uint8  GetContestStatus();
    uint8  GetContestCriteria();
    uint8  GetContestMeasure();
    uint32 GetContestFish();
    uint32 GetContestStartTime();
    uint32 GetContestChangeTime();

    // Contest Control
    void   ProgressContest();
    void   ScoreContest();
    uint16 GetNextAvailableContestID();

    // Contest Entries
    fish_ranking_entry* GetFishRankEntry(uint8 entry);
    fish_ranking_entry* GetPlayerEntry(CCharEntity* PChar);
    uint32              FishingRankEntryCount();
    uint32              ScoreFish(CItemFish* PFish, fishing_contest_t* PCon);

    // Data storage
    void WriteContestData();
    void WriteContestEntryData();
    void CleanDatabaseEntries();

    // Player Utils
    void SubmitFish(CCharEntity* PChar, uint32 score);
    void WithdrawFish(CCharEntity* PChar);
    bool HasRewardPending(CCharEntity* PChar, uint16 contestId);
    void GiveContestReward(CCharEntity* PChar, uint16 contestId);

    // Initialization
    void InitNewContest(uint16 contestId = 0);
    void InitNewContest(uint16 contestId, uint32 fishId, uint8 criteria, uint8 measure);
    void LoadCurrentContest();
    void LoadContestEntries(uint16 contestId = 0);
    void InitializeFishingContestSystem();

}; // namespace fishingcontest

#endif // _FISHINGCONTEST_H
