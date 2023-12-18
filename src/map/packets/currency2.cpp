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

#include "currency2.h"

#include "entities/charentity.h"

CCurrencyPacket2::CCurrencyPacket2(CCharEntity* PChar)
{
    this->setType(0x118);
    this->setSize(132);

    const char* query = "SELECT bayld, kinetic_unit, imprimaturs, mystical_canteen, obsidian_fragment, lebondopt_wing, \
                         pulchridopt_wing, mweya_plasm, ghastly_stone, ghastly_stone_1, ghastly_stone_2, verdigris_stone, \
                         verdigris_stone_1, verdigris_stone_2, wailing_stone, wailing_stone_1, wailing_stone_2, \
                         snowslit_stone, snowslit_stone_1, snowslit_stone_2, snowtip_stone, snowtip_stone_1, snowtip_stone_2, \
                         snowdim_stone, snowdim_stone_1, snowdim_stone_2, snoworb_stone, snoworb_stone_1, snoworb_stone_2, \
                         leafslit_stone, leafslit_stone_1, leafslit_stone_2, leaftip_stone, leaftip_stone_1, leaftip_stone_2, \
                         leafdim_stone, leafdim_stone_1, leafdim_stone_2, leaforb_stone, leaforb_stone_1, leaforb_stone_2, \
                         duskslit_stone, duskslit_stone_1, duskslit_stone_2, dusktip_stone, dusktip_stone_1, dusktip_stone_2, \
                         duskdim_stone, duskdim_stone_1, duskdim_stone_2, duskorb_stone, duskorb_stone_1, duskorb_stone_2, \
                         pellucid_stone, fern_stone, taupe_stone, escha_beads, escha_silt, potpourri, current_hallmarks, \
                         total_hallmarks, gallantry, crafter_points, fire_crystal_set, ice_crystal_set, wind_crystal_set, \
                         earth_crystal_set, lightning_crystal_set, water_crystal_set, light_crystal_set, dark_crystal_set, \
                         mc_s_sr01_set, mc_s_sr02_set, mc_s_sr03_set, liquefaction_spheres_set, induration_spheres_set, \
                         detonation_spheres_set, scission_spheres_set, impaction_spheres_set, reverberation_spheres_set, \
                         transfixion_spheres_set, compression_spheres_set, fusion_spheres_set, distortion_spheres_set, \
                         fragmentation_spheres_set, gravitation_spheres_set, light_spheres_set, darkness_spheres_set, \
                         silver_aman_voucher \
                         FROM char_points WHERE charid = % d ";

    int ret = _sql->Query(query, PChar->id);
    if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = _sql->GetUIntData(0); // bayld
        ref<uint16>(0x08) = _sql->GetUIntData(1); // kinetic_unit
        ref<uint8>(0x0A)  = _sql->GetUIntData(2); // imprimaturs
        ref<uint8>(0x0B)  = _sql->GetUIntData(3); // mystical_canteen
        ref<uint32>(0x0C) = _sql->GetUIntData(4); // obsidian_fragment
        ref<uint16>(0x10) = _sql->GetUIntData(5); // lebondopt_wing
        ref<uint16>(0x12) = _sql->GetUIntData(6); // pulchridopt_wing
        ref<uint32>(0x14) = _sql->GetUIntData(7); // mewya_plasm

        ref<uint8>(0x18) = _sql->GetUIntData(8);  // ghastly_stone
        ref<uint8>(0x19) = _sql->GetUIntData(9);  // ghastly_stone_1
        ref<uint8>(0x1A) = _sql->GetUIntData(10); // ghastly_stone_2
        ref<uint8>(0x1B) = _sql->GetUIntData(11); // verdigris_stone
        ref<uint8>(0x1C) = _sql->GetUIntData(12); // verdigris_stone_1
        ref<uint8>(0x1D) = _sql->GetUIntData(13); // verdigris_stone_2
        ref<uint8>(0x1E) = _sql->GetUIntData(14); // wailing_stone
        ref<uint8>(0x1F) = _sql->GetUIntData(15); // wailing_stone_1
        ref<uint8>(0x20) = _sql->GetUIntData(16); // wailing_stone_2

        ref<uint8>(0x21) = _sql->GetUIntData(17); // snowslit_stone
        ref<uint8>(0x22) = _sql->GetUIntData(18); // snowslit_stone_1
        ref<uint8>(0x23) = _sql->GetUIntData(19); // snowslit_stone_2
        ref<uint8>(0x24) = _sql->GetUIntData(20); // snowtip_stone
        ref<uint8>(0x25) = _sql->GetUIntData(21); // snowtip_stone_1
        ref<uint8>(0x26) = _sql->GetUIntData(22); // snowtip_stone_2
        ref<uint8>(0x27) = _sql->GetUIntData(23); // snowdim_stone
        ref<uint8>(0x28) = _sql->GetUIntData(24); // snowdim_stone_1
        ref<uint8>(0x29) = _sql->GetUIntData(25); // snowdim_stone_2
        ref<uint8>(0x2A) = _sql->GetUIntData(26); // snoworb_stone
        ref<uint8>(0x2B) = _sql->GetUIntData(27); // snoworb_stone_1
        ref<uint8>(0x2C) = _sql->GetUIntData(28); // snoworb_stone_2
        ref<uint8>(0x2D) = _sql->GetUIntData(29); // leafslit_stone
        ref<uint8>(0x2E) = _sql->GetUIntData(30); // leafslit_stone_1
        ref<uint8>(0x2F) = _sql->GetUIntData(31); // leafslit_stone_2
        ref<uint8>(0x30) = _sql->GetUIntData(32); // leaftip_stone
        ref<uint8>(0x31) = _sql->GetUIntData(33); // leaftip_stone_1
        ref<uint8>(0x32) = _sql->GetUIntData(34); // leaftip_stone_2
        ref<uint8>(0x33) = _sql->GetUIntData(35); // leafdim_stone
        ref<uint8>(0x34) = _sql->GetUIntData(36); // leafdim_stone_1
        ref<uint8>(0x35) = _sql->GetUIntData(37); // leafdim_stone_2
        ref<uint8>(0x36) = _sql->GetUIntData(38); // leaforb_stone
        ref<uint8>(0x37) = _sql->GetUIntData(39); // leaforb_stone_1
        ref<uint8>(0x38) = _sql->GetUIntData(40); // leaforb_stone_2
        ref<uint8>(0x39) = _sql->GetUIntData(41); // duskslit_stone
        ref<uint8>(0x3A) = _sql->GetUIntData(42); // duskslit_stone_1
        ref<uint8>(0x3B) = _sql->GetUIntData(43); // duskslit_stone_2
        ref<uint8>(0x3C) = _sql->GetUIntData(44); // dusktip_stone
        ref<uint8>(0x3D) = _sql->GetUIntData(45); // dusktip_stone_1
        ref<uint8>(0x3E) = _sql->GetUIntData(46); // dusktip_stone_2
        ref<uint8>(0x3F) = _sql->GetUIntData(47); // duskdim_stone
        ref<uint8>(0x40) = _sql->GetUIntData(48); // duskdim_stone_1
        ref<uint8>(0x41) = _sql->GetUIntData(49); // duskdim_stone_2
        ref<uint8>(0x42) = _sql->GetUIntData(50); // duskorb_stone
        ref<uint8>(0x43) = _sql->GetUIntData(51); // duskorb_stone_1
        ref<uint8>(0x44) = _sql->GetUIntData(52); // duskorb_stone_2

        ref<uint8>(0x45) = _sql->GetUIntData(53); // pellucid_stone
        ref<uint8>(0x46) = _sql->GetUIntData(54); // fern_stone
        ref<uint8>(0x47) = _sql->GetUIntData(55); // taupe_stone

        ref<uint16>(0x4A) = _sql->GetUIntData(56); // escha_beads
        ref<uint32>(0x4C) = _sql->GetUIntData(57); // escha_silt

        ref<uint32>(0x50) = _sql->GetUIntData(58); // potpourri

        ref<uint32>(0x54) = _sql->GetUIntData(59); // current_hallmarks
        ref<uint32>(0x58) = _sql->GetUIntData(60); // total_hallmarks
        ref<uint32>(0x5C) = _sql->GetUIntData(61); // gallantry

        ref<uint32>(0x60) = _sql->GetUIntData(62); // crafter_points

        ref<uint8>(0x64) = _sql->GetUIntData(63); // fire_crystal_set
        ref<uint8>(0x65) = _sql->GetUIntData(64); // ice_crystal_set
        ref<uint8>(0x66) = _sql->GetUIntData(65); // wind_crystal_set
        ref<uint8>(0x67) = _sql->GetUIntData(66); // earth_crystal_set
        ref<uint8>(0x68) = _sql->GetUIntData(67); // lightning_crystal_set
        ref<uint8>(0x69) = _sql->GetUIntData(68); // water_crystal_set
        ref<uint8>(0x6A) = _sql->GetUIntData(69); // light_crystal_set
        ref<uint8>(0x6B) = _sql->GetUIntData(70); // dark_crystal_set
        ref<uint8>(0x6C) = _sql->GetUIntData(71); // mc_s_sr01_set
        ref<uint8>(0x6D) = _sql->GetUIntData(72); // mc_s_sr02_set
        ref<uint8>(0x6E) = _sql->GetUIntData(73); // mc_s_sr03_set
        ref<uint8>(0x6F) = _sql->GetUIntData(74); // liquefaction_spheres_set
        ref<uint8>(0x70) = _sql->GetUIntData(75); // induration_spheres_set
        ref<uint8>(0x71) = _sql->GetUIntData(76); // detonation_spheres_set
        ref<uint8>(0x72) = _sql->GetUIntData(77); // scission_spheres_set
        ref<uint8>(0x73) = _sql->GetUIntData(78); // impaction_spheres_set
        ref<uint8>(0x74) = _sql->GetUIntData(79); // reverberation_spheres_set
        ref<uint8>(0x75) = _sql->GetUIntData(80); // transfixion_spheres_set
        ref<uint8>(0x76) = _sql->GetUIntData(81); // compression_spheres_set
        ref<uint8>(0x77) = _sql->GetUIntData(82); // fusion_spheres_set
        ref<uint8>(0x78) = _sql->GetUIntData(83); // distortion_spheres_set
        ref<uint8>(0x79) = _sql->GetUIntData(84); // fragmentation_spheres_set
        ref<uint8>(0x7A) = _sql->GetUIntData(85); // gravitation_spheres_set
        ref<uint8>(0x7B) = _sql->GetUIntData(86); // light_spheres_set
        ref<uint8>(0x7C) = _sql->GetUIntData(87); // darkness_spheres_set

        ref<uint32>(0x80) = _sql->GetUIntData(88); // silver_aman_voucher
    }
}
