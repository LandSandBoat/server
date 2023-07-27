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

#ifndef _CAHITEMSLISTPACKET_H_
#define _CAHITEMSLISTPACKET_H_

#include "common/cbasetypes.h"

class CAHItemsListPacket
{
public:
    CAHItemsListPacket(uint16 offset);

    void AddItem(ahItem* item);
    void SetItemCount(uint16 count);

    uint8* GetData();
    uint16 GetSize() const;

private:
    uint8  m_count{};
    uint16 m_offset{};

    uint8 m_PData[256]{};
};

#endif
