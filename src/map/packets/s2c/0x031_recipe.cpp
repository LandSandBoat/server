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

#include "0x031_recipe.h"

namespace
{
    const std::vector<std::string> craftSkillDbNames = {
        "Wood",
        "Smith",
        "Gold",
        "Cloth",
        "Leather",
        "Bone",
        "Alchemy",
        "Cook",
    };
}

GP_SERV_COMMAND_RECIPE::GP_SERV_COMMAND_RECIPE(GP_SERV_COMMAND_RECIPE_TYPE type, const uint16 skillID, const uint16 skillLevel, const uint8 skillRank, const uint16 offset)
{
    auto& packet = this->data();

    switch (type)
    {
        case GP_SERV_COMMAND_RECIPE_TYPE::RecipeDetail1:
        case GP_SERV_COMMAND_RECIPE_TYPE::RecipeDetail2:
        {
            const char* craftName = craftSkillDbNames[skillID - 1].c_str();
            uint8       minSkill  = skillRank * 10;
            uint8       maxSkill  = (skillRank + 1) * 10;

            if (skillLevel < maxSkill)
            {
                maxSkill = skillLevel;
            }

            const auto query = std::format("SELECT KeyItem, Wood, Smith, Gold, Cloth, Leather, Bone, Alchemy, Cook, Crystal, Result, "
                                           "Ingredient1, Ingredient2, Ingredient3, Ingredient4, Ingredient5, Ingredient6, Ingredient7, Ingredient8 "
                                           "FROM synth_recipes INNER JOIN item_basic ON Result = item_basic.itemid "
                                           "WHERE {} >= GREATEST(`Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`) AND "
                                           "{} BETWEEN ? AND ? AND Desynth = 0 ORDER BY {}, item_basic.name LIMIT ?, 1",
                                           craftName, craftName, craftName);
            const auto rset  = db::preparedStmt(query, minSkill, maxSkill, offset);
            FOR_DB_SINGLE_RESULT(rset)
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
                        this_skill = rset->get<uint16>(i);
                    }

                    if (this_skill > 0u)
                    {
                        subcraftIDs[subidx] = i;
                        subidx++;
                    }
                }

                packet.Details.productitem   = rset->get<uint16>("Result");
                packet.Details.need_skill_1  = subcraftIDs[0];
                packet.Details.need_skill_2  = subcraftIDs[1];
                packet.Details.need_skill_3  = subcraftIDs[2];
                packet.Details.need_item     = rset->get<uint16>("Crystal");
                packet.Details.need_key_item = rset->get<uint16>("KeyItem");

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

                    this_ingredient = rset->get<uint16>(11 + i);
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

                auto idx = 0;
                for (auto& [itemId, itemCount] : ingredients)
                {
                    packet.Details.itemnum[idx]   = itemId;
                    packet.Details.itemcount[idx] = itemCount;
                    idx++;
                }
            }

            packet.Details.Type = GP_SERV_COMMAND_RECIPE_TYPE::RecipeDetail1;
            break;
        }
        case GP_SERV_COMMAND_RECIPE_TYPE::RecipeList:
        {
            const char* craftName = craftSkillDbNames[skillID - 1].c_str();
            const uint8 minSkill  = skillRank * 10;
            uint8       maxSkill  = (skillRank + 1) * 10;
            uint8       idx       = 0;

            if (skillLevel < maxSkill)
            {
                maxSkill = skillLevel;
            }

            const auto query = std::format("SELECT Result FROM synth_recipes "
                                           "INNER JOIN item_basic ON Result = item_basic.itemid "
                                           "WHERE {} >= GREATEST(`Wood`, `Smith`, `Gold`, `Cloth`, `Leather`, `Bone`, `Alchemy`, `Cook`) AND "
                                           "{} BETWEEN ? AND ? AND Desynth = 0 ORDER BY {}, item_basic.name LIMIT ?, 17",
                                           craftName, craftName, craftName);
            const auto rset  = db::preparedStmt(query, minSkill, maxSkill, offset);
            FOR_DB_MULTIPLE_RESULTS(rset)
            {
                if (idx == 16)
                {
                    // The 17th result of a query is not displayed in the menu, but instead is used to signal
                    // to the client that another page is available.  This item ID is stored at 0x32.
                    packet.List.itemnum_next = rset->get<uint16>("Result");
                    break;
                }

                packet.List.itemnum[idx] = rset->get<uint16>("Result");
                ++idx;
            }

            packet.List.Type = GP_SERV_COMMAND_RECIPE_TYPE::RecipeList;
            break;
        }
        default:
            break;
    }
}
