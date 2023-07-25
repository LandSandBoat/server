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

#include "jailutils.h"

#include "conquest_system.h"
#include "entities/charentity.h"

#include "ai/ai_container.h"
#include "ai/controllers/player_controller.h"

/************************************************************************
 *                                                                       *
 *                                                                       *
 *                                                                       *
 ************************************************************************/

namespace jailutils
{
    bool InPrison(CCharEntity* PChar)
    {
        TracyZoneScoped;
        return PChar->m_GMlevel == 0 && PChar->getZone() == ZONE_MORDION_GAOL;
    }

    void Add(CCharEntity* PChar)
    {
        PChar->PAI->SetController(nullptr);

        // TODO:
    }

    void Del(CCharEntity* PChar)
    {
        PChar->PAI->SetController(std::make_unique<CPlayerController>(PChar));

        // TODO:
    }
}; // namespace jailutils
