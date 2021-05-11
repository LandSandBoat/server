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
*  Appraisal Origin IDs                                                 *
*                                                                       *
************************************************************************/

uint8 CItem::getAppraisalID()
{
    return m_extra[0x16];
}

void CItem::setAppraisalID(uint8 appID)
{
    m_extra[0x16] = appID;
}
