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

#include "common/utils.h"
#include "exdata/appraisable.h"
#include "exdata/augment_standard.h"
#include "exdata/base.h"
#include "item.h"

#include <algorithm>
#include <atomic>

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

namespace
{

auto allocItemUid() -> uint64
{
    static std::atomic<uint64> nextUid{ 1 };

    return nextUid.fetch_add(1, std::memory_order_relaxed);
}

} // namespace

CItem::CItem(uint16 id)
: m_id(id)
, m_uid(allocItemUid())
, m_subid(0)
, m_type(0)
, m_subtype(0)
, m_quantity(0)
, m_stackSize(0)
, m_BasePrice(0)
, m_CharPrice(0)
, m_ahCat(0)
, m_flag(xi::ItemFlag::None)
, m_slotID(-1)
, m_locationID(-1)
, m_sent(false)
{
    std::memset(m_extra, 0, sizeof(m_extra));
}

CItem::CItem(const CItem& other)
: m_id(other.m_id)
, m_uid(allocItemUid())
, m_subid(other.m_subid)
, m_type(other.m_type)
, m_subtype(other.m_subtype)
, m_quantity(other.m_quantity)
, m_stackSize(other.m_stackSize)
, m_BasePrice(other.m_BasePrice)
, m_CharPrice(other.m_CharPrice)
, m_ahCat(other.m_ahCat)
, m_flag(other.m_flag)
, m_slotID(other.m_slotID)
, m_locationID(other.m_locationID)
, m_sent(other.m_sent)
, dirty_(other.dirty_)
, m_name(other.m_name)
, m_send(other.m_send)
, m_recv(other.m_recv)
{
    std::memcpy(m_extra, other.m_extra, sizeof(m_extra));
}

CItem::~CItem() = default;

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setID(uint16 id)
{
    m_id = id;
}

auto CItem::getID() const -> uint16
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

auto CItem::getSubID() const -> uint16
{
    return m_subid;
}

/************************************************************************
 *                                                                       *
 *  Parameter defining the characteristics of the subject                *
 *                                                                       *
 ************************************************************************/

void CItem::setFlag(const xi::ItemFlag flag)
{
    m_flag = flag;
}

auto CItem::getFlag() const -> xi::ItemFlag
{
    return m_flag;
}

auto CItem::hasFlag(const xi::ItemFlag flag) const -> bool
{
    return (m_flag & flag) != xi::ItemFlag::None;
}

/************************************************************************
 *                                                                       *
 *  Appraisal Origin IDs                                                 *
 *                                                                       *
 ************************************************************************/

auto CItem::getAppraisalID() const -> uint8
{
    return this->exdata<Exdata::Appraisable>().AppraisalId;
}

void CItem::setAppraisalID(uint8 appraisalID)
{
    this->exdata<Exdata::Appraisable>().AppraisalId = appraisalID;
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

auto CItem::getAHCat() const -> uint8
{
    return m_ahCat;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setType(uint16 type)
{
    m_type |= type;
}

auto CItem::isType(ITEM_TYPE type) const -> bool
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

auto CItem::isSubType(ITEM_SUBTYPE subtype) const -> bool
{
    return (m_subtype & subtype);
}

auto CItem::uid() const -> uint64
{
    return m_uid;
}

/************************************************************************
 *                                                                       *
 *  The current number of objects in a pack                              *
 *                                                                       *
 ************************************************************************/

void CItem::setQuantity(uint32 quantity)
{
    m_quantity = std::min(quantity, m_stackSize);
}

auto CItem::getQuantity() const -> uint32
{
    return m_quantity;
}

/************************************************************************
 *                                                                       *
 * The maximum number of objects in the pack                             *
 *                                                                       *
 ************************************************************************/

void CItem::setStackSize(uint32 stackSize)
{
    m_stackSize = stackSize;
}

auto CItem::getStackSize() const -> uint32
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

auto CItem::getBasePrice() const -> uint32
{
    return m_BasePrice;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

void CItem::setCharPrice(const uint32 CharPrice)
{
    if (!this->hasFlag(xi::ItemFlag::Exclusive))
    {
        m_CharPrice = CharPrice;
    }
}

auto CItem::getCharPrice() const -> uint32
{
    return m_CharPrice;
}

/************************************************************************
 *                                                                       *
 *  The name of the subject                                              *
 *                                                                       *
 ************************************************************************/

auto CItem::getName() const -> const std::string&
{
    return m_name;
}

void CItem::setName(const std::string& name)
{
    m_name = name;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

auto CItem::getSender() const -> const std::string&
{
    return m_send;
}

void CItem::setSender(const std::string& sender)
{
    m_send = sender;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

auto CItem::getReceiver() const -> const std::string&
{
    return m_recv;
}

void CItem::setReceiver(const std::string& receiver)
{
    m_recv = receiver;
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

auto CItem::getSignature() const -> const std::string
{
    return Exdata::decodeSignature(this->exdata<Exdata::AugmentStandard>().Signature);
}

void CItem::setSignature(const std::string& signature)
{
    char encoded[SignatureStringLength] = {};
    EncodeStringSignature(signature, encoded);
    std::memset(m_extra + 0x0C, 0, sizeof(m_extra) - 0x0C);
    std::memcpy(m_extra + 0x0C, encoded, sizeof(m_extra) - 0x0C);
}

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

auto CItem::getLocationID() const -> uint8
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

auto CItem::getSlotID() const -> uint8
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

auto CItem::isSent() const -> bool
{
    return m_sent;
}

/************************************************************************
 *                                                                       *
 *  Handle Storage Slips                                                 *
 *                                                                       *
 ************************************************************************/

auto CItem::isStorageSlip() const -> bool
{
    return m_id < 29340 && m_id > 29311;
}

auto CItem::isDirty() const -> bool
{
    return dirty_;
}

void CItem::setDirty(const bool dirty)
{
    dirty_ = dirty;
}

auto CItem::isSoultrapper() const -> bool
{
    return m_id == 18721 || m_id == 18724;
}

auto CItem::isMannequin() const -> bool
{
    return m_id >= 256 && m_id <= 263;
}

auto CItem::state() const -> xi::ItemState
{
    return state_;
}

void CItem::setState(const xi::ItemState newState, xi::Badge<xi::items::detail::ItemAccess>)
{
    state_ = newState;
}

auto CItem::isBusy() const -> bool
{
    return state_ != xi::ItemState::Free;
}
