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

#include "status_effect.h"
#include "entities/battle_entity.h"
#include "entities/char_entity.h"

#include "status_effect_container.h"
#include <utility>

CStatusEffect::CStatusEffect(xi::StatusEffect id, uint16 icon, uint16 power, timer::duration tick, timer::duration duration, uint32 subid, uint16 subPower, uint16 subIcon, uint16 tier, xi::StatusEffectFlag flags, uint16 sourceType, uint32 sourceTypeParam, uint32 originID, uint8 slot)
: statusID_(id)
, subID_(subid)
, icon_(icon)
, power_(power)
, subPower_(subPower)
, subIcon_(subIcon)
, tier_(tier)
, flags_(flags)
, originID_(originID)
, sourceType_(sourceType)
, sourceTypeParam_(sourceTypeParam)
, slot_(slot)
, tickTime_(tick)
, duration_(duration)
{
    if (tickTime_ < 3s && tickTime_ != 0s)
    {
        ShowWarning("Status Effect tick time less than 3s is no longer supported.  Effect ID: %d", static_cast<uint16>(id));
    }

    // Reserve space in the modlist so we don't risk it growing
    modList_.reserve(8);
}

CStatusEffect::~CStatusEffect() = default;

auto CStatusEffect::modList() -> std::vector<CModifier>&
{
    return modList_;
}

auto CStatusEffect::isDeleted() const -> bool
{
    return deleted_;
}

auto CStatusEffect::markDeleted() -> void
{
    deleted_ = true;
}

auto CStatusEffect::GetName() const -> const std::string&
{
    return name_;
}

auto CStatusEffect::SetOwner(CBattleEntity* owner) -> void
{
    owner_ = owner;
}

auto CStatusEffect::MarkPersistDirty() const -> void
{
    if (owner_ != nullptr && owner_->objtype == TYPE_PC)
    {
        static_cast<CCharEntity*>(owner_)->setPersist(CharPersist::Effects);
    }
}

auto CStatusEffect::GetStatusID() const -> xi::StatusEffect
{
    return statusID_;
}

auto CStatusEffect::GetOwner() const -> CBattleEntity*
{
    return owner_;
}

auto CStatusEffect::GetSubID() const -> uint32
{
    return subID_;
}

auto CStatusEffect::GetSourceType() const -> uint16
{
    return sourceType_;
}

auto CStatusEffect::GetSourceTypeParam() const -> uint32
{
    return sourceTypeParam_;
}

auto CStatusEffect::GetOriginID() const -> uint32
{
    return originID_;
}

auto CStatusEffect::GetEffectType() const -> uint16
{
    return type_;
}

auto CStatusEffect::GetEffectSlot() const -> uint8
{
    return slot_;
}

auto CStatusEffect::GetIcon() const -> uint16
{
    return icon_;
}

auto CStatusEffect::GetPower() const -> uint16
{
    return power_;
}

auto CStatusEffect::GetSubPower() const -> uint16
{
    return subPower_;
}

auto CStatusEffect::GetSubIcon() const -> uint16
{
    return subIcon_;
}

auto CStatusEffect::GetTier() const -> uint16
{
    return tier_;
}

auto CStatusEffect::GetEffectFlags() const -> xi::StatusEffectFlag
{
    return flags_;
}

auto CStatusEffect::GetTickTime() const -> timer::duration
{
    return tickTime_;
}

auto CStatusEffect::GetDuration() const -> timer::duration
{
    return duration_;
}

auto CStatusEffect::GetElapsedTickCount() const -> int
{
    return tickCount_;
}

auto CStatusEffect::GetStartTime() const -> timer::time_point
{
    return startTime_;
}

auto CStatusEffect::SetEffectFlags(xi::StatusEffectFlag flags) -> void
{
    flags_ = flags;
    MarkPersistDirty();
}

auto CStatusEffect::AddEffectFlag(xi::StatusEffectFlag flag) -> void
{
    flags_ |= flag;
    MarkPersistDirty();
}

auto CStatusEffect::DelEffectFlag(xi::StatusEffectFlag flag) -> void
{
    flags_ &= ~flag;
    MarkPersistDirty();
}

auto CStatusEffect::HasEffectFlag(xi::StatusEffectFlag flag) const -> bool
{
    return (flags_ & flag) != xi::StatusEffectFlag::None;
}

auto CStatusEffect::SetIcon(uint16 icon) -> void
{
    if (owner_ == nullptr)
    {
        ShowWarning("owner_ was null.");
        return;
    }

    icon_ = icon;
    MarkPersistDirty();
    owner_->StatusEffectContainer->UpdateStatusIcons();
}

auto CStatusEffect::SetSubIcon(uint16 subIcon) -> void
{
    if (owner_ == nullptr)
    {
        ShowWarning("owner_ was null.");
        return;
    }
    subIcon_ = subIcon;
    owner_->StatusEffectContainer->UpdateStatusIcons();
}

auto CStatusEffect::SetSource(uint16 sourceType, uint32 sourceTypeParam) -> void
{
    sourceType_      = sourceType;
    sourceTypeParam_ = sourceTypeParam;
    MarkPersistDirty();
}

auto CStatusEffect::SetOriginID(uint32 originID) -> void
{
    originID_ = originID;
    MarkPersistDirty();
}

auto CStatusEffect::SetEffectType(uint16 type) -> void
{
    type_ = type;
}

auto CStatusEffect::SetEffectSlot(uint8 slot) -> void
{
    slot_ = slot;
}

auto CStatusEffect::SetPower(uint16 power) -> void
{
    power_ = power;
    MarkPersistDirty();
}

auto CStatusEffect::SetSubPower(uint16 subPower) -> void
{
    subPower_ = subPower;
    MarkPersistDirty();
}

auto CStatusEffect::SetTier(uint16 tier) -> void
{
    tier_ = tier;
    MarkPersistDirty();
}

auto CStatusEffect::SetDuration(timer::duration duration) -> void
{
    duration_ = duration;
    MarkPersistDirty();
}

auto CStatusEffect::SetStartTime(timer::time_point startTime) -> void
{
    tickCount_ = 0;
    startTime_ = startTime;
    MarkPersistDirty();
}

auto CStatusEffect::SetTickTime(timer::duration tick) -> void
{
    tickTime_ = tick;
    MarkPersistDirty();
}

auto CStatusEffect::IncrementElapsedTickCount() -> void
{
    ++tickCount_;
}

auto CStatusEffect::SetEffectName(std::string name) -> void
{
    name_ = std::move(name);
}

auto CStatusEffect::addMod(xi::Mod modType, int16 amount) -> void
{
    // Since an effect's mod list is only applied to entity when adding the effect
    // we need to add the mod to the entity manually if the effect is already applied
    if (owner_)
    {
        owner_->addModifier(modType, amount);
    }

    for (auto& i : modList_)
    {
        if (i.getModID() == modType)
        {
            i.setModAmount(i.getModAmount() + amount);
            return;
        }
    }
    modList_.emplace_back(modType, amount);
}

auto CStatusEffect::setMod(xi::Mod modType, int16 value) -> void
{
    for (auto& i : modList_)
    {
        if (i.getModID() == modType)
        {
            // Since an effect's mod list is only applied to entity when adding the effect
            // we need to add the mod to the entity manually if the effect is already applied
            if (owner_)
            {
                owner_->addModifier(modType, value - i.getModAmount());
            }

            i.setModAmount(value);
            return;
        }
    }
    modList_.emplace_back(modType, value);

    // Since an effect's mod list is only applied to entity when adding the effect
    // we need to add the mod to the entity manually if the effect is already applied
    if (owner_)
    {
        owner_->addModifier(modType, value);
    }
}
