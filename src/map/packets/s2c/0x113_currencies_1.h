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

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0113
// This packet is sent by the server to update the clients currency information. (1)
class GP_SERV_COMMAND_CURRENCIES_1 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CURRENCIES_1, GP_SERV_COMMAND_CURRENCIES_1>
{
public:
#pragma pack(push, 1) // uint64_t throws off alignment
    struct PacketData
    {
        int32_t  conquest_points_sandoria;
        int32_t  conquest_points_bastok;
        int32_t  conquest_points_windurst;
        uint16_t beastmans_seals_stored;
        uint16_t kindreds_seals_stored;
        uint16_t kindreds_crests_stored;
        uint16_t high_kindreds_crests_stored;
        uint16_t sacred_kindreds_crests_stored;
        uint16_t ancient_beastcoins_stored;
        uint16_t valor_points;
        uint16_t scylds;
        int32_t  guild_points_fishing;
        int32_t  guild_points_woodworking;
        int32_t  guild_points_smithing;
        int32_t  guild_points_goldsmithing;
        int32_t  guild_points_weaving;
        int32_t  guild_points_leathercraft;
        int32_t  guild_points_bonecraft;
        int32_t  guild_points_alchemy;
        int32_t  guild_points_cooking;
        int32_t  cinders;
        uint8_t  synergy_fewell_fire;
        uint8_t  synergy_fewell_ice;
        uint8_t  synergy_fewell_wind;
        uint8_t  synergy_fewell_earth;
        uint8_t  synergy_fewell_lightning;
        uint8_t  synergy_fewell_water;
        uint8_t  synergy_fewell_light;
        uint8_t  synergy_fewell_dark;
        int32_t  ballista_points;
        int32_t  fellow_points;
        uint16_t chocobucks_sandoria_team;
        uint16_t chocobucks_bastok_team;
        uint16_t chocobucks_windurst_team;
        uint16_t daily_tally;
        int32_t  research_marks;
        uint8_t  wizened_tunnel_worms;
        uint8_t  wizened_morion_worms;
        uint8_t  wizened_phantom_worms;
        uint8_t  unknown67;
        int32_t  moblin_marbles;
        uint16_t infamy;
        uint16_t prestige;
        int32_t  legion_points;
        int32_t  sparks_of_eminence;
        int32_t  shining_stars;
        int32_t  imperial_standing;
        int32_t  assault_points_l_sanctum;
        int32_t  assault_points_mjtg;
        int32_t  assault_points_l_cavern;
        int32_t  assault_points_periqia;
        int32_t  assault_points_ilrusi_atoll;
        int32_t  tokens;
        int32_t  zeni;
        int32_t  jettons;
        int32_t  therion_ichor;
        int32_t  allied_notes;
        uint16_t copper_aman_vouchers_stored;
        uint16_t login_points;
        int32_t  cruor;
        int32_t  resistance_credits;
        int32_t  dominion_notes;
        uint8_t  echelon_battle_trophies_5th;
        uint8_t  echelon_battle_trophies_4th;
        uint8_t  echelon_battle_trophies_3rd;
        uint8_t  echelon_battle_trophies_2nd;
        uint8_t  echelon_battle_trophies_1st;
        uint8_t  cave_conservation_points;
        uint8_t  imperial_army_id_tags;
        uint8_t  op_credits;
        int32_t  traverser_stones;
        int32_t  voidstones;
        int32_t  kupofrieds_corundums;
        uint8_t  moblin_pheromone_sacks;
        uint8_t  unknownCD;
        uint8_t  rems_tale_chapters_1_stored;
        uint8_t  rems_tale_chapters_2_stored;
        uint8_t  rems_tale_chapters_3_stored;
        uint8_t  rems_tale_chapters_4_stored;
        uint8_t  rems_tale_chapters_5_stored;
        uint8_t  rems_tale_chapters_6_stored;
        uint8_t  rems_tale_chapters_7_stored;
        uint8_t  rems_tale_chapters_8_stored;
        uint8_t  rems_tale_chapters_9_stored;
        uint8_t  rems_tale_chapters_10_stored;
        uint64_t bloodshed_plans_stored : 9;
        uint64_t umbrage_plans_stored : 9;
        uint64_t ritualistic_plans_stored : 9;
        uint64_t tutelary_plans_stored : 9;
        uint64_t primacy_plans_stored : 9;
        uint64_t unused : 19;
        uint16_t reclamation_marks;
        uint16_t padding00;
        int32_t  unity_accolades;
        uint16_t fire_crystals_stored;
        uint16_t ice_crystals_stored;
        uint16_t wind_crystals_stored;
        uint16_t earth_crystals_stored;
        uint16_t lightning_crystals_stored;
        uint16_t water_crystals_stored;
        uint16_t light_crystals_stored;
        uint16_t dark_crystals_stored;
        uint16_t deeds;
        uint16_t padding01;
    };
#pragma pack(pop)

    GP_SERV_COMMAND_CURRENCIES_1(CCharEntity* PChar);
};
