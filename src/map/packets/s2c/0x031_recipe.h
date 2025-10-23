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

class CCharEntity;
enum class GP_SERV_COMMAND_RECIPE_TYPE : uint16_t
{
    RecipeDetail1 = 1,
    RecipeList    = 2,
    RecipeDetail2 = 3,
    Unknown       = 4,
};

struct GP_SERV_COMMAND_RECIPE_TYPE1_3
{
    uint16_t                    productitem;   // PS2: productitem
    uint16_t                    need_skill_1;  // PS2: need_skill_1
    uint16_t                    need_skill_2;  // PS2: need_skill_2
    uint16_t                    need_skill_3;  // PS2: need_skill_3
    uint16_t                    need_item;     // PS2: need_item
    uint16_t                    need_key_item; // PS2: (New; did not exist.)
    uint16_t                    itemnum[8];    // PS2: itemnum
    uint16_t                    itemcount[8];  // PS2: itemcount
    GP_SERV_COMMAND_RECIPE_TYPE Type;          // PS2: (New; did not exist.)
    uint16_t                    unknown32;     // PS2: (New; did not exist.)
};

struct GP_SERV_COMMAND_RECIPE_TYPE2
{
    uint16_t                    unused04[6];  // PS2: (New; did not exist.)
    uint16_t                    itemnum[16];  // PS2: (New; did not exist.)
    GP_SERV_COMMAND_RECIPE_TYPE Type;         // PS2: (New; did not exist.)
    uint16_t                    itemnum_next; // PS2: (New; did not exist.)
};

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0031
// This packet is sent by the server to inform the client of synthesis related recipes.
class GP_SERV_COMMAND_RECIPE final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_RECIPE, GP_SERV_COMMAND_RECIPE>
{
public:
    struct PacketData
    {
        union
        {
            GP_SERV_COMMAND_RECIPE_TYPE1_3 Details;
            GP_SERV_COMMAND_RECIPE_TYPE2   List;
        };
    };

    GP_SERV_COMMAND_RECIPE(GP_SERV_COMMAND_RECIPE_TYPE type, uint16 skillID, uint16 skillLevel, uint8 skillRank, uint16 offset);
};
