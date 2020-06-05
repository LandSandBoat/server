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

#include "../../common/socket.h"

#include "currency1.h"

#include "../entities/charentity.h"

CCurrencyPacket1::CCurrencyPacket1(CCharEntity* PChar)
{
	this->id(0x113);
	this->length(252);

    const char* query = "SELECT sandoria_cp, bastok_cp, windurst_cp, beastman_seal, kindred_seal, kindred_crest, \
                        high_kindred_crest, sacred_kindred_crest, ancient_beastcoin, valor_point, scyld, \
                        guild_fishing, guild_woodworking, guild_smithing, guild_goldsmithing, guild_weaving, \
                        guild_leathercraft, guild_bonecraft, guild_alchemy, guild_cooking, cinder, fire_fewell, \
                        ice_fewell, wind_fewell, earth_fewell, lightning_fewell, water_fewell, light_fewell, \
                        dark_fewell, ballista_point, fellow_point, chocobuck_sandoria, chocobuck_bastok, chocobuck_windurst, \
                        research_mark, tunnel_worm, morion_worm, phantom_worm, moblin_marble, infamy, prestige, \
                        legion_point, spark_of_eminence, shining_star, imperial_standing, leujaoam_assault_point, \
                        mamool_assault_point, lebros_assault_point, periqia_assault_point, ilrusi_assault_point, \
                        nyzul_isle_assault_point, zeni_point, jetton, therion_ichor, allied_notes, cruor, resistance_credit, \
                        dominion_note, fifth_echelon_trophy, fourth_echelon_trophy, third_echelon_trophy, second_echelon_trophy, \
                        first_echelon_trophy, cave_points, id_tags, op_credits, traverser_stones, voidstones, kupofried_corundums, \
                        pheromone_sacks, fire_crystals, ice_crystals, wind_crystals, earth_crystals, lightning_crystals, \
                        water_crystals, light_crystals, dark_crystals FROM char_points WHERE charid = %d";

    int ret = Sql_Query(SqlHandle, query, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0);
        ref<uint32>(0x08) = Sql_GetIntData(SqlHandle, 1);
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 2);

        ref<uint16>(0x10) = Sql_GetUIntData(SqlHandle, 3);
        ref<uint16>(0x12) = Sql_GetUIntData(SqlHandle, 4);
        ref<uint16>(0x14) = Sql_GetUIntData(SqlHandle, 5);
        ref<uint16>(0x16) = Sql_GetUIntData(SqlHandle, 6);
        ref<uint16>(0x18) = Sql_GetUIntData(SqlHandle, 7);
        ref<uint16>(0x1A) = Sql_GetUIntData(SqlHandle, 8);
        ref<uint16>(0x1C) = Sql_GetUIntData(SqlHandle, 9);
        ref<uint16>(0x1E) = Sql_GetUIntData(SqlHandle, 10);

        ref<uint32>(0x20) = Sql_GetIntData(SqlHandle, 11);
        ref<uint32>(0x24) = Sql_GetIntData(SqlHandle, 12);
        ref<uint32>(0x28) = Sql_GetIntData(SqlHandle, 13);
        ref<uint32>(0x2C) = Sql_GetIntData(SqlHandle, 14);
        ref<uint32>(0x30) = Sql_GetIntData(SqlHandle, 15);
        ref<uint32>(0x34) = Sql_GetIntData(SqlHandle, 16);
        ref<uint32>(0x38) = Sql_GetIntData(SqlHandle, 17);
        ref<uint32>(0x3C) = Sql_GetIntData(SqlHandle, 18);
        ref<uint32>(0x40) = Sql_GetIntData(SqlHandle, 19);

        ref<uint32>(0x44) = Sql_GetIntData(SqlHandle, 20);
        ref<uint8>(0x48) = Sql_GetUIntData(SqlHandle, 21);
        ref<uint8>(0x49) = Sql_GetUIntData(SqlHandle, 22);
        ref<uint8>(0x4A) = Sql_GetUIntData(SqlHandle, 23);
        ref<uint8>(0x4B) = Sql_GetUIntData(SqlHandle, 24);
        ref<uint8>(0x4C) = Sql_GetUIntData(SqlHandle, 25);
        ref<uint8>(0x4D) = Sql_GetUIntData(SqlHandle, 26);
        ref<uint8>(0x4E) = Sql_GetUIntData(SqlHandle, 27);
        ref<uint8>(0x4F) = Sql_GetUIntData(SqlHandle, 28);

        ref<uint32>(0x50) = Sql_GetIntData(SqlHandle, 29);
        ref<uint32>(0x54) = Sql_GetIntData(SqlHandle, 30);
        ref<uint16>(0x58) = Sql_GetUIntData(SqlHandle, 31);
        ref<uint16>(0x5A) = Sql_GetUIntData(SqlHandle, 32);
        ref<uint16>(0x5C) = Sql_GetUIntData(SqlHandle, 33);
        // daily tally (2 byte)
        ref<uint32>(0x60) = Sql_GetIntData(SqlHandle, 34);
        ref<uint8>(0x64) = Sql_GetUIntData(SqlHandle, 35);
        ref<uint8>(0x65) = Sql_GetUIntData(SqlHandle, 36);
        ref<uint8>(0x66) = Sql_GetUIntData(SqlHandle, 37);
        ref<uint32>(0x68) = Sql_GetIntData(SqlHandle, 38);

        ref<uint16>(0x6C) = Sql_GetUIntData(SqlHandle, 39);
        ref<uint16>(0x6E) = Sql_GetUIntData(SqlHandle, 40);

        ref<uint32>(0x70) = Sql_GetIntData(SqlHandle, 41);
        ref<uint32>(0x74) = Sql_GetIntData(SqlHandle, 42);
        ref<uint32>(0x78) = Sql_GetIntData(SqlHandle, 43);

        ref<uint32>(0x7C) = Sql_GetIntData(SqlHandle, 44);
        ref<uint32>(0x80) = Sql_GetIntData(SqlHandle, 45);
        ref<uint32>(0x84) = Sql_GetIntData(SqlHandle, 46);
        ref<uint32>(0x88) = Sql_GetIntData(SqlHandle, 47);
        ref<uint32>(0x8C) = Sql_GetIntData(SqlHandle, 48);
        ref<uint32>(0x90) = Sql_GetIntData(SqlHandle, 49);
        ref<uint32>(0x94) = Sql_GetIntData(SqlHandle, 50);
        ref<uint32>(0x98) = Sql_GetIntData(SqlHandle, 51);
        ref<uint32>(0x9C) = Sql_GetIntData(SqlHandle, 52);
        ref<uint32>(0xA0) = Sql_GetIntData(SqlHandle, 53);

        ref<uint32>(0xA4) = Sql_GetIntData(SqlHandle, 54);

        // AMAN vouchers
        // unity accolades

        ref<uint32>(0xAC) = Sql_GetIntData(SqlHandle, 55);
        ref<uint32>(0xB0) = Sql_GetIntData(SqlHandle, 56);
        ref<uint32>(0xB4) = Sql_GetIntData(SqlHandle, 57);
        ref<uint8>(0xB8) = Sql_GetUIntData(SqlHandle, 58);
        ref<uint8>(0xB9) = Sql_GetUIntData(SqlHandle, 59);
        ref<uint8>(0xBA) = Sql_GetUIntData(SqlHandle, 60);
        ref<uint8>(0xBB) = Sql_GetUIntData(SqlHandle, 61);
        ref<uint8>(0xBC) = Sql_GetUIntData(SqlHandle, 62);

        ref<uint8>(0xBD) = Sql_GetUIntData(SqlHandle, 63);

        ref<uint8>(0xBE) = Sql_GetUIntData(SqlHandle, 64);

        ref<uint8>(0xBF) = Sql_GetUIntData(SqlHandle, 65);

        ref<uint32>(0xC0) = Sql_GetIntData(SqlHandle, 66);
        ref<uint32>(0xC4) = Sql_GetIntData(SqlHandle, 67);
        ref<uint32>(0xC8) = Sql_GetIntData(SqlHandle, 68);

        ref<uint8>(0xCC) = Sql_GetUIntData(SqlHandle, 69);

        // Crystal storage
        ref<uint16>(0xE8) = Sql_GetUIntData(SqlHandle, 70); // Fire Crystals
        ref<uint16>(0xEA) = Sql_GetUIntData(SqlHandle, 71); // Ice Crystals
        ref<uint16>(0xEC) = Sql_GetUIntData(SqlHandle, 72); // Wind Crystals
        ref<uint16>(0xEE) = Sql_GetUIntData(SqlHandle, 73); // Earth Crystals
        ref<uint16>(0xF0) = Sql_GetUIntData(SqlHandle, 74); // Lightning Crystals
        ref<uint16>(0xF2) = Sql_GetUIntData(SqlHandle, 75); // Water Crystals
        ref<uint16>(0xF4) = Sql_GetUIntData(SqlHandle, 76); // Light Crystals
        ref<uint16>(0xF6) = Sql_GetUIntData(SqlHandle, 77); // Dark Crystals
    }
}
