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

#include "grades.h"

#include "common/settings.h"
#include "data/datasets/grades/dataset.h"
#include "data/datasets/stats/dataset.h"
#include "utils/dataset_loader.h"

#include <array>

namespace
{

auto grades() -> const xi::data::Grades&
{
    static const auto data = xi::data::loadDataset<xi::data::datasets::grades::Dataset>();
    return data;
}

auto stats() -> const xi::data::Stats&
{
    static const auto data = xi::data::loadDataset<xi::data::datasets::stats::Dataset>();
    return data;
}

// What a subjob contributes of its own MP. Halved on retail.
auto subJobShare(const int32 value) -> int32
{
    return static_cast<int32>(value / settings::get<float>("map.SJ_MP_DIVISOR"));
}

} // namespace

/************************************************************************
 *                                                                        *
 *  Array with the levels of palyer HP Scale per rank                     *
 *                                                                        *
 ************************************************************************/

std::array<std::array<float, 5>, 8> HPScale = { {
    // base,<30,<60,<75,>75
    { 0, 0, 0, 0, 0 },  // 0
    { 19, 9, 1, 3, 3 }, // A
    { 17, 8, 1, 3, 3 }, // B
    { 16, 7, 1, 3, 3 }, // C
    { 14, 6, 0, 3, 3 }, // D
    { 13, 5, 0, 2, 2 }, // E
    { 11, 4, 0, 2, 2 }, // F
    { 10, 3, 0, 2, 2 }, // G
} };

/************************************************************************
 *                                                                        *
 *  Array with the levels of MP Scale per rank                            *
 *                                                                        *
 ************************************************************************/

std::array<std::array<float, 4>, 8> MPScale = { {
    // base,<60,>60
    { 0, 0, 0 },    // 0
    { 16, 6, 4 },   // A
    { 14, 5, 4 },   // B
    { 12, 4, 4 },   // C
    { 10, 3, 4 },   // D
    { 8, 2, 3 },    // E
    { 6, 1, 2 },    // F
    { 4, 0.5f, 1 }, // G
} };

/************************************************************************
 *                                                                        *
 *  Array with the levels of mob HP Scale per rank                        *
 *                                                                        *
 ************************************************************************/

std::array<std::array<float, 3>, 8> MobHPScale = { {
    // Base | Job/SJ Scale | ScaleX
    { 0, 0, 0 },  // 0
    { 36, 9, 1 }, // A
    { 33, 8, 1 }, // B
    { 32, 7, 1 }, // C
    { 29, 6, 0 }, // D
    { 27, 5, 0 }, // E
    { 24, 4, 0 }, // F
    { 22, 3, 0 }, // G
} };

namespace grade
{

void LoadGrades()
{
    grades();
    stats();
}

auto GetJobGrade(const xi::Job job, const uint8 stat) -> uint8
{
    return grades().Jobs[static_cast<std::size_t>(job)][stat];
}

auto GetRaceGrades(const uint8 race, const uint8 stat) -> uint8
{
    return grades().Races[race][stat];
}

auto GetHPScale(const uint8 rank, const uint8 scale) -> float
{
    return HPScale[rank][scale];
}

auto GetMPScale(const uint8 rank, const uint8 scale) -> float
{
    return MPScale[rank][scale];
}

// Race, job and subjob parts are each rounded down to half points, then summed and rounded down once.
// Before the April 2014 update each part was rounded down to a whole point on its own instead.
auto GetBaseStat(const uint8 raceRank, const uint8 jobRank, const uint8 level, const uint8 subJobRank, const uint8 subLevel) -> uint16
{
    const auto& data = stats();

    const auto raceHalfPoints   = data.HalfPoints[raceRank][level];
    const auto jobHalfPoints    = data.HalfPoints[jobRank][level];
    const auto subJobHalfPoints = data.HalfPoints[subJobRank][subLevel];
    const auto pointsOver75     = data.PointsOver75[level];

    if (!data.RoundOnce)
    {
        return static_cast<uint16>(raceHalfPoints / 2 + jobHalfPoints / 2 + subJobHalfPoints / 4 + pointsOver75);
    }

    // Current retail pools the half points and rounds down once, plus the post-75 gains
    return static_cast<uint16>((raceHalfPoints + jobHalfPoints + subJobHalfPoints / 2) / 2 + pointsOver75);
}

// Race and job HP are whole points added together, and the subjob adds half of its own job HP
auto GetBaseHP(const uint8 race, const uint8 jobGrade, const uint8 level, const uint8 subJobGrade, const uint8 subLevel) -> uint16
{
    const auto& data = stats();

    return static_cast<uint16>(data.RaceHp[race].at(level) + data.JobHp[jobGrade].at(level) + data.JobHp[subJobGrade].at(subLevel) / 2);
}

// MP is the same shape as HP, except that a job without an MP grade brings no racial MP with it.
// When only the subjob has MP the racial part enters at the subjob's level, shared down like the subjob itself.
auto GetBaseMP(const uint8 race, const uint8 jobGrade, const uint8 level, const uint8 subJobGrade, const uint8 subLevel) -> uint16
{
    const auto& data = stats();

    if (jobGrade > 0)
    {
        return static_cast<uint16>(data.RaceMp[race].at(level) + data.JobMp[jobGrade].at(level) + subJobShare(data.JobMp[subJobGrade].at(subLevel)));
    }

    if (subJobGrade > 0)
    {
        return static_cast<uint16>(subJobShare(data.RaceMp[race].at(subLevel)) + subJobShare(data.JobMp[subJobGrade].at(subLevel)));
    }

    return 0;
}

auto GetMobHPScale(const uint8 rank, const uint8 scale) -> uint8
{
    return MobHPScale[rank][scale];
}

}; // namespace grade
