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

enum UCONTAINERTYPE
{
    UCONTAINER_EMPTY,
    UCONTAINER_SYNTES,
    UCONTAINER_FISHING,
    UCONTAINER_SHOP,
    UCONTAINER_TRADE,
    UCONTAINER_USEITEM,
    UCONTAINER_AUCTION,
    UCONTAINER_SEND_DELIVERYBOX,
    UCONTAINER_RECV_DELIVERYBOX,
};

#define UCONTAINER_SIZE 16

/************************************************************************
 *                                                                       *
 *  Universal general purpose container                                  *
 *                                                                       *
 ************************************************************************/

// main item (gil, crystal, used item...)

class CItem;

class CUContainer
{
public:
    CUContainer();

    auto GetType() -> UCONTAINERTYPE;

    void SetLock();
    void UnLock();
    void SetTarget(uint16 Target);
    void SetType(UCONTAINERTYPE Type);
    auto SetItem(uint8 slotID, CItem* PItem) -> bool;
    void SetSize(uint8 size);
    void ClearSlot(uint8 slotID);

    void Clean();
    auto IsLocked() const -> bool;
    auto IsContainerEmpty() -> bool;
    auto IsSlotEmpty(uint8 slotID) -> bool;

    auto GetTarget() const -> uint16;
    auto GetItemsCount() const -> uint8;
    auto GetItem(uint8 slotID) -> CItem*;

private:
    UCONTAINERTYPE m_ContainerType;

    bool                m_lock{};
    uint8               m_count{};
    uint16              m_target{};
    std::vector<CItem*> m_PItem;
};
