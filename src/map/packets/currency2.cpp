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

#include "currency2.h"

#include "../entities/charentity.h"

CCurrencyPacket2::CCurrencyPacket2(CCharEntity* PChar)
{
	this->type = 0x18;
	this->size = 0x25;

    const char* query = "SELECT bayld, kinetic_unit, imprimaturs, obsidian_fragment, lebondopt_wing, \
                         pulchridopt_wing, mweya_plasm FROM char_points WHERE charid = %d";

    int ret = Sql_Query(SqlHandle, query, PChar->id);
    if (ret != SQL_ERROR && Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        ref<uint32>(0x04) = Sql_GetIntData(SqlHandle, 0);  // bayld
        ref<uint16>(0x08) = Sql_GetUIntData(SqlHandle, 1); // kinetic_unit
        ref<uint8>(0x0A)  = Sql_GetUIntData(SqlHandle, 2); // imprimaturs
        ref<uint8>(0x0B)  = 0;                             // mystical_canteen
        ref<uint32>(0x0C) = Sql_GetIntData(SqlHandle, 3);  // obsidian_fragment
        ref<uint16>(0x10) = Sql_GetUIntData(SqlHandle, 4); // lebondopt_wing
        ref<uint16>(0x12) = Sql_GetUIntData(SqlHandle, 5); // pulchridopt_wing
        ref<uint32>(0x14) = Sql_GetIntData(SqlHandle, 6);  // mewya_plasm

        ref<uint8>(0x18) = 0; // ghastly_stone
        ref<uint8>(0x19) = 0; // ghastly_stone_1
        ref<uint8>(0x1A) = 0; // ghastly_stone_2
        ref<uint8>(0x1B) = 0; // verdigris_stone
        ref<uint8>(0x1C) = 0; // verdigris_stone_1
        ref<uint8>(0x1D) = 0; // verdigris_stone_2
        ref<uint8>(0x1E) = 0; // wailing_stone
        ref<uint8>(0x1F) = 0; // wailing_stone_1
        ref<uint8>(0x20) = 0; // wailing_stone_2

        ref<uint8>(0x21) = 0; // snowslit_stone
        ref<uint8>(0x22) = 0; // snowslit_stone_1
        ref<uint8>(0x23) = 0; // snowslit_stone_2
        ref<uint8>(0x24) = 0; // snowtip_stone
        ref<uint8>(0x25) = 0; // snowtip_stone_1
        ref<uint8>(0x26) = 0; // snowtip_stone_2
        ref<uint8>(0x27) = 0; // snowdim_stone
        ref<uint8>(0x28) = 0; // snowdim_stone_1
        ref<uint8>(0x29) = 0; // snowdim_stone_2
        ref<uint8>(0x2A) = 0; // snoworb_stone
        ref<uint8>(0x2B) = 0; // snoworb_stone_1
        ref<uint8>(0x2C) = 0; // snoworb_stone_2
        ref<uint8>(0x2D) = 0; // leafslit_stone
        ref<uint8>(0x2E) = 0; // leafslit_stone_1
        ref<uint8>(0x2F) = 0; // leafslit_stone_2
        ref<uint8>(0x30) = 0; // leaftip_stone
        ref<uint8>(0x31) = 0; // leaftip_stone_1
        ref<uint8>(0x32) = 0; // leaftip_stone_2
        ref<uint8>(0x33) = 0; // leafdim_stone
        ref<uint8>(0x34) = 0; // leafdim_stone_1
        ref<uint8>(0x35) = 0; // leafdim_stone_2
        ref<uint8>(0x36) = 0; // leaforb_stone
        ref<uint8>(0x37) = 0; // leaforb_stone_1
        ref<uint8>(0x38) = 0; // leaforb_stone_2
        ref<uint8>(0x39) = 0; // duskslit_stone
        ref<uint8>(0x3A) = 0; // duskslit_stone_1
        ref<uint8>(0x3B) = 0; // duskslit_stone_2
        ref<uint8>(0x3C) = 0; // dusktip_stone
        ref<uint8>(0x3D) = 0; // dusktip_stone_1
        ref<uint8>(0x3E) = 0; // dusktip_stone_2
        ref<uint8>(0x3F) = 0; // duskdim_stone
        ref<uint8>(0x40) = 0; // duskdim_stone_1
        ref<uint8>(0x41) = 0; // duskdim_stone_2
        ref<uint8>(0x42) = 0; // duskorb_stone
        ref<uint8>(0x43) = 0; // duskorb_stone_1
        ref<uint8>(0x44) = 0; // duskorb_stone_2

        ref<uint8>(0x45) = 0; // pellucid_stone
        ref<uint8>(0x46) = 0; // fern_stone
        ref<uint8>(0x47) = 0; // taupe_stone

        ref<uint16>(0x4A) = 0; // escha_beads
        ref<uint32>(0x4C) = 0; // escha_silt

        ref<uint32>(0x50) = 0; // potpourri

        ref<uint32>(0x54) = 0; // current_hallmarks
        ref<uint32>(0x58) = 0; // total_hallmarks
        ref<uint32>(0x5C) = 0; // gallantry

        ref<uint32>(0x60) = 0; // crafter_points

        ref<uint8>(0x64) = 0; // fire_crystal_set
        ref<uint8>(0x65) = 0; // ice_crystal_set
        ref<uint8>(0x66) = 0; // wind_crystal_set
        ref<uint8>(0x67) = 0; // earth_crystal_set
        ref<uint8>(0x68) = 0; // lightning_crystal_set
        ref<uint8>(0x69) = 0; // water_crystal_set
        ref<uint8>(0x6A) = 0; // light_crystal_set
        ref<uint8>(0x6B) = 0; // dark_crystal_set
        ref<uint8>(0x6C) = 0; // mc_s_sr01_set
        ref<uint8>(0x6D) = 0; // mc_s_sr02_set
        ref<uint8>(0x6E) = 0; // mc_s_sr03_set
        ref<uint8>(0x6F) = 0; // liquefaction_spheres_set
        ref<uint8>(0x70) = 0; // induration_spheres_set
        ref<uint8>(0x71) = 0; // detonation_spheres_set
        ref<uint8>(0x72) = 0; // scission_spheres_set
        ref<uint8>(0x73) = 0; // impaction_spheres_set
        ref<uint8>(0x74) = 0; // reverberation_spheres_set
        ref<uint8>(0x75) = 0; // transfixion_spheres_set
        ref<uint8>(0x76) = 0; // compression_spheres_set
        ref<uint8>(0x77) = 0; // fusion_spheres_set
        ref<uint8>(0x78) = 0; // distortion_spheres_set
        ref<uint8>(0x79) = 0; // fragmentation_spheres_set
        ref<uint8>(0x7A) = 0; // gravitation_spheres_set
        ref<uint8>(0x7B) = 0; // light_spheres_set
        ref<uint8>(0x7C) = 0; // darkness_spheres_set

        ref<uint32>(0x80) = 0; // silver_aman_voucher
    }
}
