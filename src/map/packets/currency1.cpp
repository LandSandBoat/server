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

#include "common/socket.h"

#include "currency1.h"

#include "entities/charentity.h"
#include "utils/charutils.h"

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
                        reclamation_marks, unity_accolades, fire_crystals, ice_crystals, wind_crystals, \
                        earth_crystals, lightning_crystals, water_crystals, light_crystals, dark_crystals, deeds \
                        FROM char_points WHERE charid = %d";

    int ret = sql->Query(query, PChar->id);
    if (ret != SQL_ERROR && sql->NextRow() == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = sql->GetIntData(0); // sandoria_cp
        ref<uint32>(0x08) = sql->GetIntData(1); // bastok_cp
        ref<uint32>(0x0C) = sql->GetIntData(2); // windurst_cp

        ref<uint16>(0x10) = sql->GetUIntData(3);  // beastman_seal
        ref<uint16>(0x12) = sql->GetUIntData(4);  // kindred_seal
        ref<uint16>(0x14) = sql->GetUIntData(5);  // kindred_crest
        ref<uint16>(0x16) = sql->GetUIntData(6);  // high_kindred_crest
        ref<uint16>(0x18) = sql->GetUIntData(7);  // sacred_kindred_crest
        ref<uint16>(0x1A) = sql->GetUIntData(8);  // ancient_beastcoin
        ref<uint16>(0x1C) = sql->GetUIntData(9);  // valor_point
        ref<uint16>(0x1E) = sql->GetUIntData(10); // scyld

        ref<uint32>(0x20) = sql->GetIntData(11); // guild_fishing
        ref<uint32>(0x24) = sql->GetIntData(12); // guild_woodworking
        ref<uint32>(0x28) = sql->GetIntData(13); // guild_smithing
        ref<uint32>(0x2C) = sql->GetIntData(14); // guild_goldsmithing
        ref<uint32>(0x30) = sql->GetIntData(15); // guild_weaving
        ref<uint32>(0x34) = sql->GetIntData(16); // guild_leathercraft
        ref<uint32>(0x38) = sql->GetIntData(17); // guild_bonecraft
        ref<uint32>(0x3C) = sql->GetIntData(18); // guild_alchemy
        ref<uint32>(0x40) = sql->GetIntData(19); // guild_cooking

        ref<uint32>(0x44) = sql->GetIntData(20);  // cinder
        ref<uint8>(0x48)  = sql->GetUIntData(21); // fire_fewell
        ref<uint8>(0x49)  = sql->GetUIntData(22); // ice_fewell
        ref<uint8>(0x4A)  = sql->GetUIntData(23); // wind_fewell
        ref<uint8>(0x4B)  = sql->GetUIntData(24); // earth_fewell
        ref<uint8>(0x4C)  = sql->GetUIntData(25); // lightning_fewell
        ref<uint8>(0x4D)  = sql->GetUIntData(26); // water_fewell
        ref<uint8>(0x4E)  = sql->GetUIntData(27); // light_fewell
        ref<uint8>(0x4F)  = sql->GetUIntData(28); // dark_fewell

        ref<uint32>(0x50) = sql->GetIntData(29);  // ballista_point
        ref<uint32>(0x54) = sql->GetIntData(30);  // fellow_point
        ref<uint16>(0x58) = sql->GetUIntData(31); // chocobuck_sandoria
        ref<uint16>(0x5A) = sql->GetUIntData(32); // chocobuck_bastok
        ref<uint16>(0x5C) = sql->GetUIntData(33); // chocobuck_windurst

        ref<uint16>(0x5E) = sql->GetIntData(34) == -1 ? 0 : sql->GetIntData(34); // daily_tally

        ref<uint32>(0x60) = sql->GetIntData(35);  // research_mark
        ref<uint8>(0x64)  = sql->GetUIntData(36); // tunnel_worm
        ref<uint8>(0x65)  = sql->GetUIntData(37); // morion_worm
        ref<uint8>(0x66)  = sql->GetUIntData(38); // phantom_worm
        ref<uint32>(0x68) = sql->GetIntData(39);  // moblin_marble

        ref<uint16>(0x6C) = sql->GetUIntData(40); // infamy
        ref<uint16>(0x6E) = sql->GetUIntData(41); // prestige
        ref<uint32>(0x70) = sql->GetIntData(42);  // legion_point
        ref<uint32>(0x74) = sql->GetIntData(43);  // spark_of_eminence
        ref<uint32>(0x78) = sql->GetIntData(44);  // shining_star

        ref<uint32>(0x7C) = sql->GetIntData(45); // imperial_standing
        ref<uint32>(0x80) = sql->GetIntData(46); // leujaoam_assault_point
        ref<uint32>(0x84) = sql->GetIntData(47); // mamool_assault_point
        ref<uint32>(0x88) = sql->GetIntData(48); // lebros_assault_point
        ref<uint32>(0x8C) = sql->GetIntData(49); // periqia_assault_point
        ref<uint32>(0x90) = sql->GetIntData(50); // ilrusi_assault_point
        ref<uint32>(0x94) = sql->GetIntData(51); // nyzul_isle_assault_point
        ref<uint32>(0x98) = sql->GetIntData(52); // zeni_point
        ref<uint32>(0x9C) = sql->GetIntData(53); // jetton
        ref<uint32>(0xA0) = sql->GetIntData(54); // therion_ichor

        ref<uint32>(0xA4) = sql->GetIntData(55); // allied_notes

        ref<uint16>(0xA8) = sql->GetUIntData(56); // aman_vouchers
        ref<uint16>(0xAA) = sql->GetUIntData(57); // login_points

        ref<uint32>(0xAC) = sql->GetIntData(58);  // cruor
        ref<uint32>(0xB0) = sql->GetIntData(59);  // resistance_credit
        ref<uint32>(0xB4) = sql->GetIntData(60);  // dominion_note
        ref<uint8>(0xB8)  = sql->GetUIntData(61); // fifth_echelon_trophy
        ref<uint8>(0xB9)  = sql->GetUIntData(62); // fourth_echelon_trophy
        ref<uint8>(0xBA)  = sql->GetUIntData(63); // third_echelon_trophy
        ref<uint8>(0xBB)  = sql->GetUIntData(64); // second_echelon_trophy
        ref<uint8>(0xBC)  = sql->GetUIntData(65); // first_echelon_trophy

        ref<uint8>(0xBD) = sql->GetUIntData(66); // cave_points

        ref<uint8>(0xBE) = sql->GetUIntData(67); // id_tags

        ref<uint8>(0xBF) = sql->GetUIntData(68); // op_credits

        ref<uint32>(0xC4) = sql->GetIntData(69); // voidstones
        ref<uint32>(0xC8) = sql->GetIntData(70); // kupofried_corundums

        ref<uint8>(0xCC) = sql->GetUIntData(71); // pheromone_sacks

        ref<uint8>(0xCE) = sql->GetUIntData(72); // rems_ch1
        ref<uint8>(0xCF) = sql->GetUIntData(73); // rems_ch2
        ref<uint8>(0xD0) = sql->GetUIntData(74); // rems_ch3
        ref<uint8>(0xD1) = sql->GetUIntData(75); // rems_ch4
        ref<uint8>(0xD2) = sql->GetUIntData(76); // rems_ch5
        ref<uint8>(0xD3) = sql->GetUIntData(77); // rems_ch6
        ref<uint8>(0xD4) = sql->GetUIntData(78); // rems_ch7
        ref<uint8>(0xD5) = sql->GetUIntData(79); // rems_ch8
        ref<uint8>(0xD6) = sql->GetUIntData(80); // rems_ch9
        ref<uint8>(0xD7) = sql->GetUIntData(81); // rems_ch10

        ref<uint16>(0xE0) = sql->GetUIntData(82); // reclamation_marks
        ref<uint32>(0xE4) = sql->GetIntData(83);  // unity_accolades

        // Crystal storage
        ref<uint16>(0xE8) = sql->GetUIntData(84); // Fire Crystals
        ref<uint16>(0xEA) = sql->GetUIntData(85); // Ice Crystals
        ref<uint16>(0xEC) = sql->GetUIntData(86); // Wind Crystals
        ref<uint16>(0xEE) = sql->GetUIntData(87); // Earth Crystals
        ref<uint16>(0xF0) = sql->GetUIntData(88); // Lightning Crystals
        ref<uint16>(0xF2) = sql->GetUIntData(89); // Water Crystals
        ref<uint16>(0xF4) = sql->GetUIntData(90); // Light Crystals
        ref<uint16>(0xF6) = sql->GetUIntData(91); // Dark Crystals

        ref<uint16>(0xF8) = sql->GetUIntData(92); // deeds
    }

    ref<uint32>(0xC0) = charutils::getAvailableTraverserStones(PChar); // traverser_stones
}
