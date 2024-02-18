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
enum MSGSYSTEM_ID : uint16
{
    // MSGSYSTEM_COULD_NOT_ENTER                  = 0,   // You could not enter the next area. (duplicate)
    // MSGSYSTEM_COULD_NOT_ENTER                  = 1,   // You could not enter the next area. (duplicate)
    MSGSYSTEM_COULD_NOT_ENTER                  = 2,   // You could not enter the next area.
    // MSGSYSTEM_COULD_NOT_ENTER                  = 3,   // You could not enter the next area. (duplicate)
    // MSGSYSTEM_COULD_NOT_ENTER                  = 4,   // You could not enter the next area. (duplicate)
    MSGSYSTEM_COULD_NOT_ENTER_YOUR_ROOM        = 5,   // You could not enter your room.

    MSGSYSTEM_YOU_CANNOT_INVITE_THAT_PERSON    = 23,  // You cannot invite that person at this time.

    MSGSYSTEM_YOU_DONT_HAVE_ANY                = 39,  // You don't have any <item>.

    MSGSYSTEM_CHOCOBO_REFUSED_TO_ENTER         = 138, // The chocobo refused to enter the next area.

    MSGSYSTEM_CANNOT_USE_COMMAND_AT_THE_MOMENT = 142, // You cannot use that command at the moment. Please try again later.

    MSGSYSTEM_CANNOT_WHILE_INVISIBLE           = 172, // You cannot use that command while invisible.

    MSGSYSTEM_CHARACTER_INFO_HIDDEN            = 175, // Your character information is now hidden.
    MSGSYSTEM_CHARACTER_INFO_SHOWN             = 176, // Your character information is now shown.

    MSGSYSTEM_TELL_RECIPITENT_AWAY             = 181, // Your tell was not received. The recipient is currently away.
    MSGSYSTEM_PERSON_ALREADY_IN_ALLIANCE       = 182, // That person is already in an alliance.
    MSGSYSTEM_UNABLE_TO_PROCESS_REQUEST        = 183, // Unable to process request.
    MSGSYSTEM_EXPANSION_PACK_NOT_REGISTERED    = 184, // Unable to enter next area. Expansion pack not registered.
    MSGSYSTEM_EXPANSION_PACK_NOT_INSTALLED     = 185, // Unable to enter next area. Expansion pack not installed.

    MSGSYSTEM_BLOCKAID_ACTIVATED               = 221, // Blockaid activated. Magical assistance, trades, party invites etc. from non-party/alliance characters will be blocked. This effect will continue until changing areas, or executing the "/blockaid off" command.
    MSGSYSTEM_BLOCKAID_CANCELED                = 222, // Blockaid canceled. Magical assistance, trades, party invites etc. from non-party/alliance characters will be allowed.
    MSGSYSTEM_BLOCKAID_CURRENTLY_ACTIVE        = 223, // Blockaid is currently active. ("/blockaid off" to cancel.)
    MSGSYSTEM_BLOCKAID_CURRENTLY_INACTIVE      = 224, // Blockaid is currently inactive.

    MSGSYSTEM_TARGET_IS_CURRENTLY_BLOCKING     = 225, // Target is currently blocking outside magical assistance, trades, and party invites.
    MSGSYSTEM_BLOCKED_BY_BLOCKAID              = 226, // Interaction from a non-party character was blocked by /blockaid.

    MSGSYSTEM_TRUST_NO_SEEKING_PARTY           = 296, // You cannot use Trust magic while seeking a party.
    MSGSYSTEM_TRUST_DELAY_NEW_PARTY_MEMBER     = 297, // While inviting a party member, you must wait a while before using Trust magic.
    MSGSYSTEM_TRUST_MAXIMUM_NUMBER             = 298, // You have called forth your maximum number of alter egos.
    MSGSYSTEM_TRUST_ALREADY_CALLED             = 299, // That alter ego has already been called forth.
    MSGSYSTEM_TRUST_NO_ENMITY                  = 300, // You cannot use Trust magic while having gained enmity.
    MSGSYSTEM_TRUST_SOLO_OR_LEADER             = 301, // You cannot use Trust magic unless you are solo or the party leader.
};
// clang-format on

class CMessageSystemPacket : public CBasicPacket
{
public:
    CMessageSystemPacket(uint32 param0, uint32 param1, uint16 messageID);
};

#endif
