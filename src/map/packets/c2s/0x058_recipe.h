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

#pragma once
#include "base.h"

enum class GP_CLI_COMMAND_RECIPE_MODE : uint8
{
    RequestAvailableRankList      = 1, // Requesting a random recipe of appropriate rank
    RequestAvailableRecipeList    = 2, // Requesting list of recipes for a given rank
    RequestRecipeMaterials        = 3, // Requesting a specific recipe
    RequestCampaignOpsRecipe      = 4, // Not implemented
    SubmitCampaignOpsMaterialList = 5, // Not implemented
};

// https://github.com/atom0s/XiPackets/tree/main/world/client/0x0058
// This packet is sent by the client when interacting with a
// crafting NPC that can suggest recipes to the client.
GP_CLI_PACKET(GP_CLI_COMMAND_RECIPE,
              uint16_t skill;  // PS2: skill
              uint16_t level;  // PS2: level
              uint16_t Param0; // PS2: itemnum
              uint16_t Mode;   // PS2: dammy
              uint16_t Param1; // PS2: (New; did not exist.)
              uint16_t Param2; // PS2: (New; did not exist.)
              uint16_t Param3; // PS2: (New; did not exist.)
              uint16_t Param4; // PS2: (New; did not exist.)
);
