/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#pragma once

#include <vector>

#include "./entities/battleentity.h"
#include "common/cbasetypes.h"
#include "modifier.h"

enum class JobPointType : uint16;
struct JobPointType_t
{
    uint16 id;
    uint8  value;

    auto cost() const -> uint8;
    auto format() const -> uint8;
};

constexpr uint8 jpTypePerCategory = 10;

struct JobPoints_t
{
    uint16         jobId;
    uint16         jobCategory;
    uint16         capacityPoints;
    uint16         currentJp;
    uint16         totalJpSpent;
    JobPointType_t job_point_types[jpTypePerCategory]{};
};

struct JobPointGifts_t
{
    uint16 jpRequired;
    uint16 modId;
    int16  value;
};

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/
class CCharEntity;

class CJobPoints
{
public:
    CJobPoints(CCharEntity* PChar);
    auto IsJobPointExist(JobPointType jpType) const -> bool; // Check to see if JP exists
    void RaiseJobPoint(JobPointType jpType);                 // Add upgrade
    auto GetJobPoints() const -> uint16;                     // Get unspent job points for current job
    auto GetJobPointsByJob(uint8 jobID) const -> uint16;     // get current job points for a players specified job
    void SetJobPoints(int16 amount);                         // Set job points for current job

    void AddJobPoints(uint8 jobID, uint16 amount); // Add jobpoints to a players specififed job
    void DelJobPoints(uint8 jobID, int16 amount);  // Del jobpoints to a players specified job

    auto GetJobPointsByType(JobPointType jpType) -> JobPoints_t*;
    auto GetJobPointType(JobPointType jpType) -> JobPointType_t*;

    void LoadJobPoints(); // load JPs for char from db

    auto GetAllJobPoints() -> JobPoints_t*;

    auto GetJobPointsSpent() const -> uint16;

    auto AddCapacityPoints(uint16 amount) -> bool; // Add Capacity Points for current job, and increase JP as needed
    auto GetCapacityPoints() const -> uint32;      // Get Capacity Points for Character's Current Job
    void SetCapacityPoints(uint16 amount);         // Set Capacity Points for Character's Current Job, does not handle JP increase!

    // Returns the level of a given job point type. Will return 0 if the type doesn't match the
    // player's main job or if their main job is not 99
    auto GetJobPointValue(JobPointType jpType) -> uint8;

    std::vector<CModifier> current_gifts;

private:
    CCharEntity* m_PChar;
    JobPoints_t  m_jobPoints[MAX_JOBTYPE]{};
};

namespace jobpointutils
{
    void                                LoadGifts();
    void                                RefreshGiftMods(CCharEntity* PChar);
    extern std::vector<JobPointGifts_t> jpGifts[MAX_JOBTYPE];
} // namespace jobpointutils
