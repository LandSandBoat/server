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
#include <common/utils.h>
#include <common/xirand.h>

#include "login_errors.h"
#include "nlohmann/json.hpp"
#include "session.h"

#include <iterator>

using json = nlohmann::json;

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

bool isStringMalformed(const std::string& str, std::size_t max_length);

session_t& get_authenticated_session(const std::string& ipAddr, const std::string& sessionHash);

// https://github.com/atom0s/XiPackets/blob/main/lobby/S2C_0x0004_ResponseError.md
void generateErrorMessage(uint8* packet, uint16 errorCode);

uint16 generateExpansionBitmask();

uint16 generateFeatureBitmask();

int32 saveCharacter(uint32 accid, uint32 charid, char_mini* createchar);

int32 createCharacter(session_t& session, uint8* buf);

std::string getHashFromPacket(const std::string& ip_str, uint8* data);

uint32 getAccountId(std::string accountName);

template <typename T>
struct always_false : std::false_type
{
};

template <typename T>
inline constexpr bool always_false_v = always_false<T>::value;

template <typename T>
inline std::optional<T> jsonGet(const json& jsonInput, std::string key)
{
    if (!jsonInput.contains(key))
    {
        return std::nullopt;
    }

    // Check types first, boolean can match a number
    if constexpr (std::is_same_v<T, std::string>)
    {
        if (!jsonInput[key].is_string())
        {
            return std::nullopt;
        }
    }
    else if constexpr (std::is_same_v<T, bool>)
    {
        if (!jsonInput[key].is_boolean())
        {
            return std::nullopt;
        }
    }
    else if constexpr (std::is_floating_point<T>::value)
    {
        if (!jsonInput[key].is_number_float())
        {
            return std::nullopt;
        }
    }
    else if constexpr (std::is_signed<T>::value)
    {
        if (!jsonInput[key].is_number_unsigned())
        {
            return std::nullopt;
        }
    }
    else if constexpr (std::is_unsigned<T>::value)
    {
        if (!jsonInput[key].is_number_unsigned())
        {
            return std::nullopt;
        }
    }
    else
    {
        static_assert(always_false_v<T>, "Trying to extract unsupported type from jsonGet");
    }

    return jsonInput[key].get<T>();
}

// Supposedly, there is template magic to do this inside the template above, but VC++ doesn't support it yet?
template <typename T, uint32_t size>
inline typename std::optional<std::array<T, size>> jsonGet(const json& jsonInput, std::string key)
{
    if (!jsonInput.contains(key))
    {
        return std::nullopt;
    }

    if (!jsonInput[key].is_array())
    {
        return std::nullopt;
    }

    if (jsonInput[key].size() != size)
    {
        return std::nullopt;
    }

    for (uint32_t i = 0; i < size; i++)
    {
        // JSON arrays can support mixed types, so make sure EVERY index is correct.
        if constexpr (std::is_signed<T>::value)
        {
            if (!jsonInput[key][i].is_number())
            {
                return std::nullopt;
            }
        }
        else if constexpr (std::is_unsigned<T>::value)
        {
            if (!jsonInput[key][i].is_number_unsigned())
            {
                return std::nullopt;
            }
        }
        else
        {
            static_assert(always_false_v<T>, "Trying to extract unsupported type from jsonGetArray");
        }
    }

    return jsonInput[key].get<std::array<T, size>>();
}

} // namespace loginHelpers
