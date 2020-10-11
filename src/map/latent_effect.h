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

#ifndef _LATENTEFFECT_H
#define _LATENTEFFECT_H

#include "../common/cbasetypes.h"
#include "../common/mmo.h"
#include "modifier.h"

enum LATENT
{
    LATENT_HP_UNDER_PERCENT         = 0,  //hp less than or equal to % - PARAM: HP PERCENT
    LATENT_HP_OVER_PERCENT          = 1,  //hp more than % - PARAM: HP PERCENT
    LATENT_HP_UNDER_TP_UNDER_100    = 2,  //hp less than or equal to %, tp under 100 - PARAM: HP PERCENT
    LATENT_HP_OVER_TP_UNDER_100     = 3,  //hp more than %, tp over 100 - PARAM: HP PERCENT
    LATENT_MP_UNDER_PERCENT         = 4,  //mp less than or equal to % - PARAM: MP PERCENT
    LATENT_MP_UNDER                 = 5,  //mp less than # - PARAM: MP #
    LATENT_TP_UNDER                 = 6,  //tp under # and during WS - PARAM: TP VALUE
    LATENT_TP_OVER                  = 7,  //tp over # - PARAM: TP VALUE
    LATENT_SUBJOB                   = 8,  //subjob - PARAM: JOBTYPE
    LATENT_PET_ID                   = 9,  //pettype - PARAM: PETID
    LATENT_WEAPON_DRAWN             = 10, //weapon drawn
    LATENT_WEAPON_SHEATHED          = 11, //weapon sheathed
    LATENT_SIGNET_BONUS             = 12, // While in conquest region and engaged to an even match or less target
    LATENT_STATUS_EFFECT_ACTIVE     = 13, //status effect on player - PARAM: EFFECTID
    LATENT_NO_FOOD_ACTIVE           = 14, //no food effects active on player
    LATENT_PARTY_MEMBERS            = 15, //party size # - PARAM: # OF MEMBERS
    LATENT_PARTY_MEMBERS_IN_ZONE    = 16, //party size # and members in zone - PARAM: # OF MEMBERS
    LATENT_SANCTION_REGEN_BONUS     = 17, // While in besieged region and HP is less than PARAM%
    LATENT_SANCTION_REFRESH_BONUS   = 18, // While in besieged region and MP is less than PARAM%
    LATENT_SIGIL_REGEN_BONUS        = 19, // While in campaign region and HP is less than PARAM%
    LATENT_SIGIL_REFRESH_BONUS      = 20, // While in campaign region and MP is less than PARAM%
    LATENT_AVATAR_IN_PARTY          = 21, //party has a specific avatar - PARAM: same as globals/pets.lua (21 for any avatar)
    LATENT_JOB_IN_PARTY             = 22, //party has job - PARAM: JOBTYPE
    LATENT_ZONE                     = 23, //in zone - PARAM: zoneid
    LATENT_SYNTH_TRAINEE            = 24, //synth skill under 40 + no support
    LATENT_SONG_ROLL_ACTIVE         = 25, //any song or roll active
    LATENT_TIME_OF_DAY              = 26, //PARAM: 0: DAYTIME 1: NIGHTTIME 2: DUSK-DAWN
    LATENT_HOUR_OF_DAY              = 27, //PARAM: 1: NEW DAY, 2: DAWN, 3: DAY, 4: DUSK, 5: EVENING, 6: DEAD OF NIGHT
    LATENT_FIRESDAY                 = 28,
    LATENT_EARTHSDAY                = 29,
    LATENT_WATERSDAY                = 30,
    LATENT_WINDSDAY                 = 31,
    LATENT_DARKSDAY                 = 32,
    LATENT_ICEDAY                   = 34,
    LATENT_LIGHTNINGSDAY            = 35,
    LATENT_LIGHTSDAY                = 36,
    LATENT_MOON_PHASE               = 37, //PARAM: 0: New Moon, 1: Waxing Crescent, 2: First Quarter, 3: Waxing Gibbous, 4: Full Moon, 5: Waning Gibbous, 6: Last Quarter, 7: Waning Crescent
    LATENT_JOB_MULTIPLE_5           = 38,
    LATENT_JOB_MULTIPLE_10          = 39,
    LATENT_JOB_MULTIPLE_13_NIGHT    = 40,
    LATENT_JOB_LEVEL_ODD            = 41,
    LATENT_JOB_LEVEL_EVEN           = 42,
    LATENT_WEAPON_DRAWN_HP_UNDER    = 43, //PARAM: HP PERCENT
    //                              = 44  //Unused
    LATENT_MP_UNDER_VISIBLE_GEAR    = 45, //mp less than or equal to %, calculated using MP bonuses from visible gear only
    LATENT_HP_OVER_VISIBLE_GEAR     = 46, //hp more than or equal to %, calculated using HP bonuses from visible gear only
    LATENT_WEAPON_BROKEN            = 47,
    LATENT_IN_DYNAMIS               = 48,
    LATENT_FOOD_ACTIVE              = 49, //food effect (foodId) active - PARAM: FOOD ITEMID
    LATENT_JOB_LEVEL_BELOW          = 50, //PARAM: level
    LATENT_JOB_LEVEL_ABOVE          = 51, //PARAM: level
    LATENT_WEATHER_ELEMENT          = 52, //PARAM: 0: NONE, 1: FIRE, 2: ICE, 3: WIND 4: EARTH, 5: THUNDER, 6: WATER, 7: LIGHT, 8: DARK
    LATENT_NATION_CONTROL           = 53, //checks if player region is under nation's control - PARAM: 0: Under own nation's control, 1: Outside own nation's control
    LATENT_ZONE_HOME_NATION         = 54, //in zone and citizen of nation (aketons)
    LATENT_MP_OVER                  = 55, //mp greater than # - PARAM: MP #
    LATENT_WEAPON_DRAWN_MP_OVER     = 56, //while weapon is drawn and mp greater than # - PARAM: MP #
    LATENT_ELEVEN_ROLL_ACTIVE       = 57, //corsair roll of 11 active
    LATENT_IN_ASSAULT               = 58, // is in an Instance battle in a TOAU zone
    LATENT_VS_ECOSYSTEM             = 59, // Vs. Specific Ecosystem ID (e.g. Vs. Birds: Accuracy+3)
    LATENT_VS_FAMILY                = 60, // Vs. Specific Family ID (e.g. Vs. Apkallu: Accuracy+3)
};

#define MAX_LATENTEFFECTID    61

/************************************************************************
*																		*
*  Нерешенные задачи:													*
*																		*
*  - сохранение ID сущности, добавившей эффект							*
*  - обновление эффекта (например перезапись protect 1 на protect 2)    *
*																		*
************************************************************************/

class CBattleEntity;

class CLatentEffect
{
public:

    LATENT      GetConditionsID() const;
    uint16      GetConditionsValue() const;
    uint8       GetSlot() const;
    Mod         GetModValue() const;
    int16       GetModPower() const;
    bool        IsActivated() const;

    CBattleEntity* GetOwner() const;

    void    SetConditionsId(LATENT id);
    void    SetConditionsValue(uint16 value);
    void    SetSlot(uint8 slot);
    void    SetModValue(Mod value);
    void    SetModPower(int16 power);
    bool    Activate();
    bool    Deactivate();

    CLatentEffect(
         CBattleEntity* owner,
         LATENT conditionsId,
         uint16 conditionsValue,
         uint8 slot,
         Mod modValue,
         int16 modPower
    );
    CLatentEffect(const CLatentEffect&) = delete;
    CLatentEffect& operator=(const CLatentEffect&) = delete;
    CLatentEffect(CLatentEffect&& o) noexcept
    {
        std::swap(m_POwner, o.m_POwner);
        std::swap(m_ConditionsID, o.m_ConditionsID);
        std::swap(m_ConditionsValue, o.m_ConditionsValue);
        std::swap(m_SlotID, o.m_SlotID);
        std::swap(m_ModValue, o.m_ModValue);
        std::swap(m_ModPower, o.m_ModPower);
        std::swap(m_Activated, o.m_Activated);
    }
    CLatentEffect& operator=(CLatentEffect&& o) noexcept
    {
        std::swap(m_POwner, o.m_POwner);
        std::swap(m_ConditionsID, o.m_ConditionsID);
        std::swap(m_ConditionsValue, o.m_ConditionsValue);
        std::swap(m_SlotID, o.m_SlotID);
        std::swap(m_ModValue, o.m_ModValue);
        std::swap(m_ModPower, o.m_ModPower);
        std::swap(m_Activated, o.m_Activated);
        return *this;
    }

   ~CLatentEffect();

private:

    CBattleEntity* m_POwner{nullptr};

    LATENT      m_ConditionsID{LATENT_HP_UNDER_PERCENT};         //condition type to be true
    uint16      m_ConditionsValue{0};      //condition parameter to be met
    uint8       m_SlotID{0};               //slot associated with latent
    Mod         m_ModValue{Mod::NONE};     //mod ID to be applied when active
    int16       m_ModPower{0};             //power of mod to be applied when active
    bool        m_Activated{false};        //active or not active
};

#endif

