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

#include "currency1.h"

#include "common/cbasetypes.h"
#include "common/database.h"
#include "entities/charentity.h"
#include "utils/charutils.h"

// TODO: implement the packet wholesale
// from https://github.com/atom0s/XiPackets/tree/main/world/server/0x0113
// clang-format off
struct bitPackedCurrency1
{
    uint64_t bloodshed_plans_stored   : 9;
    uint64_t umbrage_plans_stored     : 9;
    uint64_t ritualistic_plans_stored : 9;
    uint64_t tutelary_plans_stored    : 9;
    uint64_t primacy_plans_stored     : 9;
    uint64_t unused                   : 19;
};
// clang-format on

CCurrencyPacket1::CCurrencyPacket1(CCharEntity* PChar)
{
    this->setType(0x113);
    this->setSize(252);

    const char* query = "SELECT sandoria_cp, bastok_cp, windurst_cp, beastman_seal, kindred_seal, kindred_crest, \
                        high_kindred_crest, sacred_kindred_crest, ancient_beastcoin, valor_point, scyld, \
                        guild_fishing, guild_woodworking, guild_smithing, guild_goldsmithing, guild_weaving, \
                        guild_leathercraft, guild_bonecraft, guild_alchemy, guild_cooking, cinder, fire_fewell, \
                        ice_fewell, wind_fewell, earth_fewell, lightning_fewell, water_fewell, light_fewell, \
                        dark_fewell, ballista_point, fellow_point, chocobuck_sandoria, chocobuck_bastok, \
                        chocobuck_windurst, daily_tally, research_mark, tunnel_worm, morion_worm, phantom_worm, \
                        moblin_marble, infamy, prestige, legion_point, spark_of_eminence, shining_star, \
                        imperial_standing, leujaoam_assault_point, mamool_assault_point, lebros_assault_point, \
                        periqia_assault_point, ilrusi_assault_point, nyzul_isle_assault_point, zeni_point, jetton, \
                        therion_ichor, allied_notes, aman_vouchers, login_points, cruor, resistance_credit, \
                        dominion_note, fifth_echelon_trophy, fourth_echelon_trophy, third_echelon_trophy, \
                        second_echelon_trophy, first_echelon_trophy, cave_points, id_tags, op_credits, \
                        voidstones, kupofried_corundums, pheromone_sacks, rems_ch1, rems_ch2, \
                        rems_ch3, rems_ch4, rems_ch5, rems_ch6, rems_ch7, rems_ch8, rems_ch9, rems_ch10, \
                        bloodshed_plans, umbrage_plans, ritualistic_plans, tutelary_plans, primacy_plans, \
                        reclamation_marks, unity_accolades, fire_crystals, ice_crystals, wind_crystals, \
                        earth_crystals, lightning_crystals, water_crystals, light_crystals, dark_crystals, deeds \
                        FROM char_points WHERE charid = ?";

    auto rset = db::preparedStmt(query, PChar->id);
    if (rset && rset->rowsCount() && rset->next())
    {
        ref<uint32>(0x04) = rset->get<uint32>("sandoria_cp");
        ref<uint32>(0x08) = rset->get<uint32>("bastok_cp");
        ref<uint32>(0x0C) = rset->get<uint32>("windurst_cp");

        ref<uint16>(0x10) = rset->get<uint16>("beastman_seal");
        ref<uint16>(0x12) = rset->get<uint16>("kindred_seal");
        ref<uint16>(0x14) = rset->get<uint16>("kindred_crest");
        ref<uint16>(0x16) = rset->get<uint16>("high_kindred_crest");
        ref<uint16>(0x18) = rset->get<uint16>("sacred_kindred_crest");
        ref<uint16>(0x1A) = rset->get<uint16>("ancient_beastcoin");
        ref<uint16>(0x1C) = rset->get<uint16>("valor_point");
        ref<uint16>(0x1E) = rset->get<uint16>("scyld");

        ref<uint32>(0x20) = rset->get<uint32>("guild_fishing");
        ref<uint32>(0x24) = rset->get<uint32>("guild_woodworking");
        ref<uint32>(0x28) = rset->get<uint32>("guild_smithing");
        ref<uint32>(0x2C) = rset->get<uint32>("guild_goldsmithing");
        ref<uint32>(0x30) = rset->get<uint32>("guild_weaving");
        ref<uint32>(0x34) = rset->get<uint32>("guild_leathercraft");
        ref<uint32>(0x38) = rset->get<uint32>("guild_bonecraft");
        ref<uint32>(0x3C) = rset->get<uint32>("guild_alchemy");
        ref<uint32>(0x40) = rset->get<uint32>("guild_cooking");

        ref<uint32>(0x44) = rset->get<uint32>("cinder");
        ref<uint8>(0x48)  = rset->get<uint8>("fire_fewell");
        ref<uint8>(0x49)  = rset->get<uint8>("ice_fewell");
        ref<uint8>(0x4A)  = rset->get<uint8>("wind_fewell");
        ref<uint8>(0x4B)  = rset->get<uint8>("earth_fewell");
        ref<uint8>(0x4C)  = rset->get<uint8>("lightning_fewell");
        ref<uint8>(0x4D)  = rset->get<uint8>("water_fewell");
        ref<uint8>(0x4E)  = rset->get<uint8>("light_fewell");
        ref<uint8>(0x4F)  = rset->get<uint8>("dark_fewell");

        ref<uint32>(0x50) = rset->get<uint32>("ballista_point");
        ref<uint32>(0x54) = rset->get<uint32>("fellow_point");
        ref<uint16>(0x58) = rset->get<uint16>("chocobuck_sandoria");
        ref<uint16>(0x5A) = rset->get<uint16>("chocobuck_bastok");
        ref<uint16>(0x5C) = rset->get<uint16>("chocobuck_windurst");

        const auto dailyTally = rset->get<int32>("daily_tally");
        ref<uint16>(0x5E)     = dailyTally == -1 ? 0 : static_cast<uint16>(dailyTally);

        ref<uint32>(0x60) = rset->get<uint32>("research_mark");
        ref<uint8>(0x64)  = rset->get<uint8>("tunnel_worm");
        ref<uint8>(0x65)  = rset->get<uint8>("morion_worm");
        ref<uint8>(0x66)  = rset->get<uint8>("phantom_worm");
        ref<uint32>(0x68) = rset->get<uint32>("moblin_marble");

        ref<uint16>(0x6C) = rset->get<uint16>("infamy");
        ref<uint16>(0x6E) = rset->get<uint16>("prestige");
        ref<uint32>(0x70) = rset->get<uint32>("legion_point");
        ref<uint32>(0x74) = rset->get<uint32>("spark_of_eminence");
        ref<uint32>(0x78) = rset->get<uint32>("shining_star");

        ref<uint32>(0x7C) = rset->get<uint32>("imperial_standing");
        ref<uint32>(0x80) = rset->get<uint32>("leujaoam_assault_point");
        ref<uint32>(0x84) = rset->get<uint32>("mamool_assault_point");
        ref<uint32>(0x88) = rset->get<uint32>("lebros_assault_point");
        ref<uint32>(0x8C) = rset->get<uint32>("periqia_assault_point");
        ref<uint32>(0x90) = rset->get<uint32>("ilrusi_assault_point");
        ref<uint32>(0x94) = rset->get<uint32>("nyzul_isle_assault_point");
        ref<uint32>(0x98) = rset->get<uint32>("zeni_point");
        ref<uint32>(0x9C) = rset->get<uint32>("jetton");
        ref<uint32>(0xA0) = rset->get<uint32>("therion_ichor");

        ref<uint32>(0xA4) = rset->get<uint32>("allied_notes");

        ref<uint16>(0xA8) = rset->get<uint16>("aman_vouchers");
        ref<uint16>(0xAA) = rset->get<uint16>("login_points");

        ref<uint32>(0xAC) = rset->get<uint32>("cruor");
        ref<uint32>(0xB0) = rset->get<uint32>("resistance_credit");
        ref<uint32>(0xB4) = rset->get<uint32>("dominion_note");
        ref<uint8>(0xB8)  = rset->get<uint8>("fifth_echelon_trophy");
        ref<uint8>(0xB9)  = rset->get<uint8>("fourth_echelon_trophy");
        ref<uint8>(0xBA)  = rset->get<uint8>("third_echelon_trophy");
        ref<uint8>(0xBB)  = rset->get<uint8>("second_echelon_trophy");
        ref<uint8>(0xBC)  = rset->get<uint8>("first_echelon_trophy");

        ref<uint8>(0xBD) = rset->get<uint8>("cave_points");

        ref<uint8>(0xBE) = rset->get<uint8>("id_tags");

        ref<uint8>(0xBF) = rset->get<uint8>("op_credits");

        ref<uint32>(0xC4) = rset->get<uint32>("voidstones");
        ref<uint32>(0xC8) = rset->get<uint32>("kupofried_corundums");

        ref<uint8>(0xCC) = rset->get<uint8>("pheromone_sacks");

        ref<uint8>(0xCE) = rset->get<uint8>("rems_ch1");
        ref<uint8>(0xCF) = rset->get<uint8>("rems_ch2");
        ref<uint8>(0xD0) = rset->get<uint8>("rems_ch3");
        ref<uint8>(0xD1) = rset->get<uint8>("rems_ch4");
        ref<uint8>(0xD2) = rset->get<uint8>("rems_ch5");
        ref<uint8>(0xD3) = rset->get<uint8>("rems_ch6");
        ref<uint8>(0xD4) = rset->get<uint8>("rems_ch7");
        ref<uint8>(0xD5) = rset->get<uint8>("rems_ch8");
        ref<uint8>(0xD6) = rset->get<uint8>("rems_ch9");
        ref<uint8>(0xD7) = rset->get<uint8>("rems_ch10");

        // clang-format off
        bitPackedCurrency1 packedData =
        {
            .bloodshed_plans_stored   = rset->get<uint64>("bloodshed_plans"),
            .umbrage_plans_stored     = rset->get<uint64>("umbrage_plans"),
            .ritualistic_plans_stored = rset->get<uint64>("ritualistic_plans"),
            .tutelary_plans_stored    = rset->get<uint64>("tutelary_plans"),
            .primacy_plans_stored     = rset->get<uint64>("primacy_plans"),
            .unused                   = 0U,
        };
        std::memcpy(&ref<uint64>(0xD8), &packedData, sizeof(packedData));
        // clang-format on

        ref<uint16>(0xE0) = rset->get<uint16>("reclamation_marks");
        ref<uint32>(0xE4) = rset->get<uint32>("unity_accolades");

        ref<uint16>(0xE8) = rset->get<uint16>("fire_crystals");
        ref<uint16>(0xEA) = rset->get<uint16>("ice_crystals");
        ref<uint16>(0xEC) = rset->get<uint16>("wind_crystals");
        ref<uint16>(0xEE) = rset->get<uint16>("earth_crystals");
        ref<uint16>(0xF0) = rset->get<uint16>("lightning_crystals");
        ref<uint16>(0xF2) = rset->get<uint16>("water_crystals");
        ref<uint16>(0xF4) = rset->get<uint16>("light_crystals");
        ref<uint16>(0xF6) = rset->get<uint16>("dark_crystals");

        ref<uint16>(0xF8) = rset->get<uint16>("deeds");
    }

    // Contains it's own query and logic
    ref<uint32>(0xC0) = charutils::getAvailableTraverserStones(PChar); // traverser_stones
}
