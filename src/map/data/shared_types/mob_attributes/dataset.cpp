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

#include "data/shared_types/mob_attributes/dataset.h"

#include "data/shared_types/mob_attributes/yaml.h"

#include "data/yaml/enum_keyed_map.h"
#include "data/yaml/enum_token.h"

#include <fmt/format.h>

#include <algorithm>
#include <optional>
#include <stdexcept>
#include <string>
#include <string_view>
#include <utility>

namespace xi::data
{
namespace
{

template <class T>
void mergeField(T& target, const std::optional<T>& overrideValue)
{
    if (overrideValue)
    {
        target = *overrideValue;
    }
}

template <class T>
void mergeField(std::optional<T>& target, const std::optional<T>& overrideValue)
{
    if (overrideValue)
    {
        target = overrideValue;
    }
}

template <class Key, class Value>
void mergeField(HashMap<Key, Value>& target, const HashMap<Key, Value>& overrideValues)
{
    for (const auto& [key, value] : overrideValues)
    {
        target.insert_or_assign(key, value);
    }
}

void mergeField(StatRanksData& target, const std::optional<StatRanksOverrides>& overrideValue)
{
    if (overrideValue)
    {
        applyOverrides(target, *overrideValue);
    }
}

// Field n of the resolved struct pairs with field n of the overrides; the assertions below keep that true.
template <class Data, class Overrides>
void mergeFields(Data& target, const Overrides& overrides)
{
    static_assert(glz::reflect<Data>::size == glz::reflect<Overrides>::size,
                  "resolved attributes and their overrides must declare the same fields");
    static_assert(std::ranges::equal(glz::reflect<Data>::keys, glz::reflect<Overrides>::keys),
                  "resolved attributes and their overrides must declare the same fields in the same order");

    auto targetFields   = glz::to_tie(target);
    auto overrideFields = glz::to_tie(overrides);

    [&]<size_t... Index>(std::index_sequence<Index...>)
    {
        (mergeField(glz::get<Index>(targetFields), glz::get<Index>(overrideFields)), ...);
    }(std::make_index_sequence<glz::reflect<Data>::size>{});
}

} // namespace

void applyOverrides(StatRanksData& target, const StatRanksOverrides& overrides)
{
    mergeFields(target, overrides);
}

void applyOverrides(MobAttributesData& target, const MobAttributesOverrides& overrides)
{
    mergeFields(target, overrides);
}

namespace
{

// An absent token stays absent rather than resolving to the enum's zero.
template <class Enum>
auto resolveOptionalEnum(const std::optional<yaml::EnumToken<Enum>>& token) -> std::optional<Enum>
{
    if (!token)
    {
        return std::nullopt;
    }

    return yaml::resolveEnum(*token);
}

auto convertRanks(const shared::StatRanks& source) -> StatRanksOverrides
{
    return {
        .HP  = source.hp,
        .MP  = source.mp,
        .Str = resolveOptionalEnum(source.str),
        .Dex = resolveOptionalEnum(source.dex),
        .Vit = resolveOptionalEnum(source.vit),
        .Agi = resolveOptionalEnum(source.agi),
        .Int = resolveOptionalEnum(source.intelligence),
        .Mnd = resolveOptionalEnum(source.mnd),
        .Chr = resolveOptionalEnum(source.chr),
        .Def = resolveOptionalEnum(source.def),
        .Eva = resolveOptionalEnum(source.eva),
        .Att = resolveOptionalEnum(source.att),
        .Acc = resolveOptionalEnum(source.acc),
    };
}

// Each resist field maps to the modifier that implements it; the names differ on purpose.
auto convertResists(const std::optional<shared::Resists>& source) -> HashMap<xi::Mod, int16>
{
    HashMap<xi::Mod, int16> resists;
    if (!source)
    {
        return resists;
    }

    const auto take = [&resists](const std::optional<int16>& value, const xi::Mod modifier)
    {
        if (value)
        {
            resists.insert_or_assign(modifier, *value);
        }
    };

    if (const auto& physical = source->dmg_physical)
    {
        take(physical->slashing, xi::Mod::SLASH_SDT);
        take(physical->piercing, xi::Mod::PIERCE_SDT);
        take(physical->blunt, xi::Mod::IMPACT_SDT);
        take(physical->h2h, xi::Mod::HTH_SDT);
    }

    if (const auto& magic = source->dmg_magic)
    {
        take(magic->all, xi::Mod::UDMGMAGIC);
        take(magic->fire, xi::Mod::FIRE_SDT);
        take(magic->ice, xi::Mod::ICE_SDT);
        take(magic->wind, xi::Mod::WIND_SDT);
        take(magic->earth, xi::Mod::EARTH_SDT);
        take(magic->thunder, xi::Mod::THUNDER_SDT);
        take(magic->water, xi::Mod::WATER_SDT);
        take(magic->light, xi::Mod::LIGHT_SDT);
        take(magic->dark, xi::Mod::DARK_SDT);
    }

    if (const auto& element = source->rank_element)
    {
        take(element->fire, xi::Mod::FIRE_RES_RANK);
        take(element->ice, xi::Mod::ICE_RES_RANK);
        take(element->wind, xi::Mod::WIND_RES_RANK);
        take(element->earth, xi::Mod::EARTH_RES_RANK);
        take(element->thunder, xi::Mod::THUNDER_RES_RANK);
        take(element->water, xi::Mod::WATER_RES_RANK);
        take(element->light, xi::Mod::LIGHT_RES_RANK);
        take(element->dark, xi::Mod::DARK_RES_RANK);
    }

    if (const auto& status = source->rank_status)
    {
        take(status->paralyze, xi::Mod::PARALYZE_RES_RANK);
        take(status->bind, xi::Mod::BIND_RES_RANK);
        take(status->silence, xi::Mod::SILENCE_RES_RANK);
        take(status->slow, xi::Mod::SLOW_RES_RANK);
        take(status->poison, xi::Mod::POISON_RES_RANK);
        take(status->light_sleep, xi::Mod::LIGHT_SLEEP_RES_RANK);
        take(status->dark_sleep, xi::Mod::DARK_SLEEP_RES_RANK);
        take(status->blind, xi::Mod::BLIND_RES_RANK);
        take(status->stun, xi::Mod::STUN_RES_RANK);
        take(status->gravity, xi::Mod::GRAVITY_RES_RANK);
    }

    return resists;
}

} // namespace

auto convertAttributes(const shared::MobAttributes& source, const std::string_view context) -> MobAttributesOverrides
{
    MobAttributesOverrides attributes{};
    if (source.element)
    {
        attributes.Element = yaml::resolveEnum(*source.element);
    }

    if (source.stats)
    {
        attributes.Stats = convertRanks(*source.stats);
    }

    if (source.detects)
    {
        attributes.Detects = yaml::resolveFlags(source.detects);
    }

    if (source.spawn)
    {
        attributes.Respawn = source.spawn->respawn;
        if (source.spawn->type)
        {
            attributes.SpawnType = yaml::resolveFlags(source.spawn->type);
        }

        // Both hours are always written together; one alone has no meaning.
        if (const auto& window = source.spawn->window; window && window->start && window->end)
        {
            attributes.SpawnWindow = std::pair{ *window->start, *window->end };
        }
    }

    if (source.combat)
    {
        attributes.CombatSkill      = resolveOptionalEnum(source.combat->skill);
        attributes.Delay            = source.combat->delay;
        attributes.DamageMultiplier = source.combat->dmg_mult;
    }

    if (source.jobs)
    {
        attributes.MainJob = yaml::resolveEnum((*source.jobs)[0]);
        attributes.SubJob  = yaml::resolveEnum((*source.jobs)[1]);
    }

    attributes.Speed          = source.speed;
    attributes.AnimationSpeed = source.animation_speed;
    attributes.Charmable      = source.charmable;
    if (source.render)
    {
        attributes.EntityFlags  = source.render->entity_flags;
        attributes.AnimationSub = source.render->animation_sub;
        if (source.render->animation)
        {
            attributes.Animation = yaml::resolveEnum(source.render->animation);
        }

        attributes.Moving = source.render->moving;
        if (source.render->look)
        {
            attributes.Look = shared::toLookFields(*source.render->look, context);
        }

        attributes.NameVis    = source.render->name_vis;
        attributes.NamePrefix = source.render->name_prefix;
        attributes.ModelSize  = source.render->model_size;
        attributes.Hitbox     = source.render->hitbox;
    }

    if (source.behaviors)
    {
        if (source.behaviors->flags)
        {
            attributes.Behavior = yaml::resolveFlags(source.behaviors->flags);
        }

        attributes.Aggressive    = source.behaviors->aggressive;
        attributes.Links         = source.behaviors->links;
        attributes.TrueDetection = source.behaviors->true_detection;
    }
    attributes.Resists = convertResists(source.resists);
    if (source.resists && source.resists->immune_status)
    {
        attributes.Immune = yaml::resolveFlags(source.resists->immune_status);
    }

    attributes.Mods    = yaml::resolveKeys(source.mods);
    attributes.MobMods = yaml::resolveKeys(source.mob_mods);
    return attributes;
}

auto convertAttributes(const std::optional<shared::MobAttributes>& source, const std::string_view context) -> MobAttributesOverrides
{
    if (!source)
    {
        return {};
    }

    return convertAttributes(*source, context);
}

} // namespace xi::data
