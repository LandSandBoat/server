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

enum PATHFLAG
{
    PATHFLAG_NONE     = 0x00,
    PATHFLAG_RUN      = 0x01, // run at double speed
    PATHFLAG_WALLHACK = 0x02, // DEPRECATED - do not use. Kept so the 0x02 bit isn't silently reused.
    PATHFLAG_REVERSE  = 0x04, // reverse the point order
    PATHFLAG_SCRIPT   = 0x08, // don't overwrite before completion (except by another SCRIPT path)
    PATHFLAG_SLIDE    = 0x10, // slide to end point if close enough (unused in C++, reserved for Lua)
    PATHFLAG_PATROL   = 0x20, // loop the path continuously while roaming
    PATHFLAG_COORDS   = 0x40, // walk through to end; do not repeat
};
