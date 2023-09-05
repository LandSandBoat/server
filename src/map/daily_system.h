/*
===========================================================================

Copyright (c) 2023 LandSandBoat Dev Teams

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

#ifndef _DAILYSYSTEM_H
#define _DAILYSYSTEM_H
#include "map.h"

namespace daily
{
    uint16 SelectItem(CCharEntity* player, uint8 dial);
    void   LoadDailyItems();
} // namespace daily

#endif //_DAILYSYSTEM_H
