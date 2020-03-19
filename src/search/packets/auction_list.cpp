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
#include <string.h>

#include "../../common/showmsg.h"
#include "../../common/socket.h"

#include "../data_loader.h"

#include "auction_list.h"


/************************************************************************
*                                                                       *
*  Если количество отправляемых предметов превышает 20, то отправляем   *
*  их несколькими пакетами, в каждый их коротых записываем смещение     *
*                                                                       *
************************************************************************/

CAHItemsListPacket::CAHItemsListPacket(uint16 offset)
{
    m_count = 0;
    m_offset = offset;

    memset(m_PData, 0, sizeof(m_PData));

    ref<uint8>(m_PData, (0x0B)) = 0x95;                       // packet type
}

/************************************************************************
*                                                                       *
*  Добавляем предмет в пакет (по 10 байт на предмер)                    *
*                                                                       *
************************************************************************/

void CAHItemsListPacket::AddItem(ahItem* item)
{
    ref<uint16>(m_PData, (0x18 + 0x0A * m_count) + 0) = item->ItemID;
    ref<uint32>(m_PData, (0x18 + 0x0A * m_count) + 2) = item->SinglAmount;
    ref<uint32>(m_PData, (0x18 + 0x0A * m_count) + 6) = item->StackAmount;

    m_count++;
    delete item;
}

/************************************************************************
*                                                                       *
*  Устанавливаем общее количество отправляемых предметов                *
*                                                                       *
************************************************************************/

void CAHItemsListPacket::SetItemCount(uint16 count)
{
    ref<uint16>(m_PData, (0x0E)) = count;

    if ((count - m_offset) <= 20)
    {
        ref<uint8>(m_PData, (0x0A)) = 0x80;
        ref<uint16>(m_PData, (0x08)) = 0x18 + 0x0A * (count - m_offset);
    }
    else
    {
        ref<uint16>(m_PData, (0x08)) = 0x18 + 0x0A * 20;
    }
}

/************************************************************************
*                                                                       *
*  Возвращаем собранный пакет                                           *
*                                                                       *
************************************************************************/

uint8* CAHItemsListPacket::GetData()
{
    return m_PData;
}

/************************************************************************
*                                                                       *
*  Возвращаем размер отправляемого пакета                               *
*                                                                       *
************************************************************************/

uint16 CAHItemsListPacket::GetSize()
{
    return 0x18 + 0x0A * m_count + 28;
}
