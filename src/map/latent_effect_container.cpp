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

#include "latent_effect_container.h"

#include "ai/ai_container.h"
#include "conquest_system.h"
#include "entities/battle_entity.h"
#include "entities/char_entity.h"
#include "entities/trust_entity.h"
#include "items/item_weapon.h"
#include "latent_effect.h"
#include "modifier.h"
#include "status_effect_container.h"
#include "utils/battleutils.h"
#include "utils/zoneutils.h"

#include "time_server.h"

CLatentEffectContainer::CLatentEffectContainer(CCharEntity* PEntity)
: m_POwner(PEntity)
{
}

/************************************************************************
 *                                                                       *
 * Adds new latent effect to the character.                              *
 *                                                                       *
 ************************************************************************/

void CLatentEffectContainer::AddLatentEffects(std::vector<CItemEquipment::itemLatent>& latentList, uint8 reqLvl, uint8 slot)
{
    for (auto& latent : latentList)
    {
        if (m_POwner->GetMLevel() >= reqLvl || latent.ConditionsValue == static_cast<uint16>(xi::Latent::JobLevelAbove))
        {
            m_LatentEffectList.emplace_back(m_POwner, latent.ConditionsID, latent.ConditionsValue, slot, latent.ModValue, latent.ModPower);
        }
    }
}

/************************************************************************
 *                                                                       *
 * Removes all latent effects associated with a specified slot           *
 *                                                                       *
 ************************************************************************/

void CLatentEffectContainer::DelLatentEffects(uint8 reqLvl, uint8 slot)
{
    m_LatentEffectList.erase(
        std::remove_if(
            m_LatentEffectList.begin(),
            m_LatentEffectList.end(),
            [slot](auto& latent)
            {
                return latent.GetSlot() == slot;
            }),
        m_LatentEffectList.end());
}

/************************************************************************
 *                                                                       *
 * Returns true if no latents for slot are inactive                      *
 *                                                                       *
 ************************************************************************/

bool CLatentEffectContainer::HasAllLatentsActive(uint8 slot)
{
    auto allActive = true;
    for (auto iter = m_LatentEffectList.begin(); iter != m_LatentEffectList.end(); ++iter)
    {
        CLatentEffect& latent = *iter;
        if (!latent.IsActivated() && latent.GetSlot() == slot)
        {
            allActive = false;
        }
    }
    return allActive;
}

void CLatentEffectContainer::AddLatentEffect(xi::Latent conditionID, uint16 conditionValue, Mod modID, int16 modValue)
{
    m_LatentEffectList.emplace_back(m_POwner, conditionID, conditionValue, MAX_SLOTTYPE, modID, modValue);
}

auto CLatentEffectContainer::DelLatentEffect(xi::Latent conditionID, uint16 conditionValue, Mod modID, int16 modValue) -> bool
{
    // Find and remove the first instance of the latent matching the parameters
    for (auto iter = m_LatentEffectList.begin(); iter != m_LatentEffectList.end(); ++iter)
    {
        CLatentEffect& latent = *iter;
        if (latent.GetConditionsID() == conditionID && latent.GetConditionsValue() == conditionValue && latent.GetModValue() == modID &&
            latent.GetModPower() == modValue)
        {
            m_LatentEffectList.erase(iter);
            return true;
        }
    }
    return false;
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by HP and activates them if      *
 * the conditions are met.                                               *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsHP()
{
    // TODO: hook into this from anywhere HP changes
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::HpUnderPercent:
                case xi::Latent::HpOverPercent:
                case xi::Latent::HpUnderTpUnder100:
                case xi::Latent::HpOverTpUnder100:
                case xi::Latent::SanctionRegenBonus:
                case xi::Latent::SigilRegenBonus:
                case xi::Latent::HpOverVisibleGear:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by TP and activates them if      *
 * the conditions are met.                                               *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsTP()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::TpUnder:
                case xi::Latent::TpOver:
                case xi::Latent::HpUnderTpUnder100:
                case xi::Latent::HpOverTpUnder100:
                case xi::Latent::SanctionRefreshBonus:
                case xi::Latent::SigilRefreshBonus:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are occur during WS and activates them        *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsWS(bool isDuringWs)
{
    ProcessLatentEffects(
        [this, isDuringWs](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::DuringWs:
                    return ProcessLatentEffect(latentEffect, isDuringWs);
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by MP and activates them if     *
 * the conditions are met.                                              *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsMP()
{
    // TODO: hook into this from anywhere MP changes
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::MpUnderPercent:
                case xi::Latent::MpUnder:
                case xi::Latent::MpOver:
                case xi::Latent::WeaponDrawnMpOver:
                case xi::Latent::MpUnderVisibleGear:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents for a given slot (ie. on equip)                   *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsEquip(uint8 slot)
{
    ProcessLatentEffects(
        [this, slot](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetSlot() == slot)
            {
                return ProcessLatentEffect(latentEffect);
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by drawn weapon and activates   *
 * them if the conditions are met.                                      *
 *                                                                       *
 ************************************************************************/

// easy: when animationType changes to xi::Animation::Attack or to something else
void CLatentEffectContainer::CheckLatentsWeaponDraw(bool drawn)
{
    ProcessLatentEffects(
        [this, drawn](CLatentEffect& latentEffect)
        {
            if (drawn)
            {
                switch (latentEffect.GetConditionsID())
                {
                    case xi::Latent::WeaponDrawn:
                        return latentEffect.Activate();
                        break;
                    case xi::Latent::WeaponDrawnMpOver:
                        if (m_POwner->health.mp > latentEffect.GetConditionsValue())
                        {
                            return latentEffect.Activate();
                        }
                        else
                        {
                            return latentEffect.Deactivate();
                        }
                        break;
                    case xi::Latent::WeaponDrawnHpUnder:
                        if (m_POwner->health.hp < latentEffect.GetConditionsValue())
                        {
                            return latentEffect.Activate();
                        }
                        else
                        {
                            return latentEffect.Deactivate();
                        }
                        break;
                    case xi::Latent::WeaponSheathed:
                        return latentEffect.Deactivate();
                        break;
                    default:
                        break;
                }
            }
            else
            {
                switch (latentEffect.GetConditionsID())
                {
                    case xi::Latent::WeaponDrawn:
                    case xi::Latent::WeaponDrawnMpOver:
                    case xi::Latent::WeaponDrawnHpUnder:
                        return latentEffect.Deactivate();
                        break;
                    case xi::Latent::WeaponSheathed:
                        return latentEffect.Activate();
                        break;
                    default:
                        break;
                }
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by status effects and activates *
 * them if the conditions are met.                                      *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsStatusEffect()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::StatusEffectActive:
                case xi::Latent::WeatherCondition:
                case xi::Latent::WeatherElement:
                case xi::Latent::NationControl:
                case xi::Latent::InGarrison:
                case xi::Latent::SanctionFoodBonus:
                case xi::Latent::SigilFoodBonus:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks latents that are affected by food effects. Usage:             *
 * LATENT_FOOD_ACTIVE: (49,foodItemId)                                  *
 * LATENT_NO_FOOD_ACTIVE: (14,0)                                        *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsFoodEffect()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::FoodActive:
                case xi::Latent::NoFoodActive:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by rolls or songs and activates  *
 * them if the conditions are met.                                       *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsRollSong()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::SongRollActive:
                case xi::Latent::ElevenRollActive:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by day or moon and activates     *
 * them if the conditions are met.                                       *
 *                                                                       *
 ************************************************************************/

// probably call this at 00:00 vana time only
void CLatentEffectContainer::CheckLatentsDay()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::TimeOfDay)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks latents affected by the moon phase and activates them          *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsMoonPhase()
{
    TracyZoneScoped;

    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::MoonPhase)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks latents that are affected by the day of the week and           *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsWeekDay()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::Firesday:
                case xi::Latent::Earthsday:
                case xi::Latent::Watersday:
                case xi::Latent::Windsday:
                case xi::Latent::Darksday:
                case xi::Latent::Iceday:
                case xi::Latent::Lightningsday:
                case xi::Latent::Lightsday:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks latents that are affected the hour and activates them          *
 * if the conditions are met.                                            *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsHours()
{
    TracyZoneScoped;

    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::HourOfDay)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by party members and             *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsPartyMembers(size_t members, size_t trustCount)
{
    ProcessLatentEffects(
        [this, members, trustCount](CLatentEffect& latentEffect)
        {
            size_t totalMembers = members + trustCount;

            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::PartyMembers:
                    if (latentEffect.GetConditionsValue() <= totalMembers)
                    {
                        return latentEffect.Activate();
                    }
                    else
                    {
                        return latentEffect.Deactivate();
                    }
                case xi::Latent::PartyMembersInZone:
                    if (latentEffect.GetConditionsValue() <= totalMembers)
                    {
                        auto inZone = 0;
                        for (size_t m = 0; m < members; ++m)
                        {
                            auto* PMember = dynamic_cast<CCharEntity*>(m_POwner->PParty->members.at(m));
                            if (PMember != nullptr && PMember->getZone() == m_POwner->getZone())
                            {
                                inZone++;
                            }
                        }

                        auto* PLeader = dynamic_cast<CCharEntity*>(m_POwner->PParty->GetLeader());
                        if (PLeader != nullptr && m_POwner->getZone() == PLeader->getZone())
                        {
                            inZone = inZone + static_cast<int>(trustCount);
                        }

                        if (inZone == latentEffect.GetConditionsValue())
                        {
                            return latentEffect.Activate();
                        }
                        else
                        {
                            return latentEffect.Deactivate();
                        }
                    }
                    else
                    {
                        return latentEffect.Deactivate();
                    }
                    break;
                default:
                    break;
            }
            return false;
        });
}

void CLatentEffectContainer::CheckLatentsPartyJobs()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::JobInParty)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by an avatar in party and        *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsPartyAvatar()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::AvatarInParty)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by job level and                 *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsJobLevel()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::JobMultiple:
                case xi::Latent::JobMultipleAtNight:
                case xi::Latent::JobLevelBelow:
                case xi::Latent::JobLevelAbove:
                case xi::Latent::InGarrison:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by players pet type and          *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsPetType()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::PetId)
            {
                return ProcessLatentEffect(latentEffect);
            }

            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by time of vana day and          *
 * activates them if the conditions are met.                             *
 *                                                                       *
 ************************************************************************/

// will probably only call this at transition points in the day
void CLatentEffectContainer::CheckLatentsTime()
{
    // todo: this isn't called anywhere
}

/************************************************************************
 *                                                                       *
 * Checks all latents that are affected by weapon skill points           *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsWeaponBreak(uint8 slot)
{
    ProcessLatentEffects(
        [this, slot](CLatentEffect& latentEffect)
        {
            if (latentEffect.GetConditionsID() == xi::Latent::WeaponBroken && latentEffect.GetConditionsValue() == slot)
            {
                return ProcessLatentEffect(latentEffect);
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents regarding current zone                             *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsZone()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::Zone:
                case xi::Latent::InAssault:
                case xi::Latent::InDynamis:
                case xi::Latent::InAdoulin:
                case xi::Latent::WeatherCondition:
                case xi::Latent::WeatherElement:
                case xi::Latent::NationControl:
                case xi::Latent::NationCitizen:
                case xi::Latent::ZoneHomeNation:
                case xi::Latent::SanctionFoodBonus:
                case xi::Latent::SigilFoodBonus:
                    return ProcessLatentEffect(latentEffect);
                    break;
                default:
                    break;
            }
            return false;
        });
}

/************************************************************************
 *                                                                       *
 * Checks all latents regarding current weather                          *
 *                                                                       *
 ************************************************************************/
void CLatentEffectContainer::CheckLatentsWeather()
{
    uint16 zoneId = m_POwner->getZone();
    CZone* PZone  = zoneutils::GetZone(zoneId);

    if (PZone == nullptr)
    {
        ShowWarning("PZone was null for Zone ID %d.", zoneId);
        return;
    }

    CheckLatentsWeather(PZone->weather().current());
}

void CLatentEffectContainer::CheckLatentsWeather(xi::Weather weather)
{
    ProcessLatentEffects(
        [this, weather](CLatentEffect& latent)
        {
            if (latent.GetConditionsID() == xi::Latent::WeatherElement)
            {
                auto element = zoneutils::GetWeatherElement(battleutils::GetWeather((CBattleEntity*)m_POwner, false, weather));
                return ApplyLatentEffect(latent, latent.GetConditionsValue() == element);
            }
            else if (latent.GetConditionsID() == xi::Latent::WeatherCondition)
            {
                auto element = battleutils::GetWeather((CBattleEntity*)m_POwner, false, weather);
                return ApplyLatentEffect(latent, latent.GetConditionsValue() == static_cast<uint16_t>(element));
            }
            return false;
        });
}

void CLatentEffectContainer::CheckLatentsTargetChange()
{
    ProcessLatentEffects(
        [this](CLatentEffect& latentEffect)
        {
            switch (latentEffect.GetConditionsID())
            {
                case xi::Latent::SignetBonus:
                case xi::Latent::VsEcosystem:
                case xi::Latent::VsSpecies:
                case xi::Latent::VsFamily:
                    return ProcessLatentEffect(latentEffect);
                default:
                    break;
            }
            return false;
        });
}

// Process the latent effects container and apply a logic function responsible for
// filtering the appropriate latents to be activated/deactivated and finally update
// health post looping if at least one logic function returned true
void CLatentEffectContainer::ProcessLatentEffects(const Fn<bool(CLatentEffect&) const>& logic)
{
    auto update = false;

    for (auto& latent : m_LatentEffectList)
    {
        if (logic(latent))
        {
            update = true;
        }
    }

    if (update)
    {
        m_POwner->UpdateHealth();
    }
}

// Processes a single CLatentEffect* and finds the expression to evaluate for
// activation/deactivation and attempts to apply
auto CLatentEffectContainer::ProcessLatentEffect(CLatentEffect& latentEffect, bool isDuringWs) -> bool
{
    TracyZoneScoped;

    // Our default case un-finds our latent prevent us from toggling a latent we don't have programmed
    auto expression  = false;
    auto latentFound = true;

    if (m_POwner == nullptr)
    {
        return false;
    }

    // this gets the current zone ID or destination zone ID if zoning
    uint16 playerZoneID = m_POwner->getZone();
    if (playerZoneID == 0)
    {
        return false;
    }

    vanadiel_time::time_point vanaTime = vanadiel_time::now();

    // find the latent type from the enum and find the expression to tests againts
    switch (latentEffect.GetConditionsID())
    {
        case xi::Latent::HpUnderPercent:
            expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 <= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::HpOverPercent:
            expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 >= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::HpUnderTpUnder100:
            expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 <= latentEffect.GetConditionsValue() && m_POwner->health.tp < 1000;
            break;
        case xi::Latent::HpOverTpUnder100:
            expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 >= latentEffect.GetConditionsValue() && m_POwner->health.tp < 1000;
            break;
        case xi::Latent::MpUnderPercent:
            expression = m_POwner->health.maxmp && ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 <= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::MpUnder:
            expression = m_POwner->health.mp <= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::TpUnder:
            expression = m_POwner->health.tp < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::TpOver:
            expression = m_POwner->health.tp > latentEffect.GetConditionsValue();
            break;
        case xi::Latent::Subjob:
            expression = m_POwner->GetSJob() == latentEffect.GetConditionsValue();
            break;
        case xi::Latent::PetId:
            expression =
                m_POwner->PPet != nullptr && m_POwner->PPet->objtype == TYPE_PET && ((CPetEntity*)m_POwner->PPet)->petID() == latentEffect.GetConditionsValue();
            break;
        case xi::Latent::WeaponDrawn:
            expression = m_POwner->animation == xi::Animation::Attack;
            break;
        case xi::Latent::WeaponSheathed:
            expression = m_POwner->animation != xi::Animation::Attack;
            break;
        case xi::Latent::SignetBonus:
        {
            CBattleEntity* PTarget = m_POwner->GetBattleTarget();
            expression             = PTarget != nullptr &&
                                     m_POwner->GetMLevel() >= PTarget->GetMLevel() &&
                                     m_POwner->loc.zone != nullptr &&
                                     m_POwner->loc.zone->GetRegionID() < REGION_TYPE::WEST_AHT_URHGAN;
            break;
        }
        case xi::Latent::SanctionRegenBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::WEST_AHT_URHGAN &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::ALZADAAL &&
                         ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::SanctionRefreshBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::WEST_AHT_URHGAN &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::ALZADAAL &&
                         ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::SigilRegenBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::RONFAURE_FRONT &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::VALDEAUNIA_FRONT &&
                         ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::SigilRefreshBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::RONFAURE_FRONT &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::VALDEAUNIA_FRONT &&
                         ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::SanctionFoodBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::WEST_AHT_URHGAN &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::ALZADAAL;
            break;
        case xi::Latent::SigilFoodBonus:
            expression = m_POwner->loc.zone != nullptr &&
                         m_POwner->loc.zone->GetRegionID() >= REGION_TYPE::RONFAURE_FRONT &&
                         m_POwner->loc.zone->GetRegionID() <= REGION_TYPE::VALDEAUNIA_FRONT;
            break;
        case xi::Latent::StatusEffectActive:
            expression = m_POwner->StatusEffectContainer->HasStatusEffect(static_cast<xi::StatusEffect>(latentEffect.GetConditionsValue()));
            break;
        case xi::Latent::NoFoodActive:
            expression = !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Food);
            break;
        case xi::Latent::PartyMembers:
        {
            size_t partyCount = 0;
            size_t trustCount = 0;
            auto*  PParty     = m_POwner->PParty;
            auto*  PLeader    = PParty ? dynamic_cast<CCharEntity*>(PParty->GetLeader()) : nullptr;
            if (PLeader)
            {
                trustCount = PLeader->PTrusts.size();
                partyCount = PParty->members.size();
            }

            expression = latentEffect.GetConditionsValue() <= (partyCount + trustCount);
            break;
        }
        case xi::Latent::PartyMembersInZone:
        {
            auto inZone = 0;
            if (m_POwner->PParty && dynamic_cast<CCharEntity*>(m_POwner->PParty->GetLeader()))
            {
                for (auto* member : m_POwner->PParty->members)
                {
                    if (member->getZone() == m_POwner->getZone())
                    {
                        ++inZone;
                    }
                }

                auto PLeader = (CCharEntity*)m_POwner->PParty->GetLeader();
                if (m_POwner->getZone() == PLeader->getZone())
                {
                    inZone = inZone + static_cast<int>(PLeader->PTrusts.size());
                }
            }

            expression = latentEffect.GetConditionsValue() <= inZone;
            break;
        }
        case xi::Latent::AvatarInParty:
            if (m_POwner->PParty != nullptr)
            {
                for (auto* member : m_POwner->PParty->members)
                {
                    if (member->PPet != nullptr && member->PPet->objtype == TYPE_PET)
                    {
                        auto* PPet = static_cast<CPetEntity*>(member->PPet);
                        if (
                            !PPet->isDead() && PPet->petID() < 21 && // is a live avatar
                            (PPet->petID() == latentEffect.GetConditionsValue() || latentEffect.GetConditionsValue() == 21))
                        {
                            expression = true;
                            break;
                        }
                    }
                }
            }
            else if (m_POwner->PParty == nullptr && m_POwner->PPet != nullptr)
            {
                auto* PPet = (CPetEntity*)m_POwner->PPet;
                if (
                    !PPet->isDead() && PPet->petID() < 21 && // is a live avatar
                    (PPet->petID() == latentEffect.GetConditionsValue() || latentEffect.GetConditionsValue() == 21))
                {
                    expression = true;
                }
            }
            break;
        case xi::Latent::JobInParty:
            if (m_POwner->PParty != nullptr)
            {
                for (auto* member : m_POwner->PParty->members)
                {
                    if (member->id != m_POwner->id)
                    {
                        if (member->GetMJob() == latentEffect.GetConditionsValue())
                        {
                            expression = true;
                            break;
                        }
                    }
                }

                auto leader = (CCharEntity*)m_POwner->PParty->GetLeader();

                if (leader == nullptr)
                {
                    expression = false;
                    break;
                }

                for (auto* trust : leader->PTrusts)
                {
                    if (trust->GetMJob() == latentEffect.GetConditionsValue())
                    {
                        expression = true;
                        break;
                    }
                }
            }
            break;
        case xi::Latent::Zone:
            expression = latentEffect.GetConditionsValue() == m_POwner->getZone();
            break;
        case xi::Latent::SynthTrainee:
        {
            expression = (uint16)m_POwner->RealSkills.skill[latentEffect.GetConditionsValue()] / 10 < 40 &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::FishingImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::WoodworkingImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::SmithingImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::GoldsmithingImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::ClothcraftImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::LeathercraftImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::BonecraftImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::AlchemyImagery) &&
                         !m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::CookingImagery);
            break;
        }
        case xi::Latent::SongRollActive:
            expression = m_POwner->StatusEffectContainer->HasStatusEffectByFlag(xi::StatusEffectFlag::Roll | xi::StatusEffectFlag::Song);
            break;
        case xi::Latent::TimeOfDay:
        {
            uint32 VanadielHour = vanadiel_time::get_hour(vanaTime);
            switch (latentEffect.GetConditionsValue())
            {
                case 0:
                    // daytime: 06:00 to 18:00
                    expression = VanadielHour >= 6 && VanadielHour < 18;
                    break;
                case 1:
                    // nighttime: 18:00 to 06:00
                    expression = VanadielHour >= 18 || VanadielHour < 6;
                    break;
                case 2:
                    // dusk - dawn: 17:00 to 7:00
                    expression = VanadielHour >= 17 || VanadielHour < 7;
                    break;
            }
            break;
        }
        case xi::Latent::HourOfDay:
        {
            uint32 VanadielHour = vanadiel_time::get_hour(vanaTime);
            switch (latentEffect.GetConditionsValue())
            {
                case 1:
                    // new day
                    expression = VanadielHour == 4;
                    break;
                case 2:
                    // dawn
                    expression = VanadielHour >= 6 && VanadielHour < 7;
                    break;
                case 3:
                    // day
                    expression = VanadielHour >= 7 && VanadielHour < 17;
                    break;
                case 4:
                    // dusk
                    expression = VanadielHour >= 16 && VanadielHour < 18;
                    break;
                case 5:
                    // evening
                    expression = VanadielHour >= 18 && VanadielHour < 20;
                    break;
                case 6:
                    // dead of night
                    expression = VanadielHour >= 20 || VanadielHour < 4;
                    break;
            }
            break;
        }
        case xi::Latent::Firesday:
            expression = vanadiel_time::get_weekday(vanaTime) == FIRESDAY;
            break;
        case xi::Latent::Earthsday:
            expression = vanadiel_time::get_weekday(vanaTime) == EARTHSDAY;
            break;
        case xi::Latent::Watersday:
            expression = vanadiel_time::get_weekday(vanaTime) == WATERSDAY;
            break;
        case xi::Latent::Windsday:
            expression = vanadiel_time::get_weekday(vanaTime) == WINDSDAY;
            break;
        case xi::Latent::Darksday:
            expression = vanadiel_time::get_weekday(vanaTime) == DARKSDAY;
            break;
        case xi::Latent::Iceday:
            expression = vanadiel_time::get_weekday(vanaTime) == ICEDAY;
            break;
        case xi::Latent::Lightningsday:
            expression = vanadiel_time::get_weekday(vanaTime) == LIGHTNINGDAY;
            break;
        case xi::Latent::Lightsday:
            expression = vanadiel_time::get_weekday(vanaTime) == LIGHTSDAY;
            break;
        case xi::Latent::MoonPhase:
        {
            uint32 MoonPhase     = vanadiel_time::moon::get_phase(vanaTime);
            uint32 MoonDirection = vanadiel_time::moon::get_direction(vanaTime); // directions: 1 = waning, 2 = waxing, 0 = neither
            switch (latentEffect.GetConditionsValue())
            {
                case 0:
                    // New Moon - 10% waning -> 5% waxing
                    expression = MoonPhase <= 5 || (MoonPhase <= 10 && MoonDirection == 1);
                    break;
                case 1:
                    // Waxing Crescent - 7% -> 38% waxing
                    expression = MoonPhase >= 7 && MoonPhase <= 38 && MoonDirection == 2;
                    break;
                case 2:
                    // First Quarter - 40%% -> 55% waxing
                    expression = MoonPhase >= 40 && MoonPhase <= 55 && MoonDirection == 2;
                    break;
                case 3:
                    // Waxing Gibbous - 57% -> 88%
                    expression = MoonPhase >= 57 && MoonPhase <= 88 && MoonDirection == 2;
                    break;
                case 4:
                    // Full Moon - waxing 90% -> waning 95%
                    expression = MoonPhase >= 95 || (MoonPhase >= 90 && MoonDirection == 2);
                    break;
                case 5:
                    // Waning Gibbous - 93% -> 62%
                    expression = MoonPhase >= 62 && MoonPhase <= 93 && MoonDirection == 1;
                    break;
                case 6:
                    // Last Quarter - 60% -> 45%
                    expression = MoonPhase >= 45 && MoonPhase <= 60 && MoonDirection == 1;
                    break;
                case 7:
                    // Waning Crescent - 43% -> 12%
                    expression = MoonPhase >= 12 && MoonPhase <= 43 && MoonDirection == 1;
                    break;
            }
            break;
        }
        case xi::Latent::JobMultiple:
            // Check if level is odd
            if (latentEffect.GetConditionsValue() == 0)
            {
                expression = m_POwner->GetMLevel() % 2 == 1;
            }
            // Check if level is multiple of divisor
            else
            {
                expression = m_POwner->GetMLevel() % latentEffect.GetConditionsValue() == 0;
            }
            break;
        case xi::Latent::JobMultipleAtNight:
            if (latentEffect.GetConditionsValue() == 0)
            {
                expression = m_POwner->GetMLevel() % 2 == 1 && vanadiel_time::get_totd(vanaTime) == vanadiel_time::TOTD::NIGHT;
            }
            else
            {
                expression = m_POwner->GetMLevel() % latentEffect.GetConditionsValue() == 0 && vanadiel_time::get_totd(vanaTime) == vanadiel_time::TOTD::NIGHT;
            }
            break;
        case xi::Latent::WeaponDrawnHpUnder:
            expression = m_POwner->health.hp < latentEffect.GetConditionsValue() && m_POwner->animation == xi::Animation::Attack;
            break;
        case xi::Latent::MpUnderVisibleGear:
            // TODO: figure out if this is actually right
            // CItemEquipment* head = (CItemEquipment*)(m_POwner->getEquip(SLOT_HEAD));
            // CItemEquipment* body = (CItemEquipment*)(m_POwner->getEquip(SLOT_BODY));
            // CItemEquipment* hands = (CItemEquipment*)(m_POwner->getEquip(SLOT_HANDS));
            // CItemEquipment* legs = (CItemEquipment*)(m_POwner->getEquip(SLOT_LEGS));
            // CItemEquipment* feet = (CItemEquipment*)(m_POwner->getEquip(SLOT_FEET));

            // int32 visibleMp = 0;
            // visibleMp += (head ? head->getModifier(Mod::MP) : 0);
            // visibleMp += (body ? body->getModifier(Mod::MP) : 0);
            // visibleMp += (hands ? hands->getModifier(Mod::MP) : 0);
            // visibleMp += (legs ? legs->getModifier(Mod::MP) : 0);
            // visibleMp += (feet ? feet->getModifier(Mod::MP) : 0);

            // TODO: add mp percent too
            // if ((float)( mp / ((m_POwner->health.mp - m_POwner->health.modmp) + (m_POwner->PMeritPoints->GetMerit(MERIT_MAX_MP)->count * 10 ) +
            //    visibleMp) ) <= m_LatentEffectList.at(i)->GetConditionsValue())
            //{
            //    m_LatentEffectList.at(i)->Activate();
            //}
            // else
            //{
            //    m_LatentEffectList.at(i)->Deactivate();
            //}
            break;
        case xi::Latent::HpOverVisibleGear:
            // TODO: figure out if this is actually right
            // CItemEquipment* head = (CItemEquipment*)(m_POwner->getEquip(SLOT_HEAD));
            // CItemEquipment* body = (CItemEquipment*)(m_POwner->getEquip(SLOT_BODY));
            // CItemEquipment* hands = (CItemEquipment*)(m_POwner->getEquip(SLOT_HANDS));
            // CItemEquipment* legs = (CItemEquipment*)(m_POwner->getEquip(SLOT_LEGS));
            // CItemEquipment* feet = (CItemEquipment*)(m_POwner->getEquip(SLOT_FEET));

            // int32 visibleHp = 0;
            // visibleHp += (head ? head->getModifier(Mod::HP) : 0);
            // visibleHp += (body ? body->getModifier(Mod::HP) : 0);
            // visibleHp += (hands ? hands->getModifier(Mod::HP) : 0);
            // visibleHp += (legs ? legs->getModifier(Mod::HP) : 0);
            // visibleHp += (feet ? feet->getModifier(Mod::HP) : 0);

            // TODO: add mp percent too
            // if ((float)( hp / ((m_POwner->health.hp - m_POwner->health.modhp) + (m_POwner->PMeritPoints->GetMerit(MERIT_MAX_HP)->count * 10 ) +
            //    visibleHp) ) <= m_LatentEffectList.at(i)->GetConditionsValue())
            //{
            //    m_LatentEffectList.at(i)->Activate();
            //}
            // else
            //{
            //    m_LatentEffectList.at(i)->Deactivate();
            //}
            break;
        case xi::Latent::WeaponBroken:
        {
            auto  slot = latentEffect.GetSlot();
            auto* item = (CItemWeapon*)m_POwner->getEquip((SLOTTYPE)slot);
            switch (slot)
            {
                case SLOT_MAIN:
                case SLOT_SUB:
                case SLOT_RANGED:
                    expression = item != nullptr && item->isUnlocked();
                    break;
            }
            break;
        }
        case xi::Latent::InDynamis:
            expression = m_POwner->isInDynamis();
            break;
        case xi::Latent::InAssault:
            expression = m_POwner->isInAssault();
            break;
        case xi::Latent::InAdoulin:
            expression = m_POwner->isInAdoulin();
            break;
        case xi::Latent::InGarrison:
            expression = m_POwner->isInGarrison() && m_POwner->GetMLevel() >= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::FoodActive:
            expression = m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Food) &&
                         m_POwner->StatusEffectContainer->GetStatusEffect(xi::StatusEffect::Food)->GetSourceTypeParam() == latentEffect.GetConditionsValue();
            break;
        case xi::Latent::JobLevelBelow:
            expression = m_POwner->GetMLevel() < latentEffect.GetConditionsValue();
            break;
        case xi::Latent::JobLevelAbove:
            expression = m_POwner->GetMLevel() >= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::WeatherCondition:
            expression = latentEffect.GetConditionsValue() == static_cast<uint16_t>(battleutils::GetWeather((CBattleEntity*)m_POwner, false));
            break;
        case xi::Latent::WeatherElement:
            expression = latentEffect.GetConditionsValue() == zoneutils::GetWeatherElement(battleutils::GetWeather((CBattleEntity*)m_POwner, false));
            break;
        case xi::Latent::NationControl:
        {
            // playerZoneId represents the player's destination if they're zoning.
            // Otherwise, it represents their current zone.
            auto region                   = zoneutils::GetCurrentRegion(playerZoneID);
            auto hasSignet                = m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Signet);
            auto hasSanction              = m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Sanction);
            auto hasSigil                 = m_POwner->StatusEffectContainer->HasStatusEffect(xi::StatusEffect::Sigil);
            auto regionAlwaysOutOfControl = zoneutils::IsAlwaysOutOfNationControl(region);
            switch (latentEffect.GetConditionsValue())
            {
                case 0:
                    // under own nation's control
                    expression = region < REGION_TYPE::WEST_AHT_URHGAN && (conquest::GetRegionOwner(region) == m_POwner->profile.nation) &&
                                 (hasSignet || hasSanction || hasSigil);
                    break;
                case 1:
                    // outside of own nation's control
                    expression = region < REGION_TYPE::WEST_AHT_URHGAN && (regionAlwaysOutOfControl || m_POwner->profile.nation != conquest::GetRegionOwner(region)) &&
                                 (hasSignet || hasSanction || hasSigil);
                    break;
            }
            break;
        }
        case xi::Latent::NationCitizen:
        {
            expression = m_POwner->profile.nation == latentEffect.GetConditionsValue();
            break;
        }
        case xi::Latent::ZoneHomeNation:
        {
            auto nationRegion = static_cast<REGION_TYPE>(latentEffect.GetConditionsValue());
            auto region       = zoneutils::GetCurrentRegion(playerZoneID);

            switch (nationRegion)
            {
                case REGION_TYPE::SANDORIA:
                    expression = m_POwner->profile.nation == 0 && region == nationRegion;
                    break;
                case REGION_TYPE::BASTOK:
                    expression = m_POwner->profile.nation == 1 && region == nationRegion;
                    break;
                case REGION_TYPE::WINDURST:
                    expression = m_POwner->profile.nation == 2 && region == nationRegion;
                    break;
                default:
                    break;
            }
            break;
        }
        case xi::Latent::MpOver:
            expression = m_POwner->health.mp >= latentEffect.GetConditionsValue();
            break;
        case xi::Latent::WeaponDrawnMpOver:
            expression = m_POwner->health.mp > latentEffect.GetConditionsValue() && m_POwner->animation == xi::Animation::Attack;
            break;
        case xi::Latent::ElevenRollActive:
            expression = m_POwner->StatusEffectContainer->CheckForElevenRoll();
            break;
        case xi::Latent::VsEcosystem:
            if (CBattleEntity* PTarget = m_POwner->GetBattleTarget())
            {
                expression = static_cast<uint16>(PTarget->m_EcoSystem) == latentEffect.GetConditionsValue();
            }
            break;
        case xi::Latent::VsSpecies:
            if (CBattleEntity* PTarget = m_POwner->GetBattleTarget())
            {
                CMobEntity* PMob = dynamic_cast<CMobEntity*>(PTarget);
                if (PMob)
                {
                    expression = PMob->m_Species == latentEffect.GetConditionsValue();
                }
            }
            break;
        case xi::Latent::VsFamily:
            if (CBattleEntity* PTarget = m_POwner->GetBattleTarget())
            {
                CMobEntity* PMob = dynamic_cast<CMobEntity*>(PTarget);
                if (PMob)
                {
                    expression = PMob->m_Family == latentEffect.GetConditionsValue();
                }
            }
            break;
        case xi::Latent::Mainjob:
            expression = m_POwner->GetMJob() == latentEffect.GetConditionsValue();
            break;
        case xi::Latent::EquippedInSlot:
            expression = latentEffect.GetSlot() == latentEffect.GetConditionsValue();
            break;
        case xi::Latent::DuringWs:
            expression = isDuringWs;
            break;
        default:
            latentFound = false;
            ShowWarning("Latent ID %d unhandled in ProcessLatentEffect", static_cast<uint16>(latentEffect.GetConditionsID()));
            break;
    }

    // if we did not hit the default case, attempt to apply the latent effect based on the expression
    if (latentFound)
    {
        return ApplyLatentEffect(latentEffect, expression);
    }
    return false;
}

// Activates a latent effect if true otherwise deactivates the latent effect
bool CLatentEffectContainer::ApplyLatentEffect(CLatentEffect& effect, bool expression)
{
    if (expression)
    {
        return effect.Activate();
    }
    else
    {
        return effect.Deactivate();
    }
}
