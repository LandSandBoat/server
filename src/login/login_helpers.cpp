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

#include "common/md52.h"
#include <common/lua.h>

#include <common/types/hash_map.h>

#include "common/enum_traits.h"
#include "data/datasets/zones/mobs/dataset.h"
#include "data/datasets/zones/npcs/dataset.h"
#include "data/datasets/zones/settings/dataset.h"
#include "data/enums/zone.h"
#include "data/enums/zone_type.h"
#include "data/loader.h"

#include <array>
#include <fstream>
#include <unordered_set>

namespace loginHelpers
{

namespace
{

using NameHash = std::array<uint8, 16>;

auto md5Of(char* text, std::size_t length) -> NameHash
{
    NameHash out{};
    md5(reinterpret_cast<uint8*>(text), out.data(), static_cast<int32>(length));
    return out;
}

auto contains(const std::vector<NameHash>& set, const NameHash& hash) -> bool
{
    return std::ranges::binary_search(set, hash);
}

struct BadNameSets
{
    std::vector<NameHash> exact;
    std::vector<NameHash> substr;
    std::vector<NameHash> prefix;
    std::vector<NameHash> suffix;
};

// Loads sets of bad names and returns a cached copy on subsequent calls
//
// res/badnames.bin is NOT the retail dictionaries (entrynw/entry/entry_f/entry_b.dic).
// It is a custom format derived from them: each entry is MD5-hashed and all four categories are packed together into a single file.
//
// Format:
// uint32 magic ("BNF1")
// uint32 counts[4] - Number of entries per category (exact, substring, prefix, suffix)
// Followed by four blocks of N ("counts") MD5 digests (16 bytes each)
auto badNames() -> const BadNameSets&
{
    static const BadNameSets sets = []
    {
        BadNameSets   s;
        std::ifstream file("res/badnames.bin", std::ios::binary);
        char          magic[4]{};
        uint32        counts[4]{};

        if (!file.read(magic, sizeof(magic)) || std::memcmp(magic, "BNF1", sizeof(magic)) != 0 ||
            !file.read(reinterpret_cast<char*>(counts), sizeof(counts)))
        {
            ShowWarningFmt("Character name filter (res/badnames.bin) missing or malformed; disabled.");
            return s;
        }

        const auto readBlock = [&](const uint32 count)
        {
            std::vector<NameHash> out;
            for (NameHash h{}; out.size() < count && file.read(reinterpret_cast<char*>(h.data()), h.size());)
            {
                out.push_back(h);
            }

            std::ranges::sort(out);
            return out;
        };

        s.exact  = readBlock(counts[0]);
        s.substr = readBlock(counts[1]);
        s.prefix = readBlock(counts[2]);
        s.suffix = readBlock(counts[3]);

        ShowInfoFmt("Loaded character name filters ({} exact, {} substring, {} prefix, {} suffix)",
                    s.exact.size(),
                    s.substr.size(),
                    s.prefix.size(),
                    s.suffix.size());
        return s;
    }();

    return sets;
}

// Character name vulgarity check
// Mirrors retail client logic 1:1
auto isVulgarName(const std::string& name) -> bool
{
    // Run all checks against lowercased string
    std::string       canon                     = to_lower(name);
    const std::size_t n                         = canon.size();
    const auto& [exact, substr, prefix, suffix] = badNames();

    // 1. Name cannot match ANY entry in the "exact" set
    if (contains(exact, md5Of(canon.data(), n)))
    {
        return true;
    }

    // 2. Name cannot contain any substring from the "substr" set
    for (std::size_t i = 0; i < n; ++i)
    {
        for (std::size_t len = 2; i + len <= n; ++len)
        {
            const NameHash hash = md5Of(canon.data() + i, len);
            // 3. Name cannot be prefixed by any entry in the "prefix" set
            if (contains(substr, hash) || (i == 0 && contains(prefix, hash)))
            {
                return true;
            }
        }
    }

    // 4. Name cannot end with any entry in the "suffix" set
    // Note: Retail handling here is a little odd and only cares about the leftmost match.
    //   Cliff -> blocked
    //   Cliffaff -> not blocked
    for (std::size_t i = 0; i < n; ++i)
    {
        for (std::size_t len = 2; i + len <= n; ++len)
        {
            if (contains(suffix, md5Of(canon.data() + i, len)))
            {
                return i + len == n;
            }
        }
    }

    return false;
}

auto comparableName(const std::string_view name) -> std::string
{
    std::string comparable;
    comparable.reserve(name.size());
    for (auto ch : name)
    {
        if (ch == '-' || ch == '_')
        {
            continue;
        }

        if (ch >= 'a' && ch <= 'z')
        {
            ch -= ('a' - 'A');
        }

        comparable.push_back(ch);
    }

    return comparable;
}

// Every name the client can see on an npc or a mob, read once.
// Zone entities come from the zone files.
// Trusts, pets and instance-only entities are still rows in the SQL tables.
auto entityNames() -> const std::unordered_set<std::string>&
{
    static const auto names = []
    {
        std::unordered_set<std::string> collected;

        const auto poolNames = db::preparedStmt("SELECT packet_name FROM mob_pools WHERE packet_name != ''");
        FOR_DB_MULTIPLE_RESULTS(poolNames)
        {
            collected.emplace(comparableName(poolNames->get<std::string>("packet_name")));
        }

        const auto npcNames = db::preparedStmt("SELECT polutils_name FROM npc_list WHERE polutils_name != ''");
        FOR_DB_MULTIPLE_RESULTS(npcNames)
        {
            collected.emplace(comparableName(npcNames->get<std::string>("polutils_name")));
        }

        for (const auto& [key, zoneId] : xi::data::EnumTraits<xi::ZoneId>::kEntries)
        {
            if (const auto npcs = xi::data::loadZoneFile<xi::data::datasets::zones::npcs::Dataset>(zoneId))
            {
                for (const auto& npc : *npcs)
                {
                    if (!npc.DisplayName.empty())
                    {
                        collected.emplace(comparableName(npc.DisplayName));
                    }
                }
            }

            if (const auto mobs = xi::data::loadZoneFile<xi::data::datasets::zones::mobs::Dataset>(zoneId))
            {
                for (const auto& [templateName, mobTemplate] : mobs->Templates)
                {
                    collected.emplace(comparableName(mobTemplate.DisplayName));
                }
            }
        }

        return collected;
    }();

    return names;
}

} // namespace

Maybe<std::string> validateCharacterName(const std::string& name)
{
    // Sanitize name & check for invalid characters
    for (const auto& letter : name)
    {
        if (!std::isalpha(static_cast<unsigned char>(letter)))
        {
            return "Invalid characters present in name.";
        }
    }

    // Check for invalid length name
    // NOTE: The client checks for this. This is to guard against packet injection.
    if (name.size() < 3 || name.size() > 15)
    {
        return "Invalid name length.";
    }

    // Check if the name is already in use by another character
    const auto rset0 = db::preparedStmt("SELECT charname FROM chars WHERE charname LIKE ?", name);
    if (!rset0)
    {
        return "Internal entity name query failed.";
    }
    else if (rset0->rowsCount() != 0)
    {
        return "Name already in use.";
    }

    // (optional) Check if the name is in use by NPC or Mob entities
    if (settings::get<bool>("login.DISABLE_MOB_NPC_CHAR_NAMES"))
    {
        if (entityNames().contains(comparableName(name)))
        {
            return "Name already in use.";
        }
    }

    // TODO: Don't raw-access Lua like this outside of Lua helper code.
    // (optional) Check if the name contains any words on the bad word list
    const auto loginSettingsTable = lua["xi"]["settings"]["login"].get<sol::table>();
    if (auto badWordsList = loginSettingsTable.get_or<sol::table>("BANNED_WORDS_LIST", sol::lua_nil); badWordsList.valid())
    {
        const auto potentialName = to_upper(name);
        for (const auto& entry : badWordsList)
        {
            const auto badWord = to_upper(entry.second.as<std::string>());
            if (potentialName.find(badWord) != std::string::npos)
            {
                return fmt::format("Name matched with bad words list <{}>.", badWord);
            }
        }
    }

    // Retail name vulgarity check.
    if (isVulgarName(name))
    {
        return "Name matched the character name filter.";
    }

    return std::nullopt;
}

// [ip_addr][session_hash] = session
HashMap<std::string, std::map<std::string, session_t>> authenticatedSessions_;

HashMap<std::string, std::map<std::string, session_t>>& getAuthenticatedSessions()
{
    return authenticatedSessions_;
}

bool isStringMalformed(const std::string& str, std::size_t max_length)
{
    const auto unprintableChar = [](const char& c) -> bool
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

auto instancedZones() -> const std::unordered_set<xi::ZoneId>&
{
    static const auto zones = []
    {
        std::unordered_set<xi::ZoneId> instanced;
        for (const auto& [name, zoneId] : xi::data::EnumTraits<xi::ZoneId>::kEntries)
        {
            const auto settings = xi::data::loadZoneFile<xi::data::datasets::zones::settings::Dataset>(zoneId);
            if (settings && (settings->Type & xi::ZoneType::Instanced) != xi::ZoneType::Unknown)
            {
                instanced.insert(zoneId);
            }
        }

        return instanced;
    }();

    return zones;
}

void loadZoneLookups()
{
    instancedZones();

    // The name set is the expensive one, and only this setting reads it.
    if (settings::get<bool>("login.DISABLE_MOB_NPC_CHAR_NAMES"))
    {
        entityNames();
    }
}

auto isZoneAtPlayerCap(const xi::ZoneId zoneId, const bool isGM) -> bool
{
    const auto cap = settings::get<uint16>("map.ZONE_PLAYER_CAP");
    if (cap == 0)
    {
        return false;
    }

    const auto reserved  = settings::get<uint16>("map.ZONE_PLAYER_GM_RESERVED");
    const auto threshold = isGM ? cap : static_cast<uint16>(cap > reserved ? cap - reserved : 0);

    if (instancedZones().contains(zoneId))
    {
        return false;
    }

    const auto rset = db::preparedStmt(
        "SELECT COUNT(*) AS pop FROM accounts_sessions s "
        "JOIN chars c ON c.charid = s.charid "
        "WHERE c.pos_zone = ?",
        zoneId);

    FOR_DB_SINGLE_RESULT(rset)
    {
        return rset->get<uint32>("pop") >= threshold;
    }

    return false;
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

uint16 generateFeatureBitmask(const bool& needsOTP)
{
    uint16 mask = 0;

    std::map<std::string, uint16> features = {
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

    if (needsOTP)
    {
        mask |= FEATURE_DISPLAY::SECURE_TOKEN;
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

int32 createCharacter(session_t& session, uint8* buf, lpkt_chr_info_sub2& charInfo)
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

    const std::vector<xi::ZoneId> bastokStartingZones   = { xi::ZoneId::BastokMines, xi::ZoneId::BastokMarkets, xi::ZoneId::PortBastok };
    const std::vector<xi::ZoneId> sandoriaStartingZones = { xi::ZoneId::SouthernSanDoria, xi::ZoneId::NorthernSanDoria, xi::ZoneId::PortSanDoria };
    const std::vector<xi::ZoneId> windurstStartingZones = { xi::ZoneId::WindurstWaters, xi::ZoneId::PortWindurst, xi::ZoneId::WindurstWoods };

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

    // The client expects to fill some data in on character creation. We never _see_ the character, so we don't need to set Race/Face/Model etc.
    // We are making an assumption on what it wants - so for now just copy what is probably required (name, charid and some other stuff related to IDs.)
    std::memcpy(&charInfo.character_name, charName.c_str(), std::min(charName.size(), sizeof(charInfo.character_name)));

    uint8  worldId     = 0;      // Use when multiple worlds are supported.
    uint32 contentId   = charID; // Reusing the character ID as the content ID (which is also the name of character folder within the USER directory) at the moment
    uint16 charIdMain  = charID & 0xFFFF;
    uint8  charIdExtra = (charID >> 16) & 0xFF;

    charInfo.ffxi_id           = contentId;
    charInfo.ffxi_id_world     = charIdMain;
    charInfo.worldid           = worldId;
    charInfo.status            = 1; // 0 = Invalid/Hidden, 1 = Available, 2 = Disabled (unpaid)
    charInfo.race_change       = 0;
    charInfo.renamef           = 0;
    charInfo.ffxi_id_world_tbl = charIdExtra;

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
