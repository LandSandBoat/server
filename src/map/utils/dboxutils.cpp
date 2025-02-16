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

#include "dboxutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/macros.h"
#include "common/settings.h"
#include "common/tracy.h"

#include "entities/charentity.h"

#include "packets/delivery_box.h"
#include "packets/inventory_finish.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/jailutils.h"
#include "utils/zoneutils.h"

#include "trade_container.h"
#include "universal_container.h"

extern std::unique_ptr<SqlConnection> _sql;

namespace
{
    auto escapeString(const std::string_view str) -> std::string
    {
        // TODO: Replace with db::escapeString
        return _sql->EscapeString(str);
    }
} // namespace

void dboxutils::HandlePacket(CCharEntity* PChar, CBasicPacket& data)
{
    TracyZoneScoped;

    const auto charName = PChar->getName();

    // TODO: Validate all of these to make sure they're within sane bounds.
    const auto action  = data.ref<uint8>(0x04);
    const auto boxtype = data.ref<uint8>(0x05);
    const auto slotID  = data.ref<uint8>(0x06);

    if (jailutils::InPrison(PChar)) // If jailed, no mailbox menu for you.
    {
        return;
    }

    if (!zoneutils::IsResidentialArea(PChar) && PChar->m_GMlevel == 0 && !PChar->loc.zone->CanUseMisc(MISC_AH) && !PChar->loc.zone->CanUseMisc(MISC_MOGMENU))
    {
        ShowWarningFmt("DBOX: {} ({}) is trying to use the delivery box in a disallowed zone [{}]", charName, PChar->id, PChar->loc.zone->getName());
        return;
    }

    if (PChar->animation == ANIMATION_SYNTH || (PChar->CraftContainer && PChar->CraftContainer->getItemsCount() > 0))
    {
        ShowWarningFmt("DBOX: {} ({}) attempting to access delivery box in the middle of a synth!", charName, PChar->id);
        return;
    }

    if ((PChar->animation >= ANIMATION_FISHING_FISH && PChar->animation <= ANIMATION_FISHING_STOP) ||
        PChar->animation == ANIMATION_FISHING_START_OLD || PChar->animation == ANIMATION_FISHING_START)
    {
        ShowWarningFmt("DBOX: {} ({}) attempting to access delivery box while fishing!", charName, PChar->id);
        return;
    }

    switch (action)
    {
        case 0x01:
        {
            DebugDeliveryBoxFmt("DBOX: SendOldItems (action: {:02X}): player: {}, boxtype: {}", action, charName, PChar->id, boxtype);
            SendOldItems(PChar, action, boxtype);
        }
        break;
        case 0x02:
        {
            const uint8  invslot      = data.ref<uint8>(0x07);
            const uint32 quantity     = data.ref<uint32>(0x08);
            const auto   recieverName = escapeString(asStringFromUntrustedSource(data[0x10], 15));

            DebugDeliveryBoxFmt("DBOX: AddItemsToBeSent (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}, invslot: {}, quantity: {}, recieverName: {}",
                                action, charName, PChar->id, boxtype, slotID, invslot, quantity, recieverName);
            AddItemsToBeSent(PChar, action, boxtype, slotID, invslot, quantity, recieverName);
        }
        break;
        case 0x03:
        {
            DebugDeliveryBoxFmt("DBOX: SendConfirmation (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            SendConfirmation(PChar, action, boxtype, slotID);
        }
        break;
        case 0x04:
        {
            DebugDeliveryBoxFmt("DBOX: CancelSendingItem (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            CancelSendingItem(PChar, action, boxtype, slotID);
        }
        break;
        case 0x05:
        {
            DebugDeliveryBoxFmt("DBOX: SendClientNewItemCount (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            SendClientNewItemCount(PChar, action, boxtype, slotID);
        }
        break;
        case 0x06:
        {
            DebugDeliveryBoxFmt("DBOX: SendNewItems (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            SendNewItems(PChar, action, boxtype, slotID);
        }
        break;
        case 0x07:
        {
            DebugDeliveryBoxFmt("DBOX: RemoveDeliveredItemFromSendingBox (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            RemoveDeliveredItemFromSendingBox(PChar, action, boxtype, slotID);
        }
        break;
        case 0x08:
        {
            DebugDeliveryBoxFmt("DBOX: UpdateDeliveryCellBeforeRemoving (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            UpdateDeliveryCellBeforeRemoving(PChar, action, boxtype, slotID);
        }
        break;
        case 0x09:
        {
            DebugDeliveryBoxFmt("DBOX: ReturnToSender (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            ReturnToSender(PChar, action, boxtype, slotID);
        }
        break;
        case 0x0A:
        {
            DebugDeliveryBoxFmt("DBOX: TakeItemFromCell (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            TakeItemFromCell(PChar, action, boxtype, slotID);
        }
        break;
        case 0x0B:
        {
            DebugDeliveryBoxFmt("DBOX: RemoveItemFromCell (action: {:02X}): player: {} ({}), boxtype: {}, slotID: {}", action, charName, PChar->id, boxtype, slotID);
            RemoveItemFromCell(PChar, action, boxtype, slotID);
        }
        break;
        case 0x0C:
        {
            const auto recieverName = escapeString(asStringFromUntrustedSource(data[0x10], 15));

            DebugDeliveryBoxFmt("DBOX: ConfirmNameBeforeSending (action: {:02X}): player: {} ({}), boxtype: {}, recieverName: {}", action, charName, PChar->id, boxtype, recieverName);
            ConfirmNameBeforeSending(PChar, action, boxtype, recieverName);
        }
        break;
        case 0x0D:
        {
            DebugDeliveryBoxFmt("DBOX: OpenSendBox (action: {:02X}): player: {} ({}), boxtype: {}", action, charName, PChar->id, boxtype);
            OpenSendBox(PChar, action, boxtype);
        }
        break;
        case 0x0E:
        {
            DebugDeliveryBoxFmt("DBOX: OpenRecvBox (action: {:02X}): player: {} ({}), boxtype: {}", action, charName, PChar->id, boxtype);
            OpenRecvBox(PChar, action, boxtype);
        }
        break;
        case 0x0F:
        {
            DebugDeliveryBoxFmt("DBOX: CloseMailWindow (action: {:02X}): player: {} ({}), boxtype: {}", action, charName, PChar->id, boxtype);
            CloseMailWindow(PChar, action, boxtype);
        }
        break;
        default:
        {
            ShowErrorFmt("DBOX: Unhandled action: {:02X}, from player {} ({})", action, charName, PChar->id);
        }
    }
}

void dboxutils::SendOldItems(CCharEntity* PChar, uint8 action, uint8 boxtype)
{
    if (boxtype < 1 || boxtype > 2 || !IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in an invalid state: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    const auto rset = db::preparedStmt("SELECT itemid, itemsubid, slot, quantity, sent, extra, sender, charname FROM delivery_box WHERE charid = ? AND box = ? "
                                       "AND slot < 8 ORDER BY slot",
                                       PChar->id, boxtype);
    if (rset)
    {
        uint8 items = 0;

        if (rset->rowsCount())
        {
            while (rset->next())
            {
                CItem* PItem = itemutils::GetItem(rset->get<uint16>("itemid"));
                if (PItem != nullptr)
                {
                    PItem->setSubID(rset->get<uint16>("itemsubid"));
                    PItem->setSlotID(rset->get<uint8>("slot"));
                    PItem->setQuantity(rset->get<uint32>("quantity"));

                    if (rset->get<uint8>("sent") == 1)
                    {
                        PItem->setSent(true);
                    }

                    db::extractFromBlob(rset, "extra", PItem->m_extra);

                    if (boxtype == 2)
                    {
                        PItem->setSender(rset->get<std::string>("charname"));
                        PItem->setReceiver(rset->get<std::string>("sender"));
                    }
                    else
                    {
                        PItem->setSender(rset->get<std::string>("sender"));
                        PItem->setReceiver(rset->get<std::string>("charname"));
                    }

                    PChar->UContainer->SetItem(PItem->getSlotID(), PItem);
                    ++items;
                }
            }
        }

        for (uint8 i = 0; i < 8; ++i)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(i), i, items, 1);
        }
    }
}

void dboxutils::AddItemsToBeSent(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID, uint8 invslot, uint32 quantity, const std::string& recieverName)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(invslot);

    if (quantity == 0 || !PItem)
    {
        return;
    }

    if (PItem->getQuantity() < quantity || PItem->getReserve() > 0)
    {
        ShowWarningFmt("DBOX: {} attempted to send insufficient/reserved {}: {} ({})", PChar->getName(), quantity, PItem->getName(), PItem->getID());
        return;
    }

    if (PChar->UContainer->IsSlotEmpty(slotID))
    {
        const auto [recvCharid, recvAccid] = charutils::getCharIdAndAccountIdFromName(recieverName);
        if (recvCharid && recvAccid)
        {
            if (PItem->getFlag() & ITEM_FLAG_NODELIVERY)
            {
                if (!(PItem->getFlag() & ITEM_FLAG_MAIL2ACCOUNT))
                {
                    return;
                }

                // Different accounts
                if (PChar->accid != recvAccid)
                {
                    return;
                }
            }

            CItem* PUBoxItem = itemutils::GetItem(PItem->getID());
            if (PUBoxItem == nullptr)
            {
                ShowErrorFmt("DBOX: PUBoxItem was null (player: {}, item: {})", PChar->getName(), PItem->getID());
                return;
            }

            PUBoxItem->setReceiver(recieverName);
            PUBoxItem->setSender(PChar->getName());
            PUBoxItem->setQuantity(quantity);
            PUBoxItem->setSlotID(PItem->getSlotID());
            std::memcpy(PUBoxItem->m_extra, PItem->m_extra, sizeof(PUBoxItem->m_extra));

            // NOTE: This will trigger SQL trigger: delivery_box_insert
            const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows(
                "INSERT INTO delivery_box(charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender) "
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                PChar->id, PChar->getName(), 2, slotID, PItem->getID(), PItem->getSubID(), quantity, PItem->m_extra, recvCharid, recieverName);

            if (rset && affectedRows && charutils::UpdateItem(PChar, LOC_INVENTORY, invslot, -(int32)quantity))
            {
                PChar->UContainer->SetItem(slotID, PUBoxItem);
                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PUBoxItem, slotID, PChar->UContainer->GetItemsCount(), 1);
                PChar->pushPacket<CInventoryFinishPacket>();
            }
            else
            {
                destroy(PUBoxItem);
            }
        }
    }
}

void dboxutils::SendConfirmation(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    uint8 send_items = 0;
    for (int i = 0; i < 8; i++)
    {
        if (!PChar->UContainer->IsSlotEmpty(i) && !PChar->UContainer->GetItem(i)->isSent())
        {
            send_items++;
        }
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        CItem* PItem = PChar->UContainer->GetItem(slotID);

        if (PItem && !PItem->isSent())
        {
            // clang-format off
            const auto success = db::transaction([&]()
            {
                uint32 charid = charutils::getCharIdFromName(PItem->getReceiver());

                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("UPDATE delivery_box SET sent = 1 WHERE charid = ? AND senderid = ? AND slot = ? AND box = ?",
                                                                                   PChar->id, charid, slotID, 2);
                if (rset && affectedRows)
                {
                    // NOTE: This will trigger SQL trigger: delivery_box_insert
                    const auto [rset2, affectedRows2] = db::preparedStmtWithAffectedRows(
                        "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                        "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
                        charid, PItem->getReceiver(), 1, PItem->getID(), PItem->getSubID(), PItem->getQuantity(), PItem->m_extra, PChar->id, PChar->getName());

                    if (rset2 && affectedRows2)
                    {
                        PItem->setSent(true);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, send_items, 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, send_items, 0x01);
                        return;
                    }
                }

                // If we got here, something went wrong.
                throw std::runtime_error(fmt::format("DBOX: Could not finalize send confirmation transaction (player: {} ({}), target: {}, slotID: {})",
                                                     PChar->getName(), PChar->id, PItem->getReceiver(), slotID));
            });
            if (success)
            {
                // TODO: Debug logging
            }
            // clang-format on
        }
    }
}

void dboxutils::CancelSendingItem(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        CItem* PItem = PChar->UContainer->GetItem(slotID);

        // clang-format off
        const auto success = db::transaction([&]()
        {
            uint32 charid = charutils::getCharIdFromName(PChar->UContainer->GetItem(slotID)->getReceiver());
            if (charid)
            {
                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows(
                    "UPDATE delivery_box SET sent = 0 WHERE charid = ? AND box = 2 AND slot = ? AND sent = 1 AND received = 0 LIMIT 1",
                    PChar->id, slotID);

                if (rset && affectedRows)
                {
                    const auto [rset2, affectedRows2] = db::preparedStmtWithAffectedRows(
                        "DELETE FROM delivery_box WHERE senderid = ? AND box = 1 AND charid = ? AND itemid = ? AND quantity = ? "
                        "AND slot >= 8 LIMIT 1",
                        PChar->id, charid, PItem->getID(), PItem->getQuantity());

                    if (rset2 && affectedRows2 == 1)
                    {
                        PChar->UContainer->GetItem(slotID)->setSent(false);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(slotID), slotID, PChar->UContainer->GetItemsCount(), 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(slotID), slotID, PChar->UContainer->GetItemsCount(), 0x01);

                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize cancel send transaction (player: {} ({}), target: {}, slotID: {})",
                                                 PChar->getName(), PChar->id, PItem->getReceiver(), slotID));
        });
        if (!success)
        {
            const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows(
                "DELETE FROM delivery_box WHERE box = 2 AND charid = ? AND itemid = ? AND quantity = ? AND slot = ? LIMIT 1",
                PChar->id, PItem->getID(), PItem->getQuantity(), slotID);
            if (rset && affectedRows)
            {
                ShowErrorFmt("DBOX: Deleting orphaned outbox record (player: {} ({}), target: {}, slotID: {})",
                                PChar->getName(), PChar->id, PItem->getReceiver(), slotID);
                PChar->pushPacket<CDeliveryBoxPacket>(0x0F, boxtype, 0, 1);
            }

            // error message: "Delivery orders are currently backlogged."
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, -1);
        }
        // clang-format on
    }
}

void dboxutils::SendClientNewItemCount(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    // Send the player the new items count not seen
    if (boxtype < 1 || boxtype > 2 || !IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in an invalid state: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    const uint8 received_items = [&]() -> uint8
    {
        if (boxtype == 0x01)
        {
            int limit = 0;
            for (int i = 0; i < 8; ++i)
            {
                if (PChar->UContainer->IsSlotEmpty(i))
                {
                    limit++;
                }
            }

            const auto rset = db::preparedStmt("SELECT charid FROM delivery_box WHERE charid = ? AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT ?", PChar->id, limit);
            if (rset)
            {
                return rset->rowsCount();
            }
        }
        else if (boxtype == 0x02)
        {
            const auto rset = db::preparedStmt("SELECT charid FROM delivery_box WHERE charid = ? AND received = 1 AND box = 2", PChar->id);
            if (rset)
            {
                return rset->rowsCount();
            }
        }

        return 0;
    }();

    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0xFF, 0x02);
    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, received_items, 0x01);
}

void dboxutils::SendNewItems(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (boxtype == 1)
    {
        // clang-format off
        const auto success = db::transaction([&]()
        {
            CItem* PItem = nullptr;

            const auto rset = db::preparedStmt("SELECT itemid, itemsubid, quantity, extra, sender, senderid FROM delivery_box WHERE charid = ? "
                                               "AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT 1",
                                               PChar->id);
            FOR_DB_SINGLE_RESULT(rset)
            {
                PItem = itemutils::GetItem(rset->get<uint32>("itemid"));
                if (PItem)
                {
                    PItem->setSubID(rset->get<uint16>("itemsubid"));
                    PItem->setQuantity(rset->get<uint32>("quantity"));
                    db::extractFromBlob(rset, "extra", PItem->m_extra);
                    PItem->setSender(rset->get<std::string>("sender"));

                    if (PChar->UContainer->IsSlotEmpty(slotID))
                    {
                        uint32 senderID = rset->get<uint32>("senderid");
                        PItem->setSlotID(slotID);

                        // the result of this query doesn't really matter, it can be sent from the auction house which has no sender record
                        db::preparedStmt("UPDATE delivery_box SET received = 1 WHERE senderid = ? AND charid = ? AND box = 2 AND received = 0 AND quantity = ? AND sent = 1 AND itemid = ? LIMIT 1",
                                         PChar->id, senderID, PItem->getQuantity(), PItem->getID());

                        const auto rset = db::preparedStmt("SELECT slot FROM delivery_box WHERE charid = ? AND box = 1 AND slot > 7 ORDER BY slot ASC", PChar->id);
                        FOR_DB_SINGLE_RESULT(rset)
                        {
                            uint8 queue = rset->get<uint8>("slot");

                            const auto rset2 = db::preparedStmt("UPDATE delivery_box SET slot = ? WHERE charid = ? AND box = 1 AND slot = ?", slotID, PChar->id, queue);
                            if (rset2)
                            {
                                const auto rset3 = db::preparedStmt("UPDATE delivery_box SET slot = slot - 1 WHERE charid = ? AND box = 1 AND slot > ?", PChar->id, queue);
                                if (rset3)
                                {
                                    PChar->UContainer->SetItem(slotID, PItem);

                                    // TODO: increment "count" for every new item, if needed
                                    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, nullptr, slotID, 1, 2);
                                    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, 1, 1);
                                    return;
                                }
                            }
                        }

                        // If we got here, something is going wrong.
                        destroy(PItem);
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize send new items transaction (player: {} ({}), slotID: {})",
                                                 PChar->getName(), PChar->id, slotID));
        });
        if (!success)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 0xEB);
        }
        // clang-format on
    }
}

void dboxutils::RemoveDeliveredItemFromSendingBox(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    uint8 receivedItems  = 0;
    uint8 deliverySlotID = 0;

    const auto rset = db::preparedStmt("SELECT slot FROM delivery_box WHERE charid = ? AND received = 1 AND box = 2 ORDER BY slot ASC", PChar->id);
    if (rset)
    {
        receivedItems = rset->rowsCount();
        if (receivedItems && rset->next())
        {
            deliverySlotID = rset->get<uint8>("slot");
            if (!PChar->UContainer->IsSlotEmpty(deliverySlotID))
            {
                CItem* PItem = PChar->UContainer->GetItem(deliverySlotID);
                if (PItem && PItem->isSent())
                {
                    const auto [rset2, affectedRows2] = db::preparedStmtWithAffectedRows("DELETE FROM delivery_box WHERE charid = ? AND box = 2 AND slot = ? LIMIT 1", PChar->id, deliverySlotID);
                    if (rset2 && affectedRows2)
                    {
                        DebugDeliveryBoxFmt("DBOX: RemoveDeliveredItemFromSendingBox (action: {:02X}): player: {} ({}) removed item: {} ({})",
                                            action, PChar->getName(), PChar->id, PItem->getName(), PItem->getID());

                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, deliverySlotID, receivedItems, 0x01);
                        PChar->UContainer->SetItem(deliverySlotID, nullptr);
                        destroy(PItem);
                    }
                }
            }
        }
    }
}

void dboxutils::UpdateDeliveryCellBeforeRemoving(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in an invalid state: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(slotID), slotID, 1, 1);
    }
}

void dboxutils::ReturnToSender(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        CItem* PItem = PChar->UContainer->GetItem(slotID);

        // For logging
        const auto itemId   = PItem->getID();
        const auto quantity = PItem->getQuantity();

        // clang-format off
        const auto success = db::transaction([&]()
        {
            // Get sender of delivery record
            const auto [senderID, senderName] = [&]() -> std::pair<uint32, std::string>
            {
                const auto rset = db::preparedStmt("SELECT senderid, sender FROM delivery_box WHERE charid = ? AND slot = ? AND box = 1 LIMIT 1",
                                                   PChar->id, slotID);
                FOR_DB_SINGLE_RESULT(rset)
                {
                    const auto senderID = rset->get<uint32>("senderid");
                    const auto senderName = rset->get<std::string>("sender");
                    return std::make_pair(senderID, senderName);
                }

                return std::make_pair(0, std::string());
            }();

            if (senderID)
            {
                // NOTE: This will trigger SQL trigger: delivery_box_insert
                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                                                                                   "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                                                                   senderID, senderName, 1, PItem->getID(), PItem->getSubID(), PItem->getQuantity(), PItem->m_extra, PChar->id, PChar->getName());
                if (rset && affectedRows)
                {
                    // Remove original delivery record
                    const auto [rset2, affectedRows2] = db::preparedStmtWithAffectedRows("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = 1 LIMIT 1", PChar->id, slotID);
                    if (rset2 && affectedRows2)
                    {
                        PChar->UContainer->SetItem(slotID, nullptr);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1);

                        DebugDeliveryBoxFmt("DBOX: ReturnToSender (action: {:02X}): player: {} ({}) returned item: {} ({}) to sender: {} ({})",
                                            action, PChar->getName(), PChar->id, PItem->getName(), itemId, senderName, senderID);

                        destroy(PItem);
                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize delivery return transaction (player: {} ({}), sender: {}, itemID: {}, quantity: {})",
                                                 PChar->getName(), PChar->id, senderName, itemId, quantity));
        });
        if (!success)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xEB);
        }
        // clang-format on
    }
}

void dboxutils::TakeItemFromCell(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (boxtype < 1 || boxtype > 2 || !IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in an invalid state {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        CItem* PItem = PChar->UContainer->GetItem(slotID);

        if (!PItem->isType(ITEM_CURRENCY) && PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xB9);
            return;
        }

        // clang-format off
        const auto success = db::transaction([&]()
        {
            if (boxtype == 0x01)
            {
                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = ? LIMIT 1",
                                                                   PChar->id, slotID, boxtype);
                if (rset && affectedRows)
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                    {
                        return;
                    }
                }
            }
            else if (boxtype == 0x02)
            {
                const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("DELETE FROM delivery_box WHERE charid = ? AND sent = 0 AND slot = ? AND box = ? LIMIT 1",
                                                                                   PChar->id, slotID, boxtype);
                if (rset && affectedRows)
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                    {
                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize take item transaction (player: {} ({}), slotID: {})",
                                                 PChar->getName(), PChar->id, slotID));
        });
        if (success)
        {
            DebugDeliveryBoxFmt("DBOX: TakeItemFromCell (action: {:02X}): player: {} ({}) received item: {} ({}) from slot {}",
                                action, PChar->getName(), PChar->id, PItem->getName(), PItem->getID(), slotID);

            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1);
            PChar->pushPacket<CInventoryFinishPacket>();
            PChar->UContainer->SetItem(slotID, nullptr);
            destroy(PItem);
        }
        else
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xBA);
        }
        // clang-format on
    }
}

void dboxutils::RemoveItemFromCell(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(slotID))
    {
        const auto [rset, affectedRows] = db::preparedStmtWithAffectedRows("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = 1 LIMIT 1", PChar->id, slotID);
        if (rset && affectedRows)
        {
            CItem* PItem = PChar->UContainer->GetItem(slotID);
            PChar->UContainer->SetItem(slotID, nullptr);

            DebugDeliveryBoxFmt("DBOX: RemoveItemFromCell (action: {:02X}): player: {} ({}) removed item {} ({}) from slot {}",
                                action, PChar->getName(), PChar->id, PItem->getName(), PItem->getID(), slotID);

            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1);
            destroy(PItem);
        }
    }
}

void dboxutils::ConfirmNameBeforeSending(CCharEntity* PChar, uint8 action, uint8 boxtype, const std::string& recieverName)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    uint32 accid = charutils::getAccountIdFromName(recieverName);
    if (accid)
    {
        const auto rset = db::preparedStmt("SELECT COUNT(*) FROM chars WHERE charid = ? AND accid = ? LIMIT 1", PChar->id, accid);
        if (rset && rset->rowsCount() && rset->next() && rset->get<uint32>("COUNT(*)"))
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0xFF, 0x02);
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0x01, 0x01);
        }
        else
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0xFF, 0x02);
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0x00, 0x01);
        }
    }
    else
    {
        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0xFF, 0x02);
        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0x00, 0xFB);
    }
}

void dboxutils::CloseMailWindow(CCharEntity* PChar, uint8 action, uint8 boxtype)
{
    if (IsAnyDeliveryBoxOpen(PChar))
    {
        PChar->UContainer->Clean();
    }

    // Open mail, close mail
    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 1);
}

void dboxutils::OpenSendBox(CCharEntity* PChar, uint8 action, uint8 boxtype)
{
    PChar->UContainer->Clean();
    PChar->UContainer->SetType(UCONTAINER_SEND_DELIVERYBOX);
    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 1);
}

void dboxutils::OpenRecvBox(CCharEntity* PChar, uint8 action, uint8 boxtype)
{
    PChar->UContainer->Clean();
    PChar->UContainer->SetType(UCONTAINER_RECV_DELIVERYBOX);
    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 1);
}

bool dboxutils::IsSendBoxOpen(CCharEntity* PChar)
{
    return PChar->UContainer->GetType() == UCONTAINER_SEND_DELIVERYBOX;
}

bool dboxutils::IsRecvBoxOpen(CCharEntity* PChar)
{
    return PChar->UContainer->GetType() == UCONTAINER_RECV_DELIVERYBOX;
}

bool dboxutils::IsAnyDeliveryBoxOpen(CCharEntity* PChar)
{
    return IsSendBoxOpen(PChar) || IsRecvBoxOpen(PChar);
}
