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

#include "magic_state.h"

#include "../ai_container.h"
#include "../../spell.h"
#include "../../status_effect_container.h"
#include "../../enmity_container.h"
#include "../../entities/battleentity.h"
#include "../../entities/mobentity.h"
#include "../../lua/luautils.h"
#include "../../utils/battleutils.h"
#include "../../packets/action.h"
#include "../../packets/message_basic.h"
#include "../../../common/utils.h"

CMagicState::CMagicState(CBattleEntity* PEntity, uint16 targid, SpellID spellid, uint8 flags) :
    CState(PEntity, targid),
    m_PEntity(PEntity),
    m_PSpell(nullptr),
    m_flags(flags)
{
    auto PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(spellid), 0, MSGBASIC_CANNOT_CAST_SPELL));
    }

    m_PSpell = PSpell->clone();

    auto PTarget = m_PEntity->IsValidTarget(m_targid, m_PSpell->getValidTarget(), m_errorMsg);
    if (!PTarget || m_errorMsg)
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    if (!CanCastSpell(PTarget))
    {
        throw CStateInitException(std::move(m_errorMsg));
    }

    auto errorMsg = luautils::OnMagicCastingCheck(m_PEntity, PTarget, GetSpell());
    if (errorMsg)
    {
        throw CStateInitException(std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, errorMsg == 1 ? MSGBASIC_CANNOT_CAST_SPELL : errorMsg));
    }

    m_castTime = std::chrono::milliseconds(battleutils::CalculateSpellCastTime(m_PEntity, this));
    m_startPos = m_PEntity->loc.p;

    action_t action;
    action.id = m_PEntity->id;
    action.spellgroup = m_PSpell->getSpellGroup();
    action.actiontype = ACTION_MAGIC_START;

    actionList_t& actionList = action.getNewActionList();
    actionList.ActionTargetID = PTarget->id;

    actionTarget_t& actionTarget = actionList.getNewActionTarget();

    actionTarget.reaction = REACTION_NONE;
    actionTarget.speceffect = SPECEFFECT_NONE;
    actionTarget.animation = 0;
    actionTarget.param = static_cast<uint16>(m_PSpell->getID());
    actionTarget.messageID = 327; // starts casting
    m_PEntity->PAI->EventHandler.triggerListener("MAGIC_START", m_PEntity, m_PSpell.get(), &action); //TODO: weaponskill lua object

    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
}

bool CMagicState::Update(time_point tick)
{
    if (tick > GetEntryTime() + m_castTime && !IsCompleted())
    {
        auto PTarget = m_PEntity->IsValidTarget(m_targid, m_PSpell->getValidTarget(), m_errorMsg);
        MSGBASIC_ID msg = MSGBASIC_IS_INTERRUPTED;

        action_t action;

        if (!PTarget || m_errorMsg || (HasMoved() && (m_PEntity->objtype != TYPE_PET ||
            static_cast<CPetEntity*>(m_PEntity)->getPetType() != PETTYPE_AUTOMATON)) || !CanCastSpell(PTarget))
        {
            m_interrupted = true;
        }
        else if (battleutils::IsParalyzed(m_PEntity))
        {
            msg = MSGBASIC_IS_PARALYZED;
            m_interrupted = true;
        }
        else if (battleutils::IsIntimidated(m_PEntity, static_cast<CBattleEntity*>(PTarget)))
        {
            msg = MSGBASIC_IS_INTIMIDATED;
            m_interrupted = true;
        }

        if (m_interrupted)
        {
            m_PEntity->OnCastInterrupted(*this, action, msg);
        }
        else
        {
            m_PEntity->OnCastFinished(*this,action);
            m_PEntity->PAI->EventHandler.triggerListener("MAGIC_USE", m_PEntity, PTarget, m_PSpell.get(), &action);
            PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", PTarget, m_PEntity, m_PSpell.get(), &action);
        }

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
            
        Complete();
    }
    else if (IsCompleted() && tick > GetEntryTime() + m_castTime + std::chrono::milliseconds(m_PSpell->getAnimationTime()))
    {
        m_PEntity->PAI->EventHandler.triggerListener("MAGIC_STATE_EXIT", m_PEntity, m_PSpell.get());
        return true;
    }
    return false;
}

void CMagicState::Cleanup(time_point tick)
{
    if (!IsCompleted())
    {
        action_t action;
        m_PEntity->OnCastInterrupted(*this, action, MSGBASIC_IS_INTERRUPTED);
        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, new CActionPacket(action));
    }
}

bool CMagicState::CanChangeState()
{
    return false;
}

CSpell* CMagicState::GetSpell()
{
    return m_PSpell.get();
}

bool CMagicState::CanCastSpell(CBattleEntity* PTarget)
{
    auto ret = m_PEntity->CanUseSpell(GetSpell());

    if (!ret)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_CAST_SPELL);
        return ret;
    }
    if (!m_PEntity->loc.zone->CanUseMisc(m_PSpell->getZoneMisc()))
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return false;
    }
    if (m_PEntity->StatusEffectContainer->HasStatusEffect({EFFECT_SILENCE, EFFECT_MUTE, EFFECT_OMERTA}))
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_UNABLE_TO_CAST_SPELLS);
        return false;
    }
    if (!HasCost())
    {
        return false;
    }
    if (!PTarget)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_ON_THAT_TARG);
        return false;
    }
    if (PTarget->IsNameHidden())
    {
        return false;
    }
    if (distance(m_PEntity->loc.p, PTarget->loc.p) > 40)
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_TOO_FAR_AWAY);
        return false;
    }
    if (m_PEntity->objtype == TYPE_PC && distance(m_PEntity->loc.p, PTarget->loc.p) > m_PSpell->getRange())
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_OUT_OF_RANGE_UNABLE_CAST);
        return false;
    }
    if (dynamic_cast<CMobEntity*>(m_PEntity))
    {
        if (distanceSquared(m_PEntity->loc.p, PTarget->loc.p) > square(28.5f))
        {
            return false;
        }
    }
    if (!m_PEntity->PAI->TargetFind->canSee(&PTarget->loc.p))
    {
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_PERFORM_ACTION);
        return false;
    }
    return true;
}

bool CMagicState::HasCost()
{
    if (m_PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU)
    {
        if (m_PEntity->objtype == TYPE_PC && !(m_flags & MAGICFLAGS_IGNORE_TOOLS) && !battleutils::HasNinjaTool(m_PEntity, GetSpell(), false))
        {
            m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_NO_NINJA_TOOLS);
            return false;
        }
    }
    // check has mp available
    else if (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT) &&
        !(m_flags & MAGICFLAGS_IGNORE_MP) && battleutils::CalculateSpellCost(m_PEntity, GetSpell()) > m_PEntity->health.mp)
    {
        if (m_PEntity->objtype == TYPE_MOB && m_PEntity->health.maxmp == 0)
        {
            ShowWarning("CMagicState::ValidCast Mob (%u) tried to cast magic with no mp!\n", m_PEntity->id);
        }
        m_errorMsg = std::make_unique<CMessageBasicPacket>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_NOT_ENOUGH_MP);
        return false;
    }
    return true;
}

void CMagicState::SpendCost()
{
    if (m_PSpell->getSpellGroup() == SPELLGROUP_NINJUTSU)
    {
        if (!(m_flags & MAGICFLAGS_IGNORE_TOOLS))
        {
            // handle ninja tools
            battleutils::HasNinjaTool(m_PEntity, GetSpell(), true);
        }
    }
    else if (m_PSpell->hasMPCost() && !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_MANAFONT) && !(m_flags & MAGICFLAGS_IGNORE_MP))
    {
        int16 cost = battleutils::CalculateSpellCost(m_PEntity, GetSpell());

        // conserve mp
        int16 rate = m_PEntity->getMod(Mod::CONSERVE_MP);

        if (tpzrand::GetRandomNumber(100) < rate)
        {
            cost = (int16)(cost * (tpzrand::GetRandomNumber(8.f, 16.f) / 16.0f));
        }

        m_PEntity->addMP(-cost);
    }
}

uint32 CMagicState::GetRecast()
{
    uint32 RecastTime = 0;

    if (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL) &&
        !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SPONTANEITY) &&
        !m_instantCast)
    {
        RecastTime = battleutils::CalculateSpellRecastTime(m_PEntity, GetSpell());
    }
    return RecastTime;
}

void CMagicState::ApplyEnmity(CBattleEntity* PTarget, int ce, int ve)
{
    bool enmityApplied = false;

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TRANQUILITY) && m_PSpell->getSpellGroup() == SPELLGROUP_WHITE)
    {
        m_PEntity->addModifier(Mod::ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_TRANQUILITY)->GetPower());
    }
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_EQUANIMITY) && m_PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        m_PEntity->addModifier(Mod::ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_EQUANIMITY)->GetPower());
    }
    if (m_PSpell->isNa())
    {
        m_PEntity->addModifier(Mod::ENMITY, -(m_PEntity->getMod(Mod::DIVINE_BENISON) >> 1)); // Half of divine benison mod amount = -enmity
    }

    if (PTarget != nullptr)
    {
        if (PTarget->objtype == TYPE_MOB && PTarget->allegiance != m_PEntity->allegiance)
        {
            if (auto mob = dynamic_cast<CMobEntity*>(PTarget))
            {
                if (PTarget->isDead())
                {
                    mob->m_DropItemTime = m_PSpell->getAnimationTime();
                }

                if (!(m_PSpell->isHeal()) || m_PSpell->tookEffect())  //can't claim mob with cure unless it does damage
                {
                    mob->PEnmityContainer->UpdateEnmity(m_PEntity, ce, ve);
                    enmityApplied = true;
                    if (PTarget->isDead())
                    { // claim mob only on death (for aoe)
                        battleutils::ClaimMob(PTarget, m_PEntity);
                    }
                    battleutils::DirtyExp(PTarget, m_PEntity);
                }
            }
        }
        else if (PTarget->allegiance == m_PEntity->allegiance)
        {
            battleutils::GenerateInRangeEnmity(m_PEntity, ce, ve);
            enmityApplied = true;
        }
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_TRANQUILITY) && m_PSpell->getSpellGroup() == SPELLGROUP_WHITE)
    {
        m_PEntity->delModifier(Mod::ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_TRANQUILITY)->GetPower());
        if (enmityApplied)
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_TRANQUILITY);
    }
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_EQUANIMITY) && m_PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        m_PEntity->delModifier(Mod::ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_EQUANIMITY)->GetPower());
        if (enmityApplied)
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_EQUANIMITY);
    }
    if (m_PSpell->isNa())
    {
        m_PEntity->delModifier(Mod::ENMITY, -(m_PEntity->getMod(Mod::DIVINE_BENISON) >> 1)); // Half of divine benison mod amount = -enmity
    }
}

bool CMagicState::HasMoved()
{
    return floorf(m_startPos.x * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.x * 10 + 0.5f) / 10 ||
        floorf(m_startPos.z * 10 + 0.5f) / 10 != floorf(m_PEntity->loc.p.z * 10 + 0.5f) / 10;
}

void CMagicState::TryInterrupt(CBattleEntity* PAttacker)
{
    if (battleutils::TryInterruptSpell(PAttacker, m_PEntity, m_PSpell.get()))
    {
        m_interrupted = true;
    }
}
