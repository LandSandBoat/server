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

#pragma once

#include <map>

#include <common/md52.h>
#include <common/mmo.h>
#include <common/socket.h> // for ref<T>
#include <common/sql.h>
#include <common/xirand.h>

#include "login_errors.h"
#include "session.h"

namespace loginHelpers
{
    std::unordered_map<std::string, std::map<std::string, session_t>>& getAuthenticatedSessions();

    // Displays expansions on main menu. // May be a 32 bit integer on the client.
    enum EXPANSION_DISPLAY : uint16
    {
        BASE_GAME               = 0x0001, // not used by the client
        RISE_OF_ZILART          = 0x0002,
        CHAINS_OF_PROMATHIA     = 0x0004,
        TREASURES_OF_AHT_URGHAN = 0x0008,
        WINGS_OF_THE_GODDESS    = 0x0010,
        A_CRYSTALLINE_PROPHECY  = 0x0020,
        A_MOOGLE_KUPOD_ETAT     = 0x0040,
        A_SHANTOTTO_ASCENSION   = 0x0080,
        VISIONS_OF_ABYSSEA      = 0x0100,
        SCARS_OF_ABYSSEA        = 0x0200,
        HEROES_OF_ABYSSEA       = 0x0400,
        SEEKERS_OF_ADOULIN      = 0x0800,
        UNUSED_EXPANSION_1      = 0x1000,
        UNUSED_EXPANSION_2      = 0x2000,
        UNUSED_EXPANSION_3      = 0x4000,
        UNUSED_EXPANSION_4      = 0x8000,
    };

    // Displays features on main menu // May be a 32 bit integer on the client.
    enum FEATURE_DISPLAY : uint16
    {
        SECURE_TOKEN     = 0x0001,
        UNUSED_FEATURE_1 = 0x0002,
        MOG_WARDROBE_3   = 0x0004,
        MOG_WARDROBE_4   = 0x0008,
        MOG_WARDROBE_5   = 0x0010,
        MOG_WARDROBE_6   = 0x0020,
        MOG_WARDROBE_7   = 0x0040,
        MOG_WARDROBE_8   = 0x0080,
        UNUSED_FEATURE_2 = 0x0100,
        UNUSED_FEATURE_3 = 0x0200,
        UNUSED_FEATURE_4 = 0x0400,
        UNUSED_FEATURE_5 = 0x0800,
        UNUSED_FEATURE_6 = 0x1000,
        UNUSED_FEATURE_7 = 0x2000,
        UNUSED_FEATURE_8 = 0x4000,
        UNUSED_FEATURE_9 = 0x8000,
    };

    bool check_string(std::string const& str, std::size_t max_length);

    session_t& get_authenticated_session(std::string const& ipAddr, std::string const& sessionHash);

    // hostname/ip conversion functions
    std::string ip2str(uint32 ip);

    uint32 str2ip(const char* ip_str);

    // https://github.com/atom0s/XiPackets/blob/main/lobby/S2C_0x0004_ResponseError.md
    void generateErrorMessage(char* packet, uint16 errorCode);

    uint16 generateExpansionBitmask();

    uint16 generateFeatureBitmask();

    int32 saveCharacter(uint32 accid, uint32 charid, char_mini* createchar);

    int32 createCharacter(session_t& session, char* buf);

    void PrintPacket(const char* data, uint32 size);

    std::string getHashFromPacket(std::string const& ip_str, char* data);
} // namespace loginHelpers
