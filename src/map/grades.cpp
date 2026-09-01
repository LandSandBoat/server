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

#include <algorithm>
#include <array>

/************************************************************************
 *                                                                        *
 *  Tables for calculating player & mob characteristics                   *
 *                                                                        *
 ************************************************************************/

/************************************************************************
 *                                                                        *
 *  Array with the levels of characteristics by jobs                      *
 *                                                                        *
 ************************************************************************/

std::array<std::array<uint8, 9>, 23> JobGrades = { {
    // HP,MP,STR,DEX,VIT,AGI,INT,MND,CHR
    { 0, 0, 0, 0, 0, 0, 0, 0, 0 }, // NON
    { 2, 0, 1, 3, 4, 3, 6, 6, 5 }, // WAR
    { 1, 0, 3, 2, 1, 6, 7, 4, 5 }, // MNK
    { 5, 3, 4, 6, 4, 5, 5, 1, 3 }, // WHM
    { 6, 2, 6, 3, 6, 3, 1, 5, 4 }, // BLM
    { 4, 4, 4, 4, 5, 5, 3, 3, 4 }, // RDM
    { 4, 0, 4, 1, 4, 2, 3, 7, 7 }, // THF
    { 3, 6, 2, 5, 1, 7, 7, 3, 3 }, // PLD
    { 3, 6, 1, 3, 3, 4, 3, 7, 7 }, // DRK
    { 3, 0, 4, 3, 4, 6, 5, 5, 1 }, // BST
    { 4, 0, 4, 4, 4, 6, 4, 4, 2 }, // BRD
    { 5, 0, 5, 4, 4, 1, 5, 4, 5 }, // RNG
    { 2, 0, 3, 3, 3, 4, 5, 5, 4 }, // SAM
    { 4, 0, 3, 2, 3, 2, 4, 7, 6 }, // NIN
    { 2, 0, 2, 4, 3, 4, 6, 5, 3 }, // DRG
    { 7, 1, 6, 5, 6, 4, 2, 2, 2 }, // SMN
    { 4, 4, 5, 5, 5, 5, 5, 5, 5 }, // BLU
    { 4, 0, 5, 3, 5, 2, 3, 5, 5 }, // COR
    { 4, 0, 5, 2, 4, 3, 5, 6, 3 }, // PUP
    { 4, 0, 4, 3, 5, 2, 6, 6, 2 }, // DNC
    { 5, 4, 6, 4, 5, 4, 2, 4, 3 }, // SCH
    { 4, 3, 6, 4, 4, 5, 2, 2, 5 }, // GEO
    { 2, 6, 3, 4, 5, 2, 4, 4, 6 }  // RUN
} };

/************************************************************************
 *                                                                        *
 *  Array with the levels of characteristics by race                      *
 *                                                                        *
 ************************************************************************/

std::array<std::array<uint8, 9>, 5> RaceGrades = { {
    // HP,MP,STR,DEX,VIT,AGI,INT,MND
    { 4, 4, 4, 4, 4, 4, 4, 4, 4 }, // Hume
    { 3, 5, 2, 5, 3, 6, 6, 2, 4 }, // Elvaan
    { 7, 1, 6, 4, 5, 3, 1, 5, 4 }, // Tarutaru
    { 4, 4, 5, 1, 5, 2, 4, 5, 6 }, // Mithra
    { 1, 7, 3, 4, 1, 5, 5, 4, 6 }, // Galka
} };

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
 *  Array with the levels of base stat scale per rank                     *
 *                                                                        *
 ************************************************************************/

std::array<std::array<float, 4>, 8> StatScale = { {
    // base<60    <75     >75
    { 0, 0, 0, 0 },             // 0
    { 5, 0.50f, 0.10f, 0.35f }, // A
    { 4, 0.45f, 0.20f, 0.35f }, // B
    { 4, 0.40f, 0.25f, 0.35f }, // C
    { 3, 0.35f, 0.35f, 0.35f }, // D
    { 3, 0.30f, 0.35f, 0.35f }, // E
    { 2, 0.25f, 0.40f, 0.35f }, // F
    { 2, 0.20f, 0.40f, 0.35f }, // G
} };

// Player HP and MP growth, race and job parts summed. Subjob adds half of its own job part
// https://docs.google.com/spreadsheets/d/1P1hKWKbeuUCNKoyzDGKzNE9p7K_bjX5VlqC4CSda8v0

// Race HP: value at level 1 and HP gained per level in the bands 2-10, 11-30, 31-50, 51-60 and 61-75, same past 75
constexpr std::array<std::array<uint8, 6>, 5> HpRace = { {
    // L1, 2-10, 11-30, 31-50, 51-60, 61-75
    { 17, 7, 9, 9, 10, 4 },   // Hume
    { 18, 8, 9, 10, 11, 4 },  // Elvaan
    { 16, 6, 8, 9, 10, 4 },   // Tarutaru
    { 17, 7, 9, 9, 10, 4 },   // Mithra
    { 19, 9, 10, 11, 12, 4 }, // Galka
} };

// Job HP per rank to 75
constexpr std::array<std::array<uint8, 6>, 8> HpJob = { {
    // L1, 2-10, 11-30, 31-50, 51-60, 61-75
    { 0, 0, 0, 0, 0, 0 },     // 0
    { 19, 9, 10, 11, 12, 4 }, // A
    { 17, 8, 9, 10, 11, 4 },  // B
    { 16, 7, 8, 9, 10, 4 },   // C
    { 14, 6, 7, 7, 8, 4 },    // D
    { 13, 5, 6, 6, 7, 3 },    // E
    { 11, 4, 5, 5, 6, 3 },    // F
    { 10, 3, 4, 4, 5, 3 },    // G
} };

// Job HP gained at each level from 76 to 99
constexpr std::array<std::array<uint8, 24>, 8> HpJobGainOver75 = { {
    // one entry per level, 76 through 99
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },              // 0
    { 10, 8, 10, 8, 10, 8, 10, 8, 10, 10, 8, 10, 8, 10, 8, 10, 10, 8, 10, 8, 10, 8, 10, 8 }, // A
    { 9, 9, 9, 9, 9, 8, 10, 8, 10, 9, 8, 10, 8, 10, 8, 9, 10, 8, 10, 8, 9, 9, 9, 9 },        // B
    { 9, 8, 10, 8, 9, 8, 9, 9, 9, 9, 8, 9, 9, 9, 8, 9, 9, 9, 9, 8, 9, 8, 10, 8 },            // C
    { 9, 8, 9, 8, 9, 8, 9, 8, 9, 9, 8, 9, 8, 9, 8, 9, 9, 8, 9, 8, 9, 8, 9, 8 },              // D
    { 9, 7, 9, 8, 8, 8, 9, 7, 9, 9, 7, 9, 8, 9, 7, 9, 9, 7, 9, 8, 8, 8, 9, 7 },              // E
    { 8, 8, 8, 7, 9, 7, 8, 8, 8, 8, 8, 8, 7, 8, 8, 8, 8, 8, 8, 7, 9, 7, 8, 8 },              // F
    { 8, 7, 8, 7, 8, 7, 8, 7, 8, 8, 7, 8, 7, 8, 7, 8, 8, 7, 8, 7, 8, 7, 8, 7 },              // G
} };

// Race MP: value at level 1, MP gained per level 2-60 and 61-75, same past 75
constexpr std::array<std::array<uint8, 3>, 5> MpRace = { {
    // L1, 2-60, 61-75
    { 14, 5, 4 }, // Hume
    { 12, 4, 4 }, // Elvaan
    { 16, 6, 4 }, // Tarutaru
    { 14, 5, 4 }, // Mithra
    { 8, 3, 4 },  // Galka
} };

// Race MP before the April 2014 update: value at level 1, gain per level 2-30, 31-60 and 61-75
constexpr std::array<std::array<uint8, 4>, 5> MpRacePre2014 = { {
    // L1, 2-30, 31-60, 61-75
    { 10, 3, 3, 4 }, // Hume
    { 8, 2, 3, 1 },  // Elvaan
    { 16, 6, 6, 4 }, // Tarutaru
    { 10, 3, 3, 4 }, // Mithra
    { 4, 1, 0, 1 },  // Galka
} };

// Job MP per rank: value at level 1, MP gained per level 2-60 and 61-75
constexpr std::array<std::array<uint8, 3>, 8> MpJob = { {
    // L1, 2-60, 61-75
    { 0, 0, 0 },  // 0
    { 16, 6, 4 }, // A
    { 14, 5, 4 }, // B
    { 12, 4, 4 }, // C
    { 10, 3, 4 }, // D
    { 0, 0, 0 },  // E (no MP job has this rank)
    { 6, 1, 2 },  // F
    { 0, 0, 0 },  // G (no MP job has this rank)
} };

// Job MP gained at each level from 76 to 99
constexpr std::array<std::array<uint8, 24>, 8> MpJobGainOver75 = { {
    // one entry per level, 76 through 99
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },                // 0
    { 8, 10, 8, 10, 10, 8, 10, 10, 8, 10, 10, 8, 10, 8, 10, 10, 8, 10, 10, 8, 10, 10, 8, 10 }, // A
    { 8, 9, 9, 9, 10, 8, 10, 9, 9, 9, 10, 8, 10, 8, 10, 9, 9, 9, 10, 8, 10, 9, 9, 9 },         // B
    { 8, 9, 8, 9, 10, 8, 9, 9, 9, 9, 9, 8, 10, 8, 9, 9, 9, 9, 9, 8, 10, 9, 8, 9 },             // C
    { 8, 9, 8, 9, 9, 8, 9, 9, 8, 9, 9, 8, 10, 8, 9, 9, 8, 9, 9, 8, 9, 9, 8, 9 },               // D
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },                // E
    { 6, 7, 7, 7, 8, 6, 7, 8, 6, 8, 7, 6, 8, 6, 8, 7, 6, 8, 7, 7, 7, 7, 7, 7 },                // F
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },                // G
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

// Player base stat growth per rank (A to G)
// https://docs.google.com/spreadsheets/d/1P1hKWKbeuUCNKoyzDGKzNE9p7K_bjX5VlqC4CSda8v0
// Value at level 1 in whole points, and gain per level from 2 to 60 in twentieths of a point (10 = 0.50)
constexpr std::array<std::array<uint8, 2>, 8> StatGrowth = { {
    // L1, 2-60
    { 0, 0 },  // 0
    { 5, 10 }, // A
    { 4, 9 },  // B
    { 4, 8 },  // C
    { 3, 7 },  // D
    { 3, 6 },  // E
    { 2, 5 },  // F
    { 2, 4 },  // G
} };

// Cumulative half points gained from level 61 to 75
// Ranks D/E and F/G share a schedule
constexpr std::array<std::array<uint8, 15>, 8> StatHalfPointsGained61To75 = { {
    { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },    // 0
    { 0, 0, 0, 0, 1, 1, 1, 1, 1, 2, 2, 2, 2, 2, 3 },    // A
    { 0, 0, 1, 1, 2, 2, 2, 3, 3, 4, 4, 4, 5, 5, 6 },    // B
    { 0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 7, 7, 8 },    // C
    { 0, 1, 2, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 9, 10 },   // D
    { 0, 1, 2, 2, 3, 4, 4, 5, 6, 7, 7, 8, 9, 9, 10 },   // E
    { 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 8, 9, 10, 11, 12 }, // F
    { 0, 1, 2, 3, 4, 4, 5, 6, 7, 8, 8, 9, 10, 11, 12 }, // G
} };

// Levels past 75 where no stat is gained, in ascending order
constexpr std::array<uint8, 6> StatPlateauLevelsOver75 = { 76, 80, 85, 89, 94, 98 };

namespace
{

// Number of levels a character at atLevel has gained inside the bracket [from, to]
auto levelsIn(const uint8 atLevel, const int32 from, const int32 to) -> int32
{
    return std::clamp<int32>(atLevel - from + 1, 0, to - from + 1);
}

// One banded HP table evaluated at a level, capped at 75 where the bands end
auto bandedHp(const std::array<uint8, 6>& growthTable, const uint8 atLevel) -> int32
{
    const auto& [atLevel1, gain2To10, gain11To30, gain31To50, gain51To60, gain61To75] = growthTable;

    const auto cappedLevel = std::min<uint8>(atLevel, 75);
    return atLevel1 +
           gain2To10 * levelsIn(cappedLevel, 2, 10) +
           gain11To30 * levelsIn(cappedLevel, 11, 30) +
           gain31To50 * levelsIn(cappedLevel, 31, 50) +
           gain51To60 * levelsIn(cappedLevel, 51, 60) +
           gain61To75 * levelsIn(cappedLevel, 61, 75);
}

// Job HP at a level: the banded growth through 75 plus the captured per-level gains past it
auto jobHp(const uint8 rank, const uint8 atLevel) -> int32
{
    auto hp = bandedHp(HpJob[rank], atLevel);
    for (int32 i = 0; i < levelsIn(atLevel, 76, 99); ++i)
    {
        hp += HpJobGainOver75[rank][i];
    }
    return hp;
}

// Race HP stops growing at 75
// Before the April 2014 update races used the job HP values at their racial HP grade
auto raceHp(const uint8 race, const uint8 atLevel) -> int32
{
    if (settings::get<bool>("main.USE_OLD_STAT_FORMULAS"))
    {
        return bandedHp(HpJob[grade::GetRaceGrades(race, 0)], atLevel);
    }
    return bandedHp(HpRace[race], atLevel);
}

// Job MP at a level: linear growth through 75 plus the captured per-level gains past it
auto jobMp(const uint8 rank, const uint8 atLevel) -> int32
{
    const auto& [atLevel1, gain2To60, gain61To75] = MpJob[rank];

    const auto cappedLevel = std::min<uint8>(atLevel, 75);

    auto mp = atLevel1 + gain2To60 * levelsIn(cappedLevel, 2, 60) + gain61To75 * levelsIn(cappedLevel, 61, 75);
    for (int32 i = 0; i < levelsIn(atLevel, 76, 99); ++i)
    {
        mp += MpJobGainOver75[rank][i];
    }
    return mp;
}

// Race MP stops growing at 75
auto raceMp(const uint8 race, const uint8 atLevel) -> int32
{
    const auto cappedLevel = std::min<uint8>(atLevel, 75);
    if (settings::get<bool>("main.USE_OLD_STAT_FORMULAS"))
    {
        const auto& [atLevel1, gain2To30, gain31To60, gain61To75] = MpRacePre2014[race];
        return atLevel1 + gain2To30 * levelsIn(cappedLevel, 2, 30) + gain31To60 * levelsIn(cappedLevel, 31, 60) + gain61To75 * levelsIn(cappedLevel, 61, 75);
    }
    const auto& [atLevel1, gain2To60, gain61To75] = MpRace[race];
    return atLevel1 + gain2To60 * levelsIn(cappedLevel, 2, 60) + gain61To75 * levelsIn(cappedLevel, 61, 75);
}

} // namespace

namespace grade
{

auto GetJobGrade(xi::Job job, uint8 stat) -> uint8
{
    return JobGrades[static_cast<uint8>(job)][stat];
}

uint8 GetRaceGrades(uint8 race, uint8 stat)
{
    return RaceGrades[race][stat];
}

float GetHPScale(uint8 rank, uint8 scale)
{
    return HPScale[rank][scale];
}

float GetMPScale(uint8 rank, uint8 scale)
{
    return MPScale[rank][scale];
}

float GetStatScale(uint8 rank, uint8 scale)
{
    return StatScale[rank][scale];
}

// Race, job and subjob parts are each rounded down to half points, then summed and rounded down once
// See USE_OLD_STAT_FORMULAS for the older behaviour, which rounds each part down to a whole point on its own
auto GetBaseStat(uint8 raceRank, uint8 jobRank, uint8 level, uint8 subJobRank, uint8 subLevel) -> uint16
{
    // Value of one component (race or job) at a level, in half points
    const auto halfPointsFor = [](uint8 rank, uint8 atLevel) -> int32
    {
        // Level used for the growth tables
        const auto cappedLevel = std::clamp<uint8>(atLevel, 1, 75);
        // Level ups that grant the per-level gain: none at level 1, no more after 60
        const auto levelsGained                = std::min<uint8>(cappedLevel, 60) - 1;
        const auto& [atLevel1, gainPerLevel20] = StatGrowth[rank];
        // Level 1 value plus the gains so far, computed in twentieths and rounded down to half points
        const auto halfPoints = (20 * atLevel1 + gainPerLevel20 * levelsGained) / 10;
        if (cappedLevel <= 60)
        {
            return halfPoints;
        }
        // 61 to 75 add a fixed per-rank schedule of half points instead of a rate
        return halfPoints + StatHalfPointsGained61To75[rank][cappedLevel - 61];
    };

    // Each component in half points
    const auto raceHalfPoints   = halfPointsFor(raceRank, level);
    const auto jobHalfPoints    = halfPointsFor(jobRank, level);
    const auto subJobHalfPoints = [&]() -> int32
    {
        if (subLevel == 0)
        {
            return 0;
        }
        return halfPointsFor(subJobRank, subLevel);
    }();

    // Plateau levels reached so far (the table is sorted, so it is the position of the first one above level)
    const auto plateauCount = std::ranges::upper_bound(StatPlateauLevelsOver75, level) - StatPlateauLevelsOver75.begin();
    // Whole points gained past 75: one per level, except at the plateau levels
    const auto pointsOver75 = std::max<int32>(0, level - 75 - static_cast<int32>(plateauCount));

    // Older retail rounded each component down to whole points, not 0.5
    if (settings::get<bool>("main.USE_OLD_STAT_FORMULAS"))
    {
        return static_cast<uint16>(raceHalfPoints / 2 + jobHalfPoints / 2 + subJobHalfPoints / 4 + pointsOver75);
    }

    // Current retail pools the half points and rounds down once, plus the post-75 gains
    return static_cast<uint16>((raceHalfPoints + jobHalfPoints + subJobHalfPoints / 2) / 2 + pointsOver75);
}

// Job and race HP are whole points added together
// Subjob adds half of its own job HP
// USE_OLD_STAT_FORMULAS selects the racial values from before the April 2014 update
auto GetBaseHP(uint8 race, uint8 jobRank, uint8 level, uint8 subJobRank, uint8 subLevel) -> uint16
{
    if (subLevel == 0)
    {
        return static_cast<uint16>(raceHp(race, level) + jobHp(jobRank, level));
    }

    return static_cast<uint16>(raceHp(race, level) + jobHp(jobRank, level) + jobHp(subJobRank, subLevel) / 2);
}

// MP is the same shape as HP. In order to get the racial MP, the job must have MP.
// If main job does not have MP then the racial part enters at the subjobs level, divided like the subjob itself
// The subjob fraction is 1/SJ_MP_DIVISOR, which is 2 on retail
// USE_OLD_STAT_FORMULAS selects the racial values from before the April 2014 update
auto GetBaseMP(uint8 race, uint8 jobRank, uint8 level, uint8 subJobRank, uint8 subLevel) -> uint16
{
    // MP grade 0 means the job brings no MP at all
    const auto mainHasMp = jobRank > 0;
    const auto subHasMp  = subLevel > 0 && subJobRank > 0;

    const auto subJobMpDivisor = settings::get<float>("map.SJ_MP_DIVISOR");

    if (mainHasMp && subHasMp)
    {
        return static_cast<uint16>(raceMp(race, level) + jobMp(jobRank, level) + static_cast<int32>(jobMp(subJobRank, subLevel) / subJobMpDivisor));
    }

    if (mainHasMp)
    {
        return static_cast<uint16>(raceMp(race, level) + jobMp(jobRank, level));
    }

    if (subHasMp)
    {
        return static_cast<uint16>(static_cast<int32>(raceMp(race, subLevel) / subJobMpDivisor) + static_cast<int32>(jobMp(subJobRank, subLevel) / subJobMpDivisor));
    }

    return 0;
}

uint8 GetMobHPScale(uint8 rank, uint8 scale)
{
    return MobHPScale[rank][scale];
}

}; // namespace grade
