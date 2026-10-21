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

#pragma once

#include "common/cbasetypes.h"
#include "common/mmo.h"
#include "common/types/badge.h"

#include "data/enums/item_flag.h"
#include "data/enums/item_state.h"

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
    ITEM_FLOWERPOT  = 0x100,
};

// Additional type of object m_subtype
enum ITEM_SUBTYPE
{
    ITEM_NORMAL    = 0x00,
    ITEM_CHARGED   = 0x02,
    ITEM_AUGMENTED = 0x04,
};

class CItem
{
public:
    CItem(uint16 id);
    CItem(const CItem& other);
    auto operator=(const CItem&) -> CItem& = delete;

    virtual ~CItem();

    auto getID() const -> uint16;
    auto getSubID() const -> uint16;
    auto getFlag() const -> xi::ItemFlag;
    auto hasFlag(xi::ItemFlag flag) const -> bool;
    auto getAppraisalID() const -> uint8;
    auto getAHCat() const -> uint8;
    auto getQuantity() const -> uint32;
    auto getStackSize() const -> uint32;
    auto getBasePrice() const -> uint32;
    auto getCharPrice() const -> uint32;
    auto getLocationID() const -> uint8;
    auto getSlotID() const -> uint8;

    auto isSent() const -> bool;
    auto isType(ITEM_TYPE) const -> bool;
    auto isSubType(ITEM_SUBTYPE) const -> bool;

    // process-unique, never reused. Distinguishes this stack from an identical one
    auto uid() const -> uint64;
    auto isStorageSlip() const -> bool;

    void setID(uint16);
    void setSubID(uint16);
    void setSubType(uint8);
    void setFlag(xi::ItemFlag);
    void setAppraisalID(uint8 appraisailID);
    void setAHCat(uint8);
    void setQuantity(uint32);
    void setStackSize(uint32);
    void setBasePrice(uint32);
    void setCharPrice(uint32);
    void setLocationID(uint8 LocationID);
    void setSlotID(uint8 SlotID);
    void setSent(bool sent);

    auto getName() const -> const std::string&;
    void setName(const std::string& name);

    auto getSender() const -> const std::string&;
    void setSender(const std::string& sender);

    auto getReceiver() const -> const std::string&;
    void setReceiver(const std::string& receiver);

    virtual auto getSignature() const -> std::string;
    virtual void setSignature(const std::string& signature);

    auto isDirty() const -> bool;
    void setDirty(bool dirty);

    auto isSoultrapper() const -> bool;

    auto isMannequin() const -> bool;

    auto state() const -> xi::ItemState;
    void setState(xi::ItemState newState, xi::Badge<xi::items::detail::ItemAccess>);
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
    void setType(uint16);

private:
    uint16       m_id;
    uint64       m_uid;
    uint16       m_subid;
    uint16       m_type;
    uint8        m_subtype;
    uint32       m_quantity;  // Current number of items
    uint32       m_stackSize; // The maximum number of items
    uint32       m_BasePrice;
    uint32       m_CharPrice; // The cost of the subject in Bazaar
    uint8        m_ahCat;     // auction category
    xi::ItemFlag m_flag;

    uint8 m_slotID;     // Cell of the object in the storage
    uint8 m_locationID; // storage number

    bool m_sent;
    bool dirty_{};

    std::string m_name;
    std::string m_send;
    std::string m_recv;

    xi::ItemState state_{ xi::ItemState::Free };
};
