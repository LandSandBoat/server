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

#include "map.h"
#include "mob_spell_list.h"

CMobSpellList::CMobSpellList() = default;

void CMobSpellList::AddSpell(SpellID spellId, uint16 minLvl, uint16 maxLvl)
{
    MobSpell_t Mob_Spell = { spellId, minLvl, maxLvl };

    m_spellList.push_back(Mob_Spell);
}

// Implement namespace to work with spells
namespace mobSpellList
{
    uint16                      MAX_MOBSPELLLIST_ID = 1;
    std::vector<CMobSpellList*> PMobSpellList;

    // Load list of spells
    void LoadMobSpellList()
    {
        PMobSpellList.emplace_back(new CMobSpellList());
        const char* Query = "SELECT mob_spell_lists.spell_list_id, \
                            mob_spell_lists.spell_id, \
                            mob_spell_lists.min_level, \
                            mob_spell_lists.max_level, \
                            spell_list.content_tag \
                            FROM mob_spell_lists JOIN spell_list ON spell_list.spellid = mob_spell_lists.spell_id \
                            ORDER BY spell_list_id ASC, min_level ASC;";

        int32 ret = sql->Query(Query);

        if (ret != SQL_ERROR && sql->NumRows() != 0)
        {
            while (sql->NextRow() == SQL_SUCCESS)
            {
                SpellID spellId = (SpellID)sql->GetIntData(1);
                uint16  minLvl  = (uint16)sql->GetIntData(2);
                uint16  maxLvl  = (uint16)sql->GetIntData(3);

                uint16 pos          = sql->GetIntData(0);
                MAX_MOBSPELLLIST_ID = pos;

                while (!(PMobSpellList.size() - 1 == pos))
                {
                    PMobSpellList.emplace_back(new CMobSpellList());
                }

                PMobSpellList[pos]->AddSpell(spellId, minLvl, maxLvl);
            }
        }
    }

    // Get Spell By ID
    CMobSpellList* GetMobSpellList(uint16 MobSpellListID)
    {
        if (MobSpellListID <= MAX_MOBSPELLLIST_ID)
        {
            return PMobSpellList[MobSpellListID];
        }
        ShowCritical("MobSpellListID <%u> out of range", MobSpellListID);
        return nullptr;
    }
}; // namespace mobSpellList
