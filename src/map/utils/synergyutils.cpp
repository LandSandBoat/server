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
                    .id = rset->get<uint32>("id"),

                    .primary_skill   = rset->get<uint8>("primary_skill"),
                    .primary_rank    = rset->get<uint8>("primary_rank"),
                    .secondary_skill = rset->get<uint8>("secondary_skill"),
                    .secondary_rank  = rset->get<uint8>("secondary_rank"),
                    .tertiary_skill  = rset->get<uint8>("tertiary_skill"),
                    .tertiary_rank   = rset->get<uint8>("tertiary_rank"),

                    .cost_fire_fewell      = rset->get<uint8>("cost_fire_fewell"),
                    .cost_ice_fewell       = rset->get<uint8>("cost_ice_fewell"),
                    .cost_wind_fewell      = rset->get<uint8>("cost_wind_fewell"),
                    .cost_earth_fewell     = rset->get<uint8>("cost_earth_fewell"),
                    .cost_lightning_fewell = rset->get<uint8>("cost_lightning_fewell"),
                    .cost_water_fewell     = rset->get<uint8>("cost_water_fewell"),
                    .cost_light_fewell     = rset->get<uint8>("cost_light_fewell"),
                    .cost_dark_fewell      = rset->get<uint8>("cost_dark_fewell"),

                    .ingredient1 = rset->get<uint16>("ingredient1"),
                    .ingredient2 = rset->get<uint16>("ingredient2"),
                    .ingredient3 = rset->get<uint16>("ingredient3"),
                    .ingredient4 = rset->get<uint16>("ingredient4"),
                    .ingredient5 = rset->get<uint16>("ingredient5"),
                    .ingredient6 = rset->get<uint16>("ingredient6"),
                    .ingredient7 = rset->get<uint16>("ingredient7"),
                    .ingredient8 = rset->get<uint16>("ingredient8"),

                    .result    = rset->get<uint16>("result"),
                    .resultHQ1 = rset->get<uint16>("resultHQ1"),
                    .resultHQ2 = rset->get<uint16>("resultHQ2"),
                    .resultHQ3 = rset->get<uint16>("resultHQ3"),

                    .resultQty    = rset->get<uint8>("resultQty"),
                    .resultHQ1Qty = rset->get<uint8>("resultHQ1Qty"),
                    .resultHQ2Qty = rset->get<uint8>("resultHQ2Qty"),
                    .resultHQ3Qty = rset->get<uint8>("resultHQ3Qty"),

                    .resultName = rset->get<std::string>("resultName").c_str(),
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
