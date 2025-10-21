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

#include "0x044_extended_job_mon.h"

#include "entities/charentity.h"

GP_SERV_COMMAND_EXTENDED_JOB::MON::MON(const CCharEntity* PChar)
{
    auto& packet = this->data();

    packet.Job = JOB_MON;
    if (PChar->m_PMonstrosity)
    {
        packet.Species = PChar->m_PMonstrosity->Species;
        for (std::size_t idx = 0; idx < 12; ++idx)
        {
            packet.EquippedInstincts[idx] = PChar->m_PMonstrosity->EquippedInstincts[idx];
        }
    }
}
