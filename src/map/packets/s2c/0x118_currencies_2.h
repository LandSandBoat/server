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

#pragma once

#include "base.h"

class CCharEntity;

// https://github.com/atom0s/XiPackets/tree/main/world/server/0x0118
// This packet is sent by the server to update the clients currency information. (2)
class GP_SERV_COMMAND_CURRENCIES_2 final : public GP_SERV_PACKET<PacketS2C::GP_SERV_COMMAND_CURRENCIES_2, GP_SERV_COMMAND_CURRENCIES_2>
{
public:
    struct PacketData
    {
        int32_t  bayld;
        uint16_t kinetic_units;
        uint8_t  coalition_imprimaturs;
        uint8_t  mystical_canteens;
        int32_t  obsidian_fragments;
        uint16_t lebondopt_wings_stored;
        uint16_t pulchridopt_wings_stored;
        int32_t  mweya_plasm_corpuscles;
        uint8_t  ghastly_stones_stored;
        uint8_t  ghastly_stones_plus1_stored;
        uint8_t  ghastly_stones_plus2_stored;
        uint8_t  verdigris_stones_stored;
        uint8_t  verdigris_stones_plus1_stored;
        uint8_t  verdigris_stones_plus2_stored;
        uint8_t  wailing_stones_stored;
        uint8_t  wailing_stones_plus1_stored;
        uint8_t  wailing_stones_plus2_stored;
        uint8_t  snowslit_stones_stored;
        uint8_t  snowslit_stones_plus1_stored;
        uint8_t  snowslit_stones_plus2_stored;
        uint8_t  snowtip_stones_stored;
        uint8_t  snowtip_stones_plus1_stored;
        uint8_t  snowtip_stones_plus2_stored;
        uint8_t  snowdim_stones_stored;
        uint8_t  snowdim_stones_plus1_stored;
        uint8_t  snowdim_stones_plus2_stored;
        uint8_t  snoworb_stones_stored;
        uint8_t  snoworb_stones_plus1_stored;
        uint8_t  snoworb_stones_plus2_stored;
        uint8_t  leafslit_stones_stored;
        uint8_t  leafslit_stones_plus1_stored;
        uint8_t  leafslit_stones_plus2_stored;
        uint8_t  leaftip_stones_stored;
        uint8_t  leaftip_stones_plus1_stored;
        uint8_t  leaftip_stones_plus2_stored;
        uint8_t  leafdim_stones_stored;
        uint8_t  leafdim_stones_plus1_stored;
        uint8_t  leafdim_stones_plus2_stored;
        uint8_t  leaforb_stones_stored;
        uint8_t  leaforb_stones_plus1_stored;
        uint8_t  leaforb_stones_plus2_stored;
        uint8_t  duskslit_stones_stored;
        uint8_t  duskslit_stones_plus1_stored;
        uint8_t  duskslit_stones_plus2_stored;
        uint8_t  dusktip_stones_stored;
        uint8_t  dusktip_stones_plus1_stored;
        uint8_t  dusktip_stones_plus2_stored;
        uint8_t  duskdim_stones_stored;
        uint8_t  duskdim_stones_plus1_stored;
        uint8_t  duskdim_stones_plus2_stored;
        uint8_t  duskorb_stones_stored;
        uint8_t  duskorb_stones_plus1_stored;
        uint8_t  duskorb_stones_plus2_stored;
        uint8_t  pellucid_stones_stored;
        uint8_t  fern_stones_stored;
        uint8_t  taupe_stones_stored;
        uint16_t mellidopt_wings_stored;
        uint16_t escha_beads;
        int32_t  escha_silt;
        int32_t  potpourri;
        int32_t  hallmarks;
        int32_t  total_hallmarks;
        int32_t  badges_of_gallantry;
        int32_t  crafter_points;
        uint8_t  fire_crystals_set;
        uint8_t  ice_crystals_set;
        uint8_t  wind_crystals_set;
        uint8_t  earth_crystals_set;
        uint8_t  lightning_crystals_set;
        uint8_t  water_crystals_set;
        uint8_t  light_crystals_set;
        uint8_t  dark_crystals_set;
        uint8_t  mc_i_sr01s_set;
        uint8_t  mc_i_sr02s_set;
        uint8_t  mc_i_sr03s_set;
        uint8_t  liquefactions_spheres_set;
        uint8_t  induration_spheres_set;
        uint8_t  dentonation_spheres_set;
        uint8_t  scission_spheres_set;
        uint8_t  impaction_spheres_set;
        uint8_t  reverberation_spheres_set;
        uint8_t  transfixion_spheres_set;
        uint8_t  compression_spheres_set;
        uint8_t  fusion_spheres_set;
        uint8_t  distortion_spheres_set;
        uint8_t  fragmentation_spheres_set;
        uint8_t  gravitation_spheres_set;
        uint8_t  light_spheres_set;
        uint8_t  darkness_spheres_set;
        uint8_t  padding00[3];
        int32_t  silver_aman_vouchers_stored;
        int32_t  domain_points;
        int32_t  domain_points_earned_today;
        int32_t  mog_segments;
        int32_t  gallimaufry;
        // Everything below is undocumented on XiPackets
        uint16_t is_accolades;
        uint16_t padding02;
        int32_t  temenos_units;
        int32_t  apollyon_units;
    };

    GP_SERV_COMMAND_CURRENCIES_2(CCharEntity* PChar);
};
