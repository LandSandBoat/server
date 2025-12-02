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

#include "0x104_bazaar_exit.h"

#include "entities/charentity.h"
#include "packets/s2c/0x108_bazaar_shopping.h"

auto GP_CLI_COMMAND_BAZAAR_EXIT::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    // No parameters to validate.
    return PacketValidator();
}

void GP_CLI_COMMAND_BAZAAR_EXIT::process(MapSession* PSession, CCharEntity* PChar) const
{
    auto* PEntity = PChar->GetEntity(PChar->BazaarID.targid, TYPE_PC);
    if (!PEntity)
    {
        return;
    }

    if (auto* PTarget = static_cast<CCharEntity*>(PEntity); PTarget->id == PChar->BazaarID.id)
    {
        for (std::size_t i = 0; i < PTarget->BazaarCustomers.size(); ++i)
        {
            if (PTarget->BazaarCustomers[i].id == PChar->id)
            {
                PTarget->BazaarCustomers.erase(PTarget->BazaarCustomers.begin() + i--);
            }
        }
        if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
        {
            PTarget->pushPacket<GP_SERV_COMMAND_BAZAAR_SHOPPING>(PChar, GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE::Exit);
        }

        DebugBazaarsFmt("Bazaar Interaction [Leave Bazaar] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
    }

    PChar->BazaarID.clean();
}
