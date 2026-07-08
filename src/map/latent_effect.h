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

#include "./entities/battle_entity.h"
#include "./items/item_equipment.h"
#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "modifier.h"

#include "data/enums/latent.h"

#define MAX_LATENTEFFECTID 65

/************************************************************************
 *                                                                       *
 * Unsolved problems:                                                    *
 *                                                                       *
 * - saving the ID of the entity that added the effect                   *
 * - updating effect (for example, overwriting protect 1 with protect 2) *
 *                                                                       *
 ************************************************************************/

class CBattleEntity;

class CLatentEffect
{
public:
    auto   GetConditionsID() const -> xi::Latent;
    uint16 GetConditionsValue() const;
    uint8  GetSlot() const;
    Mod    GetModValue() const;
    int16  GetModPower() const;
    bool   IsActivated() const;

    CBattleEntity* GetOwner() const;

    void SetConditionsId(xi::Latent id);
    void SetConditionsValue(uint16 value);
    void SetSlot(uint8 slot);
    void SetModValue(Mod value);
    void SetModPower(int16 power);
    bool ModOnItemOnly(Mod modID);
    bool Activate();
    bool Deactivate();

    CLatentEffect(CBattleEntity* owner, xi::Latent conditionsId, uint16 conditionsValue, uint8 slot, Mod modValue, int16 modPower);
    CLatentEffect(const CLatentEffect&)            = delete;
    CLatentEffect& operator=(const CLatentEffect&) = delete;

    CLatentEffect(CLatentEffect&& o) noexcept
    {
        std::swap(m_POwner, o.m_POwner);
        std::swap(m_PItem, o.m_PItem);
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
        std::swap(m_PItem, o.m_PItem);
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
    CBattleEntity*  m_POwner{ nullptr };
    CItemEquipment* m_PItem{ nullptr }; // Item this latent is attached to.

    xi::Latent m_ConditionsID{ xi::Latent::HpUnderPercent }; // condition type to be true
    uint16     m_ConditionsValue{ 0 };                       // condition parameter to be met
    uint8      m_SlotID{ 0 };                                // slot associated with latent
    Mod        m_ModValue{ Mod::NONE };                      // mod ID to be applied when active
    int16      m_ModPower{ 0 };                              // power of mod to be applied when active
    bool       m_Activated{ false };                         // active or not active
};

#endif
