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

#ifndef _CUNIVERSALCONTAINER_H
#define _CUNIVERSALCONTAINER_H

#include "common/cbasetypes.h"
#include <vector>

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
class CBaseEntity;

class CUContainer
{
public:
    CUContainer();

    UCONTAINERTYPE GetType();

    void SetLock();
    void UnLock();
    void SetTarget(uint16 Target);
    void SetType(UCONTAINERTYPE Type);
    bool SetItem(uint8 slotID, CItem* PItem);
    void SetSize(uint8 size);
    void ClearSlot(uint8 slotID);

    void Clean();
    bool IsLocked() const;
    bool IsContainerEmpty();
    bool IsSlotEmpty(uint8 slotID);

    uint16 GetTarget() const;
    uint8  GetItemsCount() const;
    CItem* GetItem(uint8 slotID);

private:
    UCONTAINERTYPE m_ContainerType;

    bool                m_lock{};
    uint8               m_count{};
    uint16              m_target{};
    std::vector<CItem*> m_PItem;
};

#endif
