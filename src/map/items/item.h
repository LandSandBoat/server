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

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "common/types/badge.h"

#include "map/enums/item_flag.h"
#include "map/enums/item_state.h"

namespace xi::items::detail
{
struct ItemAccess;
} // namespace xi::items::detail

// The main type of item m_type
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
    ITEM_LINKSHELL  = 0x80,
};

// Additional type of object m_subtype
enum ITEM_SUBTYPE
{
    ITEM_NORMAL    = 0x00,
    ITEM_LOCKED    = 0x01,
    ITEM_CHARGED   = 0x02,
    ITEM_AUGMENTED = 0x04,
    ITEM_UNLOCKED  = 0xFE,
};

class CItem
{
public:
    CItem(uint16 id);
    CItem(const CItem& other);
    auto operator=(const CItem&) -> CItem& = delete;

    virtual ~CItem();

    uint16 getID() const;
    uint16 getSubID() const;
    auto   getFlag() const -> ItemFlag;
    auto   hasFlag(ItemFlag flag) const -> bool;
    uint8  getAppraisalID() const;
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
    bool isStorageSlip() const;

    void setID(uint16);
    void setSubID(uint16);
    void setSubType(uint8);
    void setFlag(ItemFlag);
    void setAppraisalID(uint8 appraisailID);
    void setAHCat(uint8);
    void setReserve(uint32);
    void setQuantity(uint32);
    void setStackSize(uint32);
    void setBasePrice(uint32);
    void setCharPrice(uint32);
    void setLocationID(uint8 LocationID);
    void setSlotID(uint8 SlotID);
    void setSent(bool sent);

    const std::string& getName() const;
    void               setName(const std::string& name);

    const std::string& getSender() const;
    void               setSender(const std::string& sender);

    const std::string& getReceiver() const;
    void               setReceiver(const std::string& receiver);

    virtual auto getSignature() const -> const std::string;
    virtual void setSignature(const std::string& signature);

    auto isDirty() const -> bool;
    void setDirty(bool dirty);

    bool isSoultrapper() const;

    bool isMannequin() const;

    auto state() const -> ItemState;
    void setState(ItemState newState, xi::Badge<xi::items::detail::ItemAccess>);
    auto isBusy() const -> bool;

    static constexpr uint32_t extra_size = 0x18;
    uint8                     m_extra[extra_size]{};

    template <typename T>
    auto exdata() -> T&
    {
        static_assert(sizeof(T) == extra_size, "Exdata struct must be 24 bytes");
        return *reinterpret_cast<T*>(m_extra);
    }

    template <typename T>
    auto exdata() const -> const T&
    {
        static_assert(sizeof(T) == extra_size, "Exdata struct must be 24 bytes");
        return *reinterpret_cast<const T*>(m_extra);
    }

protected:
    void setType(uint8);

private:
    uint16   m_id;
    uint16   m_subid;
    uint8    m_type;
    uint8    m_subtype;
    uint32   m_quantity; // Current number of items
    uint32   m_reserve;
    uint32   m_stackSize; // The maximum number of items
    uint32   m_BasePrice;
    uint32   m_CharPrice; // The cost of the subject in Bazaar
    uint8    m_ahCat;     // auction category
    ItemFlag m_flag;

    uint8 m_slotID;     // Cell of the object in the storage
    uint8 m_locationID; // storage number

    bool m_sent;
    bool dirty_{};

    std::string m_name;
    std::string m_send;
    std::string m_recv;

    ItemState state_{ ItemState::Free };
};

#endif
