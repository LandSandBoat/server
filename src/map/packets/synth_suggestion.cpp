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

#include "common/socket.h"
#include "map.h"

#include "synth_suggestion.h"
#include <map>

CSynthSuggestionListPacket::CSynthSuggestionListPacket(uint16 skillID, uint16 skillLevel, uint8 skillRank, uint16 resultOffset)
{
    this->setType(0x31);
    this->setSize(0x34);

    ref<uint8>(0x0A) = skillLevel;

    const char* craftName = craftSkillDbNames[skillID - 1].c_str();
    uint8       minSkill  = skillRank * 10;
    uint8       maxSkill  = (skillRank + 1) * 10;

    if (skillLevel < maxSkill)
    {
        maxSkill = skillLevel;
    }

    const char* fmtQuery = "SELECT Result FROM synth_recipes INNER JOIN item_basic ON Result = item_basic.itemid \
        WHERE `%s` >= GREATEST(`Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`) AND \
        `%s` BETWEEN %u AND %u AND Desynth = 0 ORDER BY `%s`, item_basic.name LIMIT %d, 17;";

    int32 ret = _sql->Query(fmtQuery, craftName, craftName, minSkill, maxSkill, craftName, resultOffset);

    if (ret != SQL_ERROR && _sql->NumRows() != 0)
    {
        uint8 itemIdOffset = 0x10;
        while (_sql->NextRow() == SQL_SUCCESS)
        {
            ref<uint16>(itemIdOffset) = _sql->GetUIntData(0);

            itemIdOffset += 2;
            if (itemIdOffset == 0x30)
            {
                // The 17th result of a query is not displayed in the menu, but instead is used to signal
                // to the client that another page is available.  This item ID is stored at 0x32.
                itemIdOffset += 2;
            }
        }
    }

    ref<uint16>(0x30) = 0x02;
}

CSynthSuggestionRecipePacket::CSynthSuggestionRecipePacket(uint16 skillID, uint16 skillLevel, uint8 skillRank, uint16 selectedRecipeOffset)
{
    this->setType(0x31);
    this->setSize(0x34);

    const char* craftName = craftSkillDbNames[skillID - 1].c_str();
    uint8       minSkill  = skillRank * 10;
    uint8       maxSkill  = (skillRank + 1) * 10;

    if (skillLevel < maxSkill)
    {
        maxSkill = skillLevel;
    }

    const char* fmtQuery = "SELECT KeyItem, Wood, Smith, Gold, Cloth, Leather, Bone, Alchemy, Cook, Crystal, Result, \
        Ingredient1, Ingredient2, Ingredient3, Ingredient4, Ingredient5, Ingredient6, Ingredient7, Ingredient8 \
        FROM synth_recipes INNER JOIN item_basic ON Result = item_basic.itemid \
        WHERE `%s` >= GREATEST(`Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`) AND \
        `%s` BETWEEN %u AND %u AND Desynth = 0 ORDER BY `%s`, item_basic.name LIMIT %d, 1;";

    int32 ret = _sql->Query(fmtQuery, craftName, craftName, minSkill, maxSkill, craftName, selectedRecipeOffset);

    if (ret != SQL_ERROR && _sql->NumRows() != 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        std::map<uint16, uint16> ingredients;
        uint16                   subcraftIDs[3] = { 0u, 0u, 0u };
        size_t                   subidx         = 0;

        // So, each craft can have up to 3 subcrafts. This loop is
        //     to pack the subcraft requirements to be sent
        for (auto i = 1; i < 9; ++i)
        {
            uint16 this_skill = 0u;
            if (i != skillID && subidx < 3)
            {
                this_skill = _sql->GetUIntData(i);
            }

            if (this_skill > 0u)
            {
                subcraftIDs[subidx] = i;
                subidx++;
            }
        }

        ref<uint16>(0x04) = _sql->GetUIntData(10);
        ref<uint16>(0x06) = subcraftIDs[0];
        ref<uint16>(0x08) = subcraftIDs[1];
        ref<uint16>(0x0A) = subcraftIDs[2];
        ref<uint16>(0x0C) = _sql->GetUIntData(9);
        ref<uint16>(0x0E) = _sql->GetUIntData(0);

        // So this loop is a little weird. What we store in the db
        //     is a list of 8 individual ingredients which may or
        //     may not contain duplicates. What we need for the
        //     packet is a set of ingredient and quantity. In order
        //     to achieve that, we're pushing the first instance of
        //     an ingredient into a std::map with a qty 1 and then
        //     any duplicate instances will increase the quantity
        //     without creating new duplicate entries
        for (auto i = 0; i < 8; ++i)
        {
            uint16 this_ingredient = 0;

            this_ingredient = _sql->GetUIntData(11 + i);
            if (this_ingredient != 0)
            {
                if (ingredients[this_ingredient])
                {
                    ingredients[this_ingredient] = ingredients[this_ingredient] + 1;
                }
                else
                {
                    ingredients[this_ingredient] = 1;
                }
            }
        }

        // Finally, store the contents of the map of ingredients
        //     into the proper offsets in the packet before sending
        uint8 pointer_ref = 0x10u;
        for (auto& ingredient : ingredients)
        {
            ref<uint16>(pointer_ref)        = ingredient.first;
            ref<uint16>(pointer_ref + 0x10) = ingredient.second;
            pointer_ref += 0x02u;
            if (pointer_ref > 0x1E)
            {
                break;
            }
        }
        ref<uint16>(0x30) = 0x01;
    }
}
