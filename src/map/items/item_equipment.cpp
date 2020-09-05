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

#include "item_equipment.h"

#include <string.h>
#include "../map.h"

CItemEquipment::CItemEquipment(uint16 id) : CItemUsable(id)
{
	setType(ITEM_EQUIPMENT);

	m_jobs         = 0;
	m_modelID      = 0;
	m_removeSlotID = 0;
	m_shieldSize   = 0;
	m_scriptType   = 0;
	m_reqLvl       = 255;
    m_iLvl         = 0;
	m_equipSlotID  = 255;
    m_absorption   = 0;
}

CItemEquipment::~CItemEquipment()
{
	// ни в коем случае не освобождать здесь указатели на модификатоты и спецеффекты. они глобальны.
}

uint16 CItemEquipment::getModelId()
{
	return m_modelID;
}

uint8 CItemEquipment::getShieldSize()
{
	return m_shieldSize;
}

uint16 CItemEquipment::getEquipSlotId()
{
	return m_equipSlotID;
}

uint16 CItemEquipment::getRemoveSlotId()
{
	return m_removeSlotID;
}

uint8 CItemEquipment::getReqLvl()
{
	return m_reqLvl;
}

uint8 CItemEquipment::getILvl()
{
    return m_iLvl;
}

uint32 CItemEquipment::getJobs()
{
	return m_jobs;
}

void CItemEquipment::setReqLvl(uint8 lvl)
{
	m_reqLvl = lvl;
}

void CItemEquipment::setILvl(uint8 lvl)
{
    m_iLvl = lvl;
}

void CItemEquipment::setJobs(uint32 jobs)
{
	m_jobs = jobs;
}

void CItemEquipment::setModelId(uint16 mdl)
{
	m_modelID = mdl;
}

void CItemEquipment::setShieldSize(uint8 shield)
{
	m_shieldSize = shield;
}

void CItemEquipment::setEquipSlotId(uint16 equipSlot)
{
	m_equipSlotID = equipSlot;
}

void CItemEquipment::setRemoveSlotId(uint16 removSlot)
{
	m_removeSlotID = removSlot;
}

uint8 CItemEquipment::getSlotType()
{
	uint32 result = 0;
	getMSB(&result,(uint32)m_equipSlotID);
	return result;
}

/************************************************************************
*																		*
*  Процент урона, блокируемого щитом                                    *
*																		*
************************************************************************/

uint8 CItemEquipment::getShieldAbsorption()
{
    return m_absorption;
}

/************************************************************************
*																		*
*  Проверяем, является ли проедмет щитом                                *
*																		*
************************************************************************/

bool CItemEquipment::IsShield()
{
    return m_shieldSize > 0 && m_shieldSize <= 6;
}

/************************************************************************
*																		*
*  Проверяем необходимость выполнения скрипта для экипировки при		*
*  возникновении какого-либо из событий (экипировка, смена зоны и т.п.)	*
*																		*
*  Функция возвращает типы событий на которые предмет реагирует, что	*
*  избавляет нас от необходимости проверять	предмет во всех событиях	*
*																		*
************************************************************************/

uint16 CItemEquipment::getScriptType()
{
	return m_scriptType;
}

void CItemEquipment::setScriptType(uint16 ScriptType)
{
	m_scriptType = ScriptType;
}

/************************************************************************
*                                                                       *
*  Добавляем модификатор к предмету                                     *
*                                                                       *
************************************************************************/

void CItemEquipment::addModifier(CModifier modifier)
{
    if (IsShield() && modifier.getModID() == Mod::DEF)
    {
        // reduction calc source: www.bluegartr.com/threads/84830-Shield-Asstery
        // http://www.ffxiah.com/forum/topic/21671/paladin-faq-info-and-trade-studies/33/ <~Aegis and Ochain
		auto pdt = (uint8)(modifier.getModAmount() / 2);

        switch(m_shieldSize)
        {
            case 1: // Buckler
                pdt += 22;
                break;
            case 2: // Round
            case 6: // Ochain
                pdt += 40;
                break;
            case 3: // Kite
                pdt += 50;
                break;
            case 4: // Tower
            case 5: // Aegis
                pdt += 55;
                break;
        }
        m_absorption = std::min<uint8>(pdt, 100);
    }
    modList.push_back(modifier);
}

int16 CItemEquipment::getModifier(Mod mod)
{
	for (uint16 i = 0; i < modList.size(); ++i)
	{
		if (modList.at(i).getModID() == mod)
		{
			return modList.at(i).getModAmount();
		}
	}
	return 0;
}

void CItemEquipment::addPetModifier(CPetModifier modifier)
{
    petModList.push_back(modifier);
}

void CItemEquipment::addLatent(LATENT ConditionsID, uint16 ConditionsValue, Mod ModValue, int16 ModPower)
{
    itemLatent latent{ ConditionsID, ConditionsValue, ModValue, ModPower };
    latentList.push_back(latent);
}

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

void CItemEquipment::setTrialNumber(uint16 trial)
{
    if (trial)
    {
        ref<uint8>(m_extra, 0x01) |= 0x40;
        setSubType(ITEM_AUGMENTED);
        ref<uint8>(m_extra, 0x00) |= 0x02;
        ref<uint8>(m_extra, 0x01) |= 0x03;
    }
    else
        ref<uint8>(m_extra, 0x01) &= ~0x40;

    trial &= 0x7FFF;                               // Trial is only 15 bits long
    ref<uint16>(m_extra, 0x0A) &= ~0x7FFF;
    ref<uint16>(m_extra, 0x0A) |= (uint16)trial;
}

uint16 CItemEquipment::getTrialNumber()
{
    return ref<uint16>(m_extra, 0x0A) & 0x7FFF;
}

/************************************************************************
*                                                                       *
*  Augments: 5 bits for value, 11 bits for augment ID                   *
*                                                                       *
************************************************************************/
void CItemEquipment::LoadAugment(uint8 slot, uint16 augment)
{
    ref<uint16>(m_extra, 2 + (slot * 2)) = augment;
}

bool CItemEquipment::PushAugment(uint16 type, uint8 value)
{
    uint8 slot = 0;
    uint16 augment = ref<uint16>(m_extra, 2 + (slot * 2));
    while (augment != 0 && slot < 4)
    {
        ++slot;
        augment = ref<uint16>(m_extra, 2 + (slot * 2));
    }
    if (augment == 0)
    {
        setAugment(slot, type, value);
        return true;
    }
    return false;
}

void CItemEquipment::ApplyAugment(uint8 slot)
{
    SetAugmentMod(
        (uint16)unpackBitsBE(m_extra, 2 + (slot * 2), 0, 11),
        (uint8)unpackBitsBE(m_extra, 2 + (slot * 2), 11, 5)
        );
}

void CItemEquipment::setAugment(uint8 slot, uint16 type, uint8 value)
{
    packBitsBE(m_extra, type, 2 + (slot * 2), 0, 11);
    packBitsBE(m_extra, value, 2 + (slot * 2), 11, 5);

    SetAugmentMod(type, value);
}

void CItemEquipment::SetAugmentMod(uint16 type, uint8 value)
{
    if (type != 0)
    {
        setSubType(ITEM_AUGMENTED);
        ref<uint8>(m_extra, 0x00) |= 0x02;
        ref<uint8>(m_extra, 0x01) |= 0x03;
    }


    // obtain augment info by querying the db
    const char* fmtQuery = "SELECT augmentId, multiplier, modId, `value`, `isPet`, `petType` FROM augments WHERE augmentId = %u";

    int32 ret = Sql_Query(SqlHandle, fmtQuery, type);

    while (ret != SQL_ERROR &&
        Sql_NumRows(SqlHandle) != 0 &&
        Sql_NextRow(SqlHandle) == SQL_SUCCESS)
    {
        uint8 multiplier = (uint8)Sql_GetUIntData(SqlHandle, 1);
        Mod modId = static_cast<Mod>(Sql_GetUIntData(SqlHandle, 2));
        int16 modValue = (int16)Sql_GetIntData(SqlHandle, 3);

        // type is 0 unless mod is for pets
        uint8 isPet = (uint8)Sql_GetUIntData(SqlHandle, 4);
        PetModType petType = static_cast<PetModType>(Sql_GetIntData(SqlHandle, 5));

        // apply modifier to item. increase modifier power by 'value' (default magnitude 1 for most augments) if multiplier isn't specified
        // otherwise increase modifier power using the multiplier
        // check if we should be adding to or taking away from the mod power (handle scripted augments properly)
        modValue = (modValue > 0 ? modValue + value : modValue - value) * (multiplier > 1 ? multiplier : 1);

        if (!isPet)
            addModifier(CModifier(modId, modValue));
        else
            addPetModifier(CPetModifier(modId, petType, modValue));
    }
}

uint16 CItemEquipment::getAugment(uint8 slot)
{
    return ref<uint16>(m_extra, 2 + (slot * 2));
}
