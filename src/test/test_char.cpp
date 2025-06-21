/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "test_char.h"
#include "common/cbasetypes.h"
#include "common/database.h"
#include "entities/charentity.h"
#include "login/login_helpers.h"
#include <bcrypt/BCrypt.hpp>

namespace
{
    std::vector<std::string> charIdTables = {
        "chars",
        "char_chocobos",
        "char_effects",
        "char_equip",
        "char_equip_saved",
        "char_exp",
        "char_flags",
        "char_history",
        "char_inventory",
        "char_job_points",
        "char_jobs",
        "char_look",
        "char_merit",
        "char_monstrosity",
        "char_pet",
        "char_points",
        "char_profile",
        "char_recast",
        "char_skills",
        "char_spells",
        "char_stats",
        "char_storage",
        "char_style",
        "char_unlocks",
        "char_vars",

        "accounts_parties",
        "accounts_sessions",
    };

    // Can use IDs higher than 24 bits, since that's the maximum supported by the login server and client.
    uint32 MinTestAccId  = 20000000;
    uint32 MinTestCharId = 20000000;
} // namespace

// Cleans the given character ID or all characters with IDs >= MinTestCharId.
void TestChar::clean(uint32 charId /* = 0 */)
{
    std::string matchingCondition = std::format(">= {}", MinTestCharId);
    if (charId > 0)
    {
        matchingCondition = std::format("= {}", charId);
    }

    std::vector cleanupQueries = {
        std::format("DELETE FROM accounts WHERE id {}", matchingCondition),
        std::format("DELETE FROM auction_house WHERE seller {}", matchingCondition),
        std::format("DELETE FROM delivery_box WHERE charid {} OR senderid {}", matchingCondition, matchingCondition),
        std::format("DELETE FROM audit_bazaar WHERE seller {} OR purchaser {}", matchingCondition, matchingCondition),
        std::format("DELETE FROM audit_trade WHERE sender {} OR receiver {}", matchingCondition, matchingCondition),
        std::format("DELETE FROM audit_vendor WHERE seller {}", matchingCondition),
    };

    for (auto& tableName : charIdTables)
    {
        cleanupQueries.emplace_back(std::format("DELETE FROM {} WHERE charid {}", tableName, matchingCondition));
    }

    for (auto& query : cleanupQueries)
    {
        if (const auto rset = db::preparedStmt(query); !rset)
        {
            ShowErrorFmt("Failed to execute cleanup query: {}", query.c_str());
        }
    }
}

std::unique_ptr<TestChar> TestChar::create(const uint16_t zoneId)
{
    uint32_t accId  = 0;
    uint32_t charId = 0;

    auto rset = db::preparedStmt("SELECT max(id) FROM accounts");
    FOR_DB_SINGLE_RESULT(rset)
    {
        accId = std::max(MinTestAccId, rset->get<uint32>("max(id)") + 1);
    }
    else
    {
        ShowError("Unable to get max accounts ID");
        return nullptr;
    }

    auto accountName = "TEST_" + std::to_string(accId);
    rset             = db::preparedStmt("INSERT INTO accounts (id, login, password) VALUES (?, ?, ?)",
                                        accId, accountName, BCrypt::generateHash("password"));
    if (!rset)
    {
        ShowError("Unable to create new account");
        return nullptr;
    }

    rset = db::preparedStmt("SELECT max(charid) FROM chars");
    FOR_DB_SINGLE_RESULT(rset)
    {
        charId = std::max(MinTestCharId, rset->get<uint32>("max(charid)") + 1);
    }
    else
    {
        ShowError("Unable to get max character ID");
        return nullptr;
    }

    const auto charName = "T" + std::to_string(charId);

    char_mini mini = {
        .m_name   = {},
        .m_mjob   = 1,
        .m_zone   = zoneId,
        .m_nation = 1,
    };

    mini.m_look.race = 1;
    mini.m_look.size = 1;
    mini.m_look.face = 1;

    std::strncpy(reinterpret_cast<char*>(mini.m_name), charName.c_str(), sizeof(mini.m_name) - 1);
    mini.m_name[sizeof(mini.m_name) - 1] = '\0';

    loginHelpers::saveCharacter(accId, charId, &mini);

    auto testChar       = std::make_unique<TestChar>();
    testChar->accountId = accId;
    testChar->charId    = charId;
    testChar->charName  = charName;

    return testChar;
}

TestChar::~TestChar()
{
    TestChar::clean(this->charId);
}

void TestChar::clearPackets() const
{
    if (m_session)
    {
        m_session->PChar->clearPacketList();
    }
}

void TestChar::setSession(MapSession* session)
{
    m_session = session;
}

auto TestChar::getSession() const -> MapSession*
{
    return m_session;
}

auto TestChar::getEntity() const -> CCharEntity*
{
    if (m_session)
    {
        return m_session->PChar;
    }

    return nullptr;
}

void TestChar::setEntity(CCharEntity* entity) const
{
    if (m_session)
    {
        m_session->charID          = entity->id;
        m_session->PChar           = entity;
        m_session->PChar->PSession = getSession();
        m_session->PChar->status   = STATUS_TYPE::NORMAL;
    }
}

void TestChar::setBlowfish(const BLOWFISH b) const
{
    m_session->blowfish.status = b;
}

auto TestChar::getCharId() const -> uint32_t
{
    return charId;
}

auto TestChar::getAccountId() const -> uint32_t
{
    return accountId;
}
