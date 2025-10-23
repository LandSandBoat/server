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

#include "0x058_recipe.h"

#include "entities/charentity.h"
#include "packets/s2c/0x031_recipe.h"
#include "validation.h"

auto GP_CLI_COMMAND_RECIPE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .range("skill", skill, 0x01, 0x08) // Fishing 0x00 to Digging 0x0A. 0x00, 0x09, and 0x0A are not implemented
        .range("level", level, 0, 110)
        .range("Mode", Mode, // 1-5 but only 2-3 are implemented
               GP_CLI_COMMAND_RECIPE_MODE::RequestAvailableRecipeList,
               GP_CLI_COMMAND_RECIPE_MODE::RequestRecipeMaterials)
        .custom([&](PacketValidator& v)
                {
                    // clang-format off
                    switch (static_cast<GP_CLI_COMMAND_RECIPE_MODE>(Mode))
                    {
                        case GP_CLI_COMMAND_RECIPE_MODE::RequestAvailableRecipeList:
                            v.range("Param4", Param4, 0, 11)  // Skill 0 to 110
                            // The recipe pagenation values (Param1 & Param2) are used to walk the pages of recipes. The initial page will start with values 0 and 16.
                            // Each page beyond that will step through the recipes, incrementing the values by 16.
                                .multipleOf("Param1", Param1, 16);
                            break;
                        case GP_CLI_COMMAND_RECIPE_MODE::RequestRecipeMaterials:
                            v.range("Param4", Param4, 0, 11);
                            break;
                        default:
                            break;
                    }
                    // clang-format on
                });
}

void GP_CLI_COMMAND_RECIPE::process(MapSession* PSession, CCharEntity* PChar) const
{
    uint16 skillRank           = 0;
    uint16 pagination          = 0;
    uint16 selectedRecipeIndex = 0;

    switch (static_cast<GP_CLI_COMMAND_RECIPE_MODE>(Mode))
    {
        case GP_CLI_COMMAND_RECIPE_MODE::RequestAvailableRecipeList:
            // For pagination, the client sends the range in increments of 16. (0..0x10, 0x10..0x20, etc)
            skillRank  = Param4;
            pagination = Param1;

            PChar->pushPacket<GP_SERV_COMMAND_RECIPE>(GP_SERV_COMMAND_RECIPE_TYPE::RecipeList, skill, level, skillRank, pagination);
            break;
        case GP_CLI_COMMAND_RECIPE_MODE::RequestRecipeMaterials:
            skillRank           = Param4;
            selectedRecipeIndex = Param3;

            PChar->pushPacket<GP_SERV_COMMAND_RECIPE>(GP_SERV_COMMAND_RECIPE_TYPE::RecipeDetail1, skill, level, skillRank, selectedRecipeIndex);
            break;
        default:
            break;
    }
}
