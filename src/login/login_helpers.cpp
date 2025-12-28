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

bool isStringMalformed(const std::string& str, std::size_t max_length)
{
    const auto unprintableChar = [](char const& c) -> bool
    {
        return c < 0x20;
    };

    const bool isEmpty   = str.empty();
    const bool isTooLong = str.size() > max_length;

    const bool hasInvalidChar = std::any_of(
        str.cbegin(),
        str.cend(),
        unprintableChar);

    return isEmpty || isTooLong || hasInvalidChar;
}

session_t& get_authenticated_session(const std::string& ipAddr, const std::string& sessionHash)
{
    return authenticatedSessions_[ipAddr][sessionHash]; // NOTE: Will construct if doesn't exist
}

// https://github.com/atom0s/XiPackets/blob/main/lobby/S2C_0x0004_ResponseError.md
void generateErrorMessage(uint8* packet, uint16 errorCode)
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

    uint8 hash[16];
    md5(packet, hash, 0x24);
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
    for (const auto& expansion : expansions)
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
    for (const auto& feature : features)
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
    const auto charName = asStringFromUntrustedSource(createchar->m_name);

    if (!db::preparedStmt("INSERT INTO chars(charid,accid,charname,pos_zone,nation) VALUES(?, ?, ?, ?, ?)", charid, accid, charName, createchar->m_zone, createchar->m_nation))
    {
        ShowDebug(fmt::format("lobby_ccsave: char<{}>, accid: {}, charid: {}", charName, accid, charid));
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_look(charid,face,race,size) VALUES(?, ?, ?, ?)", charid, createchar->m_look.face, createchar->m_look.race, createchar->m_look.size))
    {
        ShowDebug(fmt::format("lobby_cLook: char<{}>, charid: {}", charName, charid));
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_stats(charid,mjob) VALUES(?, ?)", charid, createchar->m_mjob))
    {
        ShowDebug(fmt::format("lobby_cStats: charid: {}", charid));
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_exp(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_flags(charid) VALUES(?) ON DUPLICATE KEY UPDATE disconnecting = disconnecting", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_jobs(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_points(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_unlocks(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_profile(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_storage(charid) VALUES(?) ON DUPLICATE KEY UPDATE charid = charid", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("DELETE FROM char_inventory WHERE charid = ?", charid))
    {
        return -1;
    }

    if (!db::preparedStmt("INSERT INTO char_inventory(charid) VALUES(?)", charid))
    {
        return -1;
    }

    if (settings::get<bool>("main.NEW_CHARACTER_CUTSCENE"))
    {
        if (!db::preparedStmt("INSERT INTO char_vars(charid, varname, value) VALUES(?, ?, ?)",
                              charid,
                              "HQuest[newCharacterCS]notSeen",
                              1))
        {
            return -1;
        }
    }
    return 0;
}

int32 createCharacter(session_t& session, uint8* buf)
{
    char_mini createchar{};

    std::memcpy(createchar.m_name, session.requestedNewCharacterName.c_str(), 16);

    const auto charName = asStringFromUntrustedSource(createchar.m_name);

    createchar.m_look.race = ref<uint8>(buf, 48);
    createchar.m_look.size = ref<uint8>(buf, 57);
    createchar.m_look.face = ref<uint8>(buf, 60);

    if (createchar.m_look.race < 1 || createchar.m_look.race > 8) // 1(HumeM) to 8(Galka)
    {
        ShowError(fmt::format("{} attempted to create character with invalid race {}", charName, createchar.m_look.race));
        return -1;
    }

    if (createchar.m_look.size > 2) // Large
    {
        ShowError(fmt::format("{} attempted to create character with invalid size {}", charName, createchar.m_look.size));
        return -1;
    }

    if (createchar.m_look.face > 15) // Face 8B
    {
        ShowError(fmt::format("{} attempted to create character with invalid face {}", charName, createchar.m_look.face));
        return -1;
    }

    // Validate that the job is a starting job.
    uint8 mjob        = ref<uint8>(buf, 50);
    createchar.m_mjob = std::clamp<uint8>(mjob, 1, 6);

    // Log that the character attempting to create a non-starting job.
    if (mjob != createchar.m_mjob)
    {
        ShowInfo(fmt::format("{} attempted to create invalid starting job {} substituting {}",
                             charName,
                             mjob,
                             createchar.m_mjob));
    }

    createchar.m_nation = ref<uint8>(buf, 54);

    if (createchar.m_nation > 2) // 0x00 = San d'Oria, 0x01 = Bastok, 0x02 = Windurst
    {
        ShowError(fmt::format("{} attempted to create character with invalid nation {}", charName, createchar.m_nation));
        return -1;
    }

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

    const auto rset = db::preparedStmt("SELECT COALESCE(MAX(charid), 0) AS max_id FROM chars");
    if (!rset)
    {
        return -1;
    }

    uint32 charID = 0;
    if (rset->rowsCount() != 0 && rset->next())
    {
        charID = rset->get<uint32>("max_id") + 1;
    }

    if (saveCharacter(session.accountID, charID, &createchar) == -1)
    {
        return -1;
    }

    ShowDebug(fmt::format("char <{}> successfully saved", charName));
    return 0;
}

std::string getHashFromPacket(const std::string& ip_str, uint8* data)
{
    auto hash = asStringFromUntrustedSource(data + 12, 16);
    if (authenticatedSessions_[ip_str].find(hash) == authenticatedSessions_[ip_str].end())
    {
        return "";
    }
    return hash;
}

uint32 getAccountId(std::string accountName)
{
    const auto rset = db::preparedStmt("SELECT id FROM accounts WHERE accounts.login = ? LIMIT 1", accountName);
    if (rset && rset->next())
    {
        return rset->get<uint32>("id");
    }

    return 0;
}

} // namespace loginHelpers
