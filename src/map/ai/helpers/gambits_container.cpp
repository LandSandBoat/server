#include "gambits_container.h"

#include "../../ability.h"
#include "../../ai/states/ability_state.h"
#include "../../ai/states/magic_state.h"
#include "../../ai/states/mobskill_state.h"
#include "../../ai/states/petskill_state.h"
#include "../../ai/states/range_state.h"
#include "../../ai/states/weaponskill_state.h"
#include "../../enmity_container.h"
#include "../../mobskill.h"
#include "../../spell.h"
#include "../../utils/battleutils.h"
#include "../../utils/trustutils.h"
#include "../../weapon_skill.h"

#include "../../weapon_skill.h"
#include "../controllers/player_controller.h"
#include "../controllers/trust_controller.h"

namespace gambits
{
    // Validate gambit before it's inserted into the gambit list
    // Check levels, etc.
    std::string CGambitsContainer::AddGambit(Gambit_t const& gambit)
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
                }
            }
        }
        if (available)
        {
            gambits.push_back(gambit);
            return gambit.identifier;
        }
        return "";
    }

    void CGambitsContainer::RemoveGambit(std::string const& id)
    {
        gambits.erase(
            std::remove_if(gambits.begin(), gambits.end(),
                           [&id](Gambit_t const& gambit)
                           { return gambit.identifier == id; }),
            gambits.end());
    }

    void CGambitsContainer::RemoveAllGambits()
    {
        gambits.clear();
    }

    void CGambitsContainer::Tick(time_point tick)
    {
        TracyZoneScoped;

        auto* controller      = static_cast<CTrustController*>(POwner->PAI->GetController());
        uint8 currentPartyPos = controller->GetPartyPosition();
        auto  position_offset = static_cast<std::chrono::milliseconds>(currentPartyPos * 10);

        if ((tick + position_offset) < m_lastAction)
        {
            return;
        }

        // TODO: Is this necessary?
        // Not already doing something
        if (POwner->PAI->IsCurrentState<CAbilityState>() || POwner->PAI->IsCurrentState<CRangeState>() || POwner->PAI->IsCurrentState<CMagicState>() ||
            POwner->PAI->IsCurrentState<CWeaponSkillState>() || POwner->PAI->IsCurrentState<CMobSkillState>() ||
            POwner->PAI->IsCurrentState<CPetSkillState>())
        {
            return;
        }

        auto random_offset = static_cast<std::chrono::milliseconds>(xirand::GetRandomNumber(1000, 2500));
        m_lastAction       = tick + random_offset;

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
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                    {
                        result = true;
                    }
                });
                // clang-format on
                return result;
            }
            else if (predicate.target == G_TARGET::MASTER)
            {
                return CheckTrigger(POwner->PMaster, predicate);
            }
            else if (predicate.target == G_TARGET::PARTY_DEAD)
            {
                auto result = false;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (PMember->isDead())
                    {
                        result = true;
                    }
                });
                // clang-format on
                return result;
            }
            else if (predicate.target == G_TARGET::TANK)
            {
                auto result = false;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                    {
                        result = true;
                    }
                });
                // clang-format on
                return result;
            }
            else if (predicate.target == G_TARGET::MELEE)
            {
                auto result = false;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                    {
                        result = true;
                    }
                });
                // clang-format on
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
                    } });
                return result;
            }
            else if (predicate.target == G_TARGET::CASTER)
            {
                auto result = false;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                    {
                        result = true;
                    }
                });
                // clang-format on
                return result;
            }
            else if (predicate.target == G_TARGET::TOP_ENMITY)
            {
                auto result = false;
                if (auto* PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(PMember) && CheckTrigger(PMember, predicate) && PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                        {
                            result = true;
                        }
                    });
                    // clang-format on
                }
                return result;
            }
            else if (predicate.target == G_TARGET::CURILLA)
            {
                auto result = false;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                    {
                        auto name = PMember->GetName();
                        if (strcmpi(name.c_str(), "curilla") == 0)
                        {
                            result = true;
                        }
                    }
                });
                // clang-format on
                return result;
            }
            else if (predicate.target == G_TARGET::PARTY_MULTI)
            {
                uint8 count = 0;
                // clang-format off
                static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                {
                    if (isValidMember(PMember) && CheckTrigger(PMember, predicate))
                    {
                        ++count;
                    }
                });
                // clang-format on
                return count > 1;
            }

            // Fallthrough
            return false;
        };

        // Didn't WS/MS, go for other Gambits
        for (auto& gambit : gambits)
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
                if (!all_predicates_true)
                {
                    break;
                }

                auto isValidMember = [this](CBattleEntity* PSettableTarget, CBattleEntity* PPartyTarget)
                {
                    return !PSettableTarget && PPartyTarget->isAlive() && POwner->loc.zone == PPartyTarget->loc.zone &&
                           distance(POwner->loc.p, PPartyTarget->loc.p) <= 15.0f;
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
                    auto* mob = POwner->GetBattleTarget();
                    target    = CheckTrigger(mob, gambit.predicates[0]) ? mob : nullptr;
                }
                else if (gambit.predicates[0].target == G_TARGET::PARTY)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]))
                        {
                            target = PMember;
                        }
                    });
                    // clang-format on
                }
                else if (gambit.predicates[0].target == G_TARGET::MASTER)
                {
                    target = POwner->PMaster;
                }
                else if (gambit.predicates[0].target == G_TARGET::PARTY_DEAD)
                {
                    auto* mob = POwner->GetBattleTarget();
                    if (mob != nullptr)
                    {
                        // clang-format off
                        static_cast<CCharEntity*>(POwner->PMaster)->ForParty([&](CBattleEntity* PMember) {
                            if (PMember->isDead())
                            {
                                target = PMember;
                            }
                        });
                        // clang-format on
                    }
                }
                else if (gambit.predicates[0].target == G_TARGET::TANK)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) &&
                            (PMember->GetMJob() == JOB_PLD || PMember->GetMJob() == JOB_RUN))
                        {
                            target = PMember;
                        }
                    });
                    // clang-format on
                }
                else if (gambit.predicates[0].target == G_TARGET::MELEE)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) &&
                            melee_jobs.find(PMember->GetMJob()) != melee_jobs.end())
                        {
                            target = PMember;
                        }
                    });
                    // clang-format on
                }
                else if (gambit.predicates[0].target == G_TARGET::RANGED)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) &&
                            (PMember->GetMJob() == JOB_RNG || PMember->GetMJob() == JOB_COR))
                        {
                            target = PMember;
                        }
                    });
                    // clang-format on
                }
                else if (gambit.predicates[0].target == G_TARGET::CASTER)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) &&
                            caster_jobs.find(PMember->GetMJob()) != caster_jobs.end())
                        {
                            target = PMember;
                        }
                    });
                    // clang-format on
                }
                else if (gambit.predicates[0].target == G_TARGET::TOP_ENMITY)
                {
                    if (auto* PMob = dynamic_cast<CMobEntity*>(POwner->GetBattleTarget()))
                    {
                        // clang-format off
                        static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                        {
                            if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]) &&
                                PMob->PEnmityContainer->GetHighestEnmity() == PMember)
                            {
                                target = PMember;
                            }
                        });
                        // clang-format on
                    }
                }
                else if (gambit.predicates[0].target == G_TARGET::CURILLA)
                {
                    // clang-format off
                    static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
                    {
                        if (isValidMember(target, PMember) && CheckTrigger(PMember, gambit.predicates[0]))
                        {
                            auto name = PMember->GetName();
                            if (strcmpi(name.c_str(), "curilla") == 0)
                            {
                                target = PMember;
                            }
                        }
                    });
                    // clang-format on
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
                            controller->Cast(target->targid, spell_id.value());
                        }
                    }
                    else if (action.select == G_SELECT::HIGHEST)
                    {
                        auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(action.select_arg));
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                        }
                    }
                    else if (action.select == G_SELECT::LOWEST)
                    {
                        // TODO
                        // auto spell_id = POwner->SpellContainer->GetWorstAvailable(static_cast<SPELLFAMILY>(gambit.action.select_arg));
                        // if (spell_id.has_value())
                        //{
                        //    controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                        //}
                    }
                    else if (action.select == G_SELECT::BEST_INDI)
                    {
                        auto* PMaster  = static_cast<CCharEntity*>(POwner->PMaster);
                        auto  spell_id = POwner->SpellContainer->GetBestIndiSpell(PMaster);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
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
                        }
                    }
                    else if (action.select == G_SELECT::BEST_AGAINST_TARGET)
                    {
                        auto spell_id = POwner->SpellContainer->GetBestAgainstTargetWeakness(target);
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                        }
                    }
                    else if (action.select == G_SELECT::STORM_DAY)
                    {
                        auto spell_id = POwner->SpellContainer->GetStormDay();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                        }
                    }
                    else if (action.select == G_SELECT::HELIX_DAY)
                    {
                        auto spell_id = POwner->SpellContainer->GetHelixDay();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
                        }
                    }
                    else if (action.select == G_SELECT::RANDOM)
                    {
                        auto spell_id = POwner->SpellContainer->GetSpell();
                        if (spell_id.has_value())
                        {
                            controller->Cast(target->targid, spell_id.value());
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
                                for (size_t i = POwner->SpellContainer->m_damageList.size(); i > 0; --i)
                                {
                                    auto spell         = POwner->SpellContainer->m_damageList[i - 1];
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
                        }
                    }
                }
                else if (action.reaction == G_REACTION::JA)
                {
                    CAbility* PAbility = ability::GetAbility(action.select_arg);
                    auto      mLevel   = POwner->GetMLevel();

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

                        for (ABILITY const& waltz : wlist)
                        {
                            auto   waltzLevel = ability::GetAbility(waltz)->getLevel();
                            uint16 tpCost     = 0;

                            if (mLevel >= waltzLevel)
                            {
                                switch (ability::GetAbility(waltz)->getID())
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
                                    PAbility = ability::GetAbility(waltz);
                                    controller->Ability(target->targid, PAbility->getID());
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
                                    PAbility = ability::GetAbility(ABILITY_HASTE_SAMBA);
                                    tpCost   = 350;
                                }
                                else
                                {
                                    PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_III);
                                    tpCost   = 400;
                                }
                            }
                            else if (mLevel < 65 && mLevel > 45)
                            {
                                if (PartyHasHealer())
                                {
                                    PAbility = ability::GetAbility(ABILITY_HASTE_SAMBA);
                                    tpCost   = 350;
                                }
                                else
                                {
                                    PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II);
                                    tpCost   = 250;
                                }
                            }
                            else if (mLevel < 45 && mLevel > 35)
                            {
                                PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA_II);
                                tpCost   = 250;
                            }
                            else
                            {
                                PAbility = ability::GetAbility(ABILITY_DRAIN_SAMBA);
                                tpCost   = 100;
                            }
                        }

                        if (tpCost != 0 && (currentTP >= tpCost))
                        {
                            controller->Ability(target->targid, PAbility->getID());
                        }
                    }
                }
                else if (action.reaction == G_REACTION::MS)
                {
                    if (action.select == G_SELECT::SPECIFIC)
                    {
                        controller->MobSkill(target->targid, action.select_arg);
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

        auto* controller = static_cast<CTrustController*>(POwner->PAI->GetController());
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
            case G_CONDITION::NO_SAMBA:
            {
                bool noSamba = true;
                if (trigger_target->StatusEffectContainer->HasStatusEffect(EFFECT_DRAIN_SAMBA) ||
                    trigger_target->StatusEffectContainer->HasStatusEffect(EFFECT_HASTE_SAMBA))
                {
                    noSamba = false;
                }
                return noSamba;
                break;
            }
            case G_CONDITION::NO_STORM:
            {
                bool noStorm = true;
                // clang-format off
                if (trigger_target->StatusEffectContainer->HasStatusEffect(
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
                return noStorm;
                break;
            }
            case G_CONDITION::PT_HAS_TANK:
            {
                return PartyHasTank();
                break;
            }
            case G_CONDITION::NOT_PT_HAS_TANK:
            {
                return !PartyHasTank();
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
                auto* PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
                break;
            }
            case G_CONDITION::NOT_SC_AVAILABLE:
            {
                auto* PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect == nullptr;
                break;
            }
            case G_CONDITION::MB_AVAILABLE:
            {
                auto* PSCEffect = trigger_target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
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
            case G_CONDITION::IS_ECOSYSTEM:
            {
                return trigger_target->m_EcoSystem == ECOSYSTEM(predicate.condition_arg);
                break;
            }
            case G_CONDITION::RANDOM:
            {
                return xirand::GetRandomNumber<uint16>(100) < (int16)predicate.condition_arg;
                break;
            }
            case G_CONDITION::HP_MISSING:
            {
                return (trigger_target->health.maxhp - trigger_target->health.hp) >= (int16)predicate.condition_arg;
                break;
            }
            default:
            {
                return false;
                break;
            }
        }
    }

    bool CGambitsContainer::TryTrustSkill()
    {
        TracyZoneScoped;

        auto* target = POwner->GetBattleTarget();

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

                    return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
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
        SKILLCHAIN_ELEMENT          chosen_skillchain = SC_NONE;
        if (checkTPTrigger() && !tp_skills.empty())
        {
            switch (tp_select)
            {
                case G_SELECT::RANDOM:
                {
                    chosen_skill = xirand::GetRandomElement(tp_skills);
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
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power & 0xF));
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 4 & 0xF));
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)(power >> 8));
                        }

                        std::list<SKILLCHAIN_ELEMENT> skillProperties;
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                        skillProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);
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
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)skill.primary);
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)skill.secondary);
                            resonanceProperties.push_back((SKILLCHAIN_ELEMENT)skill.tertiary);

                            std::list<SKILLCHAIN_ELEMENT> skillProperties;
                            skillProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getPrimarySkillchain());
                            skillProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getSecondarySkillchain());
                            skillProperties.push_back((SKILLCHAIN_ELEMENT)PMasterLastWeaponSkill->getTertiarySkillchain());
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
                controller->MobSkill(target->targid, chosen_skill->skill_id);
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
