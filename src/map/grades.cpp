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
    { 3, 0, 2, 4, 3, 4, 6, 5, 3 }, // DRG
    { 7, 1, 6, 5, 6, 4, 2, 2, 2 }, // SMN
    { 4, 4, 5, 5, 5, 5, 5, 5, 5 }, // BLU
    { 4, 0, 5, 3, 5, 2, 3, 5, 5 }, // COR
    { 4, 0, 5, 2, 4, 3, 5, 6, 3 }, // PUP
    { 4, 0, 4, 3, 5, 2, 6, 6, 2 }, // DNC
    { 5, 4, 6, 4, 5, 4, 3, 4, 3 }, // SCH
    { 3, 2, 6, 4, 5, 4, 3, 3, 4 }, // GEO
    { 3, 6, 3, 4, 5, 2, 4, 4, 6 }  // RUN
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

/************************************************************************
 *                                                                        *
 *  Random Increment based on level                                       *
 *                                                                        *
 ************************************************************************/

std::array<std::array<float, 2>, 6> MobRBI = { {
    // RI | Scale
    { 0, 0 },  // 0
    { 1, 0 },  // 1
    { 2, 0 },  // 2
    { 3, 3 },  // 3
    { 4, 7 },  // 4
    { 5, 14 }, // 5
} };

namespace grade
{
    uint8 GetJobGrade(JOBTYPE job, uint8 stat)
    {
        return JobGrades[job][stat];
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

    float GetMobHPScale(uint8 rank, uint8 scale)
    {
        return MobHPScale[rank][scale];
    }

    float GetMobRBI(uint8 rank, uint8 scale)
    {
        return MobRBI[rank][scale];
    }

}; // namespace grade
