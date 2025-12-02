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

#include "0x105_bazaar_list.h"

#include "entities/charentity.h"
#include "packets/s2c/0x105_bazaar_list.h"
#include "packets/s2c/0x108_bazaar_shopping.h"

auto GP_CLI_COMMAND_BAZAAR_LIST::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .mustEqual(PChar->BazaarID.id, 0, "Character already has a Bazaar ID")
        .mustEqual(PChar->BazaarID.targid, 0, "Character already has a Bazaar Target ID");
}

void GP_CLI_COMMAND_BAZAAR_LIST::process(MapSession* PSession, CCharEntity* PChar) const
{
    CCharEntity* PTarget = UniqueNo != 0 ? PChar->loc.zone->GetCharByID(UniqueNo) : static_cast<CCharEntity*>(PChar->GetEntity(PChar->m_TargID, TYPE_PC));

    if (PTarget != nullptr && PTarget->id == UniqueNo && PTarget->hasBazaar())
    {
        PChar->BazaarID.id     = PTarget->id;
        PChar->BazaarID.targid = PTarget->targid;

        EntityID_t EntityID = { PChar->id, PChar->targid };

        if (!PChar->m_isGMHidden || (PChar->m_isGMHidden && PTarget->m_GMlevel >= PChar->m_GMlevel))
        {
            PTarget->pushPacket<GP_SERV_COMMAND_BAZAAR_SHOPPING>(PChar, GP_SERV_COMMAND_BAZAAR_SHOPPING_STATE::Enter);
        }

        PTarget->BazaarCustomers.emplace_back(EntityID);

        CItemContainer* PBazaar = PTarget->getStorage(LOC_INVENTORY);

        for (uint8 SlotID = 1; SlotID <= PBazaar->GetSize(); ++SlotID)
        {
            CItem* PItem = PBazaar->GetItem(SlotID);

            if ((PItem != nullptr) && (PItem->getCharPrice() != 0))
            {
                PChar->pushPacket<GP_SERV_COMMAND_BAZAAR_LIST>(PItem, SlotID, PChar->loc.zone->GetTax());
            }
        }

        DebugBazaarsFmt("Bazaar Interaction [View Wares] - Buyer: {}, Seller: {}", PChar->name, PTarget->name);
    }
}
