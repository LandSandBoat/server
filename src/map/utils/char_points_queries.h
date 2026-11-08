/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "common/cbasetypes.h"

#include "common/database/query.h"

#include <algorithm>
#include <array>
#include <cstddef>
#include <limits>
#include <string_view>
#include <utility>

namespace charutils
{

struct CharPointsColumn
{
    std::string_view name;
    int64            min;
    int64            max;
};

template <typename T>
consteval auto pointsColumn(const std::string_view name) -> CharPointsColumn
{
    return CharPointsColumn{ name, std::numeric_limits<T>::min(), std::numeric_limits<T>::max() };
}

// One entry per char_points column, typed as the schema stores it. A test checks the list against the schema.
inline constexpr auto charPointsColumns = std::to_array<CharPointsColumn>({
    pointsColumn<uint32>("sandoria_cp"),
    pointsColumn<uint32>("bastok_cp"),
    pointsColumn<uint32>("windurst_cp"),
    pointsColumn<uint32>("beastman_seal"),
    pointsColumn<uint16>("kindred_seal"),
    pointsColumn<uint16>("kindred_crest"),
    pointsColumn<uint16>("high_kindred_crest"),
    pointsColumn<uint16>("sacred_kindred_crest"),
    pointsColumn<uint16>("ancient_beastcoin"),
    pointsColumn<uint16>("valor_point"),
    pointsColumn<uint16>("scyld"),
    pointsColumn<uint32>("guild_fishing"),
    pointsColumn<uint32>("guild_woodworking"),
    pointsColumn<uint32>("guild_smithing"),
    pointsColumn<uint32>("guild_goldsmithing"),
    pointsColumn<uint32>("guild_weaving"),
    pointsColumn<uint32>("guild_leathercraft"),
    pointsColumn<uint32>("guild_bonecraft"),
    pointsColumn<uint32>("guild_alchemy"),
    pointsColumn<uint32>("guild_cooking"),
    pointsColumn<uint32>("cinder"),
    pointsColumn<uint8>("fire_fewell"),
    pointsColumn<uint8>("ice_fewell"),
    pointsColumn<uint8>("wind_fewell"),
    pointsColumn<uint8>("earth_fewell"),
    pointsColumn<uint8>("lightning_fewell"),
    pointsColumn<uint8>("water_fewell"),
    pointsColumn<uint8>("light_fewell"),
    pointsColumn<uint8>("dark_fewell"),
    pointsColumn<uint32>("ballista_point"),
    pointsColumn<uint32>("fellow_point"),
    pointsColumn<int32>("daily_tally"),
    pointsColumn<uint16>("chocobuck_sandoria"),
    pointsColumn<uint16>("chocobuck_bastok"),
    pointsColumn<uint16>("chocobuck_windurst"),
    pointsColumn<uint32>("research_mark"),
    pointsColumn<uint8>("tunnel_worm"),
    pointsColumn<uint8>("morion_worm"),
    pointsColumn<uint8>("phantom_worm"),
    pointsColumn<uint32>("moblin_marble"),
    pointsColumn<uint16>("infamy"),
    pointsColumn<uint16>("prestige"),
    pointsColumn<uint32>("legion_point"),
    pointsColumn<uint32>("spark_of_eminence"),
    pointsColumn<uint32>("shining_star"),
    pointsColumn<uint32>("imperial_standing"),
    pointsColumn<uint32>("leujaoam_assault_point"),
    pointsColumn<uint32>("mamool_assault_point"),
    pointsColumn<uint32>("lebros_assault_point"),
    pointsColumn<uint32>("periqia_assault_point"),
    pointsColumn<uint32>("ilrusi_assault_point"),
    pointsColumn<uint32>("nyzul_isle_assault_point"),
    pointsColumn<uint32>("zeni_point"),
    pointsColumn<uint32>("jetton"),
    pointsColumn<uint32>("therion_ichor"),
    pointsColumn<uint32>("allied_notes"),
    pointsColumn<uint16>("aman_vouchers"),
    pointsColumn<uint16>("login_points"),
    pointsColumn<uint32>("bayld"),
    pointsColumn<uint16>("kinetic_unit"),
    pointsColumn<uint32>("obsidian_fragment"),
    pointsColumn<uint16>("lebondopt_wing"),
    pointsColumn<uint16>("pulchridopt_wing"),
    pointsColumn<uint32>("mweya_plasm"),
    pointsColumn<uint32>("cruor"),
    pointsColumn<uint32>("resistance_credit"),
    pointsColumn<uint32>("dominion_note"),
    pointsColumn<uint8>("fifth_echelon_trophy"),
    pointsColumn<uint8>("fourth_echelon_trophy"),
    pointsColumn<uint8>("third_echelon_trophy"),
    pointsColumn<uint8>("second_echelon_trophy"),
    pointsColumn<uint8>("first_echelon_trophy"),
    pointsColumn<uint8>("cave_points"),
    pointsColumn<uint8>("id_tags"),
    pointsColumn<uint8>("op_credits"),
    pointsColumn<uint32>("traverser_stones"),
    pointsColumn<uint32>("voidstones"),
    pointsColumn<uint32>("kupofried_corundums"),
    pointsColumn<uint8>("imprimaturs"),
    pointsColumn<uint8>("pheromone_sacks"),
    pointsColumn<uint8>("rems_ch1"),
    pointsColumn<uint8>("rems_ch2"),
    pointsColumn<uint8>("rems_ch3"),
    pointsColumn<uint8>("rems_ch4"),
    pointsColumn<uint8>("rems_ch5"),
    pointsColumn<uint8>("rems_ch6"),
    pointsColumn<uint8>("rems_ch7"),
    pointsColumn<uint8>("rems_ch8"),
    pointsColumn<uint8>("rems_ch9"),
    pointsColumn<uint8>("rems_ch10"),
    pointsColumn<uint16>("reclamation_marks"),
    pointsColumn<uint32>("unity_accolades"),
    pointsColumn<uint16>("fire_crystals"),
    pointsColumn<uint16>("ice_crystals"),
    pointsColumn<uint16>("wind_crystals"),
    pointsColumn<uint16>("earth_crystals"),
    pointsColumn<uint16>("lightning_crystals"),
    pointsColumn<uint16>("water_crystals"),
    pointsColumn<uint16>("light_crystals"),
    pointsColumn<uint16>("dark_crystals"),
    pointsColumn<uint16>("deeds"),
    pointsColumn<uint32>("current_accolades"),
    pointsColumn<uint32>("prev_accolades"),
    pointsColumn<uint8>("mystical_canteen"),
    pointsColumn<uint8>("ghastly_stone"),
    pointsColumn<uint8>("ghastly_stone_1"),
    pointsColumn<uint8>("ghastly_stone_2"),
    pointsColumn<uint8>("verdigris_stone"),
    pointsColumn<uint8>("verdigris_stone_1"),
    pointsColumn<uint8>("verdigris_stone_2"),
    pointsColumn<uint8>("wailing_stone"),
    pointsColumn<uint8>("wailing_stone_1"),
    pointsColumn<uint8>("wailing_stone_2"),
    pointsColumn<uint8>("snowslit_stone"),
    pointsColumn<uint8>("snowslit_stone_1"),
    pointsColumn<uint8>("snowslit_stone_2"),
    pointsColumn<uint8>("snowtip_stone"),
    pointsColumn<uint8>("snowtip_stone_1"),
    pointsColumn<uint8>("snowtip_stone_2"),
    pointsColumn<uint8>("snowdim_stone"),
    pointsColumn<uint8>("snowdim_stone_1"),
    pointsColumn<uint8>("snowdim_stone_2"),
    pointsColumn<uint8>("snoworb_stone"),
    pointsColumn<uint8>("snoworb_stone_1"),
    pointsColumn<uint8>("snoworb_stone_2"),
    pointsColumn<uint8>("leafslit_stone"),
    pointsColumn<uint8>("leafslit_stone_1"),
    pointsColumn<uint8>("leafslit_stone_2"),
    pointsColumn<uint8>("leaftip_stone"),
    pointsColumn<uint8>("leaftip_stone_1"),
    pointsColumn<uint8>("leaftip_stone_2"),
    pointsColumn<uint8>("leafdim_stone"),
    pointsColumn<uint8>("leafdim_stone_1"),
    pointsColumn<uint8>("leafdim_stone_2"),
    pointsColumn<uint8>("leaforb_stone"),
    pointsColumn<uint8>("leaforb_stone_1"),
    pointsColumn<uint8>("leaforb_stone_2"),
    pointsColumn<uint8>("duskslit_stone"),
    pointsColumn<uint8>("duskslit_stone_1"),
    pointsColumn<uint8>("duskslit_stone_2"),
    pointsColumn<uint8>("dusktip_stone"),
    pointsColumn<uint8>("dusktip_stone_1"),
    pointsColumn<uint8>("dusktip_stone_2"),
    pointsColumn<uint8>("duskdim_stone"),
    pointsColumn<uint8>("duskdim_stone_1"),
    pointsColumn<uint8>("duskdim_stone_2"),
    pointsColumn<uint8>("duskorb_stone"),
    pointsColumn<uint8>("duskorb_stone_1"),
    pointsColumn<uint8>("duskorb_stone_2"),
    pointsColumn<uint8>("pellucid_stone"),
    pointsColumn<uint8>("fern_stone"),
    pointsColumn<uint8>("taupe_stone"),
    pointsColumn<uint16>("escha_beads"),
    pointsColumn<uint32>("escha_silt"),
    pointsColumn<uint32>("potpourri"),
    pointsColumn<uint32>("current_hallmarks"),
    pointsColumn<uint32>("total_hallmarks"),
    pointsColumn<uint32>("gallantry"),
    pointsColumn<uint32>("crafter_points"),
    pointsColumn<uint8>("fire_crystal_set"),
    pointsColumn<uint8>("ice_crystal_set"),
    pointsColumn<uint8>("wind_crystal_set"),
    pointsColumn<uint8>("earth_crystal_set"),
    pointsColumn<uint8>("lightning_crystal_set"),
    pointsColumn<uint8>("water_crystal_set"),
    pointsColumn<uint8>("light_crystal_set"),
    pointsColumn<uint8>("dark_crystal_set"),
    pointsColumn<uint8>("mc_s_sr01_set"),
    pointsColumn<uint8>("mc_s_sr02_set"),
    pointsColumn<uint8>("mc_s_sr03_set"),
    pointsColumn<uint8>("liquefaction_spheres_set"),
    pointsColumn<uint8>("induration_spheres_set"),
    pointsColumn<uint8>("detonation_spheres_set"),
    pointsColumn<uint8>("scission_spheres_set"),
    pointsColumn<uint8>("impaction_spheres_set"),
    pointsColumn<uint8>("reverberation_spheres_set"),
    pointsColumn<uint8>("transfixion_spheres_set"),
    pointsColumn<uint8>("compression_spheres_set"),
    pointsColumn<uint8>("fusion_spheres_set"),
    pointsColumn<uint8>("distortion_spheres_set"),
    pointsColumn<uint8>("fragmentation_spheres_set"),
    pointsColumn<uint8>("gravitation_spheres_set"),
    pointsColumn<uint8>("light_spheres_set"),
    pointsColumn<uint8>("darkness_spheres_set"),
    pointsColumn<uint32>("silver_aman_voucher"),
    pointsColumn<int16>("plaudits"),
    pointsColumn<uint16>("bloodshed_plans"),
    pointsColumn<uint16>("umbrage_plans"),
    pointsColumn<uint16>("ritualistic_plans"),
    pointsColumn<uint16>("tutelary_plans"),
    pointsColumn<uint16>("primacy_plans"),
    pointsColumn<uint32>("domain_points"),
    pointsColumn<uint32>("domain_points_daily"),
    pointsColumn<uint32>("mog_segments"),
    pointsColumn<uint32>("gallimaufry"),
    pointsColumn<uint16>("is_accolades"),
    pointsColumn<uint32>("temenos_units"),
    pointsColumn<uint32>("apollyon_units"),
    pointsColumn<uint16>("alter_ego_points"),
});

namespace detail
{

template <std::size_t N>
struct QueryText
{
    char text[N]{};
};

template <std::size_t Count>
consteval auto textSize(const std::array<std::string_view, Count>& parts) -> std::size_t
{
    auto size = std::size_t{ 1 };
    for (const auto part : parts)
    {
        size += part.size();
    }

    return size;
}

template <std::size_t N, std::size_t Count>
consteval auto joinText(const std::array<std::string_view, Count>& parts) -> QueryText<N>
{
    auto out = QueryText<N>{};
    auto pos = std::size_t{ 0 };
    for (const auto part : parts)
    {
        for (const auto c : part)
        {
            out.text[pos++] = c;
        }
    }

    return out;
}

template <std::size_t I>
struct ColumnQueryText
{
    static constexpr auto name        = charPointsColumns[I].name;
    static constexpr auto selectParts = std::array<std::string_view, 3>{ "SELECT ", name, " FROM char_points WHERE charid = ? LIMIT 1" };
    static constexpr auto updateParts = std::array<std::string_view, 3>{ "UPDATE char_points SET ", name, " = ? WHERE charid = ?" };
    static constexpr auto select      = joinText<textSize(selectParts)>(selectParts);
    static constexpr auto update      = joinText<textSize(updateParts)>(updateParts);
};

} // namespace detail

struct CharPointsQueries
{
    CharPointsColumn column;
    db::Query        select;
    db::Query        update;
};

inline constexpr auto charPointsQueries = []<std::size_t... I>(std::index_sequence<I...>) consteval
{
    return std::array{
        CharPointsQueries{
            charPointsColumns[I],
            db::Query(detail::ColumnQueryText<I>::select.text),
            db::Query(detail::ColumnQueryText<I>::update.text),
        }...,
    };
}(std::make_index_sequence<charPointsColumns.size()>{});

static_assert(std::ranges::all_of(
    charPointsQueries,
    [](const CharPointsQueries& queries)
    {
        return queries.select.placeholders() == 1 && queries.update.placeholders() == 2;
    }));

} // namespace charutils
