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
#include "currency2.h"

#include "common/cbasetypes.h"
#include "common/database.h"
#include "entities/charentity.h"

CCurrencyPacket2::CCurrencyPacket2(CCharEntity* PChar)
{
    this->setType(0x118);
    this->setSize(150);

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
                         silver_aman_voucher, domain_points, domain_points_daily, mog_segments, gallimaufry, is_accolades \
                         FROM char_points WHERE charid = ?";

    const auto rset = db::preparedStmt(query, PChar->id);
    if (rset && rset->rowsCount() && rset->next())
    {
        ref<uint32>(0x04) = rset->get<uint32>("bayld");
        ref<uint16>(0x08) = rset->get<uint16>("kinetic_unit");
        ref<uint8>(0x0A)  = rset->get<uint8>("imprimaturs");
        ref<uint8>(0x0B)  = rset->get<uint8>("mystical_canteen");
        ref<uint32>(0x0C) = rset->get<uint32>("obsidian_fragment");
        ref<uint16>(0x10) = rset->get<uint16>("lebondopt_wing");
        ref<uint16>(0x12) = rset->get<uint16>("pulchridopt_wing");
        ref<uint32>(0x14) = rset->get<uint32>("mweya_plasm");

        ref<uint8>(0x18) = rset->get<uint8>("ghastly_stone");
        ref<uint8>(0x19) = rset->get<uint8>("ghastly_stone_1");
        ref<uint8>(0x1A) = rset->get<uint8>("ghastly_stone_2");
        ref<uint8>(0x1B) = rset->get<uint8>("verdigris_stone");
        ref<uint8>(0x1C) = rset->get<uint8>("verdigris_stone_1");
        ref<uint8>(0x1D) = rset->get<uint8>("verdigris_stone_2");
        ref<uint8>(0x1E) = rset->get<uint8>("wailing_stone");
        ref<uint8>(0x1F) = rset->get<uint8>("wailing_stone_1");
        ref<uint8>(0x20) = rset->get<uint8>("wailing_stone_2");

        ref<uint8>(0x21) = rset->get<uint8>("snowslit_stone");
        ref<uint8>(0x22) = rset->get<uint8>("snowslit_stone_1");
        ref<uint8>(0x23) = rset->get<uint8>("snowslit_stone_2");
        ref<uint8>(0x24) = rset->get<uint8>("snowtip_stone");
        ref<uint8>(0x25) = rset->get<uint8>("snowtip_stone_1");
        ref<uint8>(0x26) = rset->get<uint8>("snowtip_stone_2");
        ref<uint8>(0x27) = rset->get<uint8>("snowdim_stone");
        ref<uint8>(0x28) = rset->get<uint8>("snowdim_stone_1");
        ref<uint8>(0x29) = rset->get<uint8>("snowdim_stone_2");
        ref<uint8>(0x2A) = rset->get<uint8>("snoworb_stone");
        ref<uint8>(0x2B) = rset->get<uint8>("snoworb_stone_1");
        ref<uint8>(0x2C) = rset->get<uint8>("snoworb_stone_2");
        ref<uint8>(0x2D) = rset->get<uint8>("leafslit_stone");
        ref<uint8>(0x2E) = rset->get<uint8>("leafslit_stone_1");
        ref<uint8>(0x2F) = rset->get<uint8>("leafslit_stone_2");
        ref<uint8>(0x30) = rset->get<uint8>("leaftip_stone");
        ref<uint8>(0x31) = rset->get<uint8>("leaftip_stone_1");
        ref<uint8>(0x32) = rset->get<uint8>("leaftip_stone_2");
        ref<uint8>(0x33) = rset->get<uint8>("leafdim_stone");
        ref<uint8>(0x34) = rset->get<uint8>("leafdim_stone_1");
        ref<uint8>(0x35) = rset->get<uint8>("leafdim_stone_2");
        ref<uint8>(0x36) = rset->get<uint8>("leaforb_stone");
        ref<uint8>(0x37) = rset->get<uint8>("leaforb_stone_1");
        ref<uint8>(0x38) = rset->get<uint8>("leaforb_stone_2");
        ref<uint8>(0x39) = rset->get<uint8>("duskslit_stone");
        ref<uint8>(0x3A) = rset->get<uint8>("duskslit_stone_1");
        ref<uint8>(0x3B) = rset->get<uint8>("duskslit_stone_2");
        ref<uint8>(0x3C) = rset->get<uint8>("dusktip_stone");
        ref<uint8>(0x3D) = rset->get<uint8>("dusktip_stone_1");
        ref<uint8>(0x3E) = rset->get<uint8>("dusktip_stone_2");
        ref<uint8>(0x3F) = rset->get<uint8>("duskdim_stone");
        ref<uint8>(0x40) = rset->get<uint8>("duskdim_stone_1");
        ref<uint8>(0x41) = rset->get<uint8>("duskdim_stone_2");
        ref<uint8>(0x42) = rset->get<uint8>("duskorb_stone");
        ref<uint8>(0x43) = rset->get<uint8>("duskorb_stone_1");
        ref<uint8>(0x44) = rset->get<uint8>("duskorb_stone_2");

        ref<uint8>(0x45) = rset->get<uint8>("pellucid_stone");
        ref<uint8>(0x46) = rset->get<uint8>("fern_stone");
        ref<uint8>(0x47) = rset->get<uint8>("taupe_stone");

        ref<uint16>(0x4A) = rset->get<uint16>("escha_beads");
        ref<uint32>(0x4C) = rset->get<uint32>("escha_silt");

        ref<uint32>(0x50) = rset->get<uint32>("potpourri");

        ref<uint32>(0x54) = rset->get<uint32>("current_hallmarks");
        ref<uint32>(0x58) = rset->get<uint32>("total_hallmarks");
        ref<uint32>(0x5C) = rset->get<uint32>("gallantry");

        ref<uint32>(0x60) = rset->get<uint32>("crafter_points");

        ref<uint8>(0x64) = rset->get<uint8>("fire_crystal_set");
        ref<uint8>(0x65) = rset->get<uint8>("ice_crystal_set");
        ref<uint8>(0x66) = rset->get<uint8>("wind_crystal_set");
        ref<uint8>(0x67) = rset->get<uint8>("earth_crystal_set");
        ref<uint8>(0x68) = rset->get<uint8>("lightning_crystal_set");
        ref<uint8>(0x69) = rset->get<uint8>("water_crystal_set");
        ref<uint8>(0x6A) = rset->get<uint8>("light_crystal_set");
        ref<uint8>(0x6B) = rset->get<uint8>("dark_crystal_set");
        ref<uint8>(0x6C) = rset->get<uint8>("mc_s_sr01_set");
        ref<uint8>(0x6D) = rset->get<uint8>("mc_s_sr02_set");
        ref<uint8>(0x6E) = rset->get<uint8>("mc_s_sr03_set");
        ref<uint8>(0x6F) = rset->get<uint8>("liquefaction_spheres_set");
        ref<uint8>(0x70) = rset->get<uint8>("induration_spheres_set");
        ref<uint8>(0x71) = rset->get<uint8>("detonation_spheres_set");
        ref<uint8>(0x72) = rset->get<uint8>("scission_spheres_set");
        ref<uint8>(0x73) = rset->get<uint8>("impaction_spheres_set");
        ref<uint8>(0x74) = rset->get<uint8>("reverberation_spheres_set");
        ref<uint8>(0x75) = rset->get<uint8>("transfixion_spheres_set");
        ref<uint8>(0x76) = rset->get<uint8>("compression_spheres_set");
        ref<uint8>(0x77) = rset->get<uint8>("fusion_spheres_set");
        ref<uint8>(0x78) = rset->get<uint8>("distortion_spheres_set");
        ref<uint8>(0x79) = rset->get<uint8>("fragmentation_spheres_set");
        ref<uint8>(0x7A) = rset->get<uint8>("gravitation_spheres_set");
        ref<uint8>(0x7B) = rset->get<uint8>("light_spheres_set");
        ref<uint8>(0x7C) = rset->get<uint8>("darkness_spheres_set");

        ref<uint32>(0x80) = rset->get<uint32>("silver_aman_voucher");

        ref<uint32>(0x84) = rset->get<uint32>("domain_points");
        ref<uint32>(0x88) = rset->get<uint32>("domain_points_daily");
        ref<uint32>(0x8C) = rset->get<uint32>("mog_segments");
        ref<uint32>(0x90) = rset->get<uint32>("gallimaufry");
        ref<uint16>(0x94) = rset->get<uint16>("is_accolades");
    }
}
