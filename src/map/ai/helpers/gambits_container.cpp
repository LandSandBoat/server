#include "gambits_container.h"

#include "../../ability.h"
#include "../../enmity_container.h"
#include "../../spell.h"
#include "../../mobskill.h"
#include "../../weapon_skill.h"
#include "../../ai/states/ability_state.h"
#include "../../ai/states/mobskill_state.h"
#include "../../ai/states/magic_state.h"
#include "../../ai/states/range_state.h"
#include "../../ai/states/weaponskill_state.h"
#include "../../utils/battleutils.h"
#include "../../utils/trustutils.h"

#include "../controllers/player_controller.h"
#include "../../weapon_skill.h"

namespace gambits
{

// Validate gambit before it's inserted into the gambit list
// Check levels, etc.
void CGambitsContainer::AddGambit(Gambit_t gambit)
{
    TracyZoneScoped;

    bool available = true;
    for (auto& action : gambit.actions)
    {
        if (action.reaction == G_REACTION::MA && action.select == G_SELECT::SPECIFIC)
        {
            if (!spell::CanUseSpell(static_cast<CBattleEntity*>(POwner), static_cast<SpellID>(action.select_arg)))
            {
                available = false;
            }
        }
    }
    if (available)
    {
        gambits.push_back(gambit);
    }
}

void CGambitsContainer::Tick(time_point tick)
{
    TracyZoneScoped;

    if (tick < m_lastAction)
    {
        return;
    }

    // TODO: Is this necessary?
    // Not already doing something
    if (POwner->PAI->IsCurrentState<CAbilityState>() ||
        POwner->PAI->IsCurrentState<CRangeState>() ||
        POwner->PAI->IsCurrentState<CMagicState>() ||
        POwner->PAI->IsCurrentState<CWeaponSkillState>() ||
        POwner->PAI->IsCurrentState<CMobSkillState>())
    {
        return;
    }

    auto random_offset = static_cast<std::chrono::milliseconds>(tpzrand::GetRandomNumber(1000, 2500));
    m_lastAction = tick + random_offset;

    auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());

    // Deal with TP skills before any gambits
    // TODO: Should this be its own special gambit?
    if (POwner->health.tp >= 1000 && TryTrustSkill())
    {
        return;
    }

    auto runPredicate = [&](Predicate_t& predicate) -> bool
    {
        auto isValidMember = [&](CBattleEntity* PPartyTarget) -> bool
        {
            return PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone && distance(POwner->loc.p, PPartyTarget->loc.p) <= 15.0f;
        };

        if (predicate.target == G_TARGET::SELF)
        {
            return CheckTrigger(POwner, predicate);
        }
        else if (predicate.target == G_TARGET::TARGET)
        {
            return CheckTrigger(POwner->GetBattleTarget(), predicate);
        }
        else if (predicate.target == G_TARGET::PARTY)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::MASTER)
        {
            return CheckTrigger(POwner->PMaster, predicate);
        }
        else if (predicate.target == G_TARGET::TANK)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::MELEE)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::RANGED)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::CASTER)
        {
            auto result = false;
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                {
                    result = true;
                }
            });
            return result;
        }
        else if (predicate.target == G_TARGET::TOP_ENMITY)
        {
            auto result = false;
            if (auto PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                    {
                        result = true;
                    }
                });
            }
            return result;
        }

        // Fallthrough
        return false;
    };

    // Didn't WS/MS, go for other Gambits
    for (auto gambit : gambits)
    {
        if (tick < gambit.last_used + std::chrono::seconds(gambit.retry_delay))
        {
            continue;
        }

        for (auto& action : gambit.actions)
        {
            // Make sure that the predicates remain true for each action in a gambit
            bool all_predicates_true = true;
            for (auto& predicate : gambit.predicates)
            {
                if (!runPredicate(predicate))
                {
                    all_predicates_true = false;
                }
            }
            if (!all_predicates_true) { break; }

            auto isValidMember = [this](CBattleEntity* PSettableTarget, CBattleEntity* PPartyTarget)
            {
                return !PSettableTarget && PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone && distance(POwner->loc.p, PPartyTarget->loc.p) <= 15.0f;
            };

            // TODO: This whole section is messy and bonkers
            // Try and extract target out the first predicate
            CBattleEntity* target = nullptr;
            if (gambit.predicates[0].target == G_TARGET::SELF)
            {
                target = CheckTrigger(POwner, gambit.predicates[0]) ? POwner : nullptr;
            }
            else if (gambit.predicates[0].target == G_TARGET::TARGET)
            {
                auto mob = POwner->GetBattleTarget();
                target = CheckTrigger(mob, gambit.predicates[0]) ? mob : nullptr;
            }
            else if (gambit.predicates[0].target == G_TARGET::PARTY)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::MASTER)
            {
                target = POwner->PMaster;
            }
            else if (gambit.predicates[0].target == G_TARGET::TANK)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::MELEE)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::RANGED)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::CASTER)
            {
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                    {
                        target = PMember;
                    }
                });
            }
            else if (gambit.predicates[0].target == G_TARGET::TOP_ENMITY)
            {
                if (auto PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
                {
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) && PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                        {
                            target = PMember;
                        }
                    });
                }
            }

            if (!target)
            {
                break;
            }

            if (action.reaction == G_REACTION::RATTACK)
            {
                controller->RangedAttack(target->targid);
            }
            else if (action.reaction == G_REACTION::MA)
            {
                if (action.select == G_SELECT::SPECIFIC)
                {
                    auto spell_id = POwner->SpellContainer->GetAvailable(static_cast<SpellID>(action.select_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.select == G_SELECT::HIGHEST)
                {
                    auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.select_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.select == G_SELECT::LOWEST)
                {
                    // TODO
                    //auto spell_id = POwner->SpellContainer->GetWorstAvailable(static_cast<SPELLFAMILY>(gambit.action.select_arg));
                    //if (spell_id.has_value())
                    //{
                    //    controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    //}
                }
                else if (action.select == G_SELECT::RANDOM)
                {
                    auto spell_id = POwner->SpellContainer->GetSpell();
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (action.select == G_SELECT::MB_ELEMENT)
                {
                    CStatusEffect* PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN, 0);
                    std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                    if (uint16 power = PSCEffect->GetPower())
                    {
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::optional<SpellID> spell_id;
                    for (auto& resonance_element : resonanceProperties)
                    {
                        for (auto& chain_element : battleutils::GetSkillchainMagicElement(resonance_element))
                        {
                            // TODO: SpellContianer->GetBestByElement(ELEMENT)
                            // NOTE: Iterating this list in reverse guarantees finding the best match
                            for (size_t i = POwner->SpellContainer->m_damageList.size(); i > 0 ; --i)
                            {
                                auto spell = POwner->SpellContainer->m_damageList[i-1];
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
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
            }
            else if (action.reaction == G_REACTION::JA)
            {
                CAbility* PAbility = ability::GetAbility(action.select_arg);
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
                }
            }
            else if (action.reaction == G_REACTION::MSG)
            {
                if (action.select == G_SELECT::SPECIFIC)
                {
                    //trustutils::SendTrustMessage(POwner, action.select_arg);
                }
            }

            // Assume success
            if (gambit.retry_delay != 0)
            {
                gambit.last_used = tick;
            }
        }
    }
}

bool CGambitsContainer::CheckTrigger(CBattleEntity* trigger_target, Predicate_t& predicate)
{
    TracyZoneScoped;

    auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());
    switch (predicate.condition)
    {
        case G_CONDITION::ALWAYS:
        {
            return true;
            break;
        }
        case G_CONDITION::HPP_LT:
        {
            return trigger_target->GetHPP() < predicate.condition_arg;
            break;
        }
        case G_CONDITION::HPP_GTE:
        {
            return trigger_target->GetHPP() >= predicate.condition_arg;
            break;
        }
        case G_CONDITION::MPP_LT:
        {
            return trigger_target->GetMPP() < predicate.condition_arg;
            break;
        }
        case G_CONDITION::TP_LT:
        {
            return trigger_target->health.tp < (int16)predicate.condition_arg;
            break;
        }
        case G_CONDITION::TP_GTE:
        {
            return trigger_target->health.tp >= (int16)predicate.condition_arg;
            break;
        }
        case G_CONDITION::STATUS:
        {
            return trigger_target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::NOT_STATUS:
        {
            return !trigger_target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::STATUS_FLAG:
        {
            return trigger_target->StatusEffectContainer->HasStatusEffectByFlag(static_cast<EFFECTFLAG>(predicate.condition_arg));
            break;
        }
        case G_CONDITION::HAS_TOP_ENMITY:
        {
            return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid == POwner->targid : false;
            break;
        }
        case G_CONDITION::NOT_HAS_TOP_ENMITY:
        {
            return (controller->GetTopEnmity()) ? controller->GetTopEnmity()->targid != POwner->targid : false;
            break;
        }
        case G_CONDITION::SC_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
            break;
        }
        case G_CONDITION::NOT_SC_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect == nullptr;
            break;
        }
        case G_CONDITION::MB_AVAILABLE:
        {
            auto PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() > 0;
            break;
        }
        case G_CONDITION::READYING_WS:
        {
            return trigger_target->PAI->IsCurrentState<CWeaponSkillState>();
            break;
        }
        case G_CONDITION::READYING_MS:
        {
            return trigger_target->PAI->IsCurrentState<CMobSkillState>();
            break;
        }
        case G_CONDITION::READYING_JA:
        {
            return trigger_target->PAI->IsCurrentState<CAbilityState>();
            break;
        }
        case G_CONDITION::CASTING_MA:
        {
            return trigger_target->PAI->IsCurrentState<CMagicState>();
            break;
        }
        case G_CONDITION::RANDOM:
        {
            return tpzrand::GetRandomNumber<uint16>(100) < (int16)predicate.condition_arg;
            break;
        }
        default: { return false;  break; }
    }
}

bool CGambitsContainer::TryTrustSkill()
{
    TracyZoneScoped;

    auto target = POwner->GetBattleTarget();

    auto checkTPTrigger = [&]() -> bool
    {
        if (POwner->health.tp >= 3000) { return true; } // Go, go, go!

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
            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&result](CBattleEntity* PMember)
            {
                if (PMember->health.tp >= 1000)
                {
                    result = true;
                }
            });
            return result;
            break;
        }
        case G_TP_TRIGGER::CLOSER:
        {
            auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

            // TODO: ...and has a valid WS...

            return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
            break;
        }
        default:
        {
            return false;
            break;
        }
        }
    };

    std::optional<TrustSkill_t> chosen_skill;
    SKILLCHAIN_ELEMENT chosen_skillchain = SC_NONE;
    if (checkTPTrigger() && !tp_skills.empty())
    {
        switch (tp_select)
        {
            case G_SELECT::RANDOM:
            {
                chosen_skill = tpzrand::GetRandomElement(tp_skills);                
                break;
            }
            case G_SELECT::HIGHEST: // Form the best possible skillchain
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);

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
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                    }

                    std::list<SKILLCHAIN_ELEMENT> skillProperties;
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                    skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                    if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties); possible_skillchain != SC_NONE)
                    {
                        if (possible_skillchain >= chosen_skillchain)
                        {
                            chosen_skill = skill;
                            chosen_skillchain = possible_skillchain;
                        }
                    }
                }
                break;
            }
            case G_SELECT::SPECIAL_AYAME:
            {
                auto PMaster = static_cast<CCharEntity*>(POwner->PMaster);
                auto PMasterController = static_cast<CPlayerController*>(PMaster->PAI->GetController());
                auto PMasterLastWeaponSkill = PMasterController->getLastWeaponSkill();

                if (PMasterLastWeaponSkill)
                {
                    for (auto& skill : tp_skills)
                    {
                        std::list<SKILLCHAIN_ELEMENT> resonanceProperties;
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getPrimarySkillchain());
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getSecondarySkillchain());
                        resonanceProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getTertiarySkillchain());

                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);
                        if (SKILLCHAIN_ELEMENT possible_skillchain = battleutils::FormSkillchain(resonanceProperties, skillProperties); possible_skillchain != SC_NONE)
                        {
                            if (possible_skillchain >= chosen_skillchain)
                            {
                                chosen_skill = skill;
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
            default: { break; }
        }
    }

    if (chosen_skill)
    {
        auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());
        if (chosen_skill->skill_type == G_REACTION::WS)
        {
            CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(chosen_skill->skill_id);
            if (battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
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
            controller->MobSkill(target->targid, chosen_skill->skill_id);
        }
        return true;
    }
    return false;
}

} // namespace gambits