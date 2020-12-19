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

#ifndef _CITEM_H
#define _CITEM_H

#include "../../common/cbasetypes.h"
#include "../../common/mmo.h"

// основной тип предмета m_type

enum ITEM_TYPE
{
    ITEM_BASIC      = 0x00,
    ITEM_GENERAL    = 0x01,
    ITEM_USABLE     = 0x02,
    ITEM_PUPPET     = 0x04,
    ITEM_EQUIPMENT  = 0x08,
    ITEM_WEAPON     = 0x10,
    ITEM_CURRENCY   = 0x20,
    ITEM_FURNISHING = 0x40,
    ITEM_LINKSHELL  = 0x80
};

// дополнительный тип предмета m_subtype

enum ITEM_SUBTYPE
{
    ITEM_NORMAL    = 0x00,
    ITEM_LOCKED    = 0x01,
    ITEM_CHARGED   = 0x02,
    ITEM_AUGMENTED = 0x04,
    ITEM_UNLOCKED  = 0xFE
};

// флаги предметов

enum ITEM_FLAG
{
    ITEM_FLAG_WALLHANGING  = 0x0001,
    ITEM_FLAG_01           = 0x0002,
    ITEM_FLAG_MYSTERY_BOX  = 0x0004, // Can be gained from Gobbie Mystery Box
    ITEM_FLAG_MOG_GARDEN   = 0x0008, // Can use in Mog Garden
    ITEM_FLAG_MAIL2ACCOUNT = 0x0010, // CanSendPOL Polutils Value
    ITEM_FLAG_INSCRIBABLE  = 0x0020,
    ITEM_FLAG_NOAUCTION    = 0x0040,
    ITEM_FLAG_SCROLL       = 0x0080,
    ITEM_FLAG_LINKSHELL    = 0x0100, // Linkshell Polutils Value
    ITEM_FLAG_CANUSE       = 0x0200,
    ITEM_FLAG_CANTRADENPC  = 0x0400,
    ITEM_FLAG_CANEQUIP     = 0x0800,
    ITEM_FLAG_NOSALE       = 0x1000,
    ITEM_FLAG_NODELIVERY   = 0x2000,
    ITEM_FLAG_EX           = 0x4000, // NoTradePC Polutils Value
    ITEM_FLAG_RARE         = 0x8000
};

class CItem
{
public:
    CItem(uint16 id);
    virtual ~CItem();

    uint16 getID() const;
    uint16 getSubID() const;
    uint16 getFlag() const;
    uint8  getAHCat() const;
    uint32 getReserve() const;
    uint32 getQuantity() const;
    uint32 getStackSize() const;
    uint32 getBasePrice() const;
    uint32 getCharPrice() const;
    uint8  getLocationID() const;
    uint8  getSlotID() const;

    bool isSent() const;
    bool isType(ITEM_TYPE) const;
    bool isSubType(ITEM_SUBTYPE) const;

    void setID(uint16);
    void setSubID(uint16);
    void setSubType(uint8);
    void setFlag(uint16);
    void setAHCat(uint8);
    void setReserve(uint32);
    void setQuantity(uint32);
    void setStackSize(uint32);
    void setBasePrice(uint32);
    void setCharPrice(uint32);
    void setLocationID(uint8 LocationID);
    void setSlotID(uint8 SlotID);
    void setSent(bool sent);

    const int8* getName();
    void        setName(int8* name);

    const int8* getSender();
    void        setSender(int8* sender);

    const int8* getReceiver();
    void        setReceiver(int8* receiver);

    virtual const int8* getSignature();
    virtual void        setSignature(int8* signature);

    uint8 m_extra[0x18]; // any extra data pertaining to item (augments, furniture location, etc)

protected:
    void setType(uint8);

private:
    uint16 m_id;
    uint16 m_subid;
    uint8  m_type;
    uint8  m_subtype;
    uint32 m_quantity;  // текущее количество предметов
    uint32 m_reserve;   // зарезервированное количество предметов
    uint32 m_stackSize; // максимальное количество предметов
    uint32 m_BasePrice;
    uint32 m_CharPrice; // стоимость предмета в bazaar
    uint8  m_ahCat;     // категоряи предмета на укционе
    uint16 m_flag;

    uint8 m_slotID;     // ячейка предмета в хранилище
    uint8 m_locationID; // номер хранилища предмета

    bool m_sent;

    string_t m_name;
    string_t m_send;
    string_t m_recv;
};

#endif
