/*
===========================================================================

  Copyright (c) 2025 LandSandBoat Dev Teams

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

#include "independent_animation.h"

#include "entities/baseentity.h"

CIndependentAnimationPacket::CIndependentAnimationPacket(CBaseEntity* PEntity, CBaseEntity* PTarget, uint16 animId, uint8 type)
{
    this->setType(0x3A);
    this->setSize(0x28);

    if (PEntity)
    {
        ref<uint32>(0x04) = PEntity->id;
        ref<uint32>(0x08) = PTarget->id;

        ref<uint16>(0x0C) = PEntity->targid;
        ref<uint16>(0x0E) = PTarget->targid;

        ref<uint16>(0x10) = animId;

        ref<uint8>(0x12) = type;
    }
}
