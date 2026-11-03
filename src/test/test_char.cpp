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
#include "login/login_helpers.h"
#include "map/entities/base_entity.h"
#include "map/entities/char_entity.h"
#include "test_common.h"
#include "zone.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <format>
#include <limits>
#include <utility>

#include <bcrypt/BCrypt.hpp>

namespace
{

constexpr uint32 MinTestCharId = 20000000;
constexpr uint32 MinTestAccId  = 20000000;

} // namespace

// Cleans the given character ID or all characters with IDs >= MinTestCharId.
void TestChar::clean(uint32 charId /* = 0 */)
{
    const auto ids = [&]() -> std::pair<uint32, uint32>
    {
        if (charId > 0)
        {
            return { charId, charId };
        }

        return { MinTestCharId, std::numeric_limits<uint32>::max() };
    }();

    constexpr auto oneIdColumn = std::to_array<db::Query>({
        "DELETE FROM accounts WHERE id BETWEEN ? AND ?",
        "DELETE FROM auction_house WHERE seller BETWEEN ? AND ?",
        "DELETE FROM audit_vendor WHERE seller BETWEEN ? AND ?",
    });

    constexpr auto twoIdColumns = std::to_array<db::Query>({
        "DELETE FROM delivery_box WHERE charid BETWEEN ? AND ? OR senderid BETWEEN ? AND ?",
        "DELETE FROM audit_bazaar WHERE seller BETWEEN ? AND ? OR purchaser BETWEEN ? AND ?",
        "DELETE FROM audit_trade WHERE sender BETWEEN ? AND ? OR receiver BETWEEN ? AND ?",
    });

    constexpr auto charIdColumn = std::to_array<db::Query>({
        "DELETE FROM chars WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_chocobos WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_effects WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_equip WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_equip_saved WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_exp WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_flags WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_history WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_inventory WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_job_points WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_jobs WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_look WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_merit WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_monstrosity WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_pet WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_points WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_profile WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_recast WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_skills WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_spells WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_stats WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_storage WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_style WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_unlocks WHERE charid BETWEEN ? AND ?",
        "DELETE FROM char_vars WHERE charid BETWEEN ? AND ?",

        "DELETE FROM accounts_parties WHERE charid BETWEEN ? AND ?",
        "DELETE FROM accounts_sessions WHERE charid BETWEEN ? AND ?",
    });

    constexpr auto placeholdersAre = [](const std::size_t count)
    {
        return [count](const db::Query query)
        {
            return query.placeholders() == count;
        };
    };

    static_assert(std::ranges::all_of(oneIdColumn, placeholdersAre(2)));
    static_assert(std::ranges::all_of(twoIdColumns, placeholdersAre(4)));
    static_assert(std::ranges::all_of(charIdColumn, placeholdersAre(2)));

    for (const auto query : oneIdColumn)
    {
        if (!db::preparedStmt(db::selected(query), ids.first, ids.second))
        {
            ShowErrorFmt("Failed to execute cleanup query: {}", query);
        }
    }

    for (const auto query : twoIdColumns)
    {
        if (!db::preparedStmt(db::selected(query), ids.first, ids.second, ids.first, ids.second))
        {
            ShowErrorFmt("Failed to execute cleanup query: {}", query);
        }
    }

    for (const auto query : charIdColumn)
    {
        if (!db::preparedStmt(db::selected(query), ids.first, ids.second))
        {
            ShowErrorFmt("Failed to execute cleanup query: {}", query);
        }
    }
}

auto TestChar::create(const xi::ZoneId zoneId, const CharRace race) -> std::unique_ptr<TestChar>
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

    rset = db::preparedStmt("INSERT INTO accounts (id, login, password) VALUES (?, ?, ?)",
                            accId,
                            accountName,
                            BCrypt::generateHash("password"));
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
        .m_mjob   = static_cast<uint8>(xi::Job::WAR),
        .m_zone   = zoneId,
        .m_nation = xi::Nation::Sandoria,
    };

    mini.m_look.race = static_cast<uint8>(race);
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
    // drain without clearPacketList, which also resets the spawn lists
    if (session_)
    {
        while (!session_->PChar->isPacketListEmpty())
        {
            std::ignore = session_->PChar->popPacket();
        }
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
