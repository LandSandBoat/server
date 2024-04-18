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

    int ret = _sql->Query(query, PChar->id);
    if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = _sql->GetIntData(0); // sandoria_cp
        ref<uint32>(0x08) = _sql->GetIntData(1); // bastok_cp
        ref<uint32>(0x0C) = _sql->GetIntData(2); // windurst_cp

        ref<uint16>(0x10) = _sql->GetUIntData(3);  // beastman_seal
        ref<uint16>(0x12) = _sql->GetUIntData(4);  // kindred_seal
        ref<uint16>(0x14) = _sql->GetUIntData(5);  // kindred_crest
        ref<uint16>(0x16) = _sql->GetUIntData(6);  // high_kindred_crest
        ref<uint16>(0x18) = _sql->GetUIntData(7);  // sacred_kindred_crest
        ref<uint16>(0x1A) = _sql->GetUIntData(8);  // ancient_beastcoin
        ref<uint16>(0x1C) = _sql->GetUIntData(9);  // valor_point
        ref<uint16>(0x1E) = _sql->GetUIntData(10); // scyld

        ref<uint32>(0x20) = _sql->GetIntData(11); // guild_fishing
        ref<uint32>(0x24) = _sql->GetIntData(12); // guild_woodworking
        ref<uint32>(0x28) = _sql->GetIntData(13); // guild_smithing
        ref<uint32>(0x2C) = _sql->GetIntData(14); // guild_goldsmithing
        ref<uint32>(0x30) = _sql->GetIntData(15); // guild_weaving
        ref<uint32>(0x34) = _sql->GetIntData(16); // guild_leathercraft
        ref<uint32>(0x38) = _sql->GetIntData(17); // guild_bonecraft
        ref<uint32>(0x3C) = _sql->GetIntData(18); // guild_alchemy
        ref<uint32>(0x40) = _sql->GetIntData(19); // guild_cooking

        ref<uint32>(0x44) = _sql->GetIntData(20);  // cinder
        ref<uint8>(0x48)  = _sql->GetUIntData(21); // fire_fewell
        ref<uint8>(0x49)  = _sql->GetUIntData(22); // ice_fewell
        ref<uint8>(0x4A)  = _sql->GetUIntData(23); // wind_fewell
        ref<uint8>(0x4B)  = _sql->GetUIntData(24); // earth_fewell
        ref<uint8>(0x4C)  = _sql->GetUIntData(25); // lightning_fewell
        ref<uint8>(0x4D)  = _sql->GetUIntData(26); // water_fewell
        ref<uint8>(0x4E)  = _sql->GetUIntData(27); // light_fewell
        ref<uint8>(0x4F)  = _sql->GetUIntData(28); // dark_fewell

        ref<uint32>(0x50) = _sql->GetIntData(29);  // ballista_point
        ref<uint32>(0x54) = _sql->GetIntData(30);  // fellow_point
        ref<uint16>(0x58) = _sql->GetUIntData(31); // chocobuck_sandoria
        ref<uint16>(0x5A) = _sql->GetUIntData(32); // chocobuck_bastok
        ref<uint16>(0x5C) = _sql->GetUIntData(33); // chocobuck_windurst

        ref<uint16>(0x5E) = _sql->GetIntData(34) == -1 ? 0 : _sql->GetIntData(34); // daily_tally

        ref<uint32>(0x60) = _sql->GetIntData(35);  // research_mark
        ref<uint8>(0x64)  = _sql->GetUIntData(36); // tunnel_worm
        ref<uint8>(0x65)  = _sql->GetUIntData(37); // morion_worm
        ref<uint8>(0x66)  = _sql->GetUIntData(38); // phantom_worm
        ref<uint32>(0x68) = _sql->GetIntData(39);  // moblin_marble

        ref<uint16>(0x6C) = _sql->GetUIntData(40); // infamy
        ref<uint16>(0x6E) = _sql->GetUIntData(41); // prestige
        ref<uint32>(0x70) = _sql->GetIntData(42);  // legion_point
        ref<uint32>(0x74) = _sql->GetIntData(43);  // spark_of_eminence
        ref<uint32>(0x78) = _sql->GetIntData(44);  // shining_star

        ref<uint32>(0x7C) = _sql->GetIntData(45); // imperial_standing
        ref<uint32>(0x80) = _sql->GetIntData(46); // leujaoam_assault_point
        ref<uint32>(0x84) = _sql->GetIntData(47); // mamool_assault_point
        ref<uint32>(0x88) = _sql->GetIntData(48); // lebros_assault_point
        ref<uint32>(0x8C) = _sql->GetIntData(49); // periqia_assault_point
        ref<uint32>(0x90) = _sql->GetIntData(50); // ilrusi_assault_point
        ref<uint32>(0x94) = _sql->GetIntData(51); // nyzul_isle_assault_point
        ref<uint32>(0x98) = _sql->GetIntData(52); // zeni_point
        ref<uint32>(0x9C) = _sql->GetIntData(53); // jetton
        ref<uint32>(0xA0) = _sql->GetIntData(54); // therion_ichor

        ref<uint32>(0xA4) = _sql->GetIntData(55); // allied_notes

        ref<uint16>(0xA8) = _sql->GetUIntData(56); // aman_vouchers
        ref<uint16>(0xAA) = _sql->GetUIntData(57); // login_points

        ref<uint32>(0xAC) = _sql->GetIntData(58);  // cruor
        ref<uint32>(0xB0) = _sql->GetIntData(59);  // resistance_credit
        ref<uint32>(0xB4) = _sql->GetIntData(60);  // dominion_note
        ref<uint8>(0xB8)  = _sql->GetUIntData(61); // fifth_echelon_trophy
        ref<uint8>(0xB9)  = _sql->GetUIntData(62); // fourth_echelon_trophy
        ref<uint8>(0xBA)  = _sql->GetUIntData(63); // third_echelon_trophy
        ref<uint8>(0xBB)  = _sql->GetUIntData(64); // second_echelon_trophy
        ref<uint8>(0xBC)  = _sql->GetUIntData(65); // first_echelon_trophy

        ref<uint8>(0xBD) = _sql->GetUIntData(66); // cave_points

        ref<uint8>(0xBE) = _sql->GetUIntData(67); // id_tags

        ref<uint8>(0xBF) = _sql->GetUIntData(68); // op_credits

        ref<uint32>(0xC4) = _sql->GetIntData(69); // voidstones
        ref<uint32>(0xC8) = _sql->GetIntData(70); // kupofried_corundums

        ref<uint8>(0xCC) = _sql->GetUIntData(71); // pheromone_sacks

        ref<uint8>(0xCE) = _sql->GetUIntData(72); // rems_ch1
        ref<uint8>(0xCF) = _sql->GetUIntData(73); // rems_ch2
        ref<uint8>(0xD0) = _sql->GetUIntData(74); // rems_ch3
        ref<uint8>(0xD1) = _sql->GetUIntData(75); // rems_ch4
        ref<uint8>(0xD2) = _sql->GetUIntData(76); // rems_ch5
        ref<uint8>(0xD3) = _sql->GetUIntData(77); // rems_ch6
        ref<uint8>(0xD4) = _sql->GetUIntData(78); // rems_ch7
        ref<uint8>(0xD5) = _sql->GetUIntData(79); // rems_ch8
        ref<uint8>(0xD6) = _sql->GetUIntData(80); // rems_ch9
        ref<uint8>(0xD7) = _sql->GetUIntData(81); // rems_ch10

        ref<uint16>(0xE0) = _sql->GetUIntData(82); // reclamation_marks
        ref<uint32>(0xE4) = _sql->GetIntData(83);  // unity_accolades

        // Crystal storage
        ref<uint16>(0xE8) = _sql->GetUIntData(84); // Fire Crystals
        ref<uint16>(0xEA) = _sql->GetUIntData(85); // Ice Crystals
        ref<uint16>(0xEC) = _sql->GetUIntData(86); // Wind Crystals
        ref<uint16>(0xEE) = _sql->GetUIntData(87); // Earth Crystals
        ref<uint16>(0xF0) = _sql->GetUIntData(88); // Lightning Crystals
        ref<uint16>(0xF2) = _sql->GetUIntData(89); // Water Crystals
        ref<uint16>(0xF4) = _sql->GetUIntData(90); // Light Crystals
        ref<uint16>(0xF6) = _sql->GetUIntData(91); // Dark Crystals

        ref<uint16>(0xF8) = _sql->GetUIntData(92); // deeds
    }

    ref<uint32>(0xC0) = charutils::getAvailableTraverserStones(PChar); // traverser_stones
}
