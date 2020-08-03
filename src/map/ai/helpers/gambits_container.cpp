#include "gambits_container.h"

#include "../../ability.h"
#include "../../spell.h"
#include "../../weapon_skill.h"
#include "../../utils/battleutils.h"

namespace gambits
{

// Validate gambit before it's inserted into the gambit list
// Check levels, etc.
void CGambitsContainer::AddGambit(Gambit_t gambit)
{
    bool available = true;
    if (gambit.action.reaction == G_REACTION::MA && gambit.action.select == G_SELECT::SPECIFIC)
    {
        if (!spell::CanUseSpell(static_cast<CBattleEntity*>(POwner), static_cast<SpellID>(gambit.action.select_arg)))
        {
            available = false;
        }
    }
    if (available)
    {
        gambits.push_back(gambit);
    }
}

void CGambitsContainer::Tick(time_point tick)
{
    if (tick < m_lastAction)
    {
        return;
    }
    auto random_offset = static_cast<std::chrono::milliseconds>(tpzrand::GetRandomNumber(1000, 2500));
    m_lastAction = tick + random_offset;

    auto controller = static_cast<CTrustController*>(POwner->PAI->GetController());

    for (auto gambit : gambits)
    {
        if (tick < gambit.last_used + std::chrono::seconds(gambit.retry_delay))
        {
            continue;
        }

        auto checkTrigger = [&](CBattleEntity* target, Predicate_t& predicate) -> bool
        {
            switch (predicate.condition)
            {
            case G_CONDITION::ALWAYS:
            {
                return true;
                break;
            }
            case G_CONDITION::HPP_LT:
            {
                return target->GetHPP() < predicate.condition_arg;
                break;
            }
            case G_CONDITION::HPP_GTE:
            {
                return target->GetHPP() >= predicate.condition_arg;
                break;
            }
            case G_CONDITION::MPP_LT:
            {
                return target->GetMPP() < predicate.condition_arg;
                break;
            }
            case G_CONDITION::TP_LT:
            {
                return target->health.tp < predicate.condition_arg;
                break;
            }
            case G_CONDITION::TP_GTE:
            {
                return target->health.tp >= predicate.condition_arg;
                break;
            }
            case G_CONDITION::STATUS:
            {
                return target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
                break;
            }
            case G_CONDITION::NOT_STATUS:
            {
                return !target->StatusEffectContainer->HasStatusEffect(static_cast<EFFECT>(predicate.condition_arg));
                break;
            }
            case G_CONDITION::STATUS_FLAG:
            {
                return target->StatusEffectContainer->HasStatusEffectByFlag(static_cast<EFFECTFLAG>(predicate.condition_arg));
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
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() == 0;
                break;
            }
            case G_CONDITION::NOT_SC_AVAILABLE:
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect == nullptr;
                break;
            }
            case G_CONDITION::MB_AVAILABLE:
            {
                auto PSCEffect = target->StatusEffectContainer->GetStatusEffect(EFFECT_SKILLCHAIN);
                return PSCEffect && PSCEffect->GetStartTime() + 3s < server_clock::now() && PSCEffect->GetTier() > 0;
                break;
            }
            default: { return false;  break; }
            }
        };

        CBattleEntity* target = nullptr;
        if (gambit.predicate.target == G_TARGET::SELF)
        {
            target = checkTrigger(POwner, gambit.predicate) ? POwner : nullptr;
        }
        else if (gambit.predicate.target == G_TARGET::TARGET)
        {
            auto mob = POwner->GetBattleTarget();
            target = checkTrigger(mob, gambit.predicate) ? mob : nullptr;
        }
        else if (gambit.predicate.target == G_TARGET::PARTY)
        {
            auto isValidMember = [&](CBattleEntity* PPartyTarget)
            {
                return !target && PPartyTarget->isAlive() &&
                    POwner->loc.zone == PPartyTarget->loc.zone &&
                    distance(POwner->loc.p, PPartyTarget->loc.p) <= 15.0f;
            };

            static_cast<CCharEntity*>(POwner->PMaster)->ForPartyWithTrusts([&](CBattleEntity* PMember)
            {
                if (isValidMember(PMember) && checkTrigger(PMember, gambit.predicate))
                {
                    target = PMember;
                }
            });
        }
        else if (gambit.predicate.target == G_TARGET::MASTER)
        {
            target = POwner->PMaster;
        }
        else if (gambit.predicate.target == G_TARGET::TANK)
        {
            // TODO
        }

        if (target)
        {
            if (gambit.action.reaction == G_REACTION::MA)
            {
                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    auto spell_id = POwner->SpellContainer->GetAvailable(static_cast<SpellID>(gambit.action.select_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (gambit.action.select == G_SELECT::HIGHEST)
                {
                    auto spell_id = POwner->SpellContainer->GetBestAvailable(static_cast<SPELLFAMILY>(gambit.action.select_arg));
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (gambit.action.select == G_SELECT::LOWEST)
                {
                    // TODO
                    //auto spell_id = POwner->SpellContainer->GetWorstAvailable(static_cast<SPELLFAMILY>(gambit.action.select_arg));
                    //if (spell_id.has_value())
                    //{
                    //    controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    //}
                }
                else if (gambit.action.select == G_SELECT::RANDOM)
                {
                    auto spell_id = POwner->SpellContainer->GetSpell();
                    if (spell_id.has_value())
                    {
                        controller->Cast(target->targid, static_cast<SpellID>(spell_id.value()));
                    }
                }
                else if (gambit.action.select == G_SELECT::MB_ELEMENT)
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
            else if (gambit.action.reaction == G_REACTION::JA)
            {
                CAbility* PAbility = ability::GetAbility(gambit.action.select_arg);
                if (PAbility->getValidTarget() == TARGET_SELF)
                {
                    target = POwner;
                }
                else
                {
                    target = POwner->GetBattleTarget();
                }

                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    controller->Ability(target->targid, PAbility->getID());
                }
            }
            else if (gambit.action.reaction == G_REACTION::WS)
            {
                CWeaponSkill* PWeaponSkill = battleutils::GetWeaponSkill(gambit.action.select_arg);
                if (battleutils::isValidSelfTargetWeaponskill(PWeaponSkill->getID()))
                {
                    target = POwner;
                }
                else
                {
                    target = POwner->GetBattleTarget();
                }

                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    controller->WeaponSkill(target->targid, PWeaponSkill->getID());
                }
            }
            else if (gambit.action.reaction == G_REACTION::MS)
            {
                if (gambit.action.select == G_SELECT::SPECIFIC)
                {
                    auto mob = POwner->GetBattleTarget();
                    controller->MobSkill(mob->targid, gambit.action.select_arg);
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

} // namespace gambits