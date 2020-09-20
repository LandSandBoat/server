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

#ifndef _STATUSEFFECTCONTAINER_H
#define _STATUSEFFECTCONTAINER_H

#include "../common/cbasetypes.h"
#include "../common/taskmgr.h"

#include <set>

#include "status_effect.h"

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

class CBattleEntity;

class CStatusEffectContainer
{
public:

    uint64	m_Flags{0};											// биты переполнения байтов m_StatusIcons (по два бита на каждый эффект)
    uint8 m_StatusIcons[32];                  // иконки статус-эффектов

    bool ApplyBardEffect(CStatusEffect* PStatusEffect, uint8 maxSongs);
    bool CanGainStatusEffect(CStatusEffect* PStatusEffect); // returns true if the status effect will take effect
    bool AddStatusEffect(CStatusEffect* StatusEffect, bool silent = false);
    bool DelStatusEffect(EFFECT StatusID);
    bool DelStatusEffectSilent(EFFECT StatusID);
    bool DelStatusEffect(EFFECT StatusID, uint16 SubID);
    void DelStatusEffectsByFlag(uint32 flag, bool silent = false);                   // удаляем все эффекты с указанным типом
    void DelStatusEffectsByIcon(uint16 IconID);                 // удаляем все эффекты с указанной иконкой
    void DelStatusEffectsByType(uint16 Type);
    bool DelStatusEffectByTier(EFFECT StatusID, uint16 power);
    void KillAllStatusEffect();

    bool HasStatusEffect(EFFECT StatusID);                      // проверяем наличие эффекта
    bool HasStatusEffect(EFFECT StatusID, uint16 SubID);        // проверяем наличие эффекта с уникальным subid
    bool HasStatusEffect(std::initializer_list<EFFECT>);
    bool HasStatusEffectByFlag(uint32 flag);

    EFFECT EraseStatusEffect();                                 // удаляем первый отрицательный эффект
    EFFECT HealingWaltz();				// dancers healing waltz
    uint8 EraseAllStatusEffect();               // erases all status effects
    EFFECT DispelStatusEffect(EFFECTFLAG flag);             // удаляем первый положительный эффект
    uint8 DispelAllStatusEffect(EFFECTFLAG flag);                // dispels all status effects
    CStatusEffect* StealStatusEffect(EFFECTFLAG flag);             // dispels one effect and returns it

    CStatusEffect* GetStatusEffect(EFFECT StatusID);
    CStatusEffect* GetStatusEffect(EFFECT StatusID, uint32 SubID);

    void UpdateStatusIcons();                                   // пересчитываем иконки эффектов
    void CheckEffectsExpiry(time_point tick);
    void TickEffects(time_point tick);
    void TickRegen(time_point tick);

    void LoadStatusEffects();                                   // загружаем эффекты персонажа
    void SaveStatusEffects(bool logout = false);                // сохраняем эффекты персонажа

    uint8 GetEffectsCount(EFFECT ID);                        // получаем количество эффектов с указанным id
    uint8 GetLowestFreeSlot(); // returns the lowest free slot for songs/rolls

    bool ApplyCorsairEffect(CStatusEffect* PStatusEffect, uint8 maxRolls, uint8 bustDuration);
    bool CheckForElevenRoll();
    bool HasBustEffect(uint16 id);
    bool HasCorsairEffect(uint32 charid);
    void Fold(uint32 charid);

    uint8 GetActiveManeuvers();
    void RemoveOldestManeuver();
    void RemoveAllManeuvers();

    void WakeUp(); // remove sleep effects
    bool IsAsleep();
    bool HasPreventActionEffect(); // checks if owner has an effect that prevents actions, like stun, petrify, sleep etc

    uint16 GetConfrontationEffect(); // gets confrontation number (bcnm, confrontation, campaign, reive mark)
    void CopyConfrontationEffect(CBattleEntity* PEntity); // copies confrontation status (pet summoning, etc)

    template<typename F, typename... Args>
    void ForEachEffect(F func, Args&&... args)
    {
        for (auto&& PEffect : m_StatusEffectSet)
        {
            func(PEffect, std::forward<Args>(args)...);
        }
    }

    CStatusEffectContainer(CBattleEntity* PEntity);
    ~CStatusEffectContainer();

private:

    CBattleEntity* m_POwner;

    // void ReplaceStatusEffect(EFFECT effect); //this needs to be implemented
    void RemoveStatusEffect(uint32 id, bool silent = false);	// удаляем эффект по его номеру в контейнере
    void RemoveStatusEffect(CStatusEffect* PEffect, bool silent = false);	// удаляем эффект по его номеру в контейнере
    void DeleteStatusEffects();
    void SetEffectParams(CStatusEffect* StatusEffect);			// устанавливаем имя эффекта
    void HandleAura(CStatusEffect* PStatusEffect);

    void OverwriteStatusEffect(CStatusEffect* StatusEffect);

    std::multiset<CStatusEffect*, bool(*)(CStatusEffect* AStatus, CStatusEffect* BStatus)>	m_StatusEffectSet;
};

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

namespace effects
{
    void LoadEffectsParameters();
    uint16 GetEffectElement(uint16 effect);
};

#endif

