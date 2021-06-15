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

#include <cstring>

#include "../../common/utils.h"
#include "item.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

CItem::CItem(uint16 id)
{
    m_id = id;

    m_subid     = 0;
    m_type      = 0;
    m_subtype   = 0;
    m_reserve   = 0;
    m_quantity  = 0;
    m_stackSize = 0;
    m_BasePrice = 0;
    m_CharPrice = 0;
    m_ahCat     = 0;
    m_flag      = 0;
    m_sent      = false;

    m_slotID     = -1;
    m_locationID = -1;

    memset(m_extra, 0, sizeof m_extra);
}

CItem::~CItem() = default;

/************************************************************************
 *                                                                       *
 *  Уникальный номер предмета                                            *
 *                                                                       *
 ************************************************************************/

void CItem::setID(uint16 id)
{
    m_id = id;
}

uint16 CItem::getID() const
{
    return m_id;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setSubID(uint16 subid)
{
    m_subid = subid;
}

uint16 CItem::getSubID() const
{
    return m_subid;
}

/************************************************************************
 *                                                                       *
 *  Параметр, определяющий характеристики предмета                       *
 *                                                                       *
 ************************************************************************/

void CItem::setFlag(uint16 flag)
{
    m_flag = flag;
}

uint16 CItem::getFlag() const
{
    return m_flag;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setAHCat(uint8 ahCat)
{
    m_ahCat = ahCat;
}

uint8 CItem::getAHCat() const
{
    return m_ahCat;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setType(uint8 type)
{
    m_type |= type;
}

bool CItem::isType(ITEM_TYPE type) const
{
    return (m_type & type);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setSubType(uint8 subtype)
{
    m_subtype = (subtype > 128 ? m_subtype & subtype : m_subtype | subtype);
}

bool CItem::isSubType(ITEM_SUBTYPE subtype) const
{
    return (m_subtype & subtype);
}

/************************************************************************
 *                                                                       *
 *  Зарезервированное количество предметов в пачке                       *
 *                                                                       *
 ************************************************************************/

void CItem::setReserve(uint32 reserve)
{
    m_reserve = (reserve < m_quantity ? reserve : m_quantity);
}

uint32 CItem::getReserve() const
{
    return m_reserve;
}

/************************************************************************
 *                                                                       *
 *  Текущее количество предметов в пачке                                 *
 *                                                                       *
 ************************************************************************/

void CItem::setQuantity(uint32 quantity)
{
    m_quantity = (quantity < m_stackSize ? quantity : m_stackSize);
}

uint32 CItem::getQuantity() const
{
    return m_quantity;
}

/************************************************************************
 *                                                                       *
 *  Максимальное количество предметов в пачке                            *
 *                                                                       *
 ************************************************************************/

void CItem::setStackSize(uint32 stackSize)
{
    m_stackSize = stackSize;
}

uint32 CItem::getStackSize() const
{
    return m_stackSize;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setBasePrice(uint32 BasePrice)
{
    m_BasePrice = BasePrice;
}

uint32 CItem::getBasePrice() const
{
    return m_BasePrice;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setCharPrice(uint32 CharPrice)
{
    if (!(m_flag & ITEM_FLAG_EX))
    {
        m_CharPrice = CharPrice;
    }
}

uint32 CItem::getCharPrice() const
{
    return m_CharPrice;
}

/************************************************************************
 *                                                                       *
 *  Название предмета                                                    *
 *                                                                       *
 ************************************************************************/

const int8* CItem::getName()
{
    return (const int8*)m_name.c_str();
}

void CItem::setName(int8* name)
{
    m_name.clear();
    m_name.insert(0, (const char*)name);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

const int8* CItem::getSender()
{
    return (const int8*)m_send.c_str();
}

void CItem::setSender(int8* sender)
{
    m_send.clear();
    m_send.insert(0, (const char*)sender);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

const int8* CItem::getReceiver()
{
    return (const int8*)m_recv.c_str();
}

void CItem::setReceiver(int8* receiver)
{
    m_recv.clear();
    m_recv.insert(0, (const char*)receiver);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

const int8* CItem::getSignature()
{
    return (int8*)m_extra + 0x0C;
}

void CItem::setSignature(int8* signature)
{
    memcpy(m_extra + 0x0C, signature, sizeof(m_extra) - 0x0C);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

uint8 CItem::getLocationID() const
{
    return m_locationID;
}

void CItem::setLocationID(uint8 locationID)
{
    m_locationID = locationID;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

uint8 CItem::getSlotID() const
{
    return m_slotID;
}

void CItem::setSlotID(uint8 slotID)
{
    m_slotID = slotID;
}

/************************************************************************
 *                                                                       *
 *  Sent (via send/delivery box)                                         *
 *                                                                       *
 ************************************************************************/

void CItem::setSent(bool sent)
{
    m_sent = sent;
}

bool CItem::isSent() const
{
    return m_sent;
}

/************************************************************************
 *                                                                       *
 *  Handle Storage Slips                                                 *
 *                                                                       *
 ************************************************************************/

bool CItem::isStorageSlip() const
{
    return m_id < 29340 && m_id > 29311;
}

// Original work by Byrth of Windower, translated to C++
// https://github.com/Windower/Lua/blob/dev/addons/libs/extdata.lua

// Thanks to Godmode of Eden for this impl.
void PackSoultrapperName(std::string name, uint8 output[], uint8 size)
{
    uint8 current = 0;
    uint8 next = 0;
    uint8 shift = 1;
    uint8 loops = 0;
    uint8 total = (uint8)name.length();
    uint8 maxSize = std::max((uint8)20, size);

    for (uint8 i = 0; i <= maxSize; ++i)
    {
        current = i < total ? (uint8)name.at(i) : 0;
        next = i + 1 < total ? (uint8)name.at(i + 1) : 0;
        uint8 tempLeft = current;
        for (int j = 0; j < shift; ++j)
        {
            tempLeft = tempLeft << 1;
            if (j + 1 != shift && tempLeft & 128) tempLeft = tempLeft ^ 128;
        }
        uint8 tempRight = next >> (7 - shift);
        output[i - loops] = tempLeft | tempRight;

        if (shift == 7)
        {
            shift = 1;
            loops++;
            i++;
            total--;
        }
        else
        {
            shift++;
        }
    }
}

void CItem::setSoulPlateName(std::string name)
{
    PackSoultrapperName(name, m_extra, 20);
}

void CItem::setSoulPlateSkillIndex(uint16 index)
{
    m_extra[20] = index << 7;
    m_extra[21] = index >> 1;
    m_extra[22] = index >> 9;
}

void CItem::setSoulPlateFP(uint8 fp)
{
    m_extra[22] = fp << 3;
    m_extra[23] = (0x03 << 4) & fp;
}

auto CItem::getSoulPlateName() -> std::string
{
    // TODO
    return "";
}

auto CItem::getSoulPlateSkillIndex() -> uint16
{
    return (m_extra[20] >> 7) + (m_extra[21] << 1) + ((m_extra[22] & 0x03) << 9);
}

auto CItem::getSoulPlateFP() -> uint8
{
    return (m_extra[22] >> 3) + ((m_extra[23] & 0x03) << 4);
}
