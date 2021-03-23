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
                        dark_fewell, ballista_point, fellow_point, chocobuck_sandoria, chocobuck_bastok, \
                        chocobuck_windurst, daily_tally, research_mark, tunnel_worm, morion_worm, phantom_worm, \
                        moblin_marble, infamy, prestige, legion_point, spark_of_eminence, shining_star, \
                        imperial_standing, leujaoam_assault_point, mamool_assault_point, lebros_assault_point, \
                        periqia_assault_point, ilrusi_assault_point, nyzul_isle_assault_point, zeni_point, jetton, \
                        therion_ichor, allied_notes, aman_vouchers, login_points, cruor, resistance_credit, \
                        dominion_note, fifth_echelon_trophy, fourth_echelon_trophy, third_echelon_trophy, \
                        second_echelon_trophy, first_echelon_trophy, cave_points, id_tags, op_credits, \
                        traverser_stones, voidstones, kupofried_corundums, pheromone_sacks, rems_ch1, rems_ch2, \
                        rems_ch3, rems_ch4, rems_ch5, rems_ch6, rems_ch7, rems_ch8, rems_ch9, rems_ch10, \
                        reclamation_marks, unity_accolades, fire_crystals, ice_crystals, wind_crystals, \
                        earth_crystals, lightning_crystals, water_crystals, light_crystals, dark_crystals, deeds \
                        FROM char_points WHERE charid = %d";

    int ret = Sql_Query(SqlHandle, query, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0); // sandoria_cp
        ref<uint32>(0x08) = Sql_GetIntData(SqlHandle, 1); // bastok_cp
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 2); // windurst_cp

        ref<uint16>(0x10) = Sql_GetUIntData(SqlHandle, 3);  // beastman_seal
        ref<uint16>(0x12) = Sql_GetUIntData(SqlHandle, 4);  // kindred_seal
        ref<uint16>(0x14) = Sql_GetUIntData(SqlHandle, 5);  // kindred_crest
        ref<uint16>(0x16) = Sql_GetUIntData(SqlHandle, 6);  // high_kindred_crest
        ref<uint16>(0x18) = Sql_GetUIntData(SqlHandle, 7);  // sacred_kindred_crest
        ref<uint16>(0x1A) = Sql_GetUIntData(SqlHandle, 8);  // ancient_beastcoin
        ref<uint16>(0x1C) = Sql_GetUIntData(SqlHandle, 9);  // valor_point
        ref<uint16>(0x1E) = Sql_GetUIntData(SqlHandle, 10); // scyld

        ref<uint32>(0x20) = Sql_GetIntData(SqlHandle, 11); // guild_fishing
        ref<uint32>(0x24) = Sql_GetIntData(SqlHandle, 12); // guild_woodworking
        ref<uint32>(0x28) = Sql_GetIntData(SqlHandle, 13); // guild_smithing
        ref<uint32>(0x2C) = Sql_GetIntData(SqlHandle, 14); // guild_goldsmithing
        ref<uint32>(0x30) = Sql_GetIntData(SqlHandle, 15); // guild_weaving
        ref<uint32>(0x34) = Sql_GetIntData(SqlHandle, 16); // guild_leathercraft
        ref<uint32>(0x38) = Sql_GetIntData(SqlHandle, 17); // guild_bonecraft
        ref<uint32>(0x3C) = Sql_GetIntData(SqlHandle, 18); // guild_alchemy
        ref<uint32>(0x40) = Sql_GetIntData(SqlHandle, 19); // guild_cooking

        ref<uint32>(0x44) = Sql_GetIntData(SqlHandle, 20);  // cinder
        ref<uint8>(0x48)  = Sql_GetUIntData(SqlHandle, 21); // fire_fewell
        ref<uint8>(0x49)  = Sql_GetUIntData(SqlHandle, 22); // ice_fewell
        ref<uint8>(0x4A)  = Sql_GetUIntData(SqlHandle, 23); // wind_fewell
        ref<uint8>(0x4B)  = Sql_GetUIntData(SqlHandle, 24); // earth_fewell
        ref<uint8>(0x4C)  = Sql_GetUIntData(SqlHandle, 25); // lightning_fewell
        ref<uint8>(0x4D)  = Sql_GetUIntData(SqlHandle, 26); // water_fewell
        ref<uint8>(0x4E)  = Sql_GetUIntData(SqlHandle, 27); // light_fewell
        ref<uint8>(0x4F)  = Sql_GetUIntData(SqlHandle, 28); // dark_fewell

        ref<uint32>(0x50) = Sql_GetIntData(SqlHandle, 29);  // ballista_point
        ref<uint32>(0x54) = Sql_GetIntData(SqlHandle, 30);  // fellow_point
        ref<uint16>(0x58) = Sql_GetUIntData(SqlHandle, 31); // chocobuck_sandoria
        ref<uint16>(0x5A) = Sql_GetUIntData(SqlHandle, 32); // chocobuck_bastok
        ref<uint16>(0x5C) = Sql_GetUIntData(SqlHandle, 33); // chocobuck_windurst

        ref<uint16>(0x5E) = Sql_GetIntData(SqlHandle, 34) == -1 ? 0 : Sql_GetIntData(SqlHandle, 34); // daily_tally

        ref<uint32>(0x60) = Sql_GetIntData(SqlHandle, 35);  // research_mark
        ref<uint8>(0x64)  = Sql_GetUIntData(SqlHandle, 36); // tunnel_worm
        ref<uint8>(0x65)  = Sql_GetUIntData(SqlHandle, 37); // morion_worm
        ref<uint8>(0x66)  = Sql_GetUIntData(SqlHandle, 38); // phantom_worm
        ref<uint32>(0x68) = Sql_GetIntData(SqlHandle, 39);  // moblin_marble

        ref<uint16>(0x6C) = Sql_GetUIntData(SqlHandle, 40); // infamy
        ref<uint16>(0x6E) = Sql_GetUIntData(SqlHandle, 41); // prestige
        ref<uint32>(0x70) = Sql_GetIntData(SqlHandle, 42);  // legion_point
        ref<uint32>(0x74) = Sql_GetIntData(SqlHandle, 43);  // spark_of_eminence
        ref<uint32>(0x78) = Sql_GetIntData(SqlHandle, 44);  // shining_star

        ref<uint32>(0x7C) = Sql_GetIntData(SqlHandle, 45); // imperial_standing
        ref<uint32>(0x80) = Sql_GetIntData(SqlHandle, 46); // leujaoam_assault_point
        ref<uint32>(0x84) = Sql_GetIntData(SqlHandle, 47); // mamool_assault_point
        ref<uint32>(0x88) = Sql_GetIntData(SqlHandle, 48); // lebros_assault_point
        ref<uint32>(0x8C) = Sql_GetIntData(SqlHandle, 49); // periqia_assault_point
        ref<uint32>(0x90) = Sql_GetIntData(SqlHandle, 50); // ilrusi_assault_point
        ref<uint32>(0x94) = Sql_GetIntData(SqlHandle, 51); // nyzul_isle_assault_point
        ref<uint32>(0x98) = Sql_GetIntData(SqlHandle, 52); // zeni_point
        ref<uint32>(0x9C) = Sql_GetIntData(SqlHandle, 53); // jetton
        ref<uint32>(0xA0) = Sql_GetIntData(SqlHandle, 54); // therion_ichor

        ref<uint32>(0xA4) = Sql_GetIntData(SqlHandle, 55); // allied_notes

        ref<uint16>(0xA8) = Sql_GetUIntData(SqlHandle, 56); // aman_vouchers
        ref<uint16>(0xAA) = Sql_GetUIntData(SqlHandle, 57); // login_points

        ref<uint32>(0xAC) = Sql_GetIntData(SqlHandle, 58);  // cruor
        ref<uint32>(0xB0) = Sql_GetIntData(SqlHandle, 59);  // resistance_credit
        ref<uint32>(0xB4) = Sql_GetIntData(SqlHandle, 60);  // dominion_note
        ref<uint8>(0xB8)  = Sql_GetUIntData(SqlHandle, 61); // fifth_echelon_trophy
        ref<uint8>(0xB9)  = Sql_GetUIntData(SqlHandle, 62); // fourth_echelon_trophy
        ref<uint8>(0xBA)  = Sql_GetUIntData(SqlHandle, 63); // third_echelon_trophy
        ref<uint8>(0xBB)  = Sql_GetUIntData(SqlHandle, 64); // second_echelon_trophy
        ref<uint8>(0xBC)  = Sql_GetUIntData(SqlHandle, 65); // first_echelon_trophy

        ref<uint8>(0xBD) = Sql_GetUIntData(SqlHandle, 66); // cave_points

        ref<uint8>(0xBE) = Sql_GetUIntData(SqlHandle, 67); // id_tags

        ref<uint8>(0xBF) = Sql_GetUIntData(SqlHandle, 68); // op_credits

        ref<uint32>(0xC0) = Sql_GetIntData(SqlHandle, 69); // traverser_stones
        ref<uint32>(0xC4) = Sql_GetIntData(SqlHandle, 70); // voidstones
        ref<uint32>(0xC8) = Sql_GetIntData(SqlHandle, 71); // kupofried_corundums

        ref<uint8>(0xCC) = Sql_GetUIntData(SqlHandle, 72); // pheromone_sacks

        ref<uint8>(0xCE) = Sql_GetUIntData(SqlHandle, 73); // rems_ch1
        ref<uint8>(0xCF) = Sql_GetUIntData(SqlHandle, 74); // rems_ch2
        ref<uint8>(0xD0) = Sql_GetUIntData(SqlHandle, 75); // rems_ch3
        ref<uint8>(0xD1) = Sql_GetUIntData(SqlHandle, 76); // rems_ch4
        ref<uint8>(0xD2) = Sql_GetUIntData(SqlHandle, 77); // rems_ch5
        ref<uint8>(0xD3) = Sql_GetUIntData(SqlHandle, 78); // rems_ch6
        ref<uint8>(0xD4) = Sql_GetUIntData(SqlHandle, 79); // rems_ch7
        ref<uint8>(0xD5) = Sql_GetUIntData(SqlHandle, 80); // rems_ch8
        ref<uint8>(0xD6) = Sql_GetUIntData(SqlHandle, 81); // rems_ch9
        ref<uint8>(0xD7) = Sql_GetUIntData(SqlHandle, 82); // rems_ch10

        ref<uint16>(0xE0) = Sql_GetUIntData(SqlHandle, 83); // reclamation_marks
        ref<uint32>(0xE4) = Sql_GetIntData(SqlHandle, 84);  // unity_accolades

        // Crystal storage
        ref<uint16>(0xE8) = Sql_GetUIntData(SqlHandle, 85); // Fire Crystals
        ref<uint16>(0xEA) = Sql_GetUIntData(SqlHandle, 86); // Ice Crystals
        ref<uint16>(0xEC) = Sql_GetUIntData(SqlHandle, 87); // Wind Crystals
        ref<uint16>(0xEE) = Sql_GetUIntData(SqlHandle, 88); // Earth Crystals
        ref<uint16>(0xF0) = Sql_GetUIntData(SqlHandle, 89); // Lightning Crystals
        ref<uint16>(0xF2) = Sql_GetUIntData(SqlHandle, 90); // Water Crystals
        ref<uint16>(0xF4) = Sql_GetUIntData(SqlHandle, 91); // Light Crystals
        ref<uint16>(0xF6) = Sql_GetUIntData(SqlHandle, 92); // Dark Crystals

        ref<uint16>(0xF8) = Sql_GetUIntData(SqlHandle, 93); // deeds
    }
}
