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

#include "0x10b_bazaar_close.h"

#include "entities/charentity.h"
#include "packets/s2c/0x107_bazaar_close.h"

auto GP_CLI_COMMAND_BAZAAR_CLOSE::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(AllListClearFlg, 0, "AllListClearFlg not 0"); // Always 0
}

void GP_CLI_COMMAND_BAZAAR_CLOSE::process(MapSession* PSession, CCharEntity* PChar) const
{
    for (std::size_t i = 0; i < PChar->BazaarCustomers.size(); ++i)
    {
        auto* PEntity = PChar->GetEntity(PChar->BazaarCustomers[i].targid, TYPE_PC);
        if (!PEntity)
        {
            continue;
        }

        if (auto* PCustomer = static_cast<CCharEntity*>(PEntity); PCustomer->id == PChar->BazaarCustomers[i].id)
        {
            PCustomer->pushPacket<GP_SERV_COMMAND_BAZAAR_CLOSE>(PChar);

            DebugBazaarsFmt("Bazaar Interaction [Leave Bazaar] - Buyer: {}, Seller: {}", PCustomer->name, PChar->name);
        }
    }

    PChar->BazaarCustomers.clear();

    PChar->isSettingBazaarPrices = true;
    PChar->updatemask |= UPDATE_HP;

    DebugBazaarsFmt("Bazaar Interaction [Setting Prices] - Character: {}", PChar->name);
}
