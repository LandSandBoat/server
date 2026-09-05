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
#include "common/types/hash_map.h"
#include "common/types/position.h"
#include "data/datasets/ecosystems/dataset.h"
#include "data/enums/allegiance.h"
#include "data/enums/content.h"
#include "data/enums/mob_type.h"
#include "data/enums/roam_flag.h"
#include "data/enums/species.h"
#include "data/enums/zone.h"
#include "data/shared_types/mob_attributes/dataset.h"

#include <string>
#include <string_view>
#include <utility>
#include <vector>

namespace xi::data
{

// Items stay names here; the loader resolves them once the item table exists.
struct LootRollData
{
    uint16                                      Chance{};
    std::string                                 Item;  // empty when the roll picks from OneOf
    std::vector<std::pair<std::string, uint16>> OneOf; // name -> weight; "nothing" is reserved
};

struct LootData
{
    std::vector<LootRollData>                   Drops;
    std::vector<std::string>                    Steal;
    std::vector<std::pair<std::string, uint16>> Despoil;

    auto empty() const -> bool
    {
        return Drops.empty() && Steal.empty() && Despoil.empty();
    }
};

struct MobTemplateData
{
    uint32       Id{};        // pool id, read at runtime for modifier lookups
    std::string  Name;        // the template's key
    std::string  DisplayName; // packet name, sent to the client
    xi::Species  Species{};
    xi::MobType  Type{};
    xi::RoamFlag RoamFlags{};
    uint16       SpellList{};
    uint16       SkillList{};

    std::vector<std::string> Spells; // TODO: Replace with Spell enums

    MobAttributesOverrides Attributes{}; // applied over the species chain

    LootData       Loot{};
    xi::Allegiance Allegiance{};
    xi::Content    Content{};
};

struct MobSpawnData
{
    uint32      Id{}; // fully qualified: 0x01000000 | zone << 12 | targid
    uint16      ActIndex{};
    std::string TemplateName; // empty reserves the id without instantiating
    std::string Script;       // resolves scripts/zones/<zone>/mobs/<script>.lua
    bool        Placed{};     // false reserves the id for Lua without instantiating
    position_t  Position{};
    uint8       MinLevel{};
    uint8       MaxLevel{};

    std::string             Region; // roams this region instead of a fixed point
    std::vector<position_t> Route;  // a `path` arrives folded back on itself, so every route is a closed loop

    MobAttributesOverrides Attributes{};
};

struct MobSlotMemberData
{
    uint16 ActIndex{};
    uint8  Chance{};   // not implemented: no zone sets one
    uint32 Cooldown{}; // not implemented: nothing reads it
};

struct MobSlotData
{
    uint32                         Id{};
    std::vector<MobSlotMemberData> Members;
};

struct Mobs
{
    HashMap<std::string, MobTemplateData> Templates;
    std::vector<MobSpawnData>             Spawns;
    std::vector<MobSlotData>              Slots;
};

} // namespace xi::data

namespace xi::data::datasets::zones::mobs::wire
{

struct Document;

}

namespace xi::data::datasets::zones::mobs
{

struct Dataset
{
    using Records      = xi::data::Mobs;
    using YamlDocument = wire::Document;

    static constexpr std::string_view kDataPath{ "mobs" };
    static constexpr std::string_view kTitle{ "Zone Mobs" };
    static constexpr std::string_view kDescription{ "Mob templates, spawn groups, spawn points and slots for one zone." };

    static auto decode(std::string_view text) -> Records;

    static void verifyZone(const Records& records, xi::ZoneId zoneId);
};

} // namespace xi::data::datasets::zones::mobs
