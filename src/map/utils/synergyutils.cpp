/*
===========================================================================

  Copyright (c) 2024 LandSandBoat Dev Teams

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
#include "synergyutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/utils.h"

namespace synergyutils
{
    std::vector<SynergyRecipe> synergyRecipes;

    void LoadSynergyRecipes()
    {
        const auto rset = db::preparedStmt(R"""(
            SELECT
            id,
            primary_skill, primary_rank, secondary_skill, secondary_rank, tertiary_skill, tertiary_rank,
            cost_fire_fewell, cost_ice_fewell, cost_wind_fewell, cost_earth_fewell,
            cost_lightning_fewell, cost_water_fewell, cost_light_fewell, cost_dark_fewell,
            ingredient1, ingredient2, ingredient3, ingredient4,
            ingredient5, ingredient6, ingredient7, ingredient8,
            result, resultHQ1, resultHQ2, resultHQ3,
            resultQty, resultHQ1Qty, resultHQ2Qty, resultHQ3Qty,
            resultName
            FROM synergy_recipes;
            )""");

        if (rset || rset->rowsCount())
        {
            synergyRecipes.reserve(rset->rowsCount());

            while (rset->next())
            {
                auto recipe = SynergyRecipe{
                    .id = static_cast<uint32>(rset->getUInt("id")),

                    .primary_skill   = static_cast<uint8>(rset->getUInt("primary_skill")),
                    .primary_rank    = static_cast<uint8>(rset->getUInt("primary_rank")),
                    .secondary_skill = static_cast<uint8>(rset->getUInt("secondary_skill")),
                    .secondary_rank  = static_cast<uint8>(rset->getUInt("secondary_rank")),
                    .tertiary_skill  = static_cast<uint8>(rset->getUInt("tertiary_skill")),
                    .tertiary_rank   = static_cast<uint8>(rset->getUInt("tertiary_rank")),

                    .cost_fire_fewell      = static_cast<uint8>(rset->getUInt("cost_fire_fewell")),
                    .cost_ice_fewell       = static_cast<uint8>(rset->getUInt("cost_ice_fewell")),
                    .cost_wind_fewell      = static_cast<uint8>(rset->getUInt("cost_wind_fewell")),
                    .cost_earth_fewell     = static_cast<uint8>(rset->getUInt("cost_earth_fewell")),
                    .cost_lightning_fewell = static_cast<uint8>(rset->getUInt("cost_lightning_fewell")),
                    .cost_water_fewell     = static_cast<uint8>(rset->getUInt("cost_water_fewell")),
                    .cost_light_fewell     = static_cast<uint8>(rset->getUInt("cost_light_fewell")),
                    .cost_dark_fewell      = static_cast<uint8>(rset->getUInt("cost_dark_fewell")),

                    .ingredient1 = static_cast<uint16>(rset->getUInt("ingredient1")),
                    .ingredient2 = static_cast<uint16>(rset->getUInt("ingredient2")),
                    .ingredient3 = static_cast<uint16>(rset->getUInt("ingredient3")),
                    .ingredient4 = static_cast<uint16>(rset->getUInt("ingredient4")),
                    .ingredient5 = static_cast<uint16>(rset->getUInt("ingredient5")),
                    .ingredient6 = static_cast<uint16>(rset->getUInt("ingredient6")),
                    .ingredient7 = static_cast<uint16>(rset->getUInt("ingredient7")),
                    .ingredient8 = static_cast<uint16>(rset->getUInt("ingredient8")),

                    .result    = static_cast<uint16>(rset->getUInt("result")),
                    .resultHQ1 = static_cast<uint16>(rset->getUInt("resultHQ1")),
                    .resultHQ2 = static_cast<uint16>(rset->getUInt("resultHQ2")),
                    .resultHQ3 = static_cast<uint16>(rset->getUInt("resultHQ3")),

                    .resultQty    = static_cast<uint8>(rset->getUInt("resultQty")),
                    .resultHQ1Qty = static_cast<uint8>(rset->getUInt("resultHQ1Qty")),
                    .resultHQ2Qty = static_cast<uint8>(rset->getUInt("resultHQ2Qty")),
                    .resultHQ3Qty = static_cast<uint8>(rset->getUInt("resultHQ3Qty")),

                    .resultName = rset->getString("resultName").c_str(),
                };
                synergyRecipes.push_back(recipe);
            }
        }
    }

    auto GetSynergyRecipeByID(uint32 id) -> std::optional<SynergyRecipe>
    {
        // TODO: Use a map instead of a vector for faster lookups
        for (const auto& recipe : synergyRecipes)
        {
            if (recipe.id == id)
            {
                return recipe;
            }
        }
        return std::nullopt;
    }

    auto GetSynergyRecipeByIngredients(uint16 ingredient1, uint16 ingredient2, uint16 ingredient3, uint16 ingredient4, uint16 ingredient5, uint16 ingredient6, uint16 ingredient7, uint16 ingredient8) -> std::optional<SynergyRecipe>
    {
        // TODO: Use a map instead of a vector for faster lookups
        for (const auto& recipe : synergyRecipes)
        {
            if (recipe.ingredient1 == ingredient1 &&
                recipe.ingredient2 == ingredient2 &&
                recipe.ingredient3 == ingredient3 &&
                recipe.ingredient4 == ingredient4 &&
                recipe.ingredient5 == ingredient5 &&
                recipe.ingredient6 == ingredient6 &&
                recipe.ingredient7 == ingredient7 &&
                recipe.ingredient8 == ingredient8)
            {
                return recipe;
            }
        }
        return std::nullopt;
    }
} // namespace synergyutils
