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
#include "common/lua.h"
#include "login/login_helpers.h"
#include "lua/lua_spy.h"
#include "map/entities/baseentity.h"
#include "map/entities/charentity.h"
#include "test_common.h"

#include <format>

#include <bcrypt/BCrypt.hpp>

namespace
{
    constexpr uint32 MinTestCharId = 20000000;
    constexpr uint32 MinTestAccId  = 20000000;

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

auto TestChar::create(const uint16_t zoneId) -> std::unique_ptr<TestChar>
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
        TestError("Unable to get max accounts ID");
        return nullptr;
    }

    auto accountName = std::format("TEST_{}", accId);
    rset             = db::preparedStmt("INSERT INTO accounts (id, login, password) VALUES (?, ?, ?)",
                                        accId, accountName, BCrypt::generateHash("password"));
    if (!rset)
    {
        TestError("Unable to create new account");
        return nullptr;
    }

    rset = db::preparedStmt("SELECT max(charid) FROM chars");
    FOR_DB_SINGLE_RESULT(rset)
    {
        charId = std::max(MinTestCharId, rset->get<uint32>("max(charid)") + 1);
    }
    else
    {
        TestError("Unable to get max character ID");
        return nullptr;
    }

    const auto charName = std::format("T{}", charId);

    char_mini mini = {
        .m_name   = {},
        .m_mjob   = JOB_WAR,
        .m_zone   = zoneId,
        .m_nation = NATION_SANDORIA,
    };

    mini.m_look.race = static_cast<uint8>(CharRace::HumeMale);
    mini.m_look.size = static_cast<uint16>(CharSize::Small);
    mini.m_look.face = static_cast<uint8>(CharFace::Face1A);

    std::strncpy(reinterpret_cast<char*>(mini.m_name), charName.c_str(), sizeof(mini.m_name) - 1);
    mini.m_name[sizeof(mini.m_name) - 1] = '\0';

    loginHelpers::saveCharacter(accId, charId, &mini);

    auto testChar        = std::make_unique<TestChar>();
    testChar->accountId_ = accId;
    testChar->charId_    = charId;
    testChar->charName_  = charName;

    return testChar;
}

TestChar::~TestChar()
{
    TestChar::clean(this->charId_);
}

void TestChar::clearPackets() const
{
    if (session_)
    {
        session_->PChar->clearPacketList();
    }
}

void TestChar::setSession(MapSession* session)
{
    session_ = session;
}

auto TestChar::session() const -> MapSession*
{
    return session_;
}

auto TestChar::entity() const -> CCharEntity*
{
    if (session_)
    {
        return session_->PChar.get();
    }

    return nullptr;
}

void TestChar::setEntity(std::unique_ptr<CCharEntity> entity) const
{
    if (session_)
    {
        session_->charID          = entity->id;
        session_->PChar           = std::move(entity);
        session_->PChar->PSession = session();
        session_->PChar->status   = STATUS_TYPE::NORMAL;
    }
}

void TestChar::setBlowfish(const BLOWFISH b) const
{
    session_->blowfish.status = b;
}

auto TestChar::charId() const -> uint32_t
{
    return charId_;
}

auto TestChar::accountId() const -> uint32_t
{
    return accountId_;
}

void TestChar::setIpp(const IPP ipp)
{
    ipp_ = ipp;
}

auto TestChar::ipp() const -> IPP
{
    return ipp_;
}
