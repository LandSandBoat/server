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

#include "entities/battleentity.h"

#include "entities/charentity.h"
#include "items/item_weapon.h"
#include "latent_effect.h"
#include "status_effect_container.h"

CLatentEffect::CLatentEffect(CBattleEntity* owner, LATENT conditionsId, uint16 conditionsValue, uint8 slot, Mod modValue, int16 modPower)
: m_POwner(owner)
, m_ConditionsID(conditionsId)
, m_ConditionsValue(conditionsValue)
, m_SlotID(slot)
, m_ModValue(modValue)
, m_ModPower(modPower)
{
}

CLatentEffect::~CLatentEffect()
{
    if (m_Activated)
    {
        Deactivate();
}
}

LATENT CLatentEffect::GetConditionsID() const
{
    return m_ConditionsID;
}

uint16 CLatentEffect::GetConditionsValue() const
{
    return m_ConditionsValue;
}

uint8 CLatentEffect::GetSlot() const
{
    return m_SlotID;
}

Mod CLatentEffect::GetModValue() const
{
    return m_ModValue;
}

int16 CLatentEffect::GetModPower() const
{
    return m_ModPower;
}

bool CLatentEffect::IsActivated() const
{
    return m_Activated;
}

CBattleEntity* CLatentEffect::GetOwner() const
{
    return m_POwner;
}

void CLatentEffect::SetConditionsId(LATENT id)
{
    m_ConditionsID = id;
}

void CLatentEffect::SetConditionsValue(uint16 value)
{
    m_ConditionsValue = value;
}

void CLatentEffect::SetSlot(uint8 slot)
{
    m_SlotID = slot;
}

void CLatentEffect::SetModValue(Mod value)
{
    m_ModValue = value;
}

void CLatentEffect::SetModPower(int16 power)
{
    m_ModPower = power;
}

bool CLatentEffect::Activate()
{
    if (!IsActivated())
    {
        //additional effect/dmg latents add mod to weapon, not player
        if (GetModValue() == Mod::ITEM_ADDEFFECT_TYPE || GetModValue() == Mod::DMG)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;
            CItemWeapon* weapon = (CItemWeapon*)PChar->getEquip((SLOTTYPE)GetSlot());

            weapon->addModifier(CModifier(GetModValue(), GetModPower()));
        }
        else
        {
            m_POwner->addModifier(m_ModValue, m_ModPower);
        }

        m_Activated = true;
        //printf("LATENT ACTIVATED: %d, Current value: %d\n", m_ModValue, m_POwner->getMod(m_ModValue));
        return true;
    }
    return false;
}

bool CLatentEffect::Deactivate()
{
    if (IsActivated())
    {
        //remove the modifier from weapon, not player
        if (GetModValue() == Mod::ITEM_ADDEFFECT_TYPE || GetModValue() == Mod::DMG)
        {
            CCharEntity* PChar = (CCharEntity*)m_POwner;
			CItemWeapon* weapon = (CItemWeapon*)PChar->getEquip((SLOTTYPE)GetSlot());

            int16 modPower = GetModPower();

            if (weapon != nullptr && (weapon->isType(ITEM_EQUIPMENT) || weapon->isType(ITEM_WEAPON)))
            {
                if (GetModValue() == Mod::ITEM_ADDEFFECT_TYPE)
                {
                    for (auto& i : weapon->modList)
                    {
                        //ensure the additional effect is fully removed from the weapon
                        if (i.getModID() == Mod::ITEM_ADDEFFECT_TYPE)
                        {
                            i.setModAmount(0);
                        }
                    }
                }
                else
                {
                    weapon->addModifier(CModifier(GetModValue(), -modPower));
                }
            }
        }
        else
        {
            m_POwner->delModifier(m_ModValue, m_ModPower);
        }

        m_Activated = false;
        //printf("LATENT DEACTIVATED: %d\n", m_ModValue);
        return true;
    }
    return false;
}
