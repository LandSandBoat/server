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

#include "action.h"
#include "utils/battleutils.h"

void action_result_t::recordSkillchain(const ActionProcSkillChain effect, const int16_t dmg)
{
    if (dmg < 0)
    {
        // Absorbs damage
        this->addEffectParam   = -dmg;
        this->addEffectMessage = static_cast<MsgBasic>(384 + static_cast<uint8_t>(effect));
    }
    else
    {
        this->addEffectParam   = dmg;
        this->addEffectMessage = static_cast<MsgBasic>(287 + static_cast<uint8_t>(effect));
    }

    this->additionalEffect = effect;
}

auto action_result_t::recordDamage(const attack_outcome_t& outcome) -> action_result_t&
{
    this->param = outcome.damage;

    // Every attack type sets this bit if the target died as a result
    if (outcome.target && outcome.target->isDead())
    {
        this->info |= ActionInfo::Defeated;
    }

    switch (outcome.atkType)
    {
        case ATTACK_TYPE::SPECIAL:  // Assumed
        case ATTACK_TYPE::PHYSICAL: // Confirmed
        case ATTACK_TYPE::RANGED:   // Confirmed
        {
            if (outcome.isCritical)
            {
                this->info |= ActionInfo::CriticalHit;
            }

            // Set the defender hit recoil (HitDistortion) based on HPP dealt
            if (const auto* PTarget = outcome.target)
            {
                // Calculate damage percentage
                const uint8_t damageHPP  = PTarget->GetMaxHP() > 0 ? static_cast<uint8_t>((outcome.damage * 100) / PTarget->GetMaxHP()) : 0;
                auto          distortion = HitDistortion::None;

                // Values below need to be refined
                // Lower level mobs appear to use slightly different thresholds
                if (damageHPP >= 20)
                {
                    distortion = HitDistortion::Heavy;
                }
                else if (damageHPP >= 10)
                {
                    distortion = HitDistortion::Medium;
                }
                else if (damageHPP > 0)
                {
                    distortion = HitDistortion::Light;
                }

                this->hitDistortion = distortion;
            }

            break;
        }
        default:
            break;
    }

    return *this;
}

// Cleans up the action_t struct before bitpacking
// This sets various fields that have fixed values and are not worth setting before hand
void action_t::normalize()
{
    // Only MagicFinish emits recast
    if (actiontype != ActionCategory::MagicFinish)
    {
        recast = 0s;
    }

    switch (actiontype)
    {
        case ActionCategory::BasicAttack:
        {
            this->actionid = static_cast<uint32_t>(FourCC::BasicAttack);

            // result.kind is always 1
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 1;
                          });
            break;
        }
        case ActionCategory::RangedFinish:
        {
            // result.kind is always 2
            // Note: XiPackets claim this is always 1
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 2;
                          });
            break;
        }
        case ActionCategory::SkillFinish:
        {
            // result.kind is always 3
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 3;
                          });
            break;
        }
        case ActionCategory::ItemFinish:
        {
            // result.kind is always 1
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 1;
                          });
            break;
        }
        case ActionCategory::AbilityFinish:
        {
            // result.kind is always 2
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 2;
                          });
            break;
        }
        case ActionCategory::MagicStart:
        case ActionCategory::MagicFinish:
        case ActionCategory::RangedStart:
        case ActionCategory::SkillStart:
        case ActionCategory::ItemStart:
        case ActionCategory::AbilityStart:
        {
            // While retail will show varied values in 'kind',
            // they don't appear to be used by the client and are not consistently set
            // indicating they may just be uncleared buffers leftovers.
            break;
        }
        case ActionCategory::MobSkillFinish:
        {
            // XiPackets claim this is 2 for trusts, 3 for mobs
            // But captures only show 3 for either.
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 3;
                          });
            break;
        }
        case ActionCategory::PetSkillFinish:
        {
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 3;
                          });
            break;
        }
        case ActionCategory::Dancer:
        {
            // result.kind is always 2
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 2;
                          });
            break;
        }
        case ActionCategory::RuneFencer:
        {
            // result.kind is always 3
            ForEachResult([](action_result_t& result)
                          {
                              result.kind = 3;
                          });
            break;
        }
        default:
            break;
    }
}
