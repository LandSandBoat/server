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
#pragma once

#include "common/cbasetypes.h"

#include <optional>

namespace synergyutils
{
    struct SynergyRecipe
    {
        uint32 id;

        uint8 primary_skill;
        uint8 primary_rank;
        uint8 secondary_skill;
        uint8 secondary_rank;
        uint8 tertiary_skill;
        uint8 tertiary_rank;

        uint8 cost_fire_fewell;
        uint8 cost_ice_fewell;
        uint8 cost_wind_fewell;
        uint8 cost_earth_fewell;
        uint8 cost_lightning_fewell;
        uint8 cost_water_fewell;
        uint8 cost_light_fewell;
        uint8 cost_dark_fewell;

        uint16 ingredient1;
        uint16 ingredient2;
        uint16 ingredient3;
        uint16 ingredient4;
        uint16 ingredient5;
        uint16 ingredient6;
        uint16 ingredient7;
        uint16 ingredient8;

        uint16 result;
        uint16 resultHQ1;
        uint16 resultHQ2;
        uint16 resultHQ3;

        uint8 resultQty;
        uint8 resultHQ1Qty;
        uint8 resultHQ2Qty;
        uint8 resultHQ3Qty;

        std::string resultName;
    };

    void LoadSynergyRecipes();

    auto GetSynergyRecipeByID(uint32 id) -> std::optional<SynergyRecipe>;
    auto GetSynergyRecipeByIngredients(uint16 ingredient1, uint16 ingredient2, uint16 ingredient3, uint16 ingredient4, uint16 ingredient5, uint16 ingredient6, uint16 ingredient7, uint16 ingredient8) -> std::optional<SynergyRecipe>;
} // namespace synergyutils
