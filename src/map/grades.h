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

#pragma once

#include "common/cbasetypes.h"

#include "entities/battle_entity.h"

namespace grade
{

void LoadGrades();

auto GetJobGrade(xi::Job job, uint8 stat) -> uint8;
auto GetRaceGrades(uint8 race, uint8 stat) -> uint8;
auto GetHPScale(uint8 rank, uint8 scale) -> float;
auto GetMPScale(uint8 rank, uint8 scale) -> float;
auto GetBaseStat(uint8 raceRank, uint8 jobRank, uint8 level, uint8 subJobRank, uint8 subLevel) -> uint16;
auto GetBaseHP(uint8 race, uint8 jobGrade, uint8 level, uint8 subJobGrade, uint8 subLevel) -> uint16;
auto GetBaseMP(uint8 race, uint8 jobGrade, uint8 level, uint8 subJobGrade, uint8 subLevel) -> uint16;
auto GetMobHPScale(uint8 rank, uint8 scale) -> uint8;

}; // namespace grade
