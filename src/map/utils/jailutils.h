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

#ifndef _JAILUTILS_H
#define _JAILUTILS_H

#include "../../common/cbasetypes.h"

/*
TODO: Add functions that can:
    * Jail or pardon on-line players.  (Currently handled in script.)
    * Jail or pardon off-line players.
    * Check the prison status of players. (on-line and off-line)
    * Ban or allow account access. (on-line and off-line)
    * Set duration of jail/ban sentences.

TODO: Common actions/procedures/needs include:
    * Set/Check char_var to indicate being character being jailed.
    * Set/Check accounts_banned to indicate account being banned.
    * Set/Check jail/ban sentence duration.
    * Moving character to and from Mordion Gaol. (on-line and off-line)
        - Off-line players could be moved upon login.
*/

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CCharEntity;

namespace jailutils
{
    bool InPrison(CCharEntity* PChar);

    void Add(CCharEntity* PChar);
    void Del(CCharEntity* PChar);
}; // namespace jailutils

#endif
