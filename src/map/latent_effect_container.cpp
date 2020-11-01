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

#include "latent_effect.h"
#include "entities/charentity.h"
#include "entities/battleentity.h"
#include "entities/trustentity.h"
#include "utils/battleutils.h"
#include "utils/zoneutils.h"
#include "conquest_system.h"
#include "modifier.h"
#include "items/item_weapon.h"
#include "status_effect_container.h"
#include "ai/ai_container.h"

#include "time_server.h"

CLatentEffectContainer::CLatentEffectContainer(CCharEntity* PEntity) :
    m_POwner(PEntity)
{}

/************************************************************************
*																		*
*  Adds new latent effect to the character.								*
*																		*
************************************************************************/

void CLatentEffectContainer::AddLatentEffects(std::vector<CItemEquipment::itemLatent>& latentList, uint8 reqLvl, uint8 slot)
{
    for (auto& latent : latentList)
    {
        if (m_POwner->GetMLevel() >= reqLvl || latent.ConditionsValue == LATENT_JOB_LEVEL_ABOVE)
        {
            if (latent.ModValue == Mod::MAIN_DMG_RATING && slot == SLOT_SUB)
                m_LatentEffectList.emplace_back(m_POwner, latent.ConditionsID, latent.ConditionsValue, slot, Mod::SUB_DMG_RATING, latent.ModPower);
            else
                m_LatentEffectList.emplace_back(m_POwner, latent.ConditionsID, latent.ConditionsValue, slot, latent.ModValue, latent.ModPower);
        }
    }
}

/************************************************************************
*																		*
*  Removes all latent effects associated with a specified slot			*
*																		*
************************************************************************/

void CLatentEffectContainer::DelLatentEffects(uint8 reqLvl, uint8 slot)
{
    m_LatentEffectList.erase(std::remove_if(m_LatentEffectList.begin(), m_LatentEffectList.end(), [slot](auto& latent){
        return latent.GetSlot() == slot;
    }), m_LatentEffectList.end());
}

void CLatentEffectContainer::AddLatentEffect(LATENT conditionID, uint16 conditionValue, Mod modID, int16 modValue)
{
    m_LatentEffectList.emplace_back(m_POwner, conditionID, conditionValue, MAX_SLOTTYPE, modID, modValue);
}

bool CLatentEffectContainer::DelLatentEffect(LATENT conditionID, uint16 conditionValue, Mod modID, int16 modValue)
{
    // Find and remove the first instance of the latent matching the parameters
    for (auto iter = m_LatentEffectList.begin(); iter != m_LatentEffectList.end(); ++iter)
    {
        CLatentEffect& latent = *iter;
        if (latent.GetConditionsID() == conditionID && latent.GetConditionsValue() == conditionValue && latent.GetModValue() == modID && latent.GetModPower() == modValue)
        {
            m_LatentEffectList.erase(iter);
            return true;
        }
    }
    return false;
}

/************************************************************************
*																		*
*  Checks all latents that are affected by HP and activates them if  	*
*  the conditions are met.												*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsHP()
{
    //TODO: hook into this from anywhere HP changes
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_HP_UNDER_PERCENT:
        case LATENT_HP_OVER_PERCENT:
        case LATENT_HP_UNDER_TP_UNDER_100:
        case LATENT_HP_OVER_TP_UNDER_100:
        case LATENT_SANCTION_REGEN_BONUS:
        case LATENT_SIGIL_REGEN_BONUS:
        case LATENT_HP_OVER_VISIBLE_GEAR:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by TP and activates them if  	*
*  the conditions are met.												*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsTP()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_TP_UNDER:
        case LATENT_TP_OVER:
        case LATENT_HP_UNDER_TP_UNDER_100:
        case LATENT_HP_OVER_TP_UNDER_100:
        case LATENT_SANCTION_REFRESH_BONUS:
        case LATENT_SIGIL_REFRESH_BONUS:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by MP and activates them if  	*
*  the conditions are met.												*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsMP()
{
    //TODO: hook into this from anywhere MP changes
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_MP_UNDER_PERCENT:
        case LATENT_MP_UNDER:
        case LATENT_MP_OVER:
        case LATENT_WEAPON_DRAWN_MP_OVER:
        case LATENT_MP_UNDER_VISIBLE_GEAR:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents for a given slot (ie. on equip)					*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsEquip(uint8 slot)
{
    ProcessLatentEffects([this, slot](CLatentEffect& latentEffect)
    {
        if (latentEffect.GetSlot() == slot)
        {
            return ProcessLatentEffect(latentEffect);
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by drawn weapon and activates  	*
*  them if the conditions are met.										*
*																		*
************************************************************************/

//easy: when animationType changes to ANIMATION_ATTACK or to something else
void CLatentEffectContainer::CheckLatentsWeaponDraw(bool drawn)
{
    ProcessLatentEffects([this, drawn](CLatentEffect& latentEffect)
    {
        if (drawn)
        {
            switch (latentEffect.GetConditionsID())
            {
            case LATENT_WEAPON_DRAWN:
                return latentEffect.Activate();
                break;
            case LATENT_WEAPON_DRAWN_MP_OVER:
                if (m_POwner->health.mp > latentEffect.GetConditionsValue())
                {
                    return latentEffect.Activate();
                }
                else
                {
                    return latentEffect.Deactivate();
                }
                break;
            case LATENT_WEAPON_DRAWN_HP_UNDER:
                if (m_POwner->health.hp < latentEffect.GetConditionsValue())
                {
                    return latentEffect.Activate();
                }
                else
                {
                    return latentEffect.Deactivate();
                }
                break;
            case LATENT_WEAPON_SHEATHED:
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
            case LATENT_WEAPON_DRAWN:
            case LATENT_WEAPON_DRAWN_MP_OVER:
            case LATENT_WEAPON_DRAWN_HP_UNDER:
                return latentEffect.Deactivate();
                break;
            case LATENT_WEAPON_SHEATHED:
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
*																		*
*  Checks all latents that are affected by status effects and activates	*
*  them if the conditions are met.										*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsStatusEffect()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_STATUS_EFFECT_ACTIVE:
        case LATENT_WEATHER_ELEMENT:
        case LATENT_NATION_CONTROL:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks latents that are affected by food effects. Usage:				*
*  LATENT_FOOD_ACTIVE: (49,foodItemId)									*
*  LATENT_NO_FOOD_ACTIVE: (14,0)										*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsFoodEffect()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_FOOD_ACTIVE:
        case LATENT_NO_FOOD_ACTIVE:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by rolls or songs and activates *
*  them if the conditions are met.										*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsRollSong()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_SONG_ROLL_ACTIVE:
        case LATENT_ELEVEN_ROLL_ACTIVE:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by day or moon and activates	*
*  them if the conditions are met.										*
*																		*
************************************************************************/

//probably call this at 00:00 vana time only
void CLatentEffectContainer::CheckLatentsDay()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_TIME_OF_DAY:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks latents affected by the moon phase and activates them			*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsMoonPhase()
{
    TracyZoneScoped;
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_MOON_PHASE:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks latents that are affected by the day of the week and			*
*  activates them if the conditions are met.							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsWeekDay()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_FIRESDAY:
        case LATENT_EARTHSDAY:
        case LATENT_WATERSDAY:
        case LATENT_WINDSDAY:
        case LATENT_DARKSDAY:
        case LATENT_ICEDAY:
        case LATENT_LIGHTNINGSDAY:
        case LATENT_LIGHTSDAY:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks latents that are affected the hour and activates them			*
*  if the conditions are met.											*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsHours()
{
    TracyZoneScoped;
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_HOUR_OF_DAY:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by party members and			*
*  activates them if the conditions are met.							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsPartyMembers(size_t members)
{
    ProcessLatentEffects([this, members](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_PARTY_MEMBERS:
            if (latentEffect.GetConditionsValue() <= members)
            {
                return latentEffect.Activate();
            }
            else
            {
                return latentEffect.Deactivate();
            }
        case LATENT_PARTY_MEMBERS_IN_ZONE:
            if (latentEffect.GetConditionsValue() <= members)
            {
                auto inZone = 0;
                for (size_t m = 0; m < members; ++m)
                {
                    auto PMember = (CCharEntity*)m_POwner->PParty->members.at(m);
                    if (PMember->getZone() == m_POwner->getZone())
                    {
                        inZone++;
                    }
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
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_JOB_IN_PARTY:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by an avatar in party and		*
*  activates them if the conditions are met.							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsPartyAvatar()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_AVATAR_IN_PARTY:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by job level and			    *
*  activates them if the conditions are met.							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsJobLevel()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_JOB_LEVEL_EVEN:
        case LATENT_JOB_LEVEL_ODD:
        case LATENT_JOB_MULTIPLE_5:
        case LATENT_JOB_MULTIPLE_10:
        case LATENT_JOB_MULTIPLE_13_NIGHT:
        case LATENT_JOB_LEVEL_BELOW:
        case LATENT_JOB_LEVEL_ABOVE:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by players pet type and			*
*  activates them if the conditions are met.							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsPetType()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_PET_ID:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents that are affected by time of vana day and			*
*  activates them if the conditions are met.							*
*																		*
************************************************************************/

//will probably only call this at transition points in the day
void CLatentEffectContainer::CheckLatentsTime()
{
    // todo: this isn't called anywhere
}

/************************************************************************
*																		*
*  Checks all latents that are affected by weapon skill points			*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsWeaponBreak(uint8 slot)
{
    ProcessLatentEffects([this, slot](CLatentEffect& latentEffect)
    {
        if (latentEffect.GetConditionsID() == LATENT_WEAPON_BROKEN && latentEffect.GetConditionsValue() == slot)
        {
            return ProcessLatentEffect(latentEffect);
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents regarding current zone							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsZone()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_ZONE:
        case LATENT_IN_ASSAULT:
        case LATENT_IN_DYNAMIS:
        case LATENT_WEATHER_ELEMENT:
        case LATENT_NATION_CONTROL:
        case LATENT_ZONE_HOME_NATION:
            return ProcessLatentEffect(latentEffect);
            break;
        default:
            break;
        }
        return false;
    });
}

/************************************************************************
*																		*
*  Checks all latents regarding current weather							*
*																		*
************************************************************************/
void CLatentEffectContainer::CheckLatentsWeather()
{
    CheckLatentsWeather(zoneutils::GetZone(m_POwner->getZone())->GetWeather());
}

void CLatentEffectContainer::CheckLatentsWeather(uint16 weather)
{
    ProcessLatentEffects([this, weather](CLatentEffect& latent)
    {
        if (latent.GetConditionsID() == LATENT_WEATHER_ELEMENT)
        {
            auto element = zoneutils::GetWeatherElement(battleutils::GetWeather((CBattleEntity*)m_POwner, false, weather));
            return ApplyLatentEffect(latent, latent.GetConditionsValue() == element);
        }
        return false;
    });
}

void CLatentEffectContainer::CheckLatentsTargetChange()
{
    ProcessLatentEffects([this](CLatentEffect& latentEffect)
    {
        switch (latentEffect.GetConditionsID())
        {
        case LATENT_SIGNET_BONUS:
        case LATENT_VS_ECOSYSTEM:
        case LATENT_VS_FAMILY:
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
void CLatentEffectContainer::ProcessLatentEffects(std::function <bool(CLatentEffect&)> logic)
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
bool CLatentEffectContainer::ProcessLatentEffect(CLatentEffect& latentEffect)
{
    TracyZoneScoped;
    // Our default case un-finds our latent prevent us from toggling a latent we don't have programmed
    auto expression = false;
    auto latentFound = true;

    // find the latent type from the enum and find the expression to tests againts
    switch (latentEffect.GetConditionsID())
    {
    case LATENT_HP_UNDER_PERCENT:
        expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 <= latentEffect.GetConditionsValue();
        break;
    case LATENT_HP_OVER_PERCENT:
        expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 >= latentEffect.GetConditionsValue();
        break;
    case LATENT_HP_UNDER_TP_UNDER_100:
        expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 <= latentEffect.GetConditionsValue() && m_POwner->health.tp < 1000;
        break;
    case LATENT_HP_OVER_TP_UNDER_100:
        expression = ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 >= latentEffect.GetConditionsValue() && m_POwner->health.tp < 1000;
        break;
    case LATENT_MP_UNDER_PERCENT:
        expression = m_POwner->health.maxmp && ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 <= latentEffect.GetConditionsValue();
        break;
    case LATENT_MP_UNDER:
        expression = m_POwner->health.mp <= latentEffect.GetConditionsValue();
        break;
    case LATENT_TP_UNDER:
        expression = m_POwner->health.tp < latentEffect.GetConditionsValue();
        break;
    case LATENT_TP_OVER:
        expression = m_POwner->health.tp > latentEffect.GetConditionsValue();
        break;
    case LATENT_SUBJOB:
        expression = m_POwner->GetSJob() == latentEffect.GetConditionsValue();
        break;
    case LATENT_PET_ID:
        expression = m_POwner->PPet != nullptr && m_POwner->PPet->objtype == TYPE_PET && ((CPetEntity*)m_POwner->PPet)->m_PetID == latentEffect.GetConditionsValue();
        break;
    case LATENT_WEAPON_DRAWN:
        expression = m_POwner->animation == ANIMATION_ATTACK;
        break;
    case LATENT_WEAPON_SHEATHED:
        expression = m_POwner->animation != ANIMATION_ATTACK;
        break;
    case LATENT_SIGNET_BONUS:
    {
        CBattleEntity* PTarget = m_POwner->GetBattleTarget();
        expression = PTarget != nullptr && m_POwner->GetMLevel() >= PTarget->GetMLevel() && m_POwner->loc.zone->GetRegionID() < 28;
        break;
    }
    case LATENT_SANCTION_REGEN_BONUS:
        expression = m_POwner->loc.zone->GetRegionID() >= 28 && m_POwner->loc.zone->GetRegionID() <= 32 && ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 < latentEffect.GetConditionsValue();
        break;
    case LATENT_SANCTION_REFRESH_BONUS:
        expression = m_POwner->loc.zone->GetRegionID() >= 28 && m_POwner->loc.zone->GetRegionID() <= 32 && ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 < latentEffect.GetConditionsValue();
        break;
    case LATENT_SIGIL_REGEN_BONUS:
        expression = m_POwner->loc.zone->GetRegionID() >= 33 && m_POwner->loc.zone->GetRegionID() <= 40 && ((float)m_POwner->health.hp / m_POwner->health.maxhp) * 100 < latentEffect.GetConditionsValue();
        break;
    case LATENT_SIGIL_REFRESH_BONUS:
        expression = m_POwner->loc.zone->GetRegionID() >= 33 && m_POwner->loc.zone->GetRegionID() <= 40 && ((float)m_POwner->health.mp / m_POwner->health.maxmp) * 100 < latentEffect.GetConditionsValue();
        break;
    case LATENT_STATUS_EFFECT_ACTIVE:
        expression = m_POwner->StatusEffectContainer->HasStatusEffect((EFFECT)latentEffect.GetConditionsValue());
        break;
    case LATENT_NO_FOOD_ACTIVE:
        expression = !m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_FOOD);
        break;
    case LATENT_PARTY_MEMBERS:
        expression = m_POwner->PParty != nullptr && latentEffect.GetConditionsValue() <= m_POwner->PParty->members.size();
        break;
    case LATENT_PARTY_MEMBERS_IN_ZONE:
    {
        auto inZone = 0;
        if (m_POwner->PParty != nullptr)
        {
            for (auto member : m_POwner->PParty->members)
            {
                if (member->getZone() == m_POwner->getZone())
                {
                    ++inZone;
                }
            }
        }
        expression = latentEffect.GetConditionsValue() <= inZone;
        break;
    }
    case LATENT_AVATAR_IN_PARTY:
        if (m_POwner->PParty != nullptr)
        {
            for (auto member : m_POwner->PParty->members)
            {
                if (member->PPet != nullptr)
                {
                    auto PPet = (CPetEntity*)member->PPet;
                    if (PPet->m_PetID == latentEffect.GetConditionsValue() &&
                        PPet->PAI->IsSpawned())
                    {
                        expression = true;
                        break;
                    }
                }
            }
        }
        else if (m_POwner->PParty == nullptr && m_POwner->PPet != nullptr)
        {
            auto PPet = (CPetEntity*)m_POwner->PPet;
            if (PPet->m_PetID == latentEffect.GetConditionsValue() &&
                !PPet->isDead())
            {
                expression = true;
            }
        }
        break;
    case LATENT_JOB_IN_PARTY:
        if (m_POwner->PParty != nullptr)
        {
            for (auto member : m_POwner->PParty->members)
            {
                if (member->id != m_POwner->id)
                {
                    if (member->GetMJob() == latentEffect.GetConditionsValue())
                    {
                        expression = true;
                        break;
                    }
                }
                for (auto trust : static_cast<CCharEntity*>(member)->PTrusts)
                {
                    if (trust->GetMJob() == latentEffect.GetConditionsValue())
                    {
                        expression = true;
                        break;
                    }
                }
            }
        }
        break;
    case LATENT_ZONE:
        expression = latentEffect.GetConditionsValue() == m_POwner->getZone();
        break;
    case LATENT_SYNTH_TRAINEE:
        // todo: figure this out
        break;
    case LATENT_SONG_ROLL_ACTIVE:
        expression = m_POwner->StatusEffectContainer->HasStatusEffectByFlag(EFFECTFLAG_ROLL | EFFECTFLAG_SONG);
        break;
    case LATENT_TIME_OF_DAY:
    {
        uint32 VanadielHour = CVanaTime::getInstance()->getHour();
        switch (latentEffect.GetConditionsValue())
        {
        case 0:
            //daytime: 06:00 to 18:00
            expression = VanadielHour >= 6 && VanadielHour < 18;
            break;
        case 1:
            //nighttime: 18:00 to 06:00
            expression = VanadielHour >= 18 || VanadielHour < 6;
            break;
        case 2:
            //dusk - dawn: 17:00 to 7:00
            expression = VanadielHour >= 17 || VanadielHour < 7;
            break;
        }
        break;
    }
    case LATENT_HOUR_OF_DAY:
    {
        uint32 VanadielHour = CVanaTime::getInstance()->getHour();
        switch (latentEffect.GetConditionsValue())
        {
        case 1:
            //new day
            expression = VanadielHour == 4;
            break;
        case 2:
            //dawn
            expression = VanadielHour >= 6 && VanadielHour < 7;
            break;
        case 3:
            //day
            expression = VanadielHour >= 7 && VanadielHour < 17;
            break;
        case 4:
            //dusk
            expression = VanadielHour >= 16 && VanadielHour < 18;
            break;
        case 5:
            //evening
            expression = VanadielHour >= 18 && VanadielHour < 20;
            break;
        case 6:
            //dead of night
            expression = VanadielHour >= 20 || VanadielHour < 4;
            break;
        }
        break;
    }
    case LATENT_FIRESDAY:
        expression = CVanaTime::getInstance()->getWeekday() == FIRESDAY;
        break;
    case LATENT_EARTHSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == EARTHSDAY;
        break;
    case LATENT_WATERSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == WATERSDAY;
        break;
    case LATENT_WINDSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == WINDSDAY;
        break;
    case LATENT_DARKSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == DARKSDAY;
        break;
    case LATENT_ICEDAY:
        expression = CVanaTime::getInstance()->getWeekday() == ICEDAY;
        break;
    case LATENT_LIGHTNINGSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == LIGHTNINGDAY;
        break;
    case LATENT_LIGHTSDAY:
        expression = CVanaTime::getInstance()->getWeekday() == LIGHTSDAY;
        break;
    case LATENT_MOON_PHASE:
    {
        uint32 MoonPhase = CVanaTime::getInstance()->getMoonPhase();
        uint32 MoonDirection = CVanaTime::getInstance()->getMoonDirection(); //directions: 1 = waning, 2 = waxing, 0 = neither
        switch (latentEffect.GetConditionsValue())
        {
        case 0:
            //New Moon - 10% waning -> 5% waxing
            expression = MoonPhase <= 5 || (MoonPhase <= 10 && MoonDirection == 1);
            break;
        case 1:
            //Waxing Crescent - 7% -> 38% waxing
            expression = MoonPhase >= 7 && MoonPhase <= 38 && MoonDirection == 2;
            break;
        case 2:
            //First Quarter - 40%% -> 55% waxing
            expression = MoonPhase >= 40 && MoonPhase <= 55 && MoonDirection == 2;
            break;
        case 3:
            //Waxing Gibbous - 57% -> 88%
            expression = MoonPhase >= 57 && MoonPhase <= 88 && MoonDirection == 2;
            break;
        case 4:
            //Full Moon - waxing 90% -> waning 95%
            expression = MoonPhase >= 95 || (MoonPhase >= 90 && MoonDirection == 2);
            break;
        case 5:
            //Waning Gibbous - 93% -> 62%
            expression = MoonPhase >= 62 && MoonPhase <= 93 && MoonDirection == 1;
            break;
        case 6:
            //Last Quarter - 60% -> 45%
            expression = MoonPhase >= 45 && MoonPhase <= 60 && MoonDirection == 1;
            break;
        case 7:
            //Waning Crescent - 43% -> 12%
            expression = MoonPhase >= 12 && MoonPhase <= 43 && MoonDirection == 1;
            break;
        }
        break;
    }
    case LATENT_JOB_MULTIPLE_5:
        expression = m_POwner->GetMLevel() % 5 == 0;
        break;
    case LATENT_JOB_MULTIPLE_10:
        expression = m_POwner->GetMLevel() % 10 == 0;
        break;
    case LATENT_JOB_MULTIPLE_13_NIGHT:
        expression = m_POwner->GetMLevel() % 13 == 0 && CVanaTime::getInstance()->SyncTime() == TIME_NIGHT;
        break;
    case LATENT_JOB_LEVEL_ODD:
        expression = m_POwner->GetMLevel() % 2 == 1;
        break;
    case LATENT_JOB_LEVEL_EVEN:
        expression = m_POwner->GetMLevel() % 2 == 0;
        break;
    case LATENT_WEAPON_DRAWN_HP_UNDER:
        expression = m_POwner->health.hp < latentEffect.GetConditionsValue() && m_POwner->animation == ANIMATION_ATTACK;
        break;
    case LATENT_MP_UNDER_VISIBLE_GEAR:
        //TODO: figure out if this is actually right
        //CItemEquipment* head = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_HEAD]));
        //CItemEquipment* body = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_BODY]));
        //CItemEquipment* hands = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_HANDS]));
        //CItemEquipment* legs = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_LEGS]));
        //CItemEquipment* feet = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_FEET]));

        //int32 visibleMp = 0;
        //visibleMp += (head ? head->getModifier(Mod::MP) : 0);
        //visibleMp += (body ? body->getModifier(Mod::MP) : 0);
        //visibleMp += (hands ? hands->getModifier(Mod::MP) : 0);
        //visibleMp += (legs ? legs->getModifier(Mod::MP) : 0);
        //visibleMp += (feet ? feet->getModifier(Mod::MP) : 0);

        //TODO: add mp percent too
        //if ((float)( mp / ((m_POwner->health.mp - m_POwner->health.modmp) + (m_POwner->PMeritPoints->GetMerit(MERIT_MAX_MP)->count * 10 ) +
        //    visibleMp) ) <= m_LatentEffectList.at(i)->GetConditionsValue())
        //{
        //    m_LatentEffectList.at(i)->Activate();
        //}
        //else
        //{
        //    m_LatentEffectList.at(i)->Deactivate();
        //}
        break;
    case LATENT_HP_OVER_VISIBLE_GEAR:
        //TODO: figure out if this is actually right
        //CItemEquipment* head = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_HEAD]));
        //CItemEquipment* body = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_BODY]));
        //CItemEquipment* hands = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_HANDS]));
        //CItemEquipment* legs = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_LEGS]));
        //CItemEquipment* feet = (CItemEquipment*)(m_POwner->getStorage(LOC_INVENTORY)->GetItem(m_POwner->equip[SLOT_FEET]));

        //int32 visibleHp = 0;
        //visibleHp += (head ? head->getModifier(Mod::HP) : 0);
        //visibleHp += (body ? body->getModifier(Mod::HP) : 0);
        //visibleHp += (hands ? hands->getModifier(Mod::HP) : 0);
        //visibleHp += (legs ? legs->getModifier(Mod::HP) : 0);
        //visibleHp += (feet ? feet->getModifier(Mod::HP) : 0);

        //TODO: add mp percent too
        //if ((float)( hp / ((m_POwner->health.hp - m_POwner->health.modhp) + (m_POwner->PMeritPoints->GetMerit(MERIT_MAX_HP)->count * 10 ) +
        //    visibleHp) ) <= m_LatentEffectList.at(i)->GetConditionsValue())
        //{
        //    m_LatentEffectList.at(i)->Activate();
        //}
        //else
        //{
        //    m_LatentEffectList.at(i)->Deactivate();
        //}
        break;
    case LATENT_WEAPON_BROKEN:
    {
        auto slot = latentEffect.GetSlot();
        auto item = (CItemWeapon*)m_POwner->getEquip((SLOTTYPE)slot);
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
    case LATENT_IN_DYNAMIS:
        expression = m_POwner->isInDynamis();
        break;
    case LATENT_IN_ASSAULT:
        expression = m_POwner->isInAssault();
        break;
    case LATENT_FOOD_ACTIVE:
        expression = m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_FOOD) &&
            m_POwner->StatusEffectContainer->GetStatusEffect(EFFECT_FOOD)->GetSubID() == latentEffect.GetConditionsValue();
        break;
    case LATENT_JOB_LEVEL_BELOW:
        expression = m_POwner->GetMLevel() < latentEffect.GetConditionsValue();
        break;
    case LATENT_JOB_LEVEL_ABOVE:
        expression = m_POwner->GetMLevel() >= latentEffect.GetConditionsValue();
        break;
    case LATENT_WEATHER_ELEMENT:
        expression = latentEffect.GetConditionsValue() == zoneutils::GetWeatherElement(battleutils::GetWeather((CBattleEntity*)m_POwner, false));
        break;
    case LATENT_NATION_CONTROL:
    {
        //player is logging in/zoning
        if (m_POwner->loc.zone == nullptr)
        {
            break;
        }

        auto region = m_POwner->loc.zone->GetRegionID();
        auto hasSignet = m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SIGNET);
        auto hasSanction = m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SANCTION);
        auto hasSigil = m_POwner->StatusEffectContainer->HasStatusEffect(EFFECT_SIGIL);

        switch (latentEffect.GetConditionsValue())
        {
        case 0:
            //under own nation's control
            expression = region < 28 && conquest::GetRegionOwner(region) == m_POwner->profile.nation && (hasSignet || hasSanction || hasSigil);
            break;
        case 1:
            //outside of own nation's control
            expression = region < 28 && m_POwner->profile.nation != conquest::GetRegionOwner(region) && (hasSignet || hasSanction || hasSigil);
            break;
        }
        break;
    }
    case LATENT_ZONE_HOME_NATION:
    {
        //player is logging in/zoning
        if (m_POwner->loc.zone == nullptr)
        {
            break;
        }

        auto PZone = m_POwner->loc.zone;
        auto region = (REGIONTYPE)latentEffect.GetConditionsValue();

        switch (region)
        {
        case REGION_SANDORIA:
            expression = m_POwner->profile.nation == 0 && PZone->GetRegionID() == region;
            break;
        case REGION_BASTOK:
            expression = m_POwner->profile.nation == 1 && PZone->GetRegionID() == region;
            break;
        case REGION_WINDURST:
            expression = m_POwner->profile.nation == 2 && PZone->GetRegionID() == region;
            break;
        default:
            break;
        }
        break;
    }
    case LATENT_MP_OVER:
        expression = m_POwner->health.mp >= latentEffect.GetConditionsValue();
        break;
    case LATENT_WEAPON_DRAWN_MP_OVER:
        expression = m_POwner->health.mp > latentEffect.GetConditionsValue() && m_POwner->animation == ANIMATION_ATTACK;
        break;
    case LATENT_ELEVEN_ROLL_ACTIVE:
        expression = m_POwner->StatusEffectContainer->CheckForElevenRoll();
        break;
    case LATENT_VS_ECOSYSTEM:
        if (CBattleEntity* PTarget = m_POwner->GetBattleTarget())
        {
            expression = PTarget->m_EcoSystem == latentEffect.GetConditionsValue();
        }
        break;
    case LATENT_VS_FAMILY:
        if (CBattleEntity* PTarget = m_POwner->GetBattleTarget())
        {
            CMobEntity* PMob = dynamic_cast<CMobEntity*>(PTarget);
            if (PMob)
            {
                expression = PMob->m_Family == latentEffect.GetConditionsValue();
            }
        }
        break;
    default:
        latentFound = false;
        ShowWarning("Latent ID %d unhandled in ProcessLatentEffect\n", latentEffect.GetConditionsID());
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
