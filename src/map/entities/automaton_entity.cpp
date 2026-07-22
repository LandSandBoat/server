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

#include "automaton_entity.h"

#include "action/action.h"
#include "ai/ai_container.h"
#include "ai/controllers/automaton_controller.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "common/tracy.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "enums/automaton.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/mobutils.h"
#include "utils/puppetutils.h"

CAutomatonEntity::CAutomatonEntity(uint32 petID)
: CPetEntity(PET_TYPE::AUTOMATON, petID)
{
    TracyZoneScoped;

    PAI->SetController(nullptr);
}

CAutomatonEntity::~CAutomatonEntity()
{
    TracyZoneScoped;
}

auto CAutomatonEntity::frame() const -> AutomatonFrame
{
    return equip_.frame;
}

auto CAutomatonEntity::head() const -> AutomatonHead
{
    return equip_.head;
}

uint8 CAutomatonEntity::attachment(const uint8 slotid) const
{
    return equip_.attachments[slotid];
}

auto CAutomatonEntity::hasAttachment(const uint8 attachment) const -> bool
{
    for (auto&& attachmentid : equip_.attachments)
    {
        if (attachmentid == attachment)
        {
            return true;
        }
    }
    return false;
}

void CAutomatonEntity::setEquip(const AutomatonEquip& equip)
{
    equip_ = equip;
}

void CAutomatonEntity::burdenTick()
{
    for (auto&& burden : burden_)
    {
        if (burden > 0)
        {
            burden -= std::clamp<uint8>(1 + PMaster->getMod(Mod::BURDEN_DECAY) + this->getMod(Mod::BURDEN_DECAY), 1, burden);
        }
    }
}

auto CAutomatonEntity::burden() const -> const std::array<uint8, 8>&
{
    return burden_;
}

void CAutomatonEntity::setAllBurden(const uint8 burden)
{
    burden_.fill(burden);
}

void CAutomatonEntity::setBurdenArray(const std::array<uint8, 8> burdenArray)
{
    burden_ = burdenArray;
}

auto CAutomatonEntity::addBurden(const uint8 element, int8 burden) -> uint8
{
    // Handle Kenkonken Suppress Overload
    if (PMaster->getMod(Mod::SUPPRESS_OVERLOAD) > 0)
    {
        // TODO: Retail research, this is a best guess
        burden /= 3;
    }

    burden_[element] = std::clamp(burden_[element] + burden, 0, 255);

    if (burden > 0)
    {
        // check for overload
        const int16 thresh = 30 + PMaster->getMod(Mod::OVERLOAD_THRESH);
        if (burden_[element] > thresh)
        {
            if (xirand::GetRandomNumber(100) < (burden_[element] - thresh + 5))
            {
                // return overload duration
                return burden_[element] - thresh;
            }
        }
    }
    return 0;
}

auto CAutomatonEntity::overloadChance(const uint8 element) const -> uint8
{
    const int16 thresh = 30 + PMaster->getMod(Mod::OVERLOAD_THRESH);

    return std::clamp(burden_[element] - thresh + 5, 0, 255);
}

void CAutomatonEntity::PostTick()
{
    auto pre_mask = updatemask;
    CPetEntity::PostTick();
    if (pre_mask && status != xi::Status::Disappear)
    {
        if (PMaster && PMaster->objtype == TYPE_PC)
        {
            charutils::SendExtendedJobPackets(static_cast<CCharEntity*>(PMaster));
        }
    }
}

void CAutomatonEntity::Die()
{
    if (PMaster != nullptr)
    {
        PMaster->StatusEffectContainer->RemoveAllManeuvers();
    }
    CPetEntity::Die();
}

bool CAutomatonEntity::ValidTarget(CBattleEntity* PInitiator, uint16 targetFlags)
{
    if (targetFlags & TARGET_PLAYER && this == PInitiator)
    {
        return true;
    }
    return CPetEntity::ValidTarget(PInitiator, targetFlags);
}

void CAutomatonEntity::OnCastFinished(CMagicState& state, action_t& action)
{
    CMobEntity::OnCastFinished(state, action);

    auto* PSpell  = state.GetSpell();
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    PRecastContainer->Add(RECAST_MAGIC, static_cast<Recast>(PSpell->getID()), action.recast);

    if (PSpell->tookEffect())
    {
        puppetutils::TrySkillUP(this, xi::SkillType::AutomatonMagic, PTarget->GetMLevel());

        if (PTarget && PTarget->objtype == TYPE_MOB && PTarget->allegiance != xi::Allegiance::Player)
        {
            auto* PMob    = static_cast<CMobEntity*>(PTarget);
            auto* PMaster = dynamic_cast<CBattleEntity*>(this->PMaster);
            if (PMaster && PMaster->objtype == TYPE_PC)
            {
                PMob->PEnmityContainer->AddBaseEnmity(PMaster);
            }
        }
    }
}

void CAutomatonEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    CMobEntity::OnMobSkillFinished(state, action);

    auto* PSkill  = state.GetSkill();
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    if (PTarget && PTarget->objtype == TYPE_MOB && PTarget->allegiance != xi::Allegiance::Player)
    {
        auto* PMob    = static_cast<CMobEntity*>(PTarget);
        auto* PMaster = dynamic_cast<CBattleEntity*>(this->PMaster);
        if (PMaster && PMaster->objtype == TYPE_PC)
        {
            PMob->PEnmityContainer->AddBaseEnmity(PMaster);
        }
    }

    // Ranged attack skill up
    if (PSkill->getID() == 1949 && !PSkill->hasMissMsg())
    {
        puppetutils::TrySkillUP(this, xi::SkillType::AutomatonRanged, PTarget->GetMLevel());
    }
}

void CAutomatonEntity::Spawn()
{
    status = allegiance == xi::Allegiance::Mob ? xi::Status::Update : xi::Status::Normal;
    updatemask |= UPDATE_HP;
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", this);
    animation = xi::Animation::None;
    m_OwnerID.clean();
    HideName(false);
    luautils::OnMobSpawn(this);
}
