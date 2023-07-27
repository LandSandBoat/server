/*
===========================================================================

  Copyright (c) 2010-2019 Darkstar Dev Teams

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

#ifndef _CANTICHEAT_H
#define _CANTICHEAT_H

#include "common/cbasetypes.h"
#include "entities/charentity.h"

namespace anticheat
{
    // Cheat type as appears in the cheat id column in the cheat_incidents table.
    enum class CheatID : uint16
    {
        // Player attempted to speed up synth (craft) by injecting a synth done
        // (0x59) packet. If anti cheating is enabled this will cause all cheated
        // crafts to fail.
        // Argument is the time spent on synth animation.
        CHEAT_ID_FASTSYNTH = 1,
        // For boundary checks
        CHEAT_ID_LAST
    };

    enum CheatAction
    {
        // Do nothing, also indicates failure
        CHEAT_ACTION_NOTHING = 0x00,
        // Log the attempt in the cheat_incidents table
        CHEAT_ACTION_LOG = 0x01,
        // Block the cheating attempt
        CHEAT_ACTION_BLOCK = 0x02,
        // Send a warning message to the player
        CHEAT_ACTION_WARN = 0x04,
        // Jail the player
        CHEAT_ACTION_JAIL = 0x08,
        // For boundary checks
        CHEAT_ACTION_LAST
    };

    // Get the action bitmask of a given cheat type and potentially the warning
    // message associated with it.
    // cheatid - ID of the cheat to look up
    // warningmsg - If not NULL, receives the warning message associated with the cheat
    // warningsize - Size of the warning message buffer in bytes
    // returns the action bitmask
    CheatAction GetCheatPunitiveAction(CheatID cheatid, char* warningmsg, size_t warningsize);

    // Jail a given character. Used by the anti-cheat system if cheat severity
    // is over the cheat threshold.
    // PChar - Character to jail
    // cellid - Cell to jail the character in
    // returns true on success, false on failure
    bool JailChar(CCharEntity* PChar, uint32 cellid = 1);

    // Report a cheat, log into the incidents table and possibly jail the user
    // (according to the severity threshold in the map server configuration)
    // PChar - Character object eof the cheating player
    // cheatid - ID of the cheat caught
    // cheatarg - Optional argument (varies by cheat ID)
    // description - Optional text description to be logged
    // returns true on success, false on failure
    bool ReportCheatIncident(CCharEntity* PChar, CheatID cheatid, uint32 cheatarg = 0, const char* description = nullptr);

}; // namespace anticheat

#endif
