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

#include "automaton_controller.h"
#include "../../../common/utils.h"
#include "../../enmity_container.h"
#include "../../entities/trustentity.h"
#include "../../lua/luautils.h"
#include "../../mobskill.h"
#include "../../recast_container.h"
#include "../../status_effect_container.h"
#include "../../utils/battleutils.h"
#include "../../utils/itemutils.h"
#include "../../utils/petutils.h"
#include "../../utils/puppetutils.h"
#include "../ai_container.h"
#include "../states/ability_state.h"
#include "../states/magic_state.h"
#include "../states/weaponskill_state.h"

CAutomatonController::CAutomatonController(CAutomatonEntity* PPet)
    : CPetController(PPet)
    , PAutomaton(PPet)
{
    PPet->setInitialBurden();
    setCooldowns();
    if (isRanged())
    {
        PAutomaton->m_Behaviour |= BEHAVIOUR_STANDBACK;
    }
}

void CAutomatonController::setCooldowns()
{
    switch (PAutomaton->getFrame())
    {
    case FRAME_SHARPSHOT:
    {
        switch (PAutomaton->getHead())
        {
        case HEAD_SHARPSHOT:
            m_rangedCooldown = 20s;
            break;
        case HEAD_HARLEQUIN:
            m_rangedCooldown = 25s;
            break;
        default:
            m_rangedCooldown = 36s;
        }
    }
    break;
    case FRAME_HARLEQUIN:
    {
        setMagicCooldowns();
    }
    break;
    case FRAME_STORMWAKER:
    {
        setMagicCooldowns();
    }
    break;
    case FRAME_VALOREDGE:
    {
        m_shieldbashCooldown = 3min;
    }
    }
}

// New retail Automaton magic AI (Needs more information to accurately recreate)
void CAutomatonController::setMagicCooldowns()
{
    switch (PAutomaton->getHead())
    {
    case HEAD_HARLEQUIN:
    {
        m_magicCooldown = 10s;
        m_enfeebleCooldown = 10s;
        m_healCooldown = 15s;
    }
    break;
    case HEAD_VALOREDGE:
    {
        m_magicCooldown = 20s;
        m_healCooldown = 20s;
    }
    break;
    case HEAD_SHARPSHOT:
    {
        m_magicCooldown = 12s;
        m_enfeebleCooldown = 12s;
        m_healCooldown = 18s; // Guess
    }
    break;
    case HEAD_STORMWAKER:
    {
        m_magicCooldown = 10s;
        m_enfeebleCooldown = 12s;
        m_healCooldown = 15s; // Guess
        m_elementalCooldown = 33s; // Guess
        m_enhanceCooldown = 10s; // Guess
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        m_magicCooldown = 4s;
        m_enfeebleCooldown = 4s;
        m_healCooldown = 15s;
        m_enhanceCooldown = 15s;
        m_statusCooldown = 15s;
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        m_magicCooldown = 10s;
        m_enfeebleCooldown = 10s;
        m_elementalCooldown = 33s;
        m_enhanceCooldown = 135s;
    }
    }
}

bool CAutomatonController::isRanged()
{
    switch (PAutomaton->getHead())
    {
    case HEAD_SHARPSHOT:
    case HEAD_STORMWAKER:
    case HEAD_SOULSOOTHER:
    case HEAD_SPIRITREAVER:
        return true;
    default:
        return false;
    }
}

CurrentManeuvers CAutomatonController::GetCurrentManeuvers() const
{
    auto& statuses = PAutomaton->PMaster->StatusEffectContainer;
    return {
    statuses->GetEffectsCount(EFFECT_FIRE_MANEUVER),
    statuses->GetEffectsCount(EFFECT_EARTH_MANEUVER),
    statuses->GetEffectsCount(EFFECT_WATER_MANEUVER),
    statuses->GetEffectsCount(EFFECT_WIND_MANEUVER),
    statuses->GetEffectsCount(EFFECT_ICE_MANEUVER),
    statuses->GetEffectsCount(EFFECT_THUNDER_MANEUVER),
    statuses->GetEffectsCount(EFFECT_LIGHT_MANEUVER),
    statuses->GetEffectsCount(EFFECT_DARK_MANEUVER)
    };
}

void CAutomatonController::DoCombatTick(time_point tick)
{
    if ((PAutomaton->PMaster == nullptr || PAutomaton->PMaster->isDead()) && PAutomaton->isAlive()) {
        PAutomaton->Die();
        return;
    }

    PTarget = static_cast<CBattleEntity*>(PAutomaton->GetEntity(PAutomaton->GetBattleTargetID()));

    if (TryDeaggro())
    {
        Disengage();
        return;
    }

    // Automatons only attempt actions in 3 second intervals (Reduced by the Tactical Processor)
    if (TryAction())
    {
        auto maneuvers = GetCurrentManeuvers();

        if (TryShieldBash())
        {
            m_LastShieldBashTime = m_Tick;
            return;
        }
        else if (TrySpellcast(maneuvers))
        {
            m_LastMagicTime = m_Tick;
            return;
        }
        else if (TryTPMove())
        {
            return;
        }
        else if (TryRangedAttack())
        {
            m_LastRangedTime = m_Tick;
            return;
        }
        else if (TryAttachment())
        {
            return;
        }
    }
    Move();
}

void CAutomatonController::Move()
{
    float currentDistance = distanceSquared(PAutomaton->loc.p, PTarget->loc.p);
    if ((isRanged() && (currentDistance > 225)) || (PAutomaton->health.mp < 8 && PAutomaton->health.maxmp > 8))
    {
        PAutomaton->m_Behaviour &= ~BEHAVIOUR_STANDBACK;
    }
    CPetController::Move();
}

bool CAutomatonController::TryAction()
{
    if (m_Tick > m_LastActionTime + (m_actionCooldown - std::chrono::milliseconds(PAutomaton->getMod(Mod::AUTO_DECISION_DELAY) * 10)))
    {
        m_LastActionTime = m_Tick;
        PAutomaton->PAI->EventHandler.triggerListener("AUTOMATON_AI_TICK", PAutomaton, PTarget);
        return true;
    }
    return false;
}

bool CAutomatonController::TryShieldBash()
{
    CState* PState = PTarget->PAI->GetCurrentState();
    if (m_shieldbashCooldown > 0s && PState && PState->CanInterrupt() &&
        m_Tick > m_LastShieldBashTime + (m_shieldbashCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_SHIELD_BASH_DELAY))))
    {
        return MobSkill(PTarget->targid, m_ShieldBashAbility);
    }
    return false;
}

bool CAutomatonController::TrySpellcast(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_magicCooldown == 0s ||
        m_Tick <= m_LastMagicTime + (m_magicCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_MAGIC_DELAY))) || !CanCastSpells())
        return false;

    switch (PAutomaton->getHead())
    {
    case HEAD_VALOREDGE:
    {
        if (TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SHARPSHOT:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_HARLEQUIN:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_STORMWAKER:
    {
        bool lowHP = PTarget->GetHPP() <= 30 && PTarget->health.hp <= 300;
        if (lowHP && TryElemental(maneuvers))  // Mob low HP -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }

        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (!lowHP && maneuvers.ice && TryElemental(maneuvers))  // Ice -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }

        if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (!lowHP && !maneuvers.ice && TryElemental(maneuvers))
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
        else if (TryEnhance())
        {
            m_LastEnhanceTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        if (maneuvers.light && TryHeal(maneuvers)) // Light -> Heal
        {
            m_LastHealTime = m_Tick;
            return true;
        }

        if (TryStatusRemoval(maneuvers))
        {
            m_LastStatusTime = m_Tick;
            return true;
        }
        else if (!maneuvers.light && TryHeal(maneuvers))
        {
            m_LastHealTime = m_Tick;
            return true;
        }
        else if (TryEnhance())
        {
            m_LastEnhanceTime = m_Tick;
            return true;
        }
        else if (TryEnfeeble(maneuvers))
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        if (maneuvers.ice && TryElemental(maneuvers))  // Ice -> Nuke
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
        else if (maneuvers.dark && TryEnhance())
        {
            m_LastEnhanceTime = m_Tick;
            return true;
        }
        else if ((maneuvers.dark || PAutomaton->GetHPP() <= 75 || PAutomaton->GetMPP() <= 75) && TryEnfeeble(maneuvers)) // Dark or self HPP/MPP <= 75 -> Enfeeble
        {
            m_LastEnfeebleTime = m_Tick;
            return true;
        }

        if (!maneuvers.ice && TryElemental(maneuvers))
        {
            m_LastElementalTime = m_Tick;
            return true;
        }
    }
    }
    return false;
}

bool CAutomatonController::TryHeal(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_healCooldown == 0s || m_Tick <= m_LastHealTime + (m_healCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::AUTO_HEALING_DELAY))))
        return false;

    float threshold = 0;
    switch (maneuvers.light) // Light -> Higher healing threshold
    {
    case 1:
        threshold = 40;
        break;
    case 2:
        threshold = 50;
        break;
    case 3:
        threshold = 75;
        break;
    default:
        threshold = 30;
        break;
    }

    threshold = std::clamp<float>(threshold + PAutomaton->getMod(Mod::AUTO_HEALING_THRESHOLD), 30.f, 90.f);
    CBattleEntity* PCastTarget = nullptr;

    bool haveHate = false;
    EnmityList_t* enmityList;

    auto PMob = dynamic_cast<CMobEntity*>(PTarget);
    if (PMob)
    {
        enmityList = PMob->PEnmityContainer->GetEnmityList();
        auto masterEnmity_obj = enmityList->find(PAutomaton->PMaster->id);
        auto selfEnmity_obj = enmityList->find(PAutomaton->id);

        if (masterEnmity_obj == enmityList->end())
            haveHate = true;
        else if (selfEnmity_obj == enmityList->end())
            haveHate = false;
        else
        {
            uint16 selfEnmity = selfEnmity_obj->second.CE + selfEnmity_obj->second.VE;
            uint16 masterEnmity = masterEnmity_obj->second.CE + masterEnmity_obj->second.VE;
            haveHate = selfEnmity > masterEnmity ? true : false;
        }
    }

    // Prioritize hate
    if (haveHate)
    {
        if (PAutomaton->GetHPP() <= 50) // Automaton only heals itself when <= 50%
            PCastTarget = PAutomaton;
        else if (PAutomaton->PMaster->GetHPP() <= threshold && distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
            PCastTarget = PAutomaton->PMaster;
    }
    else
    {
        if (PAutomaton->PMaster->GetHPP() <= threshold)
            PCastTarget = PAutomaton->PMaster;
        else if (PAutomaton->GetHPP() <= 50) // Automaton only heals itself when <= 50%
            PCastTarget = PAutomaton;
    }

    if (maneuvers.light && !PCastTarget && PAutomaton->getHead() == HEAD_SOULSOOTHER && PAutomaton->PMaster->PParty) // Light + Soulsoother head -> Heal party
    {
        if (PMob)
        {
            uint16 highestEnmity = 0;
            static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember) {
                if (PMember->id != PAutomaton->PMaster->id)
                {
                    auto enmity_obj = enmityList->find(PMember->id);
                    if (enmity_obj != enmityList->end() && highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE && PMember->GetHPP() <= threshold && distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
                    {
                        highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                        PCastTarget = PMember;
                    }
                }
            });
        }
        else
        {
            static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember) {
                if (PMember->id != PAutomaton->PMaster->id && distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
                {
                    if (PMember->GetHPP() <= threshold)
                    {
                        PCastTarget = PMember;
                    }
                }
            });
        }
    }

    // This might be wrong
    if (PCastTarget)
    {
        auto missinghp = PCastTarget->GetMaxHP() - PCastTarget->health.hp;
        if (missinghp > 850 && Cast(PCastTarget->targid, SpellID::Cure_VI))
            return true;
        else if (missinghp > 600 && Cast(PCastTarget->targid, SpellID::Cure_V))
            return true;
        else if (missinghp > 350 && Cast(PCastTarget->targid, SpellID::Cure_IV))
            return true;
        else if (missinghp > 190 && Cast(PCastTarget->targid, SpellID::Cure_III))
            return true;
        else if (missinghp > 120 && Cast(PCastTarget->targid, SpellID::Cure_II))
            return true;
        else if (Cast(PCastTarget->targid, SpellID::Cure))
            return true;
    }

    return false;
}

inline bool resistanceComparator(const std::pair<SpellID, int16>& firstElem, const std::pair<SpellID, int16>& secondElem) {
    return firstElem.second < secondElem.second;
}

bool CAutomatonController::TryElemental(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_elementalCooldown == 0s || m_Tick <= m_LastElementalTime + m_elementalCooldown)
        return false;

    std::vector<SpellID> castPriority;
    std::vector<SpellID> defaultPriority;

    int8 tier = 4;
    int32 hp = PTarget->health.hp;
    int32 selfmp = PAutomaton->health.mp; // Shortcut for wasting less time
    if (selfmp < 4)
        return false;
    else if (hp <= 50 || selfmp < 16)
        tier = 0;
    else if (hp <= 150 || selfmp < 40)
        tier = 1;
    else if (hp <= 200 || selfmp < 88)
        tier = 2;
    else if (hp <= 600 || selfmp < 156)
        tier = 3;

    if (PAutomaton->getMod(Mod::AUTO_SCAN_RESISTS))
    {
        std::vector<std::pair<SpellID, int16>> reslist{
            std::make_pair(SpellID::Thunder, PTarget->getMod(Mod::THUNDERRES)),
            std::make_pair(SpellID::Blizzard, PTarget->getMod(Mod::ICERES)),
            std::make_pair(SpellID::Fire, PTarget->getMod(Mod::FIRERES)),
            std::make_pair(SpellID::Aero, PTarget->getMod(Mod::WINDRES)),
            std::make_pair(SpellID::Water, PTarget->getMod(Mod::WATERRES)),
            std::make_pair(SpellID::Stone, PTarget->getMod(Mod::EARTHRES))
        };
        std::stable_sort(reslist.begin(), reslist.end(), resistanceComparator);
        for (std::pair<SpellID, int16>& res : reslist)
            castPriority.push_back(res.first);
    }
    else if (PAutomaton->getHead() == HEAD_SPIRITREAVER)
    {
        if (maneuvers.thunder) // Thunder -> Thunder spells
            castPriority.push_back(SpellID::Thunder);
        else
            defaultPriority.push_back(SpellID::Thunder);

        if (maneuvers.ice) // Ice -> Blizzard spells
            castPriority.push_back(SpellID::Blizzard);
        else
            defaultPriority.push_back(SpellID::Blizzard);

        if (maneuvers.fire) // Fire -> Fire spells
            castPriority.push_back(SpellID::Fire);
        else
            defaultPriority.push_back(SpellID::Fire);

        if (maneuvers.wind) // Wind -> Aero spells
            castPriority.push_back(SpellID::Aero);
        else
            defaultPriority.push_back(SpellID::Aero);

        if (maneuvers.water) // Water -> Water spells
            castPriority.push_back(SpellID::Water);
        else
            defaultPriority.push_back(SpellID::Water);

        if (maneuvers.earth) // Earth -> Stone spells
            castPriority.push_back(SpellID::Stone);
        else
            defaultPriority.push_back(SpellID::Stone);
    }
    else
    {
        defaultPriority = { SpellID::Thunder, SpellID::Blizzard, SpellID::Fire, SpellID::Aero, SpellID::Water, SpellID::Stone };
    }

    for (int8 i = tier; i >= 0; --i)
    {
        for (SpellID& id : castPriority)
            if (Cast(PTarget->targid, static_cast<SpellID>(static_cast<uint16>(id) + i)))
                return true;

        for (SpellID& id : defaultPriority)
            if (Cast(PTarget->targid, static_cast<SpellID>(static_cast<uint16>(id) + i)))
                return true;
    }

    return false;
}

bool CAutomatonController::TryEnfeeble(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_enfeebleCooldown == 0s || m_Tick <= m_LastEnfeebleTime + m_enfeebleCooldown)
        return false;

    std::vector<SpellID> castPriority;
    std::vector<SpellID> defaultPriority;

    switch (PAutomaton->getHead())
    {
    case HEAD_STORMWAKER:
    {
        bool dispel = false;
        PTarget->StatusEffectContainer->ForEachEffect([&dispel](CStatusEffect* PStatus) {
            if (!dispel && PStatus->GetDuration() > 0)
            {
                if (PStatus->GetFlag() & EFFECTFLAG_DISPELABLE)
                {
                    dispel = true;
                    return;
                }
            }
        });
        if (dispel)
            castPriority.push_back(SpellID::Dispel);
    }
    default:
    {
        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
        {
            if (maneuvers.dark) // Dark -> Bio
            {
                castPriority.push_back(SpellID::Bio_II);
            }
            else
            {
                defaultPriority.push_back(SpellID::Bio_II);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light)
            {
                castPriority.push_back(SpellID::Dia_II);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia_II);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
        {
            if (maneuvers.dark) // Dark -> Bio
            {
                castPriority.push_back(SpellID::Bio);
            }
            else
            {
                defaultPriority.push_back(SpellID::Bio);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light)
            {
                castPriority.push_back(SpellID::Dia);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia);
            }
        }


        if (maneuvers.water) // Water -> Poison
        {
            castPriority.push_back(SpellID::Poison_II);
            castPriority.push_back(SpellID::Poison);
        }
        else
        {
            defaultPriority.push_back(SpellID::Poison_II);
            defaultPriority.push_back(SpellID::Poison);
        }

        if (maneuvers.wind) // Wind -> Silence
            castPriority.push_back(SpellID::Silence);
        else
            defaultPriority.push_back(SpellID::Silence);

        if (maneuvers.earth) // Earth -> Slow
            castPriority.push_back(SpellID::Slow);
        else
            defaultPriority.push_back(SpellID::Slow);

        if (maneuvers.dark) // Dark -> Blind
            castPriority.push_back(SpellID::Blind);
        else
            defaultPriority.push_back(SpellID::Blind);

        if (maneuvers.ice) // Ice -> Paralyze
            castPriority.push_back(SpellID::Paralyze);
        else
            defaultPriority.push_back(SpellID::Paralyze);

        if (maneuvers.fire) // Fire -> Addle
            castPriority.push_back(SpellID::Addle);
        else
            defaultPriority.push_back(SpellID::Addle);
    }
    break;
    case HEAD_SPIRITREAVER:
    {
        if (PAutomaton->GetMPP() <= 75 && PTarget->health.mp > 0) // MPP <= 75 -> Aspir
        {
            castPriority.push_back(SpellID::Aspir_II);
            castPriority.push_back(SpellID::Aspir);
        }

        if (PAutomaton->GetHPP() <= 75 && PTarget->m_EcoSystem != SYSTEM_UNDEAD) // HPP <= 75 -> Drain
            castPriority.push_back(SpellID::Drain);

        if (maneuvers.dark) // Dark -> Access to Enfeebles
        {
            if (!PAutomaton->StatusEffectContainer->HasStatusEffect(EFFECT_INT_BOOST)) // Use it ASAP
                defaultPriority.push_back(SpellID::Absorb_INT);

            // Not prioritizable since it requires 1 Dark to access Enfeebles and requires 2 of another element to prioritize another
            defaultPriority.push_back(SpellID::Blind);
            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                defaultPriority.push_back(SpellID::Bio_II);
            }

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
            {
                if (maneuvers.light >= 2) // 2 Light -> Dia
                {
                    castPriority.push_back(SpellID::Dia_II);
                }
                else
                {
                    defaultPriority.push_back(SpellID::Dia_II);
                }
            }
            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                defaultPriority.push_back(SpellID::Bio);
            }

            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
            {
                if (maneuvers.light >= 2) // 2 Light -> Dia
                {
                    castPriority.push_back(SpellID::Dia);
                }
                else
                {
                    defaultPriority.push_back(SpellID::Dia);
                }
            }


            if (maneuvers.water >= 2) // 2 Water -> Poison
            {
                castPriority.push_back(SpellID::Poison_II);
                castPriority.push_back(SpellID::Poison);
            }
            else
            {
                defaultPriority.push_back(SpellID::Poison_II);
                defaultPriority.push_back(SpellID::Poison);
            }

            if (maneuvers.wind >= 2) // 2 Wind -> Silence
                castPriority.push_back(SpellID::Silence);
            else
                defaultPriority.push_back(SpellID::Silence);

            if (maneuvers.earth >= 2) // 2 Earth -> Slow
                castPriority.push_back(SpellID::Slow);
            else
                defaultPriority.push_back(SpellID::Slow);

            if (maneuvers.ice >= 2) // 2 Ice -> Paralyze
                castPriority.push_back(SpellID::Paralyze);
            else
                defaultPriority.push_back(SpellID::Paralyze);

            if (maneuvers.fire >= 2) // 2 Fire -> Addle
                castPriority.push_back(SpellID::Addle);
            else
                defaultPriority.push_back(SpellID::Addle);
        }
    }
    break;
    case HEAD_SOULSOOTHER:
    {
        if (maneuvers.earth) // Earth -> Slow
            castPriority.push_back(SpellID::Slow);
        else
            defaultPriority.push_back(SpellID::Slow);

        if (maneuvers.water) // 2 Water -> Poison
        {
            castPriority.push_back(SpellID::Poison_II);
            castPriority.push_back(SpellID::Poison);
        }
        else
        {
            defaultPriority.push_back(SpellID::Poison_II);
            defaultPriority.push_back(SpellID::Poison);
        }

        if (maneuvers.dark) // Dark -> Blind > Bio
        {
            castPriority.push_back(SpellID::Blind);
            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                castPriority.push_back(SpellID::Bio_II);
            }
        }
        else
        {
            defaultPriority.push_back(SpellID::Blind);
            if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
            {
                defaultPriority.push_back(SpellID::Bio_II);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light) // Light -> Dia
            {
                castPriority.push_back(SpellID::Dia_II);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia_II);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DIA))
        {
            if (maneuvers.dark) // Dark -> Blind > Bio
            {
                castPriority.push_back(SpellID::Bio);
            }
            else
            {
                defaultPriority.push_back(SpellID::Bio);
            }
        }

        if (!PTarget->StatusEffectContainer->HasStatusEffect(EFFECT_BIO))
        {
            if (maneuvers.light) // Light -> Dia
            {
                castPriority.push_back(SpellID::Dia);
            }
            else
            {
                defaultPriority.push_back(SpellID::Dia);
            }
        }

        if (maneuvers.wind) // Wind -> Silence
            castPriority.push_back(SpellID::Silence);
        else
            defaultPriority.push_back(SpellID::Silence);

        if (maneuvers.ice) // Ice -> Paralyze
            castPriority.push_back(SpellID::Paralyze);
        else
            defaultPriority.push_back(SpellID::Paralyze);

        if (maneuvers.fire) // Fire -> Addle
            castPriority.push_back(SpellID::Addle);
        else
            defaultPriority.push_back(SpellID::Addle);
    }
    }

    for (SpellID& id : castPriority)
    {
        if (autoSpell::CanUseEnfeeble(PTarget, id) && Cast(PTarget->targid, id))
            return true;
    }

    for (SpellID& id : defaultPriority)
    {
        if (autoSpell::CanUseEnfeeble(PTarget, id) && Cast(PTarget->targid, id))
            return true;
    }

    return false;
}

bool CAutomatonController::TryStatusRemoval(const CurrentManeuvers& maneuvers)
{
    if (!PAutomaton->PMaster || m_statusCooldown == 0s || m_Tick <= m_LastStatusTime + m_statusCooldown)
        return false;

    std::vector<SpellID> castPriority;

    PAutomaton->PMaster->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
        if (PStatus->GetDuration() > 0)
        {
            auto id = autoSpell::FindNaSpell(PStatus);
            if (id.has_value())
            {
                castPriority.push_back(id.value());
            }
        }
    });

    for (SpellID& id : castPriority)
        if (Cast(PAutomaton->PMaster->targid, id))
            return true;

    castPriority.clear();

    PAutomaton->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
        if (PStatus->GetDuration() > 0)
        {
            auto id = autoSpell::FindNaSpell(PStatus);
            if (id.has_value())
            {
                castPriority.push_back(id.value());
            }
        }
    });

    for (SpellID& id : castPriority)
        if (Cast(PAutomaton->targid, id))
            return true;

    if (maneuvers.water && PAutomaton->getHead() == HEAD_SOULSOOTHER && PAutomaton->PMaster->PParty) // Water + Soulsoother head -> Remove party's statuses
    {
        for (uint8 i = 0; i < PAutomaton->PMaster->PParty->members.size(); ++i)
        {
            CBattleEntity* member = PAutomaton->PMaster->PParty->members.at(i);
            if (member->id != PAutomaton->PMaster->id)
            {
                castPriority.clear();

                member->StatusEffectContainer->ForEachEffect([&castPriority](CStatusEffect* PStatus) {
                    if (PStatus->GetDuration() > 0)
                    {
                        auto id = autoSpell::FindNaSpell(PStatus);
                        if (id.has_value())
                        {
                            castPriority.push_back(id.value());
                        }
                    }
                });

                for (auto id : castPriority)
                    if (Cast(member->targid, id))
                        return true;
            }
        }
    }

    return false;
}

bool CAutomatonController::TryEnhance()
{
    if (!PAutomaton->PMaster || m_enhanceCooldown == 0s || m_Tick <= m_LastEnhanceTime + m_enhanceCooldown)
        return false;

    if (PAutomaton->getHead() == HEAD_SPIRITREAVER)
        return Cast(PAutomaton->targid, SpellID::Dread_Spikes);

    EnmityList_t* enmityList;
    auto PMob = dynamic_cast<CMobEntity*>(PTarget);
    if (PMob)
        enmityList = PMob->PEnmityContainer->GetEnmityList();

    uint16 highestEnmity = 0;

    CBattleEntity* PRegenTarget = nullptr;
    CBattleEntity* PProtectTarget = nullptr;
    CBattleEntity* PShellTarget = nullptr;
    CBattleEntity* PHasteTarget = nullptr;
    CBattleEntity* PStoneSkinTarget = nullptr;
    CBattleEntity* PPhalanxTarget = nullptr;

    bool protect = false;
    uint8 protectcount = 0;
    bool shell = false;
    uint8 shellcount = 0;
    bool haste = false;
    bool stoneskin = false;
    bool phalanx = false;

    bool isEngaged = false;

    if (distance(PAutomaton->loc.p, PAutomaton->PMaster->loc.p) < 20)
    {
        if (PMob)
        {
            auto enmity_obj = enmityList->find(PAutomaton->PMaster->id);
            if (enmity_obj != enmityList->end())
            {
                isEngaged = true;
                if (highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
                {
                    highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                    PRegenTarget = PAutomaton->PMaster;
                }
            }
        }
        else
        {
            isEngaged = true; // Assume everyone is engaged if the target isn't a mob
        }

        PAutomaton->PMaster->StatusEffectContainer->ForEachEffect([&protect, &protectcount, &shell, &shellcount, &haste, &stoneskin, &phalanx](CStatusEffect* PStatus) {
            if (PStatus->GetDuration() > 0)
            {
                if (PStatus->GetStatusID() == EFFECT_PROTECT)
                {
                    protect = true;
                    ++protectcount;
                }

                if (PStatus->GetStatusID() == EFFECT_SHELL)
                {
                    shell = true;
                    ++shellcount;
                }

                if (PStatus->GetStatusID() == EFFECT_HASTE || PStatus->GetStatusID() == EFFECT_GEO_HASTE)
                    haste = true;

                if (PStatus->GetStatusID() == EFFECT_STONESKIN)
                    stoneskin = true;

                if (PStatus->GetStatusID() == EFFECT_PHALANX)
                    phalanx = true;
            }
        });

        if (isEngaged)
        {
            if (!protect)
                PProtectTarget = PAutomaton->PMaster;

            if (!shell)
                PShellTarget = PAutomaton->PMaster;

            if (!haste)
                PHasteTarget = PAutomaton->PMaster;

            if (!stoneskin)
                PStoneSkinTarget = PAutomaton->PMaster;

            if (!phalanx)
                PPhalanxTarget = PAutomaton->PMaster;
        }
    }

    protect = false;
    shell = false;
    haste = false;
    stoneskin = false;
    phalanx = false;

    if (PMob)
    {
        auto enmity_obj = enmityList->find(PAutomaton->id);
        if (enmity_obj != enmityList->end() && highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
        {
            highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
            PRegenTarget = PAutomaton;
        }
    }

    PAutomaton->StatusEffectContainer->ForEachEffect([&protect, &shell, &haste, &stoneskin, &phalanx](CStatusEffect* PStatus) {
        if (PStatus->GetDuration() > 0)
        {
            if (PStatus->GetStatusID() == EFFECT_PROTECT)
                protect = true;

            if (PStatus->GetStatusID() == EFFECT_SHELL)
                shell = true;

            if (PStatus->GetStatusID() == EFFECT_HASTE || PStatus->GetStatusID() == EFFECT_GEO_HASTE)
                haste = true;
        }
    });

    if (!PProtectTarget && !protect)
        PProtectTarget = PAutomaton;

    if (!PShellTarget && !shell)
        PShellTarget = PAutomaton;

    if (!PHasteTarget && !haste)
        PHasteTarget = PAutomaton;

    size_t members = 0;

    // Unknown whether it only applies buffs to other members if they have hate or if the Soulsoother head is needed
    if (PAutomaton->PMaster->PParty)
    {
        members = PAutomaton->PMaster->PParty->members.size();
        static_cast<CCharEntity*>(PAutomaton->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember) {
            if (PMember->id != PAutomaton->PMaster->id && distance(PAutomaton->loc.p, PMember->loc.p) < 20)
            {
                protect = false;
                shell = false;
                haste = false;

                isEngaged = false;

                if (PMob)
                {
                    auto enmity_obj = enmityList->find(PMember->id);
                    if (enmity_obj != enmityList->end())
                    {
                        isEngaged = true;
                        if (highestEnmity < enmity_obj->second.CE + enmity_obj->second.VE)
                        {
                            highestEnmity = enmity_obj->second.CE + enmity_obj->second.VE;
                            PRegenTarget = PMember;
                        }
                    }
                }
                else
                {
                    isEngaged = true; // Assume everyone is engaged if the target isn't a mob
                }

                PMember->StatusEffectContainer->ForEachEffect([&protect, &protectcount, &shell, &shellcount, &haste](CStatusEffect* PStatus) {
                    if (PStatus->GetDuration() > 0)
                    {
                        if (PStatus->GetStatusID() == EFFECT_PROTECT)
                        {
                            protect = true;
                            ++protectcount;
                        }

                        if (PStatus->GetStatusID() == EFFECT_SHELL)
                        {
                            shell = true;
                            ++shellcount;
                        }

                        if (PStatus->GetStatusID() == EFFECT_HASTE || PStatus->GetStatusID() == EFFECT_GEO_HASTE)
                            haste = true;
                    }
                });

                if (isEngaged)
                {
                    if (!PProtectTarget && !protect)
                        PProtectTarget = PMember;

                    if (!PShellTarget && !shell)
                        PShellTarget = PMember;

                    if (!PHasteTarget && !haste)
                        PHasteTarget = PMember;
                }
            }
        });
    }

    // No info on how this spell worked
    if ((members - protectcount) >= 4)
        Cast(PAutomaton->targid, SpellID::Protectra_V);

    // No info on how this spell worked
    if ((members - shellcount) >= 4)
        Cast(PAutomaton->targid, SpellID::Shellra_V);

    if (PRegenTarget && !(PRegenTarget->StatusEffectContainer->HasStatusEffect(EFFECT_REGEN) || PRegenTarget->StatusEffectContainer->HasStatusEffect(EFFECT_GEO_REGEN)))
        if (Cast(PRegenTarget->targid, SpellID::Regen_III) || Cast(PRegenTarget->targid, SpellID::Regen_II) || Cast(PRegenTarget->targid, SpellID::Regen))
            return true;

    if (PProtectTarget)
        if (Cast(PProtectTarget->targid, SpellID::Protect_V) || Cast(PProtectTarget->targid, SpellID::Protect_IV) || Cast(PProtectTarget->targid, SpellID::Protect_III) || Cast(PProtectTarget->targid, SpellID::Protect_II) || Cast(PProtectTarget->targid, SpellID::Protect))
            return true;

    if (PShellTarget)
        if (Cast(PShellTarget->targid, SpellID::Shell_V) ||
            Cast(PShellTarget->targid, SpellID::Shell_IV) ||
            Cast(PShellTarget->targid, SpellID::Shell_III) ||
            Cast(PShellTarget->targid, SpellID::Shell_II) ||
            Cast(PShellTarget->targid, SpellID::Shell))
            return true;

    if (PHasteTarget)
        if (Cast(PHasteTarget->targid, SpellID::Haste_II) || Cast(PHasteTarget->targid, SpellID::Haste))
            return true;

    if (PStoneSkinTarget)
        if (Cast(PStoneSkinTarget->targid, SpellID::Stoneskin))
            return true;

    if (PPhalanxTarget)
        if (Cast(PPhalanxTarget->targid, SpellID::Phalanx))
            return true;

    return false;
}

bool CAutomatonController::TryTPMove()
{
    if (PAutomaton->health.tp >= 1000)
    {
        const auto& FamilySkills = battleutils::GetMobSkillList(PAutomaton->m_Family);

        std::vector<CMobSkill*> validSkills;

        //load the skills that the automaton has access to with it's skill
        SKILLTYPE skilltype = SKILL_AUTOMATON_MELEE;

        if (PAutomaton->getFrame() == FRAME_SHARPSHOT)
            skilltype = SKILL_AUTOMATON_RANGED;

        for (auto skillid : FamilySkills)
        {
            auto PSkill = battleutils::GetMobSkill(skillid);
            if (PSkill && PAutomaton->GetSkill(skilltype) > PSkill->getParam() && PSkill->getParam() != -1 &&
                distance(PAutomaton->loc.p, PTarget->loc.p) < PSkill->getRadius())
            {
                validSkills.push_back(PSkill);
            }
        }

        int16 currentSkill = -1;
        CMobSkill* PWSkill = nullptr;
        int8 currentManeuvers = -1;

        bool attemptChain = (PAutomaton->getMod(Mod::AUTO_TP_EFFICIENCY) != 0);

        if (attemptChain)
        {
            CStatusEffect* PSCEffect = PTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
            if (PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now())
            {
                std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                if (PSCEffect->GetStartTime() + 3s < m_Tick)
                {
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }
                }

                for (auto PSkill : validSkills)
                {
                    if (PSkill->getParam() > currentSkill)
                    {
                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getPrimarySkillchain());
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getSecondarySkillchain());
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)PSkill->getTertiarySkillchain());
                        if (battleutils::FormSkillchain(resonanceProperties, skillProperties) != SC_NONE)
                        {
                            currentManeuvers = 1;
                            currentSkill = PSkill->getParam();
                            PWSkill = PSkill;
                        }
                    }
                }
            }
        }

        if (!attemptChain || (currentManeuvers == -1 && PAutomaton->PMaster && PAutomaton->PMaster->health.tp < PAutomaton->getMod(Mod::AUTO_TP_EFFICIENCY)))
        {
            for (auto PSkill : validSkills)
            {
                int8 maneuvers = luautils::OnMobAutomatonSkillCheck(PTarget, PAutomaton, PSkill);
                if (maneuvers > -1 && (maneuvers > currentManeuvers || (maneuvers == currentManeuvers && PSkill->getParam() > currentSkill)))
                {
                    currentManeuvers = maneuvers;
                    currentSkill = PSkill->getParam();
                    PWSkill = PSkill;
                }
            }
        }

        // No WS was chosen (waiting on master's TP to skillchain probably)
        if (currentManeuvers == -1)
            return false;

        if (PWSkill)
            return MobSkill(PTarget->targid, PWSkill->getID());
    }
    return false;
}

bool CAutomatonController::TryRangedAttack() // TODO: Find the animation for its ranged attack
{
    if (PAutomaton->getFrame() == FRAME_SHARPSHOT)
        if (m_rangedCooldown > 0s && m_Tick > m_LastRangedTime + (m_rangedCooldown - std::chrono::seconds(PAutomaton->getMod(Mod::SNAP_SHOT))))
            return MobSkill(PTarget->targid, m_RangedAbility);

    return false;
}

bool CAutomatonController::TryAttachment()
{
    if (!PAutomaton->PAI->CanChangeState())
        return false;
    PAutomaton->PAI->EventHandler.triggerListener("AUTOMATON_ATTACHMENT_CHECK", PAutomaton, PTarget);
    return false;
}

bool CAutomatonController::CanCastSpells()
{
    // Check for spell blockers e.g. silence
    if (PAutomaton->StatusEffectContainer->HasStatusEffect({ EFFECT_SILENCE, EFFECT_MUTE }))
        return false;

    // Check if we can change states!
    return PAutomaton->PAI->CanChangeState();
}

bool CAutomatonController::Cast(uint16 targid, SpellID spellid)
{
    if (!autoSpell::CanUseSpell(PAutomaton, spellid) || PAutomaton->PRecastContainer->HasRecast(RECAST_MAGIC, static_cast<uint16>(spellid), 0))
        return false;

    return CPetController::Cast(targid, spellid);
}

bool CAutomatonController::MobSkill(uint16 targid, uint16 wsid)
{
    if (PAutomaton->PRecastContainer->HasRecast(RECAST_ABILITY, wsid, 0))
        return false;
    return CPetController::MobSkill(targid, wsid);
}

bool CAutomatonController::Disengage()
{
    PTarget = nullptr;
    if (isRanged())
    {
        PAutomaton->m_Behaviour |= BEHAVIOUR_STANDBACK;
    }
    return CMobController::Disengage();
}

namespace autoSpell
{
    std::unordered_map<SpellID, AutomatonSpell, EnumClassHash> autoSpellList;
    std::vector<SpellID> naSpells;

    void LoadAutomatonSpellList()
    {
        const char* Query = "SELECT spellid, skilllevel, heads, enfeeble, immunity, removes FROM automaton_spells;";

        int32 ret = Sql_Query(SqlHandle, Query);

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                SpellID id = (SpellID)Sql_GetUIntData(SqlHandle, 0);
                AutomatonSpell PSpell {
                    (uint16)Sql_GetUIntData(SqlHandle, 1),
                    (uint8)Sql_GetUIntData(SqlHandle, 2),
                    (EFFECT)Sql_GetUIntData(SqlHandle, 3),
                    (IMMUNITY)Sql_GetUIntData(SqlHandle, 4)
                };

                uint32 removes = Sql_GetUIntData(SqlHandle, 5);
                while (removes > 0)
                {
                    PSpell.removes.push_back((EFFECT)(removes & 0xFF));
                    removes = removes >> 8;
                }

                if (!PSpell.removes.empty())
                {
                    naSpells.push_back(id);
                }

                autoSpellList[id] = std::move(PSpell);
            }
        }
    }

    bool CanUseSpell(CAutomatonEntity* PCaster, SpellID spellid)
    {
        const AutomatonSpell& PSpell = autoSpellList[spellid];
        return ((PCaster->GetSkill(SKILL_AUTOMATON_MAGIC) >= PSpell.skilllevel) && (PSpell.heads & (1 << ((uint8)PCaster->getHead() - 1))));
    }

    bool CanUseEnfeeble(CBattleEntity* PTarget, SpellID spell)
    {
        const AutomatonSpell& PSpell = autoSpellList[spell];
        auto& statuses = PTarget->StatusEffectContainer;
        return (!statuses->HasStatusEffect(PSpell.enfeeble) && !PTarget->hasImmunity(PSpell.immunity));
    }

    std::optional<SpellID> FindNaSpell(CStatusEffect* PStatus)
    {
        for (auto spell : naSpells)
        {
            const AutomatonSpell& PSpell = autoSpellList[spell];
            if (std::find(PSpell.removes.begin(), PSpell.removes.end(), PStatus->GetStatusID()) != PSpell.removes.end())
                return spell;
        }

        if (PStatus->GetFlag() & EFFECTFLAG_ERASABLE)
            return SpellID::Erase;
        else
            // TODO: -Wno-maybe-uninitialized - possible false positive (anonymous may be used)
            return {};
    }
    }
