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

#include "gambits_container.h"

#include "ability.h"
#include "ai/states/ability_state.h"
#include "ai/states/magic_state.h"
#include "ai/states/mobskill_state.h"
#include "ai/states/petskill_state.h"
#include "ai/states/range_state.h"
#include "ai/states/weaponskill_state.h"
#include "enmity_container.h"
#include "mobskill.h"
#include "spell.h"
#include "utils/battleutils.h"
#include "utils/trustutils.h"
#include "weapon_skill.h"

#include "ai/controllers/player_controller.h"
#include "ai/controllers/trust_controller.h"

#include <algorithm>
#include <ranges>

namespace gambits
{

// Return a new unique identifier for a gambit
auto CGambitsContainer::NewGambitIdentifier(const Gambit_t& gambit) const -> std::string
{
    return fmt::format("{}_{}_{}", gambits.size(), gambit.predicate_groups.size(), gambit.actions.size());
}

// Validate gambit before it's inserted into the gambit list
// Check levels, etc.
std::string CGambitsContainer::AddGambit(const Gambit_t& gambit)
{
    TracyZoneScoped;

    bool available = true;
    for (const auto& action : gambit.actions)
    {
        if (action.reaction == G_REACTION::MA && action.select == G_SELECT::SPECIFIC)
        {
            if (!spell::CanUseSpell(static_cast<CBattleEntity*>(POwner), static_cast<SpellID>(action.select_arg)))
            {
                available = false;
                break;
            }
        }
    }

    if (!available)
    {
        return "";
    }

    // Make a modifiable copy, assign a new identifier and store it
    Gambit_t stored   = gambit;
    stored.identifier = NewGambitIdentifier(stored);
    gambits.emplace_back(std::move(stored));
    return gambits.back().identifier;
}

void CGambitsContainer::RemoveGambit(const std::string& id)
{
    gambits.erase(
        std::remove_if(
            gambits.begin(),
            gambits.end(),
            [&id](const Gambit_t& gambit)
            {
                return gambit.identifier == id;
            }),
        gambits.end());
}

void CGambitsContainer::RemoveAllGambits()
{
    gambits.clear();
}

auto CGambitsContainer::Tick(timer::time_point tick) -> Task<void>
{
    TracyZoneScoped;

    auto* controller      = static_cast<CTrustController*>(POwner->PAI->GetController());
    uint8 currentPartyPos = controller->GetPartyPosition();
    auto  position_offset = static_cast<std::chrono::milliseconds>(currentPartyPos * 100);

    if ((tick + position_offset) < m_lastAction)
    {
        co_return;
    }

    // TODO: Is this necessary?
    // Not already doing something
    if (POwner->PAI->IsCurrentState<CAbilityState>() || POwner->PAI->IsCurrentState<CRangeState>() || POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() || POwner->PAI->IsCurrentState<CMobSkillState>() ||
        POwner->PAI->IsCurrentState<CPetSkillState>())
    {
        co_return;
    }

    auto random_offset = static_cast<std::chrono::milliseconds>(xirand::GetRandomNumber(2000, 3000));
    m_lastAction       = tick + random_offset;

    // Deal with TP skills before any gambits
    // TODO: Should this be its own special gambit?
    if (POwner->health.tp >= 1000 && TryTrustSkill())
    {
        co_return;
    }

    // Didn't WS/MS, go for other Gambits
    for (auto& gambit : gambits)
    {
        if (tick < gambit.last_used + std::chrono::seconds(gambit.retry_delay))
        {
            continue;
        }

        auto isValidMember = [this](CBattleEntity* PSettableTarget, CBattleEntity* PPartyTarget)
        {
            return !PSettableTarget && PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone &&
                   distance(POwner->loc.p, PPartyTarget->loc.p) <= 15.0f;
        };

        G_TARGET targetType = gambit.target_selector;

        CBattleEntity* target = nullptr;

        // Capture all potential targets
        std::vector<CBattleEntity*> potentialTargets;

        if (targetType == G_TARGET::SELF)
        {
            potentialTargets.push_back(POwner);
        }
        else if (targetType == G_TARGET::TARGET)
        {
            auto* mob = POwner->GetBattleTarget();
            potentialTargets.push_back(mob);
        }
        else if (targetType == G_TARGET::TRIGGER_SELF_ACTION_TARGET)
        {
            potentialTargets.push_back(POwner);
        }
        else if (targetType == G_TARGET::TRIGGER_TARGET_ACTION_SELF)
        {
            auto* mob = POwner->GetBattleTarget();
            potentialTargets.push_back(mob);
        }
        else if (targetType == G_TARGET::PARTY)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember))
                    {
                        potentialTargets.push_back(PMember);
                    }
                });
            // clang-format on
        }
        else if (targetType == G_TARGET::MASTER)
        {
            potentialTargets.push_back(POwner->PMaster);
        }
        else if (targetType == G_TARGET::PARTY_DEAD)
        {
            auto* mob = POwner->GetBattleTarget();
            if (mob != nullptr)
            {
                // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForParty([&](CBattleEntity* PMember) {
                        if (PMember->isDead())
                        {
                            potentialTargets.push_back(PMember);
                        }
                    });
                // clang-format on
            }
        }
        else if (targetType == G_TARGET::TANK)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) &&
                        (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                    {
                        potentialTargets.push_back(PMember);
                    }
                });
            // clang-format on
        }
        else if (targetType == G_TARGET::MELEE)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) &&
                        melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                    {
                        potentialTargets.push_back(PMember);
                    }
                });
            // clang-format on
        }
        else if (targetType == G_TARGET::RANGED)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) &&
                        (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                    {
                        potentialTargets.push_back(PMember);
                    }
                });
            // clang-format on
        }
        else if (targetType == G_TARGET::CASTER)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) &&
                        caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                    {
                        potentialTargets.push_back(PMember);
                    }
                });
            // clang-format on
        }
        else if (targetType == G_TARGET::TOP_ENMITY)
        {
            if (auto* PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
            {
                // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) &&
                            PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                        {
                            potentialTargets.push_back(PMember);
                        }
                    });
                // clang-format on
            }
        }
        else if (targetType == G_TARGET::CURILLA)
        {
            // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember))
                    {
                        const auto& name = PMember->getName();
                        if (strcmpi(name.c_str(), "curilla") == 0)
                        {
                            potentialTargets.push_back(PMember);
                        }
                    }
                });
            // clang-format on
        }

        // For each potential target, check if the predicates resolves
        for (auto& potentialTarget : potentialTargets)
        {
            // All predicate groups must resolve successfully for the target to be considered
            bool targetMatchAllPredicates = true;
            for (auto& predicateGroup : gambit.predicate_groups)
            {
                if (!CheckTrigger(potentialTarget, predicateGroup))
                {
                    targetMatchAllPredicates = false;
                }
            }

            if (targetMatchAllPredicates)
            {
                if (gambit.target_selector == G_TARGET::TRIGGER_SELF_ACTION_TARGET)
                {
                    target = POwner->GetBattleTarget(); // switch back to target before action for correct target selection in actions
                    break;
                }
                else if (gambit.target_selector == G_TARGET::TRIGGER_TARGET_ACTION_SELF)
                {
                    target = POwner; // switch to self before action for correct target selection in actions
                    break;
                }
                target = potentialTarget;
                break;
            }
        }

        // No target matched, continue to next gambit
        if (!target)
        {
            continue;
        }

        // Pre resolve actions and perform simple recast/availability checks.
        // This prevents attempting to cast multiple spells in the same tick (which doesn't work)
        // and ensures all actions are available before starting.
        std::vector<bool>           canExecute(gambit.actions.size(), true);
        std::vector<Maybe<SpellID>> resolvedSpells(gambit.actions.size(), std::nullopt);

        // Helper to resolve a spell action to a valid SpellID if possible.
        auto ResolveMA = [&](const Action_t& action, CBattleEntity* resolvedTarget) -> Maybe<SpellID>
        {
            if (action.select == G_SELECT::SPECIFIC)
            {
                return POwner->SpellContainer->GetAvailable(static_cast<SpellID>(action.select_arg));
            }
            else if (action.select == G_SELECT::HIGHEST)
            {
                return POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.select_arg));
            }
            else if (action.select == G_SELECT::LOWEST)
            {
                // Not implemented yet: treat as unavailable
                return std::nullopt;
            }
            else if (action.select == G_SELECT::BEST_INDI)
            {
                auto* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                return POwner->SpellContainer->GetBestIndiSpell(PMaster);
            }
            else if (action.select == G_SELECT::ENTRUSTED)
            {
                auto* PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                // Entrusted spells target master
                return POwner->SpellContainer->GetBestEntrustedSpell(PMaster);
            }
            else if (action.select == G_SELECT::BEST_AGAINST_TARGET)
            {
                auto spell_to_cast = static_cast<SpellID>(action.select_arg);
                return POwner->SpellContainer->GetBestAgainstTargetWeakness(resolvedTarget, spell_to_cast);
            }
            else if (action.select == G_SELECT::DEF_BAR_ELEMENT)
            {
                auto maybeSpellId = POwner->SpellContainer->GetAvailable(SpellID::Barfire);
                auto element      = POwner->GetLocalVar("[Gambit]CastElement");

                if (element != 0)
                {
                    switch (element)
                    {
                        case ELEMENT_FIRE:
                            maybeSpellId = SpellID::Barfire;
                            break;
                        case ELEMENT_ICE:
                            maybeSpellId = SpellID::Barblizzard;
                            break;
                        case ELEMENT_WIND:
                            maybeSpellId = SpellID::Baraero;
                            break;
                        case ELEMENT_EARTH:
                            maybeSpellId = SpellID::Barstone;
                            break;
                        case ELEMENT_THUNDER:
                            maybeSpellId = SpellID::Barthunder;
                            break;
                        case ELEMENT_WATER:
                            maybeSpellId = SpellID::Barwater;
                            break;
                        default:
                            break;
                    }
                }
                return maybeSpellId;
            }
            else if (action.select == G_SELECT::STORM_DAY)
            {
                return POwner->SpellContainer->GetStormDay();
            }
            else if (action.select == G_SELECT::HELIX_DAY)
            {
                return POwner->SpellContainer->GetHelixDay();
            }
            else if (action.select == G_SELECT::EN_MOB_WEAKNESS)
            {
                CBattleEntity* battleTarget = POwner->GetBattleTarget();
                return POwner->SpellContainer->EnSpellAgainstTargetWeakness(battleTarget);
            }
            else if (action.select == G_SELECT::STORM_MOB_WEAKNESS)
            {
                return POwner->SpellContainer->StormDayAgainstTargetWeakness(resolvedTarget);
            }
            else if (action.select == G_SELECT::HELIX_MOB_WEAKNESS)
            {
                return POwner->SpellContainer->StormDayAgainstTargetWeakness(resolvedTarget);
            }
            else if (action.select == G_SELECT::RANDOM)
            {
                return POwner->SpellContainer->GetSpell();
            }
            else if (action.select == G_SELECT::MB_ELEMENT)
            {
                CStatusEffect* PSCEffect = resolvedTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
                if (PSCEffect == nullptr)
                {
                    return std::nullopt;
                }

                std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                if (uint16 power = PSCEffect->GetPower())
                {
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                    resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 8));
                }

                Maybe<SpellID> spell_id;
                for (auto& resonance_element : resonanceProperties)
                {
                    for (auto& chain_element : battleutils::GetSkillchainMagicElement(resonance_element))
                    {
                        for (size_t ii = POwner->SpellContainer->m_damageList.size(); ii > 0; --ii)
                        {
                            auto spell         = POwner->SpellContainer->m_damageList[ii - 1];
                            auto spell_element = spell::GetSpell(spell)->getElement();
                            if (spell_element == chain_element)
                            {
                                spell_id = spell;
                                break;
                            }
                        }
                    }
                }
                return spell_id;
            }

            return std::nullopt;
        };

        // First pass: validate availability and prevent executing multiple spells in the same tick.
        int firstMAIndex = -1;
        for (size_t i = 0; i < gambit.actions.size(); ++i)
        {
            const auto& action = gambit.actions[i];
            if (action.reaction == G_REACTION::MA)
            {
                if (firstMAIndex == -1)
                {
                    firstMAIndex    = static_cast<int>(i);
                    auto maybeSpell = ResolveMA(action, target);
                    if (!maybeSpell.has_value())
                    {
                        // Couldn't resolve first spell -> cannot use this gambit now
                        canExecute[i] = false;
                    }
                    else
                    {
                        resolvedSpells[i] = maybeSpell;
                    }
                }
                else
                {
                    // More than one spell present: skip additional spells to avoid casting two spells in a row.
                    canExecute[i] = false;
                }
            }
            else if (action.reaction == G_REACTION::JA)
            {
                // Basic validation: SPECIFIC must exist
                if (action.select == G_SELECT::SPECIFIC)
                {
                    if (ability::GetAbility(action.select_arg) == nullptr)
                    {
                        canExecute[i] = false;
                    }
                }
                // Other JA selects rely on TP checks; allow for now.
            }
            else if (action.reaction == G_REACTION::MS)
            {
                if (action.select == G_SELECT::SPECIFIC)
                {
                    // No further pre-check available here; assume ok.
                }
            }
            else if (action.reaction == G_REACTION::RATTACK)
            {
                // Always available
            }
        }

        // If none of the actions are executable, skip this gambit
        bool anyExecutable = std::ranges::any_of(canExecute, [](bool v)
                                                 {
                                                     return v;
                                                 });
        if (!anyExecutable)
        {
            continue;
        }

        // Execute actions that passed the pre-checks. Use resolvedSpells for spells where available.
        bool executedAnyAction = false;
        for (size_t i = 0; i < gambit.actions.size(); ++i)
        {
            if (!canExecute[i])
            {
                continue;
            }

            const auto& action = gambit.actions[i];

            if (action.reaction == G_REACTION::RATTACK)
            {
                controller->RangedAttack(target->targid);
                executedAnyAction = true;
            }
            else if (action.reaction == G_REACTION::MA)
            {
                // Use the pre resolved spell if present, otherwise fall back
                if (resolvedSpells[i].has_value())
                {
                    controller->Cast(target->targid, resolvedSpells[i].value());
                    executedAnyAction = true;
                }
                else
                {
                    // Fallback to original, keeps existing behavior for selection
                    if (action.select == G_SELECT::SPECIFIC)
                    {
                        auto spell_id = POwner->SpellContainer->GetAvailable(static_cast<SpellID>(action.select_arg));
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::HIGHEST)
                    {
                        auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.select_arg));
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::BEST_INDI)
                    {
                        auto* PMaster  = static_cast<CCharEntity*>(POwner->PMaster);
                        auto  spell_id = POwner->SpellContainer->GetBestIndiSpell(PMaster);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::ENTRUSTED)
                    {
                        auto* PMaster  = static_cast<CCharEntity*>(POwner->PMaster);
                        auto  spell_id = POwner->SpellContainer->GetBestEntrustedSpell(PMaster);
                        target         = PMaster;
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::BEST_AGAINST_TARGET)
                    {
                        auto spell_to_cast = static_cast<SpellID>(action.select_arg);
                        auto spell_id      = POwner->SpellContainer->GetBestAgainstTargetWeakness(target, spell_to_cast);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::DEF_BAR_ELEMENT)
                    {
                        auto maybeSpellId = POwner->SpellContainer->GetAvailable(SpellID::Barfire);
                        auto element      = POwner->GetLocalVar("[Gambit]CastElement");

                        if (element != 0)
                        {
                            switch (element)
                            {
                                case ELEMENT_FIRE:
                                    maybeSpellId = SpellID::Barfire;
                                    break;
                                case ELEMENT_ICE:
                                    maybeSpellId = SpellID::Barblizzard;
                                    break;
                                case ELEMENT_WIND:
                                    maybeSpellId = SpellID::Baraero;
                                    break;
                                case ELEMENT_EARTH:
                                    maybeSpellId = SpellID::Barstone;
                                    break;
                                case ELEMENT_THUNDER:
                                    maybeSpellId = SpellID::Barthunder;
                                    break;
                                case ELEMENT_WATER:
                                    maybeSpellId = SpellID::Barwater;
                                    break;
                                default:
                                    break;
                            }

                            if (maybeSpellId.has_value())
                            {
                                controller->Cast(target->targid, maybeSpellId.value());
                                executedAnyAction = true;
                            }
                        }
                    }
                    else if (action.select == G_SELECT::STORM_DAY)
                    {
                        auto spell_id = POwner->SpellContainer->GetStormDay();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::HELIX_DAY)
                    {
                        auto spell_id = POwner->SpellContainer->GetHelixDay();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::EN_MOB_WEAKNESS)
                    {
                        CBattleEntity* battleTarget = POwner->GetBattleTarget();
                        auto           spell_id     = POwner->SpellContainer->EnSpellAgainstTargetWeakness(battleTarget);
                        if (spell_id.has_value())
                        {
                            controller->Cast(POwner->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::STORM_MOB_WEAKNESS)
                    {
                        auto spell_id = POwner->SpellContainer->StormDayAgainstTargetWeakness(target);
                        if (spell_id.has_value())
                        {
                            controller->Cast(POwner->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::HELIX_MOB_WEAKNESS)
                    {
                        auto spell_id = POwner->SpellContainer->StormDayAgainstTargetWeakness(target);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::RANDOM)
                    {
                        auto spell_id = POwner->SpellContainer->GetSpell();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                    else if (action.select == G_SELECT::MB_ELEMENT)
                    {
                        CStatusEffect* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);

                        if (PSCEffect == nullptr)
                        {
                            ShowError("G_SELECT::MB_ELEMENT: PSCEffect was null.");
                            co_return;
                        }

                        std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                        if (uint16 power = PSCEffect->GetPower())
                        {
                            resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                            resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                            resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 8));
                        }

                        Maybe<SpellID> spell_id;
                        for (auto& resonance_element : resonanceProperties)
                        {
                            for (auto& chain_element : battleutils::GetSkillchainMagicElement(resonance_element))
                            {
                                // NOTE: Iterating this list in reverse guarantees finding the best match
                                for (size_t ii = POwner->SpellContainer->m_damageList.size(); ii > 0; --ii)
                                {
                                    auto spell         = POwner->SpellContainer->m_damageList[ii - 1];
                                    auto spell_element = spell::GetSpell(spell)->getElement();
                                    if (spell_element == chain_element)
                                    {
                                        spell_id = spell;
                                        break;
                                    }
                                }
                            }
                        }

                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                            executedAnyAction = true;
                        }
                    }
                }
            }
            else if (action.reaction == G_REACTION::JA)
            {
                auto* PAbility = ability::GetAbility(action.select_arg);
                if (PAbility == nullptr)
                {
                    // If SPECIFIC was validated earlier this shouldn't happen; skip this action.
                    continue;
                }

                auto mLevel = POwner->GetMLevel();

                if (action.select == G_SELECT::HIGHEST_WALTZ)
                {
                    auto currentTP = POwner->health.tp;

                    // clang-format off
                        ABILITY wlist[5] =
                        {
                            ABILITY_CURING_WALTZ_V,
                            ABILITY_CURING_WALTZ_IV,
                            ABILITY_CURING_WALTZ_III,
                            ABILITY_CURING_WALTZ_II,
                            ABILITY_CURING_WALTZ,
                        };
                    // clang-format on

                    for (const auto& waltzId : wlist)
                    {
                        auto* PWaltzAbility = ability::GetAbility(waltzId);
                        if (PWaltzAbility == nullptr)
                        {
                            continue;
                        }

                        auto   waltzLevel = PWaltzAbility->getLevel();
                        uint16 tpCost     = 0;

                        if (mLevel >= waltzLevel)
                        {
                            switch (PWaltzAbility->getID())
                            {
                                case ABILITY_CURING_WALTZ_V:
                                    tpCost = 800;
                                    break;
                                case ABILITY_CURING_WALTZ_IV:
                                    tpCost = 650;
                                    break;
                                case ABILITY_CURING_WALTZ_III:
                                    tpCost = 500;
                                    break;
                                case ABILITY_CURING_WALTZ_II:
                                    tpCost = 350;
                                    break;
                                case ABILITY_CURING_WALTZ:
                                    tpCost = 200;
                                    break;
                                default:
                                    break;
                            }

                            if (tpCost != 0 && currentTP >= tpCost)
                            {
                                PAbility = PWaltzAbility;
                                controller->Ability(target->targid, PAbility->getID());
                                executedAnyAction = true;
                            }
                        }
                    }
                }

                if (PAbility->getValidTarget() == TARGET_SELF)
                {
                    target = POwner;
                }
                else
                {
                    target = POwner->GetBattleTarget();
                }

                if (action.select == G_SELECT::SPECIFIC)
                {
                    controller->Ability(target->targid, PAbility->getID());
                    executedAnyAction = true;
                }

                if (action.select == G_SELECT::BEST_SAMBA)
                {
                    auto   currentTP = POwner->health.tp;
                    uint16 tpCost    = 0;

                    if (mLevel >= 5)
                    {
                        if (mLevel > 65)
                        {
                            if (PartyHasHealer())
                            {
                                if (auto* PSambaAbility = ability::GetAbility(ABILITY_HASTE_SAMBA))
                                {
                                    PAbility = PSambaAbility;
                                    tpCost   = 350;
                                }
                            }
                            else
                            {
                                if (auto* PSambaAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_III))
                                {
                                    PAbility = PSambaAbility;
                                    tpCost   = 400;
                                }
                            }
                        }
                        else if (mLevel < 65 && mLevel > 45)
                        {
                            if (PartyHasHealer())
                            {
                                if (auto* PSambaAbility = ability::GetAbility(ABILITY_HASTE_SAMBA))
                                {
                                    PAbility = PSambaAbility;
                                    tpCost   = 350;
                                }
                            }
                            else
                            {
                                if (auto* PSambaAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II))
                                {
                                    PAbility = PSambaAbility;
                                    tpCost   = 250;
                                }
                            }
                        }
                        else if (mLevel < 45 && mLevel > 35)
                        {
                            if (auto* PSambaAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II))
                            {
                                PAbility = PSambaAbility;
                                tpCost   = 250;
                            }
                        }
                        else
                        {
                            if (auto* PSambaAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA))
                            {
                                PAbility = PSambaAbility;
                                tpCost   = 100;
                            }
                        }
                    }

                    if (tpCost != 0 && (currentTP >= tpCost))
                    {
                        controller->Ability(target->targid, PAbility->getID());
                        executedAnyAction = true;
                    }
                }
                else if (action.select == G_SELECT::RUNE_DAY)
                {
                    uint32 localVarElement = POwner->GetLocalVar("[Gambit]CastElement");
                    uint32 element         = battleutils::GetDayElement();
                    auto   ability         = ABILITY_IGNIS;

                    if (localVarElement > 0)
                    {
                        element = localVarElement;
                    }

                    switch (element)
                    {
                        case ELEMENT_FIRE:
                            ability = ABILITY_UNDA;
                            break;
                        case ELEMENT_ICE:
                            ability = ABILITY_IGNIS;
                            break;
                        case ELEMENT_WIND:
                            ability = ABILITY_GELUS;
                            break;
                        case ELEMENT_EARTH:
                            ability = ABILITY_FLABRA;
                            break;
                        case ELEMENT_THUNDER:
                            ability = ABILITY_TELLUS;
                            break;
                        case ELEMENT_WATER:
                            ability = ABILITY_SULPOR;
                            break;
                        case ELEMENT_LIGHT:
                            ability = ABILITY_TENEBRAE;
                            break;
                        case ELEMENT_DARK:
                            ability = ABILITY_LUX;
                            break;
                        default:
                            ability = ABILITY_IGNIS;
                            break;
                    }
                    controller->Ability(target->targid, ability);
                    executedAnyAction = true;
                }
            }
            else if (action.reaction == G_REACTION::MS)
            {
                if (action.select == G_SELECT::SPECIFIC)
                {
                    controller->MobSkill(target->targid, action.select_arg, std::nullopt);
                    executedAnyAction = true;
                }
            }
        }

        // If we executed any action and the gambit has a retry_delay, set last_used
        if (executedAnyAction && gambit.retry_delay != 0)
        {
            gambit.last_used = tick;
        }
    }
}

bool CGambitsContainer::CheckTrigger(const CBattleEntity* triggerTarget, PredicateGroup_t& predicateGroup)
{
    TracyZoneScoped;

    if (triggerTarget == nullptr)
    {
        return false;
    }

    auto*             controller = static_cast<CTrustController*>(POwner->PAI->GetController());
    std::vector<bool> predicateResults;

    // Iterate and collect results from all predicates in the group
    for (auto& predicate : predicateGroup.predicates)
    {
        switch (predicate.condition)
        {
            case G_CONDITION::ALWAYS:
            {
                predicateResults.push_back(true);
                continue;
            }
            case G_CONDITION::HPP_LT:
            {
                predicateResults.push_back(triggerTarget->GetHPP() < predicate.condition_arg);
                continue;
            }
            case G_CONDITION::HPP_GTE:
            {
                predicateResults.push_back(triggerTarget->GetHPP() >= predicate.condition_arg);
                continue;
            }
            case G_CONDITION::MPP_LT:
            {
                predicateResults.push_back(triggerTarget->GetMPP() < predicate.condition_arg);
                continue;
            }
            case G_CONDITION::MPP_GTE:
            {
                predicateResults.push_back(triggerTarget->GetMPP() >= predicate.condition_arg);
                continue;
            }
            case G_CONDITION::TP_LT:
            {
                predicateResults.push_back(triggerTarget->health.tp < (int16)predicate.condition_arg);
                continue;
            }
            case G_CONDITION::TP_GTE:
            {
                predicateResults.push_back(triggerTarget->health.tp >= (int16)predicate.condition_arg);
                continue;
            }
            case G_CONDITION::STATUS:
            {
                predicateResults.push_back(triggerTarget->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg)));
                continue;
            }
            case G_CONDITION::NOT_STATUS:
            {
                predicateResults.push_back(!triggerTarget->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg)));
                continue;
            }
            case G_CONDITION::LVL_LT:
            {
                predicateResults.push_back(triggerTarget->GetMLevel() < predicate.condition_arg);
                continue;
            }
            case G_CONDITION::LVL_GTE:
            {
                predicateResults.push_back(triggerTarget->GetMLevel() >= predicate.condition_arg);
                continue;
            }
            case G_CONDITION::HAS_RUNES:
            {
                bool hasRunes = !triggerTarget->StatusEffectContainer->GetAllRuneEffects().empty();
                predicateResults.push_back(hasRunes);
                continue;
            }
            case G_CONDITION::NO_MAX_RUNE:
            {
                auto maxRuneEffect = 1;
                bool canUseRunes   = true;

                if (POwner->GetMJob() == JOB_RUN)
                {
                    if (POwner->GetMLevel() >= 65)
                    {
                        maxRuneEffect = 3;
                    }
                    else if (POwner->GetMLevel() >= 35)
                    {
                        maxRuneEffect = 2;
                    }
                }

                if (triggerTarget->StatusEffectContainer->GetAllRuneEffects().size() >= maxRuneEffect)
                {
                    canUseRunes = false;
                }

                predicateResults.push_back(canUseRunes);
                continue;
            }
            case G_CONDITION::NO_SAMBA:
            {
                bool noSamba = true;
                if (triggerTarget->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) ||
                    triggerTarget->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA))
                {
                    noSamba = false;
                }
                predicateResults.push_back(noSamba);
                continue;
            }
            case G_CONDITION::NO_STORM:
            {
                bool noStorm = true;
                // clang-format off
                    if (triggerTarget->StatusEffectContainer->HasStatusEffect(
                    {
                        EFFECT_FIRESTORM,
                        EFFECT_HAILSTORM,
                        EFFECT_WINDSTORM,
                        EFFECT_SANDSTORM,
                        EFFECT_THUNDERSTORM,
                        EFFECT_RAINSTORM,
                        EFFECT_AURORASTORM,
                        EFFECT_VOIDSTORM,
                        EFFECT_FIRESTORM_II,
                        EFFECT_HAILSTORM_II,
                        EFFECT_WINDSTORM_II,
                        EFFECT_SANDSTORM_II,
                        EFFECT_THUNDERSTORM_II,
                        EFFECT_RAINSTORM_II,
                        EFFECT_AURORASTORM_II,
                        EFFECT_VOIDSTORM_II,
                    }))
                    {
                        noStorm = false;
                    }
                // clang-format on
                predicateResults.push_back(noStorm);
                continue;
            }
            case G_CONDITION::PT_HAS_TANK:
            {
                predicateResults.push_back(PartyHasTank());
                continue;
            }
            case G_CONDITION::NOT_PT_HAS_TANK:
            {
                predicateResults.push_back(!PartyHasTank());
                continue;
            }
            case G_CONDITION::STATUS_FLAG:
            {
                predicateResults.push_back(triggerTarget->StatusEffectContainer->HasStatusEffectByFlag(static_cast<EFFECTFLAG>(predicate.condition_arg)));
                continue;
            }
            case G_CONDITION::HAS_TOP_ENMITY:
            {
                predicateResults.push_back((controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid == POwner->targid : false);
                continue;
            }
            case G_CONDITION::NOT_HAS_TOP_ENMITY:
            {
                predicateResults.push_back((controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid != POwner->targid : false);
                continue;
            }
            case G_CONDITION::SC_AVAILABLE:
            {
                auto* PSCEffect = triggerTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                predicateResults.push_back(PSCEffect && PSCEffect->GetStartTime() + 3s < timer::now() && PSCEffect->GetTier() == 0);
                continue;
            }
            case G_CONDITION::NOT_SC_AVAILABLE:
            {
                auto* PSCEffect = triggerTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                predicateResults.push_back(PSCEffect == nullptr);
                continue;
            }
            case G_CONDITION::MB_AVAILABLE:
            {
                auto* PSCEffect = triggerTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                predicateResults.push_back(PSCEffect && PSCEffect->GetStartTime() + 3s < timer::now() && PSCEffect->GetTier() > 0);
                continue;
            }
            case G_CONDITION::LUNGE_MB_AVAILABLE:
            {
                auto* PSCEffect     = triggerTarget->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                bool  maybeUseLunge = false;

                if (PSCEffect && PSCEffect->GetStartTime() + 3s < timer::now() && PSCEffect->GetTier() > 0)
                {
                    SKILLCHAIN_ELEMENT sc = static_cast<SKILLCHAIN_ELEMENT>(PSCEffect->GetPower());

                    if (sc != SC_NONE)
                    {
                        // Only consider tier 3 or 4 skillchains (Light/Dark are tier 3/4)
                        const auto tier = battleutils::GetSkillchainTier(sc);
                        if (tier >= 3)
                        {
                            // Match Light/Dark enums (covers Light, Light II, Darkness, Darkness II)
                            if (sc == SC_LIGHT || sc == SC_LIGHT_II)
                            {
                                if (POwner->StatusEffectContainer->HasStatusEffect(
                                        {
                                            EFFECT_LUX,
                                            EFFECT_IGNIS,
                                            EFFECT_FLABRA,
                                            EFFECT_SULPOR,
                                        }))
                                {
                                    maybeUseLunge = true;
                                }
                            }
                            else if (sc == SC_DARKNESS || sc == SC_DARKNESS_II)
                            {
                                if (POwner->StatusEffectContainer->HasStatusEffect(
                                        {
                                            EFFECT_TENEBRAE,
                                            EFFECT_TELLUS,
                                            EFFECT_UNDA,
                                            EFFECT_GELUS,
                                        }))
                                {
                                    maybeUseLunge = true;
                                }
                            }
                        }
                    }
                }

                predicateResults.push_back(maybeUseLunge);
                continue;
            }
            case G_CONDITION::READYING_WS:
            {
                predicateResults.push_back(triggerTarget->PAI->IsCurrentState<CWeaponSkillState>());
                continue;
            }
            case G_CONDITION::READYING_MS:
            {
                predicateResults.push_back(triggerTarget->PAI->IsCurrentState<CMobSkillState>());
                continue;
            }
            case G_CONDITION::READYING_JA:
            {
                predicateResults.push_back(triggerTarget->PAI->IsCurrentState<CAbilityState>());
                continue;
            }
            case G_CONDITION::CASTING_MA:
            {
                predicateResults.push_back(triggerTarget->PAI->IsCurrentState<CMagicState>());
                continue;
            }
            case G_CONDITION::CASTING_ELE_MA_AOE:
            {
                bool isAOE = false;
                if (triggerTarget->PAI->IsCurrentState<CMagicState>())
                {
                    auto spellElement  = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetSpell()->getElement();
                    auto isElementalMA = spellElement >= ELEMENT_FIRE && spellElement <= ELEMENT_WATER;
                    auto spellAOEType  = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetSpell()->getAOE();
                    if (isElementalMA && spellAOEType == SPELLAOE_RADIAL)
                    {
                        isAOE = true;
                    }
                }
                predicateResults.push_back(isAOE);
                continue;
            }
            case G_CONDITION::CASTING_ELEMENT_MA:
            {
                bool isElementalMA = false;
                if (triggerTarget->PAI->IsCurrentState<CMagicState>())
                {
                    auto spellElement = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetSpell()->getElement();
                    isElementalMA     = spellElement >= ELEMENT_FIRE && spellElement <= ELEMENT_WATER;
                }
                predicateResults.push_back(isElementalMA);
                continue;
            }
            case G_CONDITION::CAST_ELE_MA_SELF:
            {
                bool isElementalMAOnSelf = false;
                if (triggerTarget->PAI->IsCurrentState<CMagicState>())
                {
                    auto spellElement  = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetSpell()->getElement();
                    auto targetID      = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetTarget()->id;
                    bool isElementalMA = spellElement >= ELEMENT_FIRE && spellElement <= ELEMENT_WATER;
                    if (targetID == POwner->id && isElementalMA)
                    {
                        isElementalMAOnSelf = true;
                    }
                }
                predicateResults.push_back(isElementalMAOnSelf);
                continue;
            }
            case G_CONDITION::NEED_ELE_BAREFFECT:
            {
                bool needBarEffect = false;
                if (triggerTarget->PAI->IsCurrentState<CMagicState>())
                {
                    auto spellElement = static_cast<CMagicState*>(triggerTarget->PAI->GetCurrentState())->GetSpell()->getElement();

                    switch (spellElement)
                    {
                        case ELEMENT_FIRE:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARFIRE);
                            break;
                        case ELEMENT_ICE:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARBLIZZARD);
                            break;
                        case ELEMENT_WIND:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARAERO);
                            break;
                        case ELEMENT_EARTH:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARSTONE);
                            break;
                        case ELEMENT_THUNDER:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARTHUNDER);
                            break;
                        case ELEMENT_WATER:
                            needBarEffect = !POwner->StatusEffectContainer->HasStatusEffect(EFFECT_BARWATER);
                            break;
                        default:
                            needBarEffect = false;
                            spellElement  = (uint16)battleutils::GetDayElement();
                            break;
                    }
                    POwner->SetLocalVar("[Gambit]CastElement", spellElement);
                }
                predicateResults.push_back(needBarEffect);
                continue;
            }
            case G_CONDITION::IS_ECOSYSTEM:
            {
                predicateResults.push_back(triggerTarget->m_EcoSystem == ECOSYSTEM(predicate.condition_arg));
                continue;
            }
            case G_CONDITION::RANDOM:
            {
                predicateResults.push_back(xirand::GetRandomNumber<uint16>(100) < (int16)predicate.condition_arg);
                continue;
            }
            case G_CONDITION::HP_MISSING:
            {
                predicateResults.push_back((triggerTarget->health.maxhp - triggerTarget->health.hp) >= (int16)predicate.condition_arg);
                continue;
            }
            case G_CONDITION::SUB_ANIMATION:
            {
                predicateResults.push_back(triggerTarget->animationsub == predicate.condition_arg);
                continue;
            }
            default:
            {
                predicateResults.push_back(false);
            }
        }
    }

    // Evaluate the group of predicates
    switch (predicateGroup.logic)
    {
        case G_LOGIC::AND:
        {
            return std::ranges::all_of(
                predicateResults,
                [](const bool result)
                {
                    return result;
                });
        }
        case G_LOGIC::OR:
        {
            return std::ranges::any_of(
                predicateResults,
                [](const bool result)
                {
                    return result;
                });
        }
        default:
            return false;
    }
}

bool CGambitsContainer::TryTrustSkill()
{
    TracyZoneScoped;

    auto* target = POwner->GetBattleTarget();

    if (!target)
    {
        return false;
    }

    auto checkTPTrigger = [&]() -> bool
    {
        if (POwner->health.tp >= 3000)
        {
            return true;
        } // Go, go, go!

        switch (tp_trigger)
        {
            case G_TP_TRIGGER::ASAP:
            {
                return true;
                break;
            }
            case G_TP_TRIGGER::OPENER:
            {
                bool result = false;
                // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (PMember->health.tp >= 1000 && PMember != POwner)
                        {
                            result = true;
                        }
                    });
                // clang-format on
                return result;
                break;
            }
            case G_TP_TRIGGER::CLOSER: // Hold TP indefinitely to close a SC.
            {
                auto* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

                // TODO: ...and has a valid WS...

                return PSCEffect && PSCEffect->GetStartTime() + 3s < timer::now() && PSCEffect->GetTier() == 0;
                break;
            }
            case G_TP_TRIGGER::CLOSER_UNTIL_TP: // Will hold TP to close a SC, but WS immediately once specified value is reached.
            {
                if (tp_value <= 1500) // If the value provided by the script is missing or too low
                {
                    tp_value = 1500; // Apply the minimum TP Hold Threshold
                }
                if (POwner->health.tp >= tp_value) // tp_value reached
                {
                    return true; // Time to WS!
                }
                auto* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

                // TODO: ...and has a valid WS...

                return PSCEffect && PSCEffect->GetStartTime() + 3s < timer::now() && PSCEffect->GetTier() == 0;
                break;
            }
            default:
            {
                return false;
                break;
            }
        }
    };

    Maybe<TrustSkill_t> chosen_skill;
    SKILLCHAIN_ELEMENT  chosen_skillchain = SC_NONE;
    if (checkTPTrigger() && !tp_skills.empty())
    {
        switch (tp_select)
        {
            case G_SELECT::RANDOM:
            {
                auto* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

                if (!PSCEffect) // Opener, if no skillchain available select a random ws
                {
                    chosen_skill = xirand::GetRandomElement(tp_skills);
                    break;
                }

                // Closer, if a skillchain is available select a random ws that can close it, if multiple are available select the one that creates the best skillchain
                for (auto& skill : tp_skills)
                {
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::list<SKILLCHAIN_ELEMENT> skillProperties;
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.primary);
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.secondary);
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                    if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties);
                        possible_skillchain != SC_NONE)
                    {
                        if (possible_skillchain >= chosen_skillchain)
                        {
                            chosen_skill      = skill;
                            chosen_skillchain = possible_skillchain;
                        }
                    }
                }
                break;
            }
            case G_SELECT::HIGHEST: // Form the best possible skillchain
            {
                auto* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

                if (!PSCEffect) // Opener
                {
                    // TODO: This relies on the skills being passed in in some kind of correct order...
                    // Probably best to do this another way
                    chosen_skill = tp_skills.at(tp_skills.size() - 1);
                    break;
                }

                // Closer
                for (auto& skill : tp_skills)
                {
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::list<SKILLCHAIN_ELEMENT> skillProperties;
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.primary);
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.secondary);
                    skillProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                    if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties);
                        possible_skillchain != SC_NONE)
                    {
                        if (possible_skillchain >= chosen_skillchain)
                        {
                            chosen_skill      = skill;
                            chosen_skillchain = possible_skillchain;
                        }
                    }
                }
                break;
            }
            case G_SELECT::SPECIAL_AYAME:
            {
                auto* PMaster                = static_cast<CCharEntity*>(POwner->PMaster);
                auto* PMasterController      = static_cast<CPlayerController*>(PMaster->PAI->GetController());
                auto* PMasterLastWeaponSkill = PMasterController->getLastWeaponSkill();

                if (PMasterLastWeaponSkill != nullptr)
                {
                    for (auto& skill : tp_skills)
                    {
                        std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.primary);
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.secondary);
                        resonanceProperties.emplace_back((SKILLCHAIN_ELEMENT)skill.tertiary);

                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.emplace_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getPrimarySkillchain());
                        skillProperties.emplace_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getSecondarySkillchain());
                        skillProperties.emplace_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getTertiarySkillchain());
                        if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties);
                            possible_skillchain != SC_NONE)
                        {
                            if (possible_skillchain >= chosen_skillchain)
                            {
                                chosen_skill      = skill;
                                chosen_skillchain = possible_skillchain;
                            }
                        }
                    }
                }
                else
                {
                    chosen_skill = tp_skills.at(tp_skills.size() - 1);
                }

                break;
            }
            case G_SELECT::SPECIAL_AUGUST:
            {
                static const uint32                     NO_QUARTER  = 3658;
                static const std::unordered_set<uint32> daybreak_ws = { 3656, 3657 };
                static const std::unordered_set<uint32> regular_ws  = { 3653, 3654, 3655 };

                bool   maybeDaybreakActive = POwner->animationsub == 5; // Daybreak active is sub animation 5, retail does the same thing.
                uint32 lastSkillUsed       = POwner->GetLocalVar("[Gambit]LastDaybreakSkill");

                std::vector<TrustSkill_t> candidates;

                if (maybeDaybreakActive)
                {
                    // Only trigger No Quarter if the last skill used was ACTUALLY a Daybreak opener
                    if (daybreak_ws.count(lastSkillUsed))
                    {
                        for (auto const& tskill : tp_skills)
                        {
                            if (tskill.skill_id == NO_QUARTER)
                            {
                                chosen_skill = tskill;
                                break;
                            }
                        }
                    }

                    // If we didn't pick No Quarter (either lastSkill was 0 or a regular skill)
                    if (!chosen_skill)
                    {
                        for (auto const& tskill : tp_skills)
                        {
                            if (daybreak_ws.count(tskill.skill_id))
                            {
                                candidates.push_back(tskill);
                            }
                        }
                    }
                }
                else
                {
                    // Normal state: use standard rotation
                    for (auto const& tskill : tp_skills)
                    {
                        if (regular_ws.count(tskill.skill_id))
                        {
                            candidates.push_back(tskill);
                        }
                    }
                    // Clear the localVar so the next Daybreak starts fresh
                    if (lastSkillUsed != 0)
                    {
                        POwner->SetLocalVar("[Gambit]LastDaybreakSkill", 0);
                    }
                }

                if (!candidates.empty() && !chosen_skill)
                {
                    chosen_skill = xirand::GetRandomElement(candidates);
                }

                // Only update the localVar if actually picked a skill
                applyTo(chosen_skill, [&](const TrustSkill_t& skill)
                        {
                            POwner->SetLocalVar("[Gambit]LastDaybreakSkill", skill.skill_id);
                        });

                break;
            }
            default:
            {
                break;
            }
        }
    }

    if (chosen_skill)
    {
        auto* controller = static_cast<CTrustController*>(POwner->PAI->GetController());
        if (chosen_skill->skill_type == G_REACTION::WS)
        {
            CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(chosen_skill->skill_id);
            if (PWeaponSkill == nullptr)
            {
                ShowError("G_REACTION::WS: PWeaponSkill was null.");
                return false;
            }

            if (chosen_skill->valid_targets & TARGET_SELF)
            {
                target = POwner;
            }
            else
            {
                target = POwner->GetBattleTarget();
            }
            controller->WeaponSkill(target->targid, PWeaponSkill->getID());
        }
        else // Mobskill
        {
            if (chosen_skill->valid_targets & TARGET_SELF || chosen_skill->valid_targets & TARGET_PLAYER_PARTY)
            {
                target = POwner;
            }
            else
            {
                target = POwner->GetBattleTarget();
            }
            controller->MobSkill(target->targid, chosen_skill->skill_id, std::nullopt);
        }
        return true;
    }
    return false;
}

// currently only used for Uka Totlihn to determin what samba to use.
bool CGambitsContainer::PartyHasHealer()
{
    bool hasHealer = false;
    // clang-format off
        static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
        {
            auto jobType = PMember->GetMJob();

            if (jobType == JOB_WHM || jobType == JOB_RDM || jobType == JOB_PLD || jobType == JOB_SCH)
            {
                hasHealer = true;
            }
        });
    // clang-format on
    return hasHealer;
}

// used to check for tanks in party (Volker, AA Hume)
bool CGambitsContainer::PartyHasTank()
{
    bool hasTank = false;
    // clang-format off
        static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
        {
            auto jobType = PMember->GetMJob();

            if (jobType == JOB_NIN || jobType == JOB_PLD || jobType == JOB_RUN)
            {
                hasTank = true;
            }
        });
    // clang-format on
    return hasTank;
}

} // namespace gambits
