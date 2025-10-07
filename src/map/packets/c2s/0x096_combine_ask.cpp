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

#include "0x096_combine_ask.h"

#include "entities/charentity.h"
#include "items.h"
#include "packets/s2c/0x022_item_trade_res.h"
#include "trade_container.h"
#include "universal_container.h"
#include "utils/jailutils.h"
#include "utils/synthutils.h"

namespace
{
    const std::set validCrystals = {
        FIRE_CRYSTAL,
        ICE_CRYSTAL,
        WIND_CRYSTAL,
        EARTH_CRYSTAL,
        LIGHTNING_CRYSTAL,
        WATER_CRYSTAL,
        LIGHT_CRYSTAL,
        DARK_CRYSTAL,
        DARK_CLUSTER,
        INFERNO_CRYSTAL,
        GLACIER_CRYSTAL,
        CYCLONE_CRYSTAL,
        TERRA_CRYSTAL,
        PLASMA_CRYSTAL,
        TORRENT_CRYSTAL,
        AURORA_CRYSTAL,
        TWILIGHT_CRYSTAL,
        PYRE_CRYSTAL,
        FROST_CRYSTAL,
        VORTEX_CRYSTAL,
        GEO_CRYSTAL,
        BOLT_CRYSTAL,
        FLUID_CRYSTAL,
        GLIMMER_CRYSTAL,
        SHADOW_CRYSTAL,
    };
}

auto GP_CLI_COMMAND_COMBINE_ASK::validate(MapSession* PSession, const CCharEntity* PChar) const -> PacketValidationResult
{
    return PacketValidator()
        .oneOf("Crystal", static_cast<ITEMID>(Crystal), validCrystals)
        .range("Items", Items, 1, 8)
        .isNotMonstrosity(PChar)
        .isNotPreventedAction(PChar)
        .isNormalStatus(PChar)
        .isNotCrafting(PChar);
}

void GP_CLI_COMMAND_COMBINE_ASK::process(MapSession* PSession, CCharEntity* PChar) const
{
    if (jailutils::InPrison(PChar))
    {
        // Prevent crafting in prison
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    // Force full synth duration wait no matter the synth animation length
    // Thus players can synth on whatever fps they want
    // TODO: Escutcheons will require changes to this block
    // See SYNTH_SPEED_XXX mods
    if (PChar->m_LastSynthTime + 15s > timer::now())
    {
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_WAIT_LONGER);
        return;
    }

    // NOTE: This section is intended to be temporary to ensure that duping shenanigans aren't possible.
    // It should be replaced by something more robust or more stateful as soon as is reasonable
    auto* PTarget = static_cast<CCharEntity*>(PChar->GetEntity(PChar->TradePending.targid, TYPE_PC));

    // Clear pending trades on synthesis start
    if (PTarget && PChar->TradePending.id == PTarget->id)
    {
        PChar->TradePending.clean();
        PTarget->TradePending.clean();
    }

    // Clears out trade session and blocks synthesis at any point in trade process after accepting
    // trade request.
    if (PChar->UContainer->GetType() != UCONTAINER_EMPTY)
    {
        if (PTarget)
        {
            ShowDebug("%s trade request with %s was canceled because %s tried to craft.",
                      PChar->getName(), PTarget->getName(), PChar->getName());

            PTarget->TradePending.clean();
            PTarget->UContainer->Clean();
            PTarget->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PChar, GP_ITEM_TRADE_RES_KIND::Cancell);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_TRADE_RES>(PTarget, GP_ITEM_TRADE_RES_KIND::Cancell);
        }

        PChar->pushPacket<CMessageStandardPacket>(MsgStd::CannotBeProcessed);
        PChar->TradePending.clean();
        PChar->UContainer->Clean();
        return;
    }
    // End temporary additions

    PChar->CraftContainer->Clean();

    const auto PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(CrystalIdx);
    if (!PItem || Crystal != PItem->getID() || PItem->getQuantity() == 0)
    {
        // Detect invalid crystal usage
        // Prevent crafting exploit to crash on container size > 8
        PChar->pushPacket<CMessageBasicPacket>(PChar, PChar, 0, 0, MSGBASIC_CANNOT_USE_IN_AREA);
        return;
    }

    uint16 itemId    = Crystal;
    uint8  invSlotId = CrystalIdx;
    PChar->CraftContainer->setItem(0, itemId, invSlotId, 0);

    std::vector<uint8> slotQty(MAX_CONTAINER_SIZE);
    for (int32 slotId = 0; slotId < Items; ++slotId)
    {
        itemId    = ItemNo[slotId];
        invSlotId = TableNo[slotId];

        slotQty[invSlotId]++;

        const auto* PSlotItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invSlotId);

        if (PSlotItem && PSlotItem->getID() == itemId && slotQty[invSlotId] <= (PSlotItem->getQuantity() - PSlotItem->getReserve()))
        {
            PChar->CraftContainer->setItem(slotId + 1, itemId, invSlotId, 1);
        }
    }

    synthutils::startSynth(PChar);
}
