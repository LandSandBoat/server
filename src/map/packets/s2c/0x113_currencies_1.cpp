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

#include "0x113_currencies_1.h"

#include "common/database.h"
#include "entities/charentity.h"
#include "utils/charutils.h"

GP_SERV_COMMAND_CURRENCIES_1::GP_SERV_COMMAND_CURRENCIES_1(CCharEntity* PChar)
{
    auto& packet = this->data();

    const char* query = "SELECT sandoria_cp, bastok_cp, windurst_cp, beastman_seal, kindred_seal, kindred_crest, "
                        "high_kindred_crest, sacred_kindred_crest, ancient_beastcoin, valor_point, scyld, "
                        "guild_fishing, guild_woodworking, guild_smithing, guild_goldsmithing, guild_weaving, "
                        "guild_leathercraft, guild_bonecraft, guild_alchemy, guild_cooking, cinder, fire_fewell, "
                        "ice_fewell, wind_fewell, earth_fewell, lightning_fewell, water_fewell, light_fewell, "
                        "dark_fewell, ballista_point, fellow_point, chocobuck_sandoria, chocobuck_bastok, "
                        "chocobuck_windurst, daily_tally, research_mark, tunnel_worm, morion_worm, phantom_worm, "
                        "moblin_marble, infamy, prestige, legion_point, spark_of_eminence, shining_star, "
                        "imperial_standing, leujaoam_assault_point, mamool_assault_point, lebros_assault_point, "
                        "periqia_assault_point, ilrusi_assault_point, nyzul_isle_assault_point, zeni_point, jetton, "
                        "therion_ichor, allied_notes, aman_vouchers, login_points, cruor, resistance_credit, "
                        "dominion_note, fifth_echelon_trophy, fourth_echelon_trophy, third_echelon_trophy, "
                        "second_echelon_trophy, first_echelon_trophy, cave_points, id_tags, op_credits, "
                        "voidstones, kupofried_corundums, pheromone_sacks, rems_ch1, rems_ch2, "
                        "rems_ch3, rems_ch4, rems_ch5, rems_ch6, rems_ch7, rems_ch8, rems_ch9, rems_ch10, "
                        "bloodshed_plans, umbrage_plans, ritualistic_plans, tutelary_plans, primacy_plans, "
                        "reclamation_marks, unity_accolades, fire_crystals, ice_crystals, wind_crystals, "
                        "earth_crystals, lightning_crystals, water_crystals, light_crystals, dark_crystals, deeds "
                        "FROM char_points WHERE charid = ?";

    auto rset = db::preparedStmt(query, PChar->id);
    FOR_DB_SINGLE_RESULT(rset)
    {
        packet.conquest_points_sandoria = rset->get<int32_t>("sandoria_cp");
        packet.conquest_points_bastok   = rset->get<int32_t>("bastok_cp");
        packet.conquest_points_windurst = rset->get<int32_t>("windurst_cp");

        packet.beastmans_seals_stored        = rset->get<uint16_t>("beastman_seal");
        packet.kindreds_seals_stored         = rset->get<uint16_t>("kindred_seal");
        packet.kindreds_crests_stored        = rset->get<uint16_t>("kindred_crest");
        packet.high_kindreds_crests_stored   = rset->get<uint16_t>("high_kindred_crest");
        packet.sacred_kindreds_crests_stored = rset->get<uint16_t>("sacred_kindred_crest");
        packet.ancient_beastcoins_stored     = rset->get<uint16_t>("ancient_beastcoin");
        packet.valor_points                  = rset->get<uint16_t>("valor_point");
        packet.scylds                        = rset->get<uint16_t>("scyld");

        packet.guild_points_fishing      = rset->get<int32_t>("guild_fishing");
        packet.guild_points_woodworking  = rset->get<int32_t>("guild_woodworking");
        packet.guild_points_smithing     = rset->get<int32_t>("guild_smithing");
        packet.guild_points_goldsmithing = rset->get<int32_t>("guild_goldsmithing");
        packet.guild_points_weaving      = rset->get<int32_t>("guild_weaving");
        packet.guild_points_leathercraft = rset->get<int32_t>("guild_leathercraft");
        packet.guild_points_bonecraft    = rset->get<int32_t>("guild_bonecraft");
        packet.guild_points_alchemy      = rset->get<int32_t>("guild_alchemy");
        packet.guild_points_cooking      = rset->get<int32_t>("guild_cooking");

        packet.cinders                  = rset->get<int32_t>("cinder");
        packet.synergy_fewell_fire      = rset->get<uint8_t>("fire_fewell");
        packet.synergy_fewell_ice       = rset->get<uint8_t>("ice_fewell");
        packet.synergy_fewell_wind      = rset->get<uint8_t>("wind_fewell");
        packet.synergy_fewell_earth     = rset->get<uint8_t>("earth_fewell");
        packet.synergy_fewell_lightning = rset->get<uint8_t>("lightning_fewell");
        packet.synergy_fewell_water     = rset->get<uint8_t>("water_fewell");
        packet.synergy_fewell_light     = rset->get<uint8_t>("light_fewell");
        packet.synergy_fewell_dark      = rset->get<uint8_t>("dark_fewell");

        packet.ballista_points          = rset->get<int32_t>("ballista_point");
        packet.fellow_points            = rset->get<int32_t>("fellow_point");
        packet.chocobucks_sandoria_team = rset->get<uint16_t>("chocobuck_sandoria");
        packet.chocobucks_bastok_team   = rset->get<uint16_t>("chocobuck_bastok");
        packet.chocobucks_windurst_team = rset->get<uint16_t>("chocobuck_windurst");

        const auto dailyTally = rset->get<int32>("daily_tally");
        packet.daily_tally    = dailyTally == -1 ? 0 : static_cast<uint16_t>(dailyTally);

        packet.research_marks        = rset->get<int32_t>("research_mark");
        packet.wizened_tunnel_worms  = rset->get<uint8_t>("tunnel_worm");
        packet.wizened_morion_worms  = rset->get<uint8_t>("morion_worm");
        packet.wizened_phantom_worms = rset->get<uint8_t>("phantom_worm");
        packet.moblin_marbles        = rset->get<int32_t>("moblin_marble");

        packet.infamy             = rset->get<uint16_t>("infamy");
        packet.prestige           = rset->get<uint16_t>("prestige");
        packet.legion_points      = rset->get<int32_t>("legion_point");
        packet.sparks_of_eminence = rset->get<int32_t>("spark_of_eminence");
        packet.shining_stars      = rset->get<int32_t>("shining_star");

        packet.imperial_standing           = rset->get<int32_t>("imperial_standing");
        packet.assault_points_l_sanctum    = rset->get<int32_t>("leujaoam_assault_point");
        packet.assault_points_mjtg         = rset->get<int32_t>("mamool_assault_point");
        packet.assault_points_l_cavern     = rset->get<int32_t>("lebros_assault_point");
        packet.assault_points_periqia      = rset->get<int32_t>("periqia_assault_point");
        packet.assault_points_ilrusi_atoll = rset->get<int32_t>("ilrusi_assault_point");
        packet.tokens                      = rset->get<int32_t>("nyzul_isle_assault_point");
        packet.zeni                        = rset->get<int32_t>("zeni_point");
        packet.jettons                     = rset->get<int32_t>("jetton");
        packet.therion_ichor               = rset->get<int32_t>("therion_ichor");

        packet.allied_notes = rset->get<int32_t>("allied_notes");

        packet.copper_aman_vouchers_stored = rset->get<uint16_t>("aman_vouchers");
        packet.login_points                = rset->get<uint16_t>("login_points");

        packet.cruor                       = rset->get<int32_t>("cruor");
        packet.resistance_credits          = rset->get<int32_t>("resistance_credit");
        packet.dominion_notes              = rset->get<int32_t>("dominion_note");
        packet.echelon_battle_trophies_5th = rset->get<uint8_t>("fifth_echelon_trophy");
        packet.echelon_battle_trophies_4th = rset->get<uint8_t>("fourth_echelon_trophy");
        packet.echelon_battle_trophies_3rd = rset->get<uint8_t>("third_echelon_trophy");
        packet.echelon_battle_trophies_2nd = rset->get<uint8_t>("second_echelon_trophy");
        packet.echelon_battle_trophies_1st = rset->get<uint8_t>("first_echelon_trophy");

        packet.cave_conservation_points = rset->get<uint8_t>("cave_points");
        packet.imperial_army_id_tags    = rset->get<uint8_t>("id_tags");
        packet.op_credits               = rset->get<uint8_t>("op_credits");

        packet.voidstones           = rset->get<int32_t>("voidstones");
        packet.kupofrieds_corundums = rset->get<int32_t>("kupofried_corundums");

        packet.moblin_pheromone_sacks = rset->get<uint8_t>("pheromone_sacks");

        packet.rems_tale_chapters_1_stored  = rset->get<uint8_t>("rems_ch1");
        packet.rems_tale_chapters_2_stored  = rset->get<uint8_t>("rems_ch2");
        packet.rems_tale_chapters_3_stored  = rset->get<uint8_t>("rems_ch3");
        packet.rems_tale_chapters_4_stored  = rset->get<uint8_t>("rems_ch4");
        packet.rems_tale_chapters_5_stored  = rset->get<uint8_t>("rems_ch5");
        packet.rems_tale_chapters_6_stored  = rset->get<uint8_t>("rems_ch6");
        packet.rems_tale_chapters_7_stored  = rset->get<uint8_t>("rems_ch7");
        packet.rems_tale_chapters_8_stored  = rset->get<uint8_t>("rems_ch8");
        packet.rems_tale_chapters_9_stored  = rset->get<uint8_t>("rems_ch9");
        packet.rems_tale_chapters_10_stored = rset->get<uint8_t>("rems_ch10");

        packet.bloodshed_plans_stored   = rset->get<uint64_t>("bloodshed_plans");
        packet.umbrage_plans_stored     = rset->get<uint64_t>("umbrage_plans");
        packet.ritualistic_plans_stored = rset->get<uint64_t>("ritualistic_plans");
        packet.tutelary_plans_stored    = rset->get<uint64_t>("tutelary_plans");
        packet.primacy_plans_stored     = rset->get<uint64_t>("primacy_plans");
        packet.unused                   = 0;

        packet.reclamation_marks = rset->get<uint16_t>("reclamation_marks");
        packet.unity_accolades   = rset->get<int32_t>("unity_accolades");

        packet.fire_crystals_stored      = rset->get<uint16_t>("fire_crystals");
        packet.ice_crystals_stored       = rset->get<uint16_t>("ice_crystals");
        packet.wind_crystals_stored      = rset->get<uint16_t>("wind_crystals");
        packet.earth_crystals_stored     = rset->get<uint16_t>("earth_crystals");
        packet.lightning_crystals_stored = rset->get<uint16_t>("lightning_crystals");
        packet.water_crystals_stored     = rset->get<uint16_t>("water_crystals");
        packet.light_crystals_stored     = rset->get<uint16_t>("light_crystals");
        packet.dark_crystals_stored      = rset->get<uint16_t>("dark_crystals");

        packet.deeds = rset->get<uint16_t>("deeds");
    }

    // Contains its own query and logic
    packet.traverser_stones = charutils::getAvailableTraverserStones(PChar);
}
