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

#include "login_helpers.h"

namespace loginHelpers
{
    // [ip_addr][session_hash] = session
    std::unordered_map<std::string, std::map<std::string, session_t>> authenticatedSessions_;

    std::unordered_map<std::string, std::map<std::string, session_t>>& getAuthenticatedSessions()
    {
        return authenticatedSessions_;
    }

    bool check_string(std::string const& str, std::size_t max_length)
    {
        // clang-format off
        return !str.empty() &&
        str.size() <= max_length &&
        std::all_of(str.cbegin(), str.cend(),
        [](char const& c)
        {
            return c >= 0x20;
        });
        // clang-format on
    }

    session_t& get_authenticated_session(std::string const& ipAddr, std::string const& sessionHash)
    {
        return authenticatedSessions_[ipAddr][sessionHash]; // NOTE: Will construct if doesn't exist
    }

    // hostname/ip conversion functions
    std::string ip2str(uint32 ip)
    {
        uint32 reversed_ip = htonl(ip);
        char   address[INET_ADDRSTRLEN];
        inet_ntop(AF_INET, &reversed_ip, address, INET_ADDRSTRLEN);
        return fmt::format("{}", str(address));
    }

    uint32 str2ip(const char* ip_str)
    {
        uint32 ip = 0;
        inet_pton(AF_INET, ip_str, &ip);

        return ntohl(ip);
    }

    // https://github.com/atom0s/XiPackets/blob/main/lobby/S2C_0x0004_ResponseError.md
    void generateErrorMessage(char* packet, uint16 errorCode)
    {
        std::memset(packet, 0, 0x24);

        packet[0] = 0x24; // size

        packet[4] = 0x49; // I
        packet[5] = 0x58; // X
        packet[6] = 0x46; // F
        packet[7] = 0x46; // F

        packet[8] = 0x04; // result

        packet[28] = 0x10; // This field is never referenced within the client. It was always observed to be 0x10, but the actual value or its purpose is unknown.

        ref<uint16>(packet, 32) = errorCode;

        unsigned char hash[16];
        md5(reinterpret_cast<uint8*>(packet), hash, 0x24);
        std::memcpy(packet + 12, hash, 16);
    }

    uint16 generateExpansionBitmask()
    {
        uint16 mask = EXPANSION_DISPLAY::BASE_GAME;

        std::map<std::string, uint16> expansions = {
            { "login.RISE_OF_ZILART", EXPANSION_DISPLAY::RISE_OF_ZILART },
            { "login.CHAINS_OF_PROMATHIA", EXPANSION_DISPLAY::CHAINS_OF_PROMATHIA },
            { "login.TREASURES_OF_AHT_URGHAN", EXPANSION_DISPLAY::TREASURES_OF_AHT_URGHAN },
            { "login.WINGS_OF_THE_GODDESS", EXPANSION_DISPLAY::WINGS_OF_THE_GODDESS },
            { "login.A_CRYSTALLINE_PROPHECY", EXPANSION_DISPLAY::A_CRYSTALLINE_PROPHECY },
            { "login.A_MOOGLE_KUPOD_ETAT", EXPANSION_DISPLAY::A_MOOGLE_KUPOD_ETAT },
            { "login.A_SHANTOTTO_ASCENSION", EXPANSION_DISPLAY::A_SHANTOTTO_ASCENSION },
            { "login.VISIONS_OF_ABYSSEA", EXPANSION_DISPLAY::VISIONS_OF_ABYSSEA },
            { "login.SCARS_OF_ABYSSEA", EXPANSION_DISPLAY::SCARS_OF_ABYSSEA },
            { "login.HEROES_OF_ABYSSEA", EXPANSION_DISPLAY::HEROES_OF_ABYSSEA },
            { "login.SEEKERS_OF_ADOULIN", EXPANSION_DISPLAY::SEEKERS_OF_ADOULIN },
        };

        // apply the expansion masks where available
        for (auto const& expansion : expansions)
        {
            if (settings::get<bool>(expansion.first))
            {
                mask |= expansion.second;
            }
        }
        return mask;
    }

    uint16 generateFeatureBitmask()
    {
        uint16 mask = 0;

        std::map<std::string, uint16> features = {
            { "login.SECURE_TOKEN", FEATURE_DISPLAY::SECURE_TOKEN }, // This needs to be broken out into auth calls once TOTP is supported
            { "login.MOG_WARDROBE_3", FEATURE_DISPLAY::MOG_WARDROBE_3 },
            { "login.MOG_WARDROBE_4", FEATURE_DISPLAY::MOG_WARDROBE_4 },
            { "login.MOG_WARDROBE_5", FEATURE_DISPLAY::MOG_WARDROBE_5 },
            { "login.MOG_WARDROBE_6", FEATURE_DISPLAY::MOG_WARDROBE_6 },
            { "login.MOG_WARDROBE_7", FEATURE_DISPLAY::MOG_WARDROBE_7 },
            { "login.MOG_WARDROBE_8", FEATURE_DISPLAY::MOG_WARDROBE_8 }
        };

        // apply the feature masks where available
        for (auto const& feature : features)
        {
            if (settings::get<bool>(feature.first))
            {
                mask |= feature.second;
            }
        }

        return mask;
    }

    int32 saveCharacter(uint32 accid, uint32 charid, char_mini* createchar)
    {
        auto _sql = std::make_unique<SqlConnection>();

        if (_sql->Query("INSERT INTO chars(charid,accid,charname,pos_zone,nation) VALUES(%u,%u,'%s',%u,%u);",
                        charid, accid, str(createchar->m_name), createchar->m_zone, createchar->m_nation) == SQL_ERROR)
        {
            ShowDebug(fmt::format("lobby_ccsave: char<{}>, accid: {}, charid: {}", str(createchar->m_name), accid, charid));
            return -1;
        }

        if (_sql->Query("INSERT INTO char_look(charid,face,race,size) VALUES(%u,%u,%u,%u);",
                        charid, createchar->m_look.face, createchar->m_look.race, createchar->m_look.size) == SQL_ERROR)
        {
            ShowDebug(fmt::format("lobby_cLook: char<{}>, charid: {}", str(createchar->m_name), charid));
            return -1;
        }

        if (_sql->Query("INSERT INTO char_stats(charid,mjob) VALUES(%u,%u);",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            ShowDebug(fmt::format("lobby_cStats: charid: {}", charid));
            return -1;
        }

        if (_sql->Query("INSERT INTO char_exp(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_jobs(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_points(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_unlocks(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_profile(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_storage(charid) VALUES(%u) ON DUPLICATE KEY UPDATE charid = charid;",
                        charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("DELETE FROM char_inventory WHERE charid = %u", charid) == SQL_ERROR)
        {
            return -1;
        }

        if (_sql->Query("INSERT INTO char_inventory(charid) VALUES(%u);", charid, createchar->m_mjob) == SQL_ERROR)
        {
            return -1;
        }

        if (settings::get<bool>("main.NEW_CHARACTER_CUTSCENE"))
        {
            if (_sql->Query("INSERT INTO char_vars(charid, varname, value) VALUES(%u, '%s', %u);",
                            charid, "HQuest[newCharacterCS]notSeen", 1) == SQL_ERROR)
            {
                return -1;
            }
        }
        return 0;
    }

    int32 createCharacter(session_t& session, char* buf)
    {
        auto      _sql = std::make_unique<SqlConnection>();
        char_mini createchar;

        std::memcpy(createchar.m_name, session.requestedNewCharacterName.c_str(), 16);

        createchar.m_look.race = ref<uint8>(buf, 48);
        createchar.m_look.size = ref<uint8>(buf, 57);
        createchar.m_look.face = ref<uint8>(buf, 60);

        // Validate that the job is a starting job.
        uint8 mjob        = ref<uint8>(buf, 50);
        createchar.m_mjob = std::clamp<uint8>(mjob, 1, 6);

        // Log that the character attempting to create a non-starting job.
        if (mjob != createchar.m_mjob)
        {
            ShowInfo(fmt::format("{} attempted to create invalid starting job {} substituting {}",
                                 session.requestedNewCharacterName, mjob, createchar.m_mjob));
        }

        createchar.m_nation = ref<uint8>(buf, 54);

        std::vector<uint32> bastokStartingZones   = { 0xEA, 0xEB, 0xEC };
        std::vector<uint32> sandoriaStartingZones = { 0xE6, 0xE7, 0xE8 };
        std::vector<uint32> windurstStartingZones = { 0xEE, 0xF0, 0xF1 };

        switch (createchar.m_nation)
        {
            case 0x02: // windy start
            {
                createchar.m_zone = windurstStartingZones[xirand::GetRandomNumber(3)];
                break;
            }
            case 0x01: // bastok start
            {
                createchar.m_zone = bastokStartingZones[xirand::GetRandomNumber(3)];
                break;
            }
            case 0x00: // sandy start
            {
                createchar.m_zone = sandoriaStartingZones[xirand::GetRandomNumber(3)];
                break;
            }
        }

        const char* fmtQuery = "SELECT max(charid) FROM chars";

        if (_sql->Query(fmtQuery) == SQL_ERROR)
        {
            return -1;
        }

        uint32 CharID = 0;

        if (_sql->NumRows() != 0)
        {
            _sql->NextRow();

            CharID = _sql->GetUIntData(0) + 1;
        }

        if (saveCharacter(session.accountID, CharID, &createchar) == -1)
        {
            return -1;
        }

        ShowDebug(fmt::format("char<{}> successfully saved", str(createchar.m_name)));
        return 0;
    }

    void PrintPacket(const char* data, uint32 size)
    {
        std::string message;

        for (size_t y = 0; y < size; y++)
        {
            message.append(fmt::sprintf("%02hhx ", data[y]));

            if (((y + 1) % 16) == 0)
            {
                message += "\n";
                ShowDebug(message);
                message.clear();
            }
        }

        if (message.length() > 0)
        {
            message += "\n";
            ShowDebug(message.c_str());
        }
    }

    std::string getHashFromPacket(std::string const& ip_str, char* data)
    {
        std::string hash = std::string(data + 12, 16);

        if (authenticatedSessions_[ip_str].find(hash) == authenticatedSessions_[ip_str].end())
        {
            return "";
        }
        return hash;
    }
} // namespace loginHelpers
