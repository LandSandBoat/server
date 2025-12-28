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

#include "0x118_currencies_2.h"

#include "common/database.h"
#include "entities/charentity.h"

GP_SERV_COMMAND_CURRENCIES_2::GP_SERV_COMMAND_CURRENCIES_2(CCharEntity* PChar)
{
    auto& packet = this->data();

    const char* query = "SELECT bayld, kinetic_unit, imprimaturs, mystical_canteen, obsidian_fragment, lebondopt_wing, "
                        "pulchridopt_wing, mweya_plasm, ghastly_stone, ghastly_stone_1, ghastly_stone_2, verdigris_stone, "
                        "verdigris_stone_1, verdigris_stone_2, wailing_stone, wailing_stone_1, wailing_stone_2, "
                        "snowslit_stone, snowslit_stone_1, snowslit_stone_2, snowtip_stone, snowtip_stone_1, snowtip_stone_2, "
                        "snowdim_stone, snowdim_stone_1, snowdim_stone_2, snoworb_stone, snoworb_stone_1, snoworb_stone_2, "
                        "leafslit_stone, leafslit_stone_1, leafslit_stone_2, leaftip_stone, leaftip_stone_1, leaftip_stone_2, "
                        "leafdim_stone, leafdim_stone_1, leafdim_stone_2, leaforb_stone, leaforb_stone_1, leaforb_stone_2, "
                        "duskslit_stone, duskslit_stone_1, duskslit_stone_2, dusktip_stone, dusktip_stone_1, dusktip_stone_2, "
                        "duskdim_stone, duskdim_stone_1, duskdim_stone_2, duskorb_stone, duskorb_stone_1, duskorb_stone_2, "
                        "pellucid_stone, fern_stone, taupe_stone, escha_beads, escha_silt, potpourri, current_hallmarks, "
                        "total_hallmarks, gallantry, crafter_points, fire_crystal_set, ice_crystal_set, wind_crystal_set, "
                        "earth_crystal_set, lightning_crystal_set, water_crystal_set, light_crystal_set, dark_crystal_set, "
                        "mc_s_sr01_set, mc_s_sr02_set, mc_s_sr03_set, liquefaction_spheres_set, induration_spheres_set, "
                        "detonation_spheres_set, scission_spheres_set, impaction_spheres_set, reverberation_spheres_set, "
                        "transfixion_spheres_set, compression_spheres_set, fusion_spheres_set, distortion_spheres_set, "
                        "fragmentation_spheres_set, gravitation_spheres_set, light_spheres_set, darkness_spheres_set, "
                        "silver_aman_voucher, domain_points, domain_points_daily, mog_segments, gallimaufry, is_accolades, "
                        "temenos_units, apollyon_units "
                        "FROM char_points WHERE charid = ?";

    const auto rset = db::preparedStmt(query, PChar->id);
    FOR_DB_SINGLE_RESULT(rset)
    {
        packet.bayld                    = rset->get<int32_t>("bayld");
        packet.kinetic_units            = rset->get<uint16_t>("kinetic_unit");
        packet.coalition_imprimaturs    = rset->get<uint8_t>("imprimaturs");
        packet.mystical_canteens        = rset->get<uint8_t>("mystical_canteen");
        packet.obsidian_fragments       = rset->get<int32_t>("obsidian_fragment");
        packet.lebondopt_wings_stored   = rset->get<uint16_t>("lebondopt_wing");
        packet.pulchridopt_wings_stored = rset->get<uint16_t>("pulchridopt_wing");
        packet.mweya_plasm_corpuscles   = rset->get<int32_t>("mweya_plasm");

        packet.ghastly_stones_stored         = rset->get<uint8_t>("ghastly_stone");
        packet.ghastly_stones_plus1_stored   = rset->get<uint8_t>("ghastly_stone_1");
        packet.ghastly_stones_plus2_stored   = rset->get<uint8_t>("ghastly_stone_2");
        packet.verdigris_stones_stored       = rset->get<uint8_t>("verdigris_stone");
        packet.verdigris_stones_plus1_stored = rset->get<uint8_t>("verdigris_stone_1");
        packet.verdigris_stones_plus2_stored = rset->get<uint8_t>("verdigris_stone_2");
        packet.wailing_stones_stored         = rset->get<uint8_t>("wailing_stone");
        packet.wailing_stones_plus1_stored   = rset->get<uint8_t>("wailing_stone_1");
        packet.wailing_stones_plus2_stored   = rset->get<uint8_t>("wailing_stone_2");

        packet.snowslit_stones_stored       = rset->get<uint8_t>("snowslit_stone");
        packet.snowslit_stones_plus1_stored = rset->get<uint8_t>("snowslit_stone_1");
        packet.snowslit_stones_plus2_stored = rset->get<uint8_t>("snowslit_stone_2");
        packet.snowtip_stones_stored        = rset->get<uint8_t>("snowtip_stone");
        packet.snowtip_stones_plus1_stored  = rset->get<uint8_t>("snowtip_stone_1");
        packet.snowtip_stones_plus2_stored  = rset->get<uint8_t>("snowtip_stone_2");
        packet.snowdim_stones_stored        = rset->get<uint8_t>("snowdim_stone");
        packet.snowdim_stones_plus1_stored  = rset->get<uint8_t>("snowdim_stone_1");
        packet.snowdim_stones_plus2_stored  = rset->get<uint8_t>("snowdim_stone_2");
        packet.snoworb_stones_stored        = rset->get<uint8_t>("snoworb_stone");
        packet.snoworb_stones_plus1_stored  = rset->get<uint8_t>("snoworb_stone_1");
        packet.snoworb_stones_plus2_stored  = rset->get<uint8_t>("snoworb_stone_2");
        packet.leafslit_stones_stored       = rset->get<uint8_t>("leafslit_stone");
        packet.leafslit_stones_plus1_stored = rset->get<uint8_t>("leafslit_stone_1");
        packet.leafslit_stones_plus2_stored = rset->get<uint8_t>("leafslit_stone_2");
        packet.leaftip_stones_stored        = rset->get<uint8_t>("leaftip_stone");
        packet.leaftip_stones_plus1_stored  = rset->get<uint8_t>("leaftip_stone_1");
        packet.leaftip_stones_plus2_stored  = rset->get<uint8_t>("leaftip_stone_2");
        packet.leafdim_stones_stored        = rset->get<uint8_t>("leafdim_stone");
        packet.leafdim_stones_plus1_stored  = rset->get<uint8_t>("leafdim_stone_1");
        packet.leafdim_stones_plus2_stored  = rset->get<uint8_t>("leafdim_stone_2");
        packet.leaforb_stones_stored        = rset->get<uint8_t>("leaforb_stone");
        packet.leaforb_stones_plus1_stored  = rset->get<uint8_t>("leaforb_stone_1");
        packet.leaforb_stones_plus2_stored  = rset->get<uint8_t>("leaforb_stone_2");
        packet.duskslit_stones_stored       = rset->get<uint8_t>("duskslit_stone");
        packet.duskslit_stones_plus1_stored = rset->get<uint8_t>("duskslit_stone_1");
        packet.duskslit_stones_plus2_stored = rset->get<uint8_t>("duskslit_stone_2");
        packet.dusktip_stones_stored        = rset->get<uint8_t>("dusktip_stone");
        packet.dusktip_stones_plus1_stored  = rset->get<uint8_t>("dusktip_stone_1");
        packet.dusktip_stones_plus2_stored  = rset->get<uint8_t>("dusktip_stone_2");
        packet.duskdim_stones_stored        = rset->get<uint8_t>("duskdim_stone");
        packet.duskdim_stones_plus1_stored  = rset->get<uint8_t>("duskdim_stone_1");
        packet.duskdim_stones_plus2_stored  = rset->get<uint8_t>("duskdim_stone_2");
        packet.duskorb_stones_stored        = rset->get<uint8_t>("duskorb_stone");
        packet.duskorb_stones_plus1_stored  = rset->get<uint8_t>("duskorb_stone_1");
        packet.duskorb_stones_plus2_stored  = rset->get<uint8_t>("duskorb_stone_2");

        packet.pellucid_stones_stored = rset->get<uint8_t>("pellucid_stone");
        packet.fern_stones_stored     = rset->get<uint8_t>("fern_stone");
        packet.taupe_stones_stored    = rset->get<uint8_t>("taupe_stone");
        packet.mellidopt_wings_stored = 0; // Not in database yet

        packet.escha_beads = rset->get<uint16_t>("escha_beads");
        packet.escha_silt  = rset->get<int32_t>("escha_silt");

        packet.potpourri = rset->get<int32_t>("potpourri");

        packet.hallmarks           = rset->get<int32_t>("current_hallmarks");
        packet.total_hallmarks     = rset->get<int32_t>("total_hallmarks");
        packet.badges_of_gallantry = rset->get<int32_t>("gallantry");

        packet.crafter_points = rset->get<int32_t>("crafter_points");

        packet.fire_crystals_set         = rset->get<uint8_t>("fire_crystal_set");
        packet.ice_crystals_set          = rset->get<uint8_t>("ice_crystal_set");
        packet.wind_crystals_set         = rset->get<uint8_t>("wind_crystal_set");
        packet.earth_crystals_set        = rset->get<uint8_t>("earth_crystal_set");
        packet.lightning_crystals_set    = rset->get<uint8_t>("lightning_crystal_set");
        packet.water_crystals_set        = rset->get<uint8_t>("water_crystal_set");
        packet.light_crystals_set        = rset->get<uint8_t>("light_crystal_set");
        packet.dark_crystals_set         = rset->get<uint8_t>("dark_crystal_set");
        packet.mc_i_sr01s_set            = rset->get<uint8_t>("mc_s_sr01_set");
        packet.mc_i_sr02s_set            = rset->get<uint8_t>("mc_s_sr02_set");
        packet.mc_i_sr03s_set            = rset->get<uint8_t>("mc_s_sr03_set");
        packet.liquefactions_spheres_set = rset->get<uint8_t>("liquefaction_spheres_set");
        packet.induration_spheres_set    = rset->get<uint8_t>("induration_spheres_set");
        packet.dentonation_spheres_set   = rset->get<uint8_t>("detonation_spheres_set");
        packet.scission_spheres_set      = rset->get<uint8_t>("scission_spheres_set");
        packet.impaction_spheres_set     = rset->get<uint8_t>("impaction_spheres_set");
        packet.reverberation_spheres_set = rset->get<uint8_t>("reverberation_spheres_set");
        packet.transfixion_spheres_set   = rset->get<uint8_t>("transfixion_spheres_set");
        packet.compression_spheres_set   = rset->get<uint8_t>("compression_spheres_set");
        packet.fusion_spheres_set        = rset->get<uint8_t>("fusion_spheres_set");
        packet.distortion_spheres_set    = rset->get<uint8_t>("distortion_spheres_set");
        packet.fragmentation_spheres_set = rset->get<uint8_t>("fragmentation_spheres_set");
        packet.gravitation_spheres_set   = rset->get<uint8_t>("gravitation_spheres_set");
        packet.light_spheres_set         = rset->get<uint8_t>("light_spheres_set");
        packet.darkness_spheres_set      = rset->get<uint8_t>("darkness_spheres_set");

        packet.silver_aman_vouchers_stored = rset->get<int32_t>("silver_aman_voucher");

        packet.domain_points              = rset->get<int32_t>("domain_points");
        packet.domain_points_earned_today = rset->get<int32_t>("domain_points_daily");
        packet.mog_segments               = rset->get<int32_t>("mog_segments");
        packet.gallimaufry                = rset->get<int32_t>("gallimaufry");
        packet.is_accolades               = rset->get<uint16_t>("is_accolades");
        packet.temenos_units              = rset->get<int32_t>("temenos_units");
        packet.apollyon_units             = rset->get<int32_t>("apollyon_units");
    }
}
