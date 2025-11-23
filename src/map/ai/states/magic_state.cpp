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

#include "action/action.h"
#include "action/interrupts.h"
#include "ai/ai_container.h"
#include "ai/controllers/pet_controller.h"
#include "ai/states/inactive_state.h"
#include "common/utils.h"
#include "enmity_container.h"
#include "entities/battleentity.h"
#include "entities/mobentity.h"
#include "job_points.h"
#include "lua/luautils.h"
#include "mob_modifier.h"
#include "packets/s2c/0x028_battle2.h"
#include "packets/s2c/0x029_battle_message.h"
#include "spell.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"

CMagicState::CMagicState(CBattleEntity* PEntity, uint16 targid, SpellID spellid, uint8 flags)
: CState(PEntity, targid)
, m_PEntity(PEntity)
, m_PSpell(nullptr)
, m_flags(flags)
{
    if (auto PMob = dynamic_cast<CMobEntity*>(m_PEntity))
    {
        if (PMob->getMobMod(MOBMOD_NO_SPELL_COST) > 0)
        {
            m_flags |= MAGICFLAGS_IGNORE_MP;
        }
    }

    auto* PSpell = spell::GetSpell(spellid);
    if (PSpell == nullptr)
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(spellid), 0, MSGBASIC_CANNOT_CAST_SPELL));
    }

    m_PSpell = PSpell->clone();

    auto* PTarget = m_PEntity->IsValidTarget(m_targid, m_PSpell->getValidTarget(), m_errorMsg);
    if (!PTarget || this->HasErrorMsg())
    {
        if (this->HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }

    if (!CanCastSpell(PTarget, false))
    {
        if (HasErrorMsg())
        {
            throw CStateInitException(m_errorMsg->copy());
        }
        else
        {
            throw CStateInitException(std::make_unique<CBasicPacket>());
        }
    }

    auto errorMsg = luautils::OnMagicCastingCheck(m_PEntity, PTarget, GetSpell());
    if (errorMsg)
    {
        throw CStateInitException(std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, errorMsg == 1 ? MSGBASIC_CANNOT_CAST_SPELL : static_cast<MSGBASIC_ID>(errorMsg)));
    }

    m_castTime = battleutils::CalculateSpellCastTime(m_PEntity, this);
    m_startPos = m_PEntity->loc.p;

    action_t action{
        .actorId    = m_PEntity->id,
        .actiontype = ActionCategory::MagicStart,
        .actionid   = static_cast<uint32_t>(m_PSpell->getFourCC()),
        .spellgroup = m_PSpell->getSpellGroup(),
        .targets    = {
            {
                   .actorId = PTarget->id,
                   .results = {
                    {
                           .param     = static_cast<int32_t>(m_PSpell->getID()),
                           .messageID = PEntity->objtype != TYPE_PC ? MSGBASIC_STARTS_CASTING_SELF : MSGBASIC_STARTS_CASTING_TARGET,
                    },
                },
            },
        },
    };

    // TODO: weaponskill lua object
    m_PEntity->PAI->EventHandler.triggerListener("MAGIC_START", m_PEntity, m_PSpell.get(), &action);

    // if spell:setFlag(xi.magic.spellFlag.NO_START_MSG) is called, don't give spell start packet
    if (GetSpell()->getFlag() & SPELLFLAG_NO_START_MSG)
    {
        action.ForEachResult([&](action_result_t& result)
                             {
                                 result.messageID = MSGBASIC_NONE;
                             });
    }

    m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));
}

bool CMagicState::Update(timer::time_point tick)
{
    action_t    action;
    auto*       PTarget = m_PEntity->IsValidTarget(m_targid, m_PSpell->getValidTarget(), m_errorMsg);
    MSGBASIC_ID msg     = MSGBASIC_IS_INTERRUPTED;

    auto isTargetValid = [&]()
    {
        // m_PEntity->IsValidTarget checks if the target is dead and returns nullptr if so, so we don't need to duplicate it here.
        if (!PTarget || m_errorMsg)
        {
            return false;
        }

        // Check hide if we're a mob and the target isn't ourselves
        if (PTarget && PTarget->id != m_PEntity->id && m_PEntity->objtype == TYPE_MOB)
        {
            if (auto petController = dynamic_cast<CMobController*>(m_PEntity->PAI->GetController()))
            {
                if (petController->CheckHide(PTarget)) // Returns true if cant detect target
                {
                    return false;
                }
            }
        }
        return true;
    };

    // Check if target is still valid during mid-cast (mostly to check if the target has died and to cancel.)
    if (!IsCompleted())
    {
        if (!isTargetValid())
        {
            // guessed, but cancels correctly.
            m_PEntity->OnCastInterrupted(*this, action, msg, false);
            m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));

            Complete();
            return false;
        }
    }

    if (tick > GetEntryTime() + m_castTime && !IsCompleted())
    {
        // CanCastSpell also does a range check which we don't want to check during midcast - mobs don't cancel spells during casting for being out of range
        if (!isTargetValid() || !CanCastSpell(PTarget, true) || HasMoved())
        {
            m_PEntity->OnCastInterrupted(*this, action, msg, false);

            Complete();
            return false;
        }
        else if (PTarget->objtype == TYPE_PC)
        {
            CCharEntity* PChar = dynamic_cast<CCharEntity*>(PTarget);
            if (PChar->m_Locked)
            {
                m_PEntity->OnCastInterrupted(*this, action, msg, true);

                Complete();
                return false;
            }

            if (m_PSpell.get()->getSpellGroup() == SPELLGROUP_TRUST)
            {
                if (!luautils::OnTrustSpellCastCheckBattlefieldTrusts(PChar))
                {
                    m_PEntity->OnCastInterrupted(*this, action, MSGBASIC_TRUST_NO_CAST_TRUST, true);
                    action.recast = 2s; // seems hardcoded to 2

                    Complete();
                    return false;
                }
            }
        }
        else if (PTarget->objtype == TYPE_PET)
        {
            CPetEntity*  PPet  = dynamic_cast<CPetEntity*>(PTarget);
            CCharEntity* PChar = dynamic_cast<CCharEntity*>(PPet->PMaster);

            if (PChar == nullptr)
            {
                return false;
            }

            if (PChar->m_Locked)
            {
                m_PEntity->OnCastInterrupted(*this, action, msg, true);

                Complete();
                return false;
            }
        }

        // Super Jump or otherwise untargetable
        if (PTarget->PAI->IsUntargetable())
        {
            m_PEntity->OnCastInterrupted(*this, action, msg, true);

            Complete();
            return false;
        }

        if (battleutils::IsParalyzed(m_PEntity))
        {
            ActionInterrupts::MagicParalyzed(m_PEntity, m_PSpell.get(), PTarget);
            Complete();
            return false;
        }

        if (battleutils::IsIntimidated(m_PEntity, PTarget))
        {
            ActionInterrupts::MagicIntimidated(m_PEntity, m_PSpell.get(), PTarget);
            Complete();
            return false;
        }

        if (m_interrupted)
        {
            m_PEntity->OnCastInterrupted(*this, action, msg, false);
            m_PEntity->PAI->EventHandler.triggerListener("MAGIC_INTERRUPTED", m_PEntity, PTarget, m_PSpell.get(), &action);
        }
        else
        {
            m_PEntity->OnCastFinished(*this, action);
            m_PEntity->PAI->EventHandler.triggerListener("MAGIC_USE", m_PEntity, PTarget, m_PSpell.get(), &action);
            PTarget->PAI->EventHandler.triggerListener("MAGIC_TAKE", PTarget, m_PEntity, m_PSpell.get(), &action);
        }

        // Zero messageID so spells dont emit messages
        if (GetSpell()->getFlag() & SPELLFLAG_NO_FINISH_MSG)
        {
            action.ForEachResult([&](action_result_t& result)
                                 {
                                     result.messageID = MSGBASIC_NONE;
                                 });
        }

        m_PEntity->loc.zone->PushPacket(m_PEntity, CHAR_INRANGE_SELF, std::make_unique<GP_SERV_COMMAND_BATTLE2>(action));

        Complete();
    }
    else if (IsCompleted() && tick > GetEntryTime() + m_castTime + m_PSpell->getAnimationTime())
    {
        if (m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);
            PChar->m_charHistory.spellsCast++;
        }
        m_PEntity->PAI->EventHandler.triggerListener("MAGIC_STATE_EXIT", m_PEntity, m_PSpell.get());
        return true;
    }
    return false;
}

void CMagicState::Cleanup(timer::time_point tick)
{
    if (!IsCompleted())
    {
        action_t action{};
        m_PEntity->OnCastInterrupted(*this, action, MSGBASIC_IS_INTERRUPTED, false);
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

bool CMagicState::CanCastSpell(CBattleEntity* PTarget, bool isEndOfCast)
{
    auto ret = m_PEntity->CanUseSpell(GetSpell());

    if (!ret)
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_CAST_SPELL);
        return ret;
    }

    if (!m_PEntity->loc.zone->CanUseMisc(m_PSpell->getZoneMisc()))
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return false;
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_UNABLE_TO_CAST_SPELLS);
        return false;
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_OMERTA))
    {
        int16 power = m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_OMERTA)->GetPower();
        if ((1 << (m_PSpell->getSpellGroup() - 1)) & power)
        {
            m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_UNABLE_TO_CAST_SPELLS);
            return false;
        }
    }

    if (!HasCost())
    {
        return false;
    }

    if (!PTarget)
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_ON_THAT_TARG);
        return false;
    }

    if (PTarget->IsNameHidden())
    {
        return false;
    }

    if (m_PEntity == PTarget)
    {
        // Remaining checks are distance/visibility checks, which aren't needed if target is self.
        return true;
    }

    if (distance(m_PEntity->loc.p, PTarget->loc.p) > 40)
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_TOO_FAR_AWAY);
        return false;
    }

    if (m_PEntity->objtype == TYPE_PC && distance(m_PEntity->loc.p, PTarget->loc.p) > m_PSpell->getRange())
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_OUT_OF_RANGE_UNABLE_CAST);
        return false;
    }

    if (dynamic_cast<CMobEntity*>(m_PEntity))
    {
        if (!isWithinDistance(m_PEntity->loc.p, PTarget->loc.p, 28.5f))
        {
            return false;
        }
    }

    if (!isEndOfCast && m_PEntity->objtype == TYPE_PC && m_PEntity->loc.zone->CanUseMisc(MISC_LOS_PLAYER_BLOCK) && !m_PEntity->CanSeeTarget(PTarget, false))
    {
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, PTarget, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_CANNOT_PERFORM_ACTION);
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
            m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_NO_NINJA_TOOLS);
            return false;
        }
    }
    // check has mp available
    else if (!battleutils::CanAffordSpell(m_PEntity, GetSpell(), m_flags))
    {
        if (m_PEntity->objtype == TYPE_MOB && m_PEntity->health.maxmp == 0)
        {
            ShowWarning("CMagicState::ValidCast Mob (%u) tried to cast magic with no mp!", m_PEntity->id);
        }
        m_errorMsg = std::make_unique<GP_SERV_COMMAND_BATTLE_MESSAGE>(m_PEntity, m_PEntity, static_cast<uint16>(m_PSpell->getID()), 0, MSGBASIC_NOT_ENOUGH_MP);
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

        // RDM Job Point: Quick Magic Effect
        if (IsInstantCast() && m_PEntity->objtype == TYPE_PC)
        {
            CCharEntity* PChar = static_cast<CCharEntity*>(m_PEntity);

            cost = (int16)(cost * (1.0f - (float)((PChar->PJobPoints->GetJobPointValue(JP_QUICK_MAGIC_EFFECT) * 2) / 100)));
        }

        // conserve mp
        int16 rate = m_PEntity->getMod(Mod::CONSERVE_MP);

        if (xirand::GetRandomNumber(100) < rate)
        {
            cost = (int16)(cost * (xirand::GetRandomNumber(8.0f, 16.0f) / 16.0f));
        }

        m_PEntity->addMP(-cost);
    }
}

timer::duration CMagicState::GetRecast()
{
    if (!m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_CHAINSPELL) && !m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SPONTANEITY) &&
        !m_instantCast)
    {
        return battleutils::CalculateSpellRecastTime(m_PEntity, GetSpell());
    }
    return 0s;
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

    // Subtle Sorcery sets Cumulative Enmity of spells to 0
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_SUBTLE_SORCERY))
    {
        ce = 0;
    }

    // If The player is under the effect of Yonin, the Base Enmity generated by Utsusemi spells is increased.
    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_YONIN) && m_PSpell->getSpellFamily() == SPELLFAMILY_UTSUSEMI)
    {
        ce = 160;
        ve = 480;
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_DIVINE_EMBLEM) && m_PSpell->getSkillType() == SKILL_DIVINE_MAGIC)
    {
        ve = ve * (1.0f + (m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_DIVINE_EMBLEM)->GetPower() / 100.0f));
        ce = ce * (1.0f + (m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_DIVINE_EMBLEM)->GetPower() / 100.0f));
    }

    if (PTarget != nullptr)
    {
        if (PTarget->objtype == TYPE_MOB && PTarget->allegiance != m_PEntity->allegiance)
        {
            if (auto* mob = dynamic_cast<CMobEntity*>(PTarget))
            {
                if (PTarget->isDead())
                {
                    mob->m_DropItemTime = m_PSpell->getAnimationTime();
                }

                if (!(m_PSpell->isHeal()) || m_PSpell->tookEffect()) // can't claim mob with cure unless it does damage
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
        {
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_TRANQUILITY);
        }
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_EQUANIMITY) && m_PSpell->getSpellGroup() == SPELLGROUP_BLACK)
    {
        m_PEntity->delModifier(Mod::ENMITY, -m_PEntity->StatusEffectContainer->GetStatusEffect(EFFECT_EQUANIMITY)->GetPower());

        if (enmityApplied)
        {
            m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_EQUANIMITY);
        }
    }

    if (m_PSpell->isNa())
    {
        m_PEntity->delModifier(Mod::ENMITY, -(m_PEntity->getMod(Mod::DIVINE_BENISON) >> 1)); // Half of divine benison mod amount = -enmity
    }

    if (m_PEntity->StatusEffectContainer->HasStatusEffect(EFFECT_DIVINE_EMBLEM) &&
        m_PSpell->getSkillType() == SKILL_DIVINE_MAGIC &&
        enmityApplied)
    {
        m_PEntity->StatusEffectContainer->DelStatusEffect(EFFECT_DIVINE_EMBLEM);
    }
}

bool CMagicState::HasMoved()
{
    // non-players can't get interrupted via movement due to edge case shenanigans seen from SE
    if (m_PEntity->objtype != TYPE_PC)
    {
        return false;
    }

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

void CMagicState::ApplyMagicCoverEnmity(CBattleEntity* PCoverAbilityTarget, CBattleEntity* PCoverAbilityUser, CMobEntity* PMob)
{
    PMob->PEnmityContainer->UpdateEnmityFromCover(PCoverAbilityTarget, PCoverAbilityUser);
}
