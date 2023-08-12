/*
===========================================================================
  Copyright (c) 2021 Ixion Dev Teams
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

#include "char_emotion_jump.h"
#include "entities/charentity.h"

CCharEmotionJumpPacket::CCharEmotionJumpPacket(CCharEntity* PChar, uint16 targetIndex, uint16 extra)
{
    this->setType(0x11E);
    this->setSize(8);

    ref<uint16>(0x04) = targetIndex;
    ref<uint16>(0x06) = extra;
}
