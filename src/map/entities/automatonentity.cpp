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

#include "automatonentity.h"

#include "ai/ai_container.h"
#include "ai/controllers/automaton_controller.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "common/tracy.h"
#include "common/utils.h"
#include "mob_modifier.h"
#include "packets/action.h"
#include "packets/char_job_extra.h"
#include "packets/entity_update.h"
#include "packets/pet_sync.h"
#include "recast_container.h"
#include "status_effect_container.h"
#include "utils/mobutils.h"
#include "utils/puppetutils.h"

CAutomatonEntity::CAutomatonEntity()
: CPetEntity(PET_TYPE::AUTOMATON)
{
    TracyZoneScoped;
    PAI->SetController(nullptr);
}

CAutomatonEntity::~CAutomatonEntity()
{
    TracyZoneScoped;
}

AUTOFRAMETYPE CAutomatonEntity::getFrame() const
{
    return (AUTOFRAMETYPE)m_Equip.Frame;
}

AUTOHEADTYPE CAutomatonEntity::getHead() const
{
    return (AUTOHEADTYPE)m_Equip.Head;
}

uint8 CAutomatonEntity::getAttachment(uint8 slotid)
{
    return m_Equip.Attachments[slotid];
}

bool CAutomatonEntity::hasAttachment(uint8 attachment)
{
    for (auto&& attachmentid : m_Equip.Attachments)
    {
        if (attachmentid == attachment)
        {
            return true;
        }
    }
    return false;
}

uint8 CAutomatonEntity::getElementMax(uint8 element)
{
    return m_ElementMax[element];
}

uint8 CAutomatonEntity::getElementCapacity(uint8 element)
{
    return m_ElementEquip[element];
}

void CAutomatonEntity::burdenTick()
{
    for (auto&& burden : m_Burden)
    {
        if (burden > 0)
        {
            burden -= std::clamp<uint8>(1 + PMaster->getMod(Mod::BURDEN_DECAY) + this->getMod(Mod::BURDEN_DECAY), 1, burden);
        }
    }
}

auto CAutomatonEntity::getBurden() -> std::array<uint8, 8>
{
    return m_Burden;
}

void CAutomatonEntity::setAllBurden(uint8 burden)
{
    m_Burden.fill(burden);
}

void CAutomatonEntity::setBurdenArray(std::array<uint8, 8> burdenArray)
{
    m_Burden = burdenArray;
}

uint8 CAutomatonEntity::addBurden(uint8 element, int8 burden)
{
    // Handle Kenkonken Suppress Overload
    if (PMaster->getMod(Mod::SUPPRESS_OVERLOAD) > 0)
    {
        // TODO: Retail research, this is a best guess
        burden /= 3;
    }

    m_Burden[element] = std::clamp(m_Burden[element] + burden, 0, 255);

    if (burden > 0)
    {
        // check for overload
        int16 thresh = 30 + PMaster->getMod(Mod::OVERLOAD_THRESH);
        if (m_Burden[element] > thresh)
        {
            if (xirand::GetRandomNumber(100) < (m_Burden[element] - thresh + 5))
            {
                // return overload duration
                return m_Burden[element] - thresh;
            }
        }
    }
    return 0;
}

uint8 CAutomatonEntity::getOverloadChance(uint8 element)
{
    int16 thresh = 30 + PMaster->getMod(Mod::OVERLOAD_THRESH);

    return std::clamp(m_Burden[element] - thresh + 5, 0, 255);
}

void CAutomatonEntity::PostTick()
{
    auto pre_mask = updatemask;
    CPetEntity::PostTick();
    if (pre_mask && status != STATUS_TYPE::DISAPPEAR)
    {
        if (PMaster && PMaster->objtype == TYPE_PC)
        {
            ((CCharEntity*)PMaster)->pushPacket<CCharJobExtraPacket>((CCharEntity*)PMaster, PMaster->GetMJob() == JOB_PUP);
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

    PRecastContainer->Add(RECAST_MAGIC, static_cast<uint16>(PSpell->getID()), action.recast);

    if (PSpell->tookEffect())
    {
        puppetutils::TrySkillUP(this, SKILL_AUTOMATON_MAGIC, PTarget->GetMLevel());
    }
}

void CAutomatonEntity::OnMobSkillFinished(CMobSkillState& state, action_t& action)
{
    CMobEntity::OnMobSkillFinished(state, action);

    auto* PSkill  = state.GetSkill();
    auto* PTarget = static_cast<CBattleEntity*>(state.GetTarget());

    // Ranged attack skill up
    if (PSkill->getID() == 1949 && !PSkill->hasMissMsg())
    {
        puppetutils::TrySkillUP(this, SKILL_AUTOMATON_RANGED, PTarget->GetMLevel());
    }
}

void CAutomatonEntity::Spawn()
{
    status = allegiance == ALLEGIANCE_TYPE::MOB ? STATUS_TYPE::UPDATE : STATUS_TYPE::NORMAL;
    updatemask |= UPDATE_HP;
    PAI->Reset();
    PAI->EventHandler.triggerListener("SPAWN", CLuaBaseEntity(this));
    animation = ANIMATION_NONE;
    m_OwnerID.clean();
    HideName(false);
    luautils::OnMobSpawn(this);
}
