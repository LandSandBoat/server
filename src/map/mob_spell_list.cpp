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

#include <cstring>

#include "lua/luautils.h"

#include "mob_spell_list.h"

CMobSpellList::CMobSpellList(const uint16 listId)
: m_listId(listId)
{
}

auto CMobSpellList::getId() const -> uint16
{
    return m_listId;
}

void CMobSpellList::AddSpell(const SpellID spellId, const uint16 minLvl, const uint16 maxLvl)
{
    MobSpell_t Mob_Spell = { spellId, minLvl, maxLvl };

    m_spellList.emplace_back(Mob_Spell);
}

auto CMobSpellList::GetSpellMinLevel(const SpellID spellId) const -> uint16
{
    for (const auto& mobSpell : m_spellList)
    {
        if (spellId == mobSpell.spellId)
        {
            return mobSpell.min_level;
        }
    }

    return 255;
}

// Implement namespace to work with spells
namespace mobSpellList
{

std::unordered_map<uint16, std::unique_ptr<CMobSpellList>> PMobSpellList;

// Load list of spells
void LoadMobSpellList()
{
    PMobSpellList[0] = std::make_unique<CMobSpellList>(0); // Add empty spell list for mobSpellListId 0

    const auto query = "SELECT mob_spell_lists.spell_list_id, "
                       "mob_spell_lists.spell_id, "
                       "mob_spell_lists.min_level, "
                       "mob_spell_lists.max_level, "
                       "spell_list.content_tag "
                       "FROM mob_spell_lists JOIN spell_list ON spell_list.spellid = mob_spell_lists.spell_id "
                       "WHERE spell_list_id < ? "
                       "ORDER BY min_level ASC";

    const auto rset = db::preparedStmt(query, MAX_MOBSPELLLIST_ID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto spellListId = rset->get<uint16>("spell_list_id");
        const auto spellId     = rset->get<uint16>("spell_id");
        const auto minLvl      = rset->get<uint16>("min_level");
        const auto maxLvl      = rset->get<uint16>("max_level");

        if (!PMobSpellList.contains(spellListId))
        {
            PMobSpellList.emplace(spellListId, std::make_unique<CMobSpellList>(spellListId));
        }

        PMobSpellList[spellListId]->AddSpell(static_cast<SpellID>(spellId), minLvl, maxLvl);
    }
}

// Get Spell By ID
auto GetMobSpellList(const uint16 mobSpellListId) -> CMobSpellList*
{
    if (PMobSpellList.contains(mobSpellListId))
    {
        return PMobSpellList[mobSpellListId].get();
    }

    ShowErrorFmt("Mob spell list ID {} does not exist.", mobSpellListId);
    return nullptr;
}

}; // namespace mobSpellList
