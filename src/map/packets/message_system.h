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

#ifndef _CMESSAGESYSTEMPACKET_H
#define _CMESSAGESYSTEMPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

// Found in ROM/27/76.dat
// clang-format off
enum class MSGSYSTEM : uint16
{
    // COULD_NOT_ENTER                  = 0,   // You could not enter the next area. (duplicate)
    // COULD_NOT_ENTER                  = 1,   // You could not enter the next area. (duplicate)
    COULD_NOT_ENTER                  = 2,   // You could not enter the next area.
    // COULD_NOT_ENTER                  = 3,   // You could not enter the next area. (duplicate)
    // COULD_NOT_ENTER                  = 4,   // You could not enter the next area. (duplicate)
    COULD_NOT_ENTER_YOUR_ROOM        = 5,   // You could not enter your room.

    YOU_CANNOT_INVITE_THAT_PERSON    = 23,  // You cannot invite that person at this time.

    YOU_DONT_HAVE_ANY                = 39,  // You don't have any <item>.

    EVENT_SKIPPED                    = 117, // Event skipped.

    CHOCOBO_REFUSED_TO_ENTER         = 138, // The chocobo refused to enter the next area.

    CANNOT_USE_COMMAND_AT_THE_MOMENT = 142, // You cannot use that command at the moment. Please try again later.

    CANNOT_WHILE_INVISIBLE           = 172, // You cannot use that command while invisible.

    CHARACTER_INFO_HIDDEN            = 175, // Your character information is now hidden.
    CHARACTER_INFO_SHOWN             = 176, // Your character information is now shown.

    TELL_RECIPITENT_AWAY             = 181, // Your tell was not received. The recipient is currently away.
    PERSON_ALREADY_IN_ALLIANCE       = 182, // That person is already in an alliance.
    UNABLE_TO_PROCESS_REQUEST        = 183, // Unable to process request.
    EXPANSION_PACK_NOT_REGISTERED    = 184, // Unable to enter next area. Expansion pack not registered.
    EXPANSION_PACK_NOT_INSTALLED     = 185, // Unable to enter next area. Expansion pack not installed.

    BLOCKAID_ACTIVATED               = 221, // Blockaid activated. Magical assistance, trades, party invites etc. from non-party/alliance characters will be blocked. This effect will continue until changing areas, or executing the "/blockaid off" command.
    BLOCKAID_CANCELED                = 222, // Blockaid canceled. Magical assistance, trades, party invites etc. from non-party/alliance characters will be allowed.
    BLOCKAID_CURRENTLY_ACTIVE        = 223, // Blockaid is currently active. ("/blockaid off" to cancel.)
    BLOCKAID_CURRENTLY_INACTIVE      = 224, // Blockaid is currently inactive.

    TARGET_IS_CURRENTLY_BLOCKING     = 225, // Target is currently blocking outside magical assistance, trades, and party invites.
    BLOCKED_BY_BLOCKAID              = 226, // Interaction from a non-party character was blocked by /blockaid.

    TRUST_NO_SEEKING_PARTY           = 296, // You cannot use Trust magic while seeking a party.
    TRUST_DELAY_NEW_PARTY_MEMBER     = 297, // While inviting a party member, you must wait a while before using Trust magic.
    TRUST_MAXIMUM_NUMBER             = 298, // You have called forth your maximum number of alter egos.
    TRUST_ALREADY_CALLED             = 299, // That alter ego has already been called forth.
    TRUST_NO_ENMITY                  = 300, // You cannot use Trust magic while having gained enmity.
    TRUST_SOLO_OR_LEADER             = 301, // You cannot use Trust magic unless you are solo or the party leader.
};
// clang-format on

class CMessageSystemPacket : public CBasicPacket
{
public:
    CMessageSystemPacket(uint32 param0, uint32 param1, MSGSYSTEM messageID);
};

#endif
