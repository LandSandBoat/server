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

    auto rset = db::preparedStmt("SELECT * FROM char_points WHERE charid = ?", PChar->id);

    if (rset && rset->rowsCount() && rset->next())
    {
        ref<uint32>(0x04) = static_cast<uint32>(rset->getInt("sandoria_cp"));
        ref<uint32>(0x08) = static_cast<uint32>(rset->getInt("bastok_cp"));
        ref<uint32>(0x0C) = static_cast<uint32>(rset->getInt("windurst_cp"));

        ref<uint16>(0x10) = static_cast<uint16>(rset->getUInt("beastman_seal"));
        ref<uint16>(0x12) = static_cast<uint16>(rset->getUInt("kindred_seal"));
        ref<uint16>(0x14) = static_cast<uint16>(rset->getUInt("kindred_crest"));
        ref<uint16>(0x16) = static_cast<uint16>(rset->getUInt("high_kindred_crest"));
        ref<uint16>(0x18) = static_cast<uint16>(rset->getUInt("sacred_kindred_crest"));
        ref<uint16>(0x1A) = static_cast<uint16>(rset->getUInt("ancient_beastcoin"));
        ref<uint16>(0x1C) = static_cast<uint16>(rset->getUInt("valor_point"));
        ref<uint16>(0x1E) = static_cast<uint16>(rset->getUInt("scyld"));

        ref<uint32>(0x20) = static_cast<uint32>(rset->getInt("guild_fishing"));
        ref<uint32>(0x24) = static_cast<uint32>(rset->getInt("guild_woodworking"));
        ref<uint32>(0x28) = static_cast<uint32>(rset->getInt("guild_smithing"));
        ref<uint32>(0x2C) = static_cast<uint32>(rset->getInt("guild_goldsmithing"));
        ref<uint32>(0x30) = static_cast<uint32>(rset->getInt("guild_weaving"));
        ref<uint32>(0x34) = static_cast<uint32>(rset->getInt("guild_leathercraft"));
        ref<uint32>(0x38) = static_cast<uint32>(rset->getInt("guild_bonecraft"));
        ref<uint32>(0x3C) = static_cast<uint32>(rset->getInt("guild_alchemy"));
        ref<uint32>(0x40) = static_cast<uint32>(rset->getInt("guild_cooking"));

        ref<uint32>(0x44) = static_cast<uint32>(rset->getInt("cinder"));
        ref<uint8>(0x48)  = static_cast<uint8>(rset->getUInt("fire_fewell"));
        ref<uint8>(0x49)  = static_cast<uint8>(rset->getUInt("ice_fewell"));
        ref<uint8>(0x4A)  = static_cast<uint8>(rset->getUInt("wind_fewell"));
        ref<uint8>(0x4B)  = static_cast<uint8>(rset->getUInt("earth_fewell"));
        ref<uint8>(0x4C)  = static_cast<uint8>(rset->getUInt("lightning_fewell"));
        ref<uint8>(0x4D)  = static_cast<uint8>(rset->getUInt("water_fewell"));
        ref<uint8>(0x4E)  = static_cast<uint8>(rset->getUInt("light_fewell"));
        ref<uint8>(0x4F)  = static_cast<uint8>(rset->getUInt("dark_fewell"));

        ref<uint32>(0x50) = static_cast<uint32>(rset->getInt("ballista_point"));
        ref<uint32>(0x54) = static_cast<uint32>(rset->getInt("fellow_point"));
        ref<uint16>(0x58) = static_cast<uint16>(rset->getUInt("chocobuck_sandoria"));
        ref<uint16>(0x5A) = static_cast<uint16>(rset->getUInt("chocobuck_bastok"));
        ref<uint16>(0x5C) = static_cast<uint16>(rset->getUInt("chocobuck_windurst"));

        ref<uint16>(0x5E) = static_cast<int32>(rset->getInt("daily_tally")) == -1 ? 0 : static_cast<uint16>(rset->getInt("daily_tally"));

        ref<uint32>(0x60) = static_cast<uint32>(rset->getInt("research_mark"));
        ref<uint8>(0x64)  = static_cast<uint8>(rset->getUInt("tunnel_worm"));
        ref<uint8>(0x65)  = static_cast<uint8>(rset->getUInt("morion_worm"));
        ref<uint8>(0x66)  = static_cast<uint8>(rset->getUInt("phantom_worm"));
        ref<uint32>(0x68) = static_cast<uint32>(rset->getInt("moblin_marble"));

        ref<uint16>(0x6C) = static_cast<uint16>(rset->getUInt("infamy"));
        ref<uint16>(0x6E) = static_cast<uint16>(rset->getUInt("prestige"));
        ref<uint32>(0x70) = static_cast<uint32>(rset->getInt("legion_point"));
        ref<uint32>(0x74) = static_cast<uint32>(rset->getInt("spark_of_eminence"));
        ref<uint32>(0x78) = static_cast<uint32>(rset->getInt("shining_star"));

        ref<uint32>(0x7C) = static_cast<uint32>(rset->getInt("imperial_standing"));
        ref<uint32>(0x80) = static_cast<uint32>(rset->getInt("leujaoam_assault_point"));
        ref<uint32>(0x84) = static_cast<uint32>(rset->getInt("mamool_assault_point"));
        ref<uint32>(0x88) = static_cast<uint32>(rset->getInt("lebros_assault_point"));
        ref<uint32>(0x8C) = static_cast<uint32>(rset->getInt("periqia_assault_point"));
        ref<uint32>(0x90) = static_cast<uint32>(rset->getInt("ilrusi_assault_point"));
        ref<uint32>(0x94) = static_cast<uint32>(rset->getInt("nyzul_isle_assault_point"));
        ref<uint32>(0x98) = static_cast<uint32>(rset->getInt("zeni_point"));
        ref<uint32>(0x9C) = static_cast<uint32>(rset->getInt("jetton"));
        ref<uint32>(0xA0) = static_cast<uint32>(rset->getInt("therion_ichor"));

        ref<uint32>(0xA4) = static_cast<uint32>(rset->getInt("allied_notes"));

        ref<uint16>(0xA8) = static_cast<uint16>(rset->getUInt("aman_vouchers"));
        ref<uint16>(0xAA) = static_cast<uint16>(rset->getUInt("login_points"));

        ref<uint32>(0xAC) = static_cast<uint32>(rset->getInt("cruor"));
        ref<uint32>(0xB0) = static_cast<uint32>(rset->getInt("resistance_credit"));
        ref<uint32>(0xB4) = static_cast<uint32>(rset->getInt("dominion_note"));
        ref<uint8>(0xB8)  = static_cast<uint8>(rset->getUInt("fifth_echelon_trophy"));
        ref<uint8>(0xB9)  = static_cast<uint8>(rset->getUInt("fourth_echelon_trophy"));
        ref<uint8>(0xBA)  = static_cast<uint8>(rset->getUInt("third_echelon_trophy"));
        ref<uint8>(0xBB)  = static_cast<uint8>(rset->getUInt("second_echelon_trophy"));
        ref<uint8>(0xBC)  = static_cast<uint8>(rset->getUInt("first_echelon_trophy"));

        ref<uint8>(0xBD) = static_cast<uint8>(rset->getUInt("cave_points"));

        ref<uint8>(0xBE) = static_cast<uint8>(rset->getUInt("id_tags"));

        ref<uint8>(0xBF) = static_cast<uint8>(rset->getUInt("op_credits"));

        ref<uint32>(0xC4) = static_cast<uint32>(rset->getInt("voidstones"));
        ref<uint32>(0xC8) = static_cast<uint32>(rset->getInt("kupofried_corundums"));

        ref<uint8>(0xCC) = static_cast<uint8>(rset->getUInt("pheromone_sacks"));

        ref<uint8>(0xCE) = static_cast<uint8>(rset->getUInt("rems_ch1"));
        ref<uint8>(0xCF) = static_cast<uint8>(rset->getUInt("rems_ch2"));
        ref<uint8>(0xD0) = static_cast<uint8>(rset->getUInt("rems_ch3"));
        ref<uint8>(0xD1) = static_cast<uint8>(rset->getUInt("rems_ch4"));
        ref<uint8>(0xD2) = static_cast<uint8>(rset->getUInt("rems_ch5"));
        ref<uint8>(0xD3) = static_cast<uint8>(rset->getUInt("rems_ch6"));
        ref<uint8>(0xD4) = static_cast<uint8>(rset->getUInt("rems_ch7"));
        ref<uint8>(0xD5) = static_cast<uint8>(rset->getUInt("rems_ch8"));
        ref<uint8>(0xD6) = static_cast<uint8>(rset->getUInt("rems_ch9"));
        ref<uint8>(0xD7) = static_cast<uint8>(rset->getUInt("rems_ch10"));

        // clang-format off
        bitPackedCurrency1 packedData =
        {
            .bloodshed_plans_stored   = static_cast<uint64_t>(rset->getUInt("bloodshed_plans")),
            .umbrage_plans_stored     = static_cast<uint64_t>(rset->getUInt("umbrage_plans")),
            .ritualistic_plans_stored = static_cast<uint64_t>(rset->getUInt("ritualistic_plans")),
            .tutelary_plans_stored    = static_cast<uint64_t>(rset->getUInt("tutelary_plans")),
            .primacy_plans_stored     = static_cast<uint64_t>(rset->getUInt("primacy_plans")),
            .unused                   = 0U,
        };
        std::memcpy(&ref<uint64>(0xD8), &packedData, sizeof(packedData));
        // clang-format on

        ref<uint16>(0xE0) = static_cast<uint16>(rset->getUInt("reclamation_marks"));
        ref<uint32>(0xE4) = static_cast<uint32>(rset->getInt("unity_accolades"));

        // Crystal storage
        ref<uint16>(0xE8) = static_cast<uint16>(rset->getUInt("fire_crystals"));
        ref<uint16>(0xEA) = static_cast<uint16>(rset->getUInt("ice_crystals"));
        ref<uint16>(0xEC) = static_cast<uint16>(rset->getUInt("wind_crystals"));
        ref<uint16>(0xEE) = static_cast<uint16>(rset->getUInt("earth_crystals"));
        ref<uint16>(0xF0) = static_cast<uint16>(rset->getUInt("lightning_crystals"));
        ref<uint16>(0xF2) = static_cast<uint16>(rset->getUInt("water_crystals"));
        ref<uint16>(0xF4) = static_cast<uint16>(rset->getUInt("light_crystals"));
        ref<uint16>(0xF6) = static_cast<uint16>(rset->getUInt("dark_crystals"));

        ref<uint16>(0xF8) = static_cast<uint16>(rset->getUInt("deeds"));
    }

    ref<uint32>(0xC0) = charutils::getAvailableTraverserStones(PChar); // traverser_stones
}
