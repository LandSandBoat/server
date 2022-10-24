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

#ifndef _GRADES_H
#define _GRADES_H

#include "../common/cbasetypes.h"

#include "entities/battleentity.h"

namespace grade
{
    uint8 GetJobGrade(JOBTYPE job, uint8 stat);
    uint8 GetRaceGrades(uint8 race, uint8 stat);

    float GetHPScale(uint8 rank, uint8 scale);
    float GetMPScale(uint8 rank, uint8 scale);
    float GetStatScale(uint8 rank, uint8 scale);
    float GetMobHPScale(uint8 rank, uint8 scale);
    float GetMobRBI(uint8 rank, uint8 scale);
}; // namespace grade

#endif
