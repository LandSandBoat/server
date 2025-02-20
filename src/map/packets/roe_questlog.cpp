/*
===========================================================================

  Copyright (c) 2020 - Kreidos | github.com/kreidos

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

#include "common/socket.h"

#include "roe_questlog.h"

#include "entities/charentity.h"

CRoeQuestLogPacket::CRoeQuestLogPacket(CCharEntity* PChar, uint8 order)
{
    this->setType(0x112);
    this->setSize(0x88);

    ref<uint32>(0x84) = order;

    std::memcpy(buffer_.data() + 0x04, &(PChar->m_eminenceLog.complete[order * 128]), 128);
}
