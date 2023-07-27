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

#ifndef _LATENTEFFECTCONTAINER_H
#define _LATENTEFFECTCONTAINER_H

#include "common/cbasetypes.h"
#include "common/taskmgr.h"

#include "entities/petentity.h"
#include "items/item_equipment.h"
#include "latent_effect.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

class CCharEntity;

class CLatentEffectContainer
{
public:
    void CheckLatentsHP();
    void CheckLatentsTP();
    void CheckLatentsMP();
    void CheckLatentsEquip(uint8 slot);
    void CheckLatentsWeaponDraw(bool drawn);
    void CheckLatentsStatusEffect();
    void CheckLatentsFoodEffect();
    void CheckLatentsRollSong();
    void CheckLatentsDay();
    void CheckLatentsMoonPhase();
    void CheckLatentsHours();
    void CheckLatentsWeekDay();
    void CheckLatentsPartyMembers(size_t members);
    void CheckLatentsPartyJobs();
    void CheckLatentsPartyAvatar();
    void CheckLatentsJobLevel();
    void CheckLatentsPetType();
    void CheckLatentsTime();
    void CheckLatentsWeaponBreak(uint8 slot);
    void CheckLatentsZone();
    void CheckLatentsWeather();
    void CheckLatentsWeather(uint16 weather);
    void CheckLatentsTargetChange();

    void AddLatentEffects(std::vector<CItemEquipment::itemLatent>& latentList, uint8 reqLvl, uint8 slot);
    void DelLatentEffects(uint8 reqLvl, uint8 slot);

    void AddLatentEffect(LATENT conditionID, uint16 conditionValue, Mod modID, int16 modValue);
    bool DelLatentEffect(LATENT conditionID, uint16 conditionValue, Mod modID, int16 modValue);

    CLatentEffectContainer(CCharEntity* PEntity);

private:
    CCharEntity*               m_POwner;
    std::vector<CLatentEffect> m_LatentEffectList;

    void ProcessLatentEffects(const std::function<bool(CLatentEffect&)>& logic);
    bool ProcessLatentEffect(CLatentEffect& latentEffect);
    bool ApplyLatentEffect(CLatentEffect& effect, bool expression);
};

#endif
