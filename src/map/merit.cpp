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

#include "merit.h"
#include "entities/char_entity.h"

#include "data/datasets/merits/dataset.h"
#include "packets/s2c/0x0aa_magic_data.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "utils/charutils.h"
#include "utils/dataset_loader.h"

#include <algorithm>
#include <string>
#include <unordered_map>
#include <utility>

#define MAX_LIMIT_POINTS 10000

namespace
{

using MeritsDataset = xi::data::datasets::merits::Dataset;

xi::data::Merits                                        meritData{};
std::unordered_map<uint16, xi::data::MeritCategoryData> categoryById;
std::unordered_map<uint16, uint16>                      meritIndexById;
Merit_t                                                 meritDefaults[kMeritPacketSlots]{};

auto loadNameLookup(const std::string& query, const std::string& column) -> std::unordered_map<std::string, uint16>
{
    std::unordered_map<std::string, uint16> lookup;

    const auto rset = db::preparedStmt(query);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto value = rset->getOrDefault<uint16>(column, 0);
        if (value != 0)
        {
            lookup.emplace(rset->get<std::string>("name"), value);
        }
    }

    return lookup;
}

// a merit grants only what it names, so sharing a name with a spell grants nothing
auto resolveGrant(const std::unordered_map<std::string, uint16>& lookup,
                  const std::string&                             declared,
                  const std::string&                             merit,
                  const std::string_view                         table) -> uint16
{
    if (declared.empty())
    {
        return 0;
    }

    const auto match = lookup.find(declared);
    if (match == lookup.end())
    {
        ShowErrorFmt("merit {} names '{}', which is not in {}", merit, declared, table);
        return 0;
    }

    return match->second;
}

auto nextUpgradeCost(const Merit_t& merit) -> uint8
{
    if (merit.costs == nullptr || merit.upgrade == 0)
    {
        return 0;
    }

    return merit.costs[std::min<uint8>(merit.count, merit.upgrade - 1)];
}

// the id with its in-category offset masked off
constexpr auto categoryOf(const xi::Merit merit) -> uint16
{
    return static_cast<uint16>(merit) & 0xFFC0;
}

} // namespace

CMeritPoints::CMeritPoints(CCharEntity* PChar)
{
    std::memcpy(merits, meritDefaults, sizeof(merits));

    m_PChar = PChar;
    LoadMeritPoints(PChar->id);

    m_LimitPoints = 0;
    m_MeritPoints = 0;
}

void CMeritPoints::LoadMeritPoints(const uint32 charid)
{
    for (auto& merit : merits)
    {
        merit.count = 0;
        merit.next  = nextUpgradeCost(merit);
    }

    const auto rset = db::preparedStmt("SELECT meritid, upgrades FROM char_merit WHERE charid = ?", charid);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto meritID  = rset->get<uint32>("meritid");
        const auto upgrades = rset->get<uint32>("upgrades");
        const auto index    = meritIndexById.find(static_cast<uint16>(meritID));
        if (index == meritIndexById.end())
        {
            continue;
        }

        auto& merit = merits[index->second];
        merit.count = static_cast<uint8>(std::min<uint32>(upgrades, merit.upgrade));
        merit.next  = nextUpgradeCost(merit);
    }
}

void CMeritPoints::SaveMeritPoints(const uint32 charid)
{
    for (const auto& merit : merits)
    {
        if (merit.count > 0)
        {
            db::preparedStmt("INSERT INTO char_merit (charid, meritid, upgrades) "
                             "VALUES(?, ?, ?) "
                             "ON DUPLICATE KEY UPDATE upgrades = ?",
                             charid,
                             merit.id,
                             merit.count,
                             merit.count);
        }
        else
        {
            db::preparedStmt("DELETE FROM char_merit "
                             "WHERE charid = ? "
                             "AND meritid = ?",
                             charid,
                             merit.id);
        }
    }
}

auto CMeritPoints::GetLimitPoints() const -> uint16
{
    return m_LimitPoints;
}

auto CMeritPoints::GetMeritPoints() const -> uint8
{
    return m_MeritPoints;
}

auto CMeritPoints::GetMeritCountInSameCategory(const xi::Merit merit) const -> uint16
{
    if (!this->IsMeritExist(merit))
    {
        return 0;
    }

    const auto category = categoryById.find(categoryOf(merit));
    if (category == categoryById.end())
    {
        return 0;
    }

    uint16 total = 0;
    for (uint8 i = 0; i < category->second.Count; ++i)
    {
        total += merits[category->second.Offset + i].count;
    }

    return total;
}

// true - If merit was added

auto CMeritPoints::AddLimitPoints(const uint16 points) -> bool
{
    m_LimitPoints += points;

    if (m_LimitPoints >= MAX_LIMIT_POINTS)
    {
        // check if player has reached cap
        if (m_MeritPoints == settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(xi::Merit::MaxMerit, m_PChar))
        {
            m_LimitPoints = MAX_LIMIT_POINTS - 1;
            return false;
        }

        uint8 MeritPoints = std::min(m_MeritPoints + m_LimitPoints / MAX_LIMIT_POINTS, settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(xi::Merit::MaxMerit, m_PChar));

        m_LimitPoints = m_LimitPoints % MAX_LIMIT_POINTS;

        if (m_MeritPoints != MeritPoints)
        {
            m_MeritPoints = MeritPoints;
            return true;
        }
    }
    return false;
}

void CMeritPoints::SetLimitPoints(const uint16 points)
{
    m_LimitPoints = std::min<uint16>(points, MAX_LIMIT_POINTS - 1);
}

void CMeritPoints::SetMeritPoints(const uint16 points)
{
    m_MeritPoints = std::min<uint8>(static_cast<uint8>(points), settings::get<uint8>("map.MAX_MERIT_POINTS") + GetMeritValue(xi::Merit::MaxMerit, m_PChar));
}

/************************************************************************
 *                                                                       *
 *  Check the availability of merit. Should only be used if receiving    *
 *  meritid from a character                                             *
 *                                                                       *
 ************************************************************************/

auto CMeritPoints::IsMeritExist(const xi::Merit merit) const -> bool
{
    if (!meritIndexById.contains(static_cast<uint16>(merit)))
    {
        return false;
    }

    return true;
}

auto CMeritPoints::GetMerit(const xi::Merit merit) -> const Merit_t*
{
    return GetMeritPointer(merit);
}

auto CMeritPoints::GetMeritByIndex(const uint16 index) const -> const Merit_t*
{
    if (index >= kMeritPacketSlots)
    {
        ShowWarning("Invalid Merit Index (%d) passed to function.", index);
        return nullptr;
    }

    return &merits[index];
}

auto CMeritPoints::GetMeritPointer(const xi::Merit merit) -> Merit_t*
{
    const auto index = meritIndexById.find(static_cast<uint16>(merit));
    if (index == meritIndexById.end())
    {
        return nullptr;
    }

    return &merits[index->second];
}

void CMeritPoints::RaiseMerit(const xi::Merit merit)
{
    Merit_t* PMerit = GetMeritPointer(merit);
    if (!PMerit)
    {
        return;
    }

    const auto category = categoryById.find(categoryOf(merit));
    if (category == categoryById.end())
    {
        return;
    }

    if (m_MeritPoints >= PMerit->next && PMerit->count < PMerit->upgrade && GetMeritCountInSameCategory(merit) < category->second.MaxUpgrades)
    {
        m_MeritPoints -= PMerit->next;

        if (PMerit->spellid != 0)
        {
            if (charutils::addSpell(m_PChar, PMerit->spellid))
            {
                charutils::SaveSpell(m_PChar, PMerit->spellid);
                m_PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(m_PChar);
            }
        }

        if (PMerit->wsunlockid != 0 && !charutils::hasLearnedWeaponskill(m_PChar, PMerit->wsunlockid))
        {
            charutils::addLearnedWeaponskill(m_PChar, PMerit->wsunlockid);
            charutils::BuildingCharWeaponSkills(m_PChar);
            charutils::SaveLearnedAbilities(m_PChar);
            m_PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(m_PChar);
        }

        PMerit->count++;

        // Reset traits
        charutils::BuildingCharTraitsTable(m_PChar);
    }
}

void CMeritPoints::LowerMerit(const xi::Merit merit)
{
    Merit_t* PMerit = GetMeritPointer(merit);
    if (!PMerit)
    {
        return;
    }

    if (PMerit->count > 0)
    {
        --PMerit->count;
        PMerit->next = nextUpgradeCost(*PMerit);
    }

    if (PMerit->spellid != 0 && PMerit->count == 0)
    {
        if (charutils::delSpell(m_PChar, PMerit->spellid))
        {
            charutils::DeleteSpell(m_PChar, PMerit->spellid);
            m_PChar->pushPacket<GP_SERV_COMMAND_MAGIC_DATA>(m_PChar);

            // Reset traits
            charutils::BuildingCharTraitsTable(m_PChar);
        }
    }

    if (PMerit->wsunlockid != 0 && PMerit->count == 0 && charutils::hasLearnedWeaponskill(m_PChar, PMerit->wsunlockid))
    {
        charutils::delLearnedWeaponskill(m_PChar, PMerit->wsunlockid);
        charutils::BuildingCharWeaponSkills(m_PChar);
        charutils::SaveLearnedAbilities(m_PChar);
        m_PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(m_PChar);
    }
}

auto CMeritPoints::GetMeritValue(const xi::Merit merit, const CCharEntity* PChar) -> int32
{
    const Merit_t* PMerit     = GetMeritPointer(merit);
    uint16         meritValue = 0;

    if (PMerit)
    {
        // general categories apply to every job, the rest need the merit's job at 75+
        if (PMerit->category <= xi::MeritCategory::Others ||
            (PMerit->jobs & (1 << (static_cast<uint8>(PChar->GetMJob()) - 1)) && PChar->GetMLevel() >= 75))
        {
            if (merit == xi::Merit::MaxMerit)
            {
                meritValue = PMerit->count;
            }
            else
            {
                meritValue = std::min(PMerit->count, meritData.LevelCaps[PChar->GetMLevel()]);
            }
        }

        if (PMerit->category == xi::MeritCategory::WeaponSkills && PChar->GetMLevel() < 96)
        {
            meritValue = 0;
        }

        meritValue *= PMerit->value;
    }

    return meritValue;
}

namespace meritNameSpace
{

auto GetSkillMerit(const xi::SkillType skill) -> std::optional<xi::Merit>
{
    const auto match = meritData.MeritBySkill.find(skill);
    if (match == meritData.MeritBySkill.end())
    {
        return std::nullopt;
    }

    return match->second;
}

void LoadMeritsList()
{
    meritData = xi::data::loadDataset<MeritsDataset>();
    meritIndexById.clear();

    if (meritData.Entries.size() > kMeritPacketSlots)
    {
        ShowErrorFmt("data/merits.yaml holds {} merits, but only {} fit the client's slots", meritData.Entries.size(), kMeritPacketSlots);
        return;
    }

    const auto spells    = loadNameLookup("SELECT name, spellid FROM spell_list", "spellid");
    const auto wsUnlocks = loadNameLookup("SELECT name, unlock_id FROM weapon_skills", "unlock_id");

    categoryById.clear();
    for (const auto& category : meritData.Categories)
    {
        categoryById[std::to_underlying(category.Id)] = category;
    }

    for (uint16 index = 0; index < meritData.Entries.size(); ++index)
    {
        const auto& entry = meritData.Entries[index];
        const auto  name  = std::string{ xi::data::EnumTraits<xi::Merit>::toName(entry.Id) };

        uint32 jobs{};
        for (const auto job : entry.Jobs)
        {
            jobs |= 1u << (std::to_underlying(job) - 1);
        }

        Merit_t merit{
            .value      = entry.Value,
            .upgrade    = entry.MaxUpgrades,
            .jobs       = jobs,
            .category   = entry.Category,
            .spellid    = resolveGrant(spells, entry.Spell, name, "spell_list"),
            .wsunlockid = resolveGrant(wsUnlocks, entry.WeaponSkill, name, "weapon_skills"),
            .costs      = entry.UpgradeCosts.data(),
        };

        merit.id   = std::to_underlying(entry.Id);
        merit.next = nextUpgradeCost(merit);

        meritDefaults[index]     = merit;
        meritIndexById[merit.id] = index;
    }
}

}; // namespace meritNameSpace
