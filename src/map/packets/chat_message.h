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

#ifndef _CCHATMESSAGEPACKET_H
#define _CCHATMESSAGEPACKET_H

#include "common/cbasetypes.h"

#include "basic.h"

// Extracted from client.
enum CHAT_MESSAGE_TYPE
{
    MESSAGE_SAY       = 0,
    MESSAGE_SHOUT     = 1,
    MESSAGE_UNKNOWN   = 2,
    MESSAGE_TELL      = 3,
    MESSAGE_PARTY     = 4,
    MESSAGE_LINKSHELL = 5,
    MESSAGE_SYSTEM_1  = 6, // Standard "printToPlayer" default if no type specified
    MESSAGE_SYSTEM_2  = 7, // Login / world announcement messages
    MESSAGE_EMOTION   = 8,
    // 9 / 10 / 11 = Does not work / nothing
    MESSAGE_GMPROMPT      = 12, // Menu prompt from GM
    MESSAGE_NS_SAY        = 13, // Same as MESSAGESAY but has no speaker object displayed
    MESSAGE_NS_SHOUT      = 14, // Same as MESSAGESHOUT but has no speaker object displayed
    MESSAGE_NS_PARTY      = 15, // Same as MESSAGEPARTY but has no speaker object displayed
    MESSAGE_NS_LINKSHELL  = 16, // Same as MESSAGELINKSHELL but has no speaker object displayed
    MESSAGE_UNKNOWN_17    = 17, // 17 through 25 appear to repeat the effects of other values
    MESSAGE_UNKNOWN_18    = 18,
    MESSAGE_UNKNOWN_19    = 19,
    MESSAGE_UNKNOWN_20    = 20,
    MESSAGE_UNKNOWN_21    = 21,
    MESSAGE_UNKNOWN_22    = 22,
    MESSAGE_UNKNOWN_23    = 23,
    MESSAGE_UNKNOWN_24    = 24,
    MESSAGE_UNKNOWN_25    = 25,
    MESSAGE_YELL          = 26,
    MESSAGE_LINKSHELL2    = 27, // Second LS color...Default is Green
    MESSAGE_NS_LINKSHELL2 = 28, // Same as LINKSHELL2 but has but has no speaker object displayed
    MESSAGE_SYSTEM_3      = 29, // "Basic system messages" in config menu. Yellow by default.
    MESSAGE_LINKSHELL3    = 30, // Yes really, it looks like a 3rd LS may have been planned at some point.
    MESSAGE_NS_LINKSHELL3 = 31, // (assumed, as it follows pattern and color)
    MESSAGE_UNKNOWN_32    = 32, // Looks the same as 31
    MESSAGE_UNITY         = 33,
    MESSAGE_JP_ASSIST     = 34,
    MESSAGE_NA_ASSIST     = 35,
};

// Made up, but if you edit this to change the order,
// You will break things that expect this order.
enum CHAT_MESSAGE_AREA
{
    MESSAGE_AREA_SYSTEM = 0, // All zones world wide
    MESSAGE_AREA_SAY    = 1, // Say range
    MESSAGE_AREA_SHOUT  = 2, // Shout
    MESSAGE_AREA_PARTY  = 3, // Party and Alliance
    MESSAGE_AREA_YELL   = 4, // Yell zones only
    MESSAGE_AREA_UNITY  = 5, // Currently -all- unities
};

class CCharEntity;

class CChatMessagePacket : public CBasicPacket
{
public:
    static const uint16 id{ 0x17 };
    CChatMessagePacket(CCharEntity* PChar, CHAT_MESSAGE_TYPE MessageType, std::string const& message, std::string const& sender = std::string());
};

#endif
