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

#include "entities/battle_entity.h"

#include "entities/char_entity.h"
#include "items/item_weapon.h"
#include "latent_effect.h"
#include "packets/s2c/0x0ac_command_data.h"
#include "status_effect_container.h"
#include "utils/charutils.h"

CLatentEffect::CLatentEffect(CBattleEntity* owner, xi::Latent conditionsId, uint16 conditionsValue, uint8 slot, xi::Mod modValue, int16 modPower)
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

auto CLatentEffect::GetConditionsID() const -> xi::Latent
{
    return m_ConditionsID;
}

auto CLatentEffect::GetConditionsValue() const -> uint16
{
    return m_ConditionsValue;
}

auto CLatentEffect::GetSlot() const -> uint8
{
    return m_SlotID;
}

auto CLatentEffect::GetModValue() const -> xi::Mod
{
    return m_ModValue;
}

auto CLatentEffect::GetModPower() const -> int16
{
    return m_ModPower;
}

auto CLatentEffect::IsActivated() const -> bool
{
    return m_Activated;
}

auto CLatentEffect::GetOwner() const -> CBattleEntity*
{
    return m_POwner;
}

void CLatentEffect::SetConditionsId(xi::Latent id)
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

void CLatentEffect::SetModValue(xi::Mod value)
{
    m_ModValue = value;
}

void CLatentEffect::SetModPower(int16 power)
{
    m_ModPower = power;
}

auto CLatentEffect::ModOnItemOnly(xi::Mod modID) -> bool
{
    if (modID == xi::Mod::DMG_RATING ||
        modID == xi::Mod::ITEM_ADDEFFECT_TYPE ||
        modID == xi::Mod::ITEM_SUBEFFECT ||
        modID == xi::Mod::ITEM_ADDEFFECT_DMG ||
        modID == xi::Mod::ITEM_ADDEFFECT_CHANCE ||
        modID == xi::Mod::ITEM_ADDEFFECT_ELEMENT ||
        modID == xi::Mod::ITEM_ADDEFFECT_STATUS ||
        modID == xi::Mod::ITEM_ADDEFFECT_POWER ||
        modID == xi::Mod::ITEM_ADDEFFECT_DURATION ||
        modID == xi::Mod::ADDS_WEAPONSKILL ||
        modID == xi::Mod::MOVE_SPEED_GEAR_BONUS ||
        modID == xi::Mod::CRITHITRATE_ONLY_WEP)
    {
        return true;
    }
    return false;
}

auto CLatentEffect::SkillMod(xi::Mod modID) -> bool
{
    return (modID >= xi::Mod::HTH && modID <= xi::Mod::STAFF) ||
           (modID >= xi::Mod::AUTO_MELEE_SKILL && modID <= xi::Mod::HANDBELL_SKILL);
}

auto CLatentEffect::Activate() -> bool
{
    if (!IsActivated())
    {
        // Additional effect/dmg latents add mod to item, not player
        if (ModOnItemOnly(GetModValue()))
        {
            CCharEntity*    PChar = static_cast<CCharEntity*>(m_POwner);
            CItemEquipment* item  = PChar->getEquip((SLOTTYPE)GetSlot());

            if (item)
            {
                item->addModifier(GetModValue(), GetModPower());
                charutils::BuildingCharWeaponSkills(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
                m_PItem = item;
            }
        }
        // Other modifiers go on the player
        else
        {
            m_POwner->addModifier(m_ModValue, m_ModPower);

            if (SkillMod(GetModValue()))
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(m_POwner);
                charutils::BuildingCharSkillsTable(PChar);
            }
        }

        m_Activated = true;
        return true;
    }
    return false;
}

auto CLatentEffect::Deactivate() -> bool
{
    if (IsActivated())
    {
        // Remove the modifier from item, not player
        if (ModOnItemOnly(GetModValue()))
        {
            if (m_PItem != nullptr)
            {
                m_PItem->delModifier(GetModValue(), GetModPower());
                CCharEntity* PChar = static_cast<CCharEntity*>(m_POwner);
                charutils::BuildingCharWeaponSkills(PChar);
                PChar->pushPacket<GP_SERV_COMMAND_COMMAND_DATA>(PChar);
            }
        }
        // Remove other modifiers from player
        else
        {
            m_POwner->delModifier(m_ModValue, m_ModPower);

            if (SkillMod(GetModValue()))
            {
                CCharEntity* PChar = static_cast<CCharEntity*>(m_POwner);
                charutils::BuildingCharSkillsTable(PChar);
            }
        }

        m_Activated = false;
        // printf("LATENT DEACTIVATED: %d", m_ModValue);
        return true;
    }
    return false;
}
