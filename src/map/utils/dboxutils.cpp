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

#include "common/async.h"

#include "dboxutils.h"

#include "common/database.h"
#include "common/logging.h"
#include "common/macros.h"
#include "common/settings.h"
#include "common/tracy.h"

#include "entities/charentity.h"

#include "packets/delivery_box.h"
#include "packets/s2c/0x01d_item_same.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"
#include "utils/zoneutils.h"

#include "packets/c2s/0x04d_pbx.h"
#include "universal_container.h"

void dboxutils::SendOldItems(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo)
{
    DebugDeliveryBoxFmt("DBOX: SendOldItems: player: {} ({}), BoxNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo));

    if (!IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action SendOldItems while UContainer is in an invalid state: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    const auto rset = db::preparedStmt("SELECT itemid, itemsubid, slot, quantity, sent, extra, sender, charname FROM delivery_box WHERE charid = ? AND box = ? "
                                       "AND slot < 8 ORDER BY slot",
                                       PChar->id, BoxNo);
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

                    if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
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
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Work, BoxNo, PChar->UContainer->GetItem(i), i, items, 1);
        }
    }
}

void dboxutils::AddItemsToBeSent(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo, int8_t ItemWorkNo, uint32_t ItemStacks, const std::string& receiverName)
{
    DebugDeliveryBoxFmt("DBOX: AddItemsToBeSent: player: {} ({}), BoxNo: {}, PostWorkNo: {}, ItemWorkNo: {}, ItemStacks: {}, receiverName: {}",
                        PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo, ItemWorkNo, ItemStacks, receiverName);

    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received AddItemsToBeSent while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    CItem* PItem = PChar->getStorage(LOC_INVENTORY)->GetItem(ItemWorkNo);

    if (ItemStacks == 0 || !PItem)
    {
        return;
    }

    if (PItem->getQuantity() < ItemStacks || PItem->getReserve() > 0)
    {
        ShowWarningFmt("DBOX: {} attempted to send insufficient/reserved {}: {} ({})", PChar->getName(), ItemStacks, PItem->getName(), PItem->getID());
        return;
    }

    if (PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        const auto [recvCharid, recvAccid] = charutils::getCharIdAndAccountIdFromName(receiverName);
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

            PUBoxItem->setReceiver(receiverName);
            PUBoxItem->setSender(PChar->getName());
            PUBoxItem->setQuantity(ItemStacks);
            PUBoxItem->setSlotID(PItem->getSlotID());
            std::memcpy(PUBoxItem->m_extra, PItem->m_extra, sizeof(PUBoxItem->m_extra));

            // NOTE: This will trigger SQL trigger: delivery_box_insert
            const auto rset = db::preparedStmt(
                "INSERT INTO delivery_box(charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender) "
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
                PChar->id, PChar->getName(), 2, PostWorkNo, PItem->getID(), PItem->getSubID(), ItemStacks, PItem->m_extra, recvCharid, receiverName);

            if (rset && rset->rowsAffected() && charutils::UpdateItem(PChar, LOC_INVENTORY, ItemWorkNo, -static_cast<int32>(ItemStacks)))
            {
                PChar->UContainer->SetItem(PostWorkNo, PUBoxItem);
                PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Set, BoxNo, PUBoxItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 1);
                PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
            }
            else
            {
                destroy(PUBoxItem);
            }
        }
    }
}

void dboxutils::SendConfirmation(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: SendConfirmation: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action SendConfirmation while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
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

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        CItem* PItem = PChar->UContainer->GetItem(PostWorkNo);

        if (PItem && !PItem->isSent())
        {
            // clang-format off
            const auto success = db::transaction([&]()
            {
                uint32 charid = charutils::getCharIdFromName(PItem->getReceiver());

                const auto rset = db::preparedStmt("UPDATE delivery_box SET sent = 1 WHERE charid = ? AND senderid = ? AND slot = ? AND box = ?",
                                                                                   PChar->id, charid, PostWorkNo, 2);
                if (rset && rset->rowsAffected())
                {
                    // NOTE: This will trigger SQL trigger: delivery_box_insert
                    const auto rset2 = db::preparedStmt(
                        "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                        "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
                        charid, PItem->getReceiver(), 1, PItem->getID(), PItem->getSubID(), PItem->getQuantity(), PItem->m_extra, PChar->id, PChar->getName());

                    if (rset2 && rset2->rowsAffected())
                    {
                        PItem->setSent(true);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Send, BoxNo, PItem, PostWorkNo, send_items, 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Send, BoxNo, PItem, PostWorkNo, send_items, 0x01);
                        return;
                    }
                }

                // If we got here, something went wrong.
                throw std::runtime_error(fmt::format("DBOX: Could not finalize send confirmation transaction (player: {} ({}), target: {}, PostWorkNo: {})",
                                                     PChar->getName(), PChar->id, PItem->getReceiver(), PostWorkNo));
            });
            if (success)
            {
                // TODO: Debug logging
            }
            // clang-format on
        }
    }
}

void dboxutils::CancelSendingItem(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: CancelSendingItem: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action CancelSendingItem while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        CItem* PItem = PChar->UContainer->GetItem(PostWorkNo);

        // clang-format off
        const auto success = db::transaction([&]()
        {
            uint32 charid = charutils::getCharIdFromName(PChar->UContainer->GetItem(PostWorkNo)->getReceiver());
            if (charid)
            {
                const auto rset = db::preparedStmt(
                    "UPDATE delivery_box SET sent = 0 WHERE charid = ? AND box = 2 AND slot = ? AND sent = 1 AND received = 0 LIMIT 1",
                    PChar->id, PostWorkNo);

                if (rset && rset->rowsAffected())
                {
                    const auto rset2 = db::preparedStmt(
                        "DELETE FROM delivery_box WHERE senderid = ? AND box = 1 AND charid = ? AND itemid = ? AND quantity = ? "
                        "AND slot >= 8 LIMIT 1",
                        PChar->id, charid, PItem->getID(), PItem->getQuantity());

                    if (rset2 && rset->rowsAffected())
                    {
                        PChar->UContainer->GetItem(PostWorkNo)->setSent(false);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Cancel, BoxNo, PChar->UContainer->GetItem(PostWorkNo), PostWorkNo, PChar->UContainer->GetItemsCount(), 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Cancel, BoxNo, PChar->UContainer->GetItem(PostWorkNo), PostWorkNo, PChar->UContainer->GetItemsCount(), 0x01);

                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize cancel send transaction (player: {} ({}), target: {}, PostWorkNo: {})",
                                                 PChar->getName(), PChar->id, PItem->getReceiver(), PostWorkNo));
        });
        if (!success)
        {
            const auto rset = db::preparedStmt(
                "DELETE FROM delivery_box WHERE box = 2 AND charid = ? AND itemid = ? AND quantity = ? AND slot = ? LIMIT 1",
                PChar->id, PItem->getID(), PItem->getQuantity(), PostWorkNo);
            if (rset && rset->rowsAffected())
            {
                ShowErrorFmt("DBOX: Deleting orphaned outbox record (player: {} ({}), target: {}, PostWorkNo: {})",
                                PChar->getName(), PChar->id, PItem->getReceiver(), PostWorkNo);
                PChar->pushPacket<CDeliveryBoxPacket>(static_cast<GP_CLI_COMMAND_PBX_COMMAND>(0x0F), BoxNo, 0, 1);
            }

            // error message: "Delivery orders are currently backlogged."
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Cancel, BoxNo, 0, -1);
        }
        // clang-format on
    }
}

void dboxutils::SendClientNewItemCount(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: SendClientNewItemCount: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    // Send the player the new items count not seen
    if (!IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action SendClientNewItemCount while UContainer is in an invalid state: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    const uint8 received_items = [&]() -> uint8
    {
        if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Incoming)
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
        else if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
        {
            const auto rset = db::preparedStmt("SELECT charid FROM delivery_box WHERE charid = ? AND received = 1 AND box = 2", PChar->id);
            if (rset)
            {
                return rset->rowsCount();
            }
        }

        return 0;
    }();

    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Check, BoxNo, 0xFF, 0x02);
    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Check, BoxNo, received_items, 0x01);
}

void dboxutils::SendNewItems(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: SendNewItems: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action SendNewItems while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Incoming)
    {
        // clang-format off
        const auto success = db::transaction([&]()
        {

            const auto rset = db::preparedStmt("SELECT itemid, itemsubid, quantity, extra, sender, senderid FROM delivery_box WHERE charid = ? "
                                               "AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT 1",
                                               PChar->id);
            FOR_DB_SINGLE_RESULT(rset)
            {
                if (CItem* PItem = itemutils::GetItem(rset->get<uint32>("itemid")))
                {
                    PItem->setSubID(rset->get<uint16>("itemsubid"));
                    PItem->setQuantity(rset->get<uint32>("quantity"));
                    db::extractFromBlob(rset, "extra", PItem->m_extra);
                    PItem->setSender(rset->get<std::string>("sender"));

                    if (PChar->UContainer->IsSlotEmpty(PostWorkNo))
                    {
                        uint32 senderID = rset->get<uint32>("senderid");
                        PItem->setSlotID(PostWorkNo);

                        // the result of this query doesn't really matter, it can be sent from the auction house which has no sender record
                        db::preparedStmt("UPDATE delivery_box SET received = 1 WHERE senderid = ? AND charid = ? AND box = 2 AND received = 0 AND quantity = ? AND sent = 1 AND itemid = ? LIMIT 1",
                                         PChar->id, senderID, PItem->getQuantity(), PItem->getID());

                        if (settings::get<bool>("map.AUDIT_PLAYER_DBOX"))
                        {
                            Async::getInstance()->submit(
                                [itemid        = PItem->getID(),
                                 quantity      = PItem->getQuantity(),
                                 sender        = senderID,
                                 sender_name   = PItem->getSender(),
                                 receiver      = PChar->id,
                                 receiver_name = PChar->getName(),
                                 date          = earth_time::timestamp()]()
                                {
                                    const auto query = "INSERT INTO audit_dbox(itemid, quantity, sender, sender_name, receiver, receiver_name, date) VALUES (?, ?, ?, ?, ?, ?, ?)";
                                    if (!db::preparedStmt(query, itemid, quantity, sender, sender_name, receiver, receiver_name, date))
                                    {
                                        ShowErrorFmt("Failed to log delivery box transaction (item: {}, quantity: {}, sender: {}, receiver: {}, date: {})", itemid, quantity, sender, receiver, date);
                                    }
                                }
                            );
                        }

                        const auto rset = db::preparedStmt("SELECT slot FROM delivery_box WHERE charid = ? AND box = 1 AND slot > 7 ORDER BY slot ASC", PChar->id);
                        FOR_DB_SINGLE_RESULT(rset)
                        {
                            uint8 queue = rset->get<uint8>("slot");

                            const auto rset2 = db::preparedStmt("UPDATE delivery_box SET slot = ? WHERE charid = ? AND box = 1 AND slot = ?", PostWorkNo, PChar->id, queue);
                            if (rset2)
                            {
                                const auto rset3 = db::preparedStmt("UPDATE delivery_box SET slot = slot - 1 WHERE charid = ? AND box = 1 AND slot > ?", PChar->id, queue);
                                if (rset3)
                                {
                                    PChar->UContainer->SetItem(PostWorkNo, PItem);

                                    // TODO: increment "count" for every new item, if needed
                                    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Recv, BoxNo, nullptr, PostWorkNo, 1, 2);
                                    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Recv, BoxNo, PItem, PostWorkNo, 1, 1);
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
            throw std::runtime_error(fmt::format("DBOX: Could not finalize send new items transaction (player: {} ({}), PostWorkNo: {})",
                                                 PChar->getName(), PChar->id, PostWorkNo));
        });
        if (!success)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Recv, BoxNo, 0, 0xEB);
        }
        // clang-format on
    }
}

void dboxutils::RemoveDeliveredItemFromSendingBox(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: RemoveDeliveredItemFromSendingBox: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action RemoveDeliveredItemFromSendingBox while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
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
                    const auto rset2 = db::preparedStmt("DELETE FROM delivery_box WHERE charid = ? AND box = 2 AND slot = ? LIMIT 1", PChar->id, deliverySlotID);
                    if (rset2 && rset2->rowsAffected())
                    {
                        DebugDeliveryBoxFmt("DBOX: RemoveDeliveredItemFromSendingBox: player: {} ({}) removed item: {} ({})",
                                            PChar->getName(), PChar->id, PItem->getName(), PItem->getID());

                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Confirm, BoxNo, 0, 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Confirm, BoxNo, PItem, deliverySlotID, receivedItems, 0x01);
                        PChar->UContainer->SetItem(deliverySlotID, nullptr);
                        destroy(PItem);
                    }
                }
            }
        }
    }
}

void dboxutils::UpdateDeliveryCellBeforeRemoving(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: UpdateDeliveryCellBeforeRemoving: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action UpdateDeliveryCellBeforeRemoving while UContainer is in an invalid state: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Accept, BoxNo, PChar->UContainer->GetItem(PostWorkNo), PostWorkNo, 1, 1);
    }
}

void dboxutils::ReturnToSender(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: ReturnToSender: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action ReturnToSender while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        CItem* PItem = PChar->UContainer->GetItem(PostWorkNo);

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
                                                   PChar->id, PostWorkNo);
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
                const auto rset = db::preparedStmt("INSERT INTO delivery_box (charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                                                                                   "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?)",
                                                                                   senderID, senderName, 1, PItem->getID(), PItem->getSubID(), PItem->getQuantity(), PItem->m_extra, PChar->id, PChar->getName());
                if (rset && rset->rowsAffected())
                {
                    // Remove original delivery record
                    const auto rset2 = db::preparedStmt("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = 1 LIMIT 1", PChar->id, PostWorkNo);
                    if (rset2 && rset2->rowsAffected())
                    {
                        PChar->UContainer->SetItem(PostWorkNo, nullptr);
                        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Reject, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 1);

                        DebugDeliveryBoxFmt("DBOX: ReturnToSender: player: {} ({}) returned item: {} ({}) to sender: {} ({})",
                                            PChar->getName(), PChar->id, PItem->getName(), itemId, senderName, senderID);

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
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Reject, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 0xEB);
        }
        // clang-format on
    }
}

void dboxutils::TakeItemFromCell(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: TakeItemFromCell: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsAnyDeliveryBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action TakeItemFromCell while UContainer is in an invalid state {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        CItem* PItem = PChar->UContainer->GetItem(PostWorkNo);

        if (!PItem->isType(ITEM_CURRENCY) && PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Get, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 0xB9);
            return;
        }

        // clang-format off
        const auto success = db::transaction([&]()
        {
            if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Incoming)
            {
                const auto rset = db::preparedStmt("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = ? LIMIT 1",
                                                                   PChar->id, PostWorkNo, BoxNo);
                if (rset && rset->rowsAffected())
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                    {
                        return;
                    }
                }
            }
            else if (BoxNo == GP_CLI_COMMAND_PBX_BOXNO::Outgoing)
            {
                const auto rset = db::preparedStmt("DELETE FROM delivery_box WHERE charid = ? AND sent = 0 AND slot = ? AND box = ? LIMIT 1",
                                                                                   PChar->id, PostWorkNo, BoxNo);
                if (rset && rset->rowsAffected())
                {
                    if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                    {
                        return;
                    }
                }
            }

            // If we got here, something went wrong.
            throw std::runtime_error(fmt::format("DBOX: Could not finalize take item transaction (player: {} ({}), PostWorkNo: {})",
                                                 PChar->getName(), PChar->id, PostWorkNo));
        });
        if (success)
        {
            DebugDeliveryBoxFmt("DBOX: TakeItemFromCell: player: {} ({}) received item: {} ({}) from slot {}",
                                PChar->getName(), PChar->id, PItem->getName(), PItem->getID(), PostWorkNo);

            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Get, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 1);
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>();
            PChar->UContainer->SetItem(PostWorkNo, nullptr);
            destroy(PItem);
        }
        else
        {
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Get, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 0xBA);
        }
        // clang-format on
    }
}

void dboxutils::RemoveItemFromCell(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, int8_t PostWorkNo)
{
    DebugDeliveryBoxFmt("DBOX: RemoveItemFromCell: player: {} ({}), BoxNo: {}, PostWorkNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), PostWorkNo);

    if (!IsRecvBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action RemoveItemFromCell while UContainer is in a state other than UCONTAINER_RECV_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    if (!PChar->UContainer->IsSlotEmpty(PostWorkNo))
    {
        const auto rset = db::preparedStmt("DELETE FROM delivery_box WHERE charid = ? AND slot = ? AND box = 1 LIMIT 1", PChar->id, PostWorkNo);
        if (rset && rset->rowsAffected())
        {
            CItem* PItem = PChar->UContainer->GetItem(PostWorkNo);
            PChar->UContainer->SetItem(PostWorkNo, nullptr);

            DebugDeliveryBoxFmt("DBOX: RemoveItemFromCell: player: {} ({}) removed item {} ({}) from slot {}",
                                PChar->getName(), PChar->id, PItem->getName(), PItem->getID(), PostWorkNo);

            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Clear, BoxNo, PItem, PostWorkNo, PChar->UContainer->GetItemsCount(), 1);
            destroy(PItem);
        }
    }
}

void dboxutils::ConfirmNameBeforeSending(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo, const std::string& receiverName)
{
    DebugDeliveryBoxFmt("DBOX: ConfirmNameBeforeSending: player: {} ({}), BoxNo: {}, receiverName: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo), receiverName);

    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action ConfirmNameBeforeSending while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", PChar->getName(), PChar->id);
        return;
    }

    uint32 accid = charutils::getAccountIdFromName(receiverName);
    if (accid)
    {
        const auto rset = db::preparedStmt("SELECT COUNT(*) FROM chars WHERE charid = ? AND accid = ? LIMIT 1", PChar->id, accid);
        if (rset && rset->rowsCount() && rset->next() && rset->get<uint32>("COUNT(*)"))
        {
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0xFF, 0x02);
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0x01, 0x01);
        }
        else
        {
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0xFF, 0x02);
            PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0x00, 0x01);
        }
    }
    else
    {
        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0xFF, 0x02);
        PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::Query, BoxNo, 0x00, 0xFB);
    }
}

void dboxutils::CloseMailWindow(CCharEntity* PChar, GP_CLI_COMMAND_PBX_BOXNO BoxNo)
{
    DebugDeliveryBoxFmt("DBOX: CloseMailWindow: player: {} ({}), BoxNo: {}", PChar->name, PChar->id, static_cast<int8_t>(BoxNo));

    if (IsAnyDeliveryBoxOpen(PChar))
    {
        PChar->UContainer->Clean();
    }

    // Open mail, close mail
    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::PostClose, BoxNo, 0, 1);
}

void dboxutils::OpenSendBox(CCharEntity* PChar)
{
    DebugDeliveryBoxFmt("DBOX: OpenSendBox: player: {} ({})", PChar->name, PChar->id);

    PChar->UContainer->Clean();
    PChar->UContainer->SetType(UCONTAINER_SEND_DELIVERYBOX);
    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::DeliOpen, GP_CLI_COMMAND_PBX_BOXNO::Outgoing, 0, 1);
}

void dboxutils::OpenRecvBox(CCharEntity* PChar)
{
    DebugDeliveryBoxFmt("DBOX: OpenRecvBox: player: {} ({})", PChar->name, PChar->id);

    PChar->UContainer->Clean();
    PChar->UContainer->SetType(UCONTAINER_RECV_DELIVERYBOX);
    PChar->pushPacket<CDeliveryBoxPacket>(GP_CLI_COMMAND_PBX_COMMAND::PostOpen, GP_CLI_COMMAND_PBX_BOXNO::Incoming, 0, 1);
}

auto dboxutils::IsSendBoxOpen(const CCharEntity* PChar) -> bool
{
    return PChar->UContainer->GetType() == UCONTAINER_SEND_DELIVERYBOX;
}

auto dboxutils::IsRecvBoxOpen(const CCharEntity* PChar) -> bool
{
    return PChar->UContainer->GetType() == UCONTAINER_RECV_DELIVERYBOX;
}

auto dboxutils::IsAnyDeliveryBoxOpen(CCharEntity* PChar) -> bool
{
    return IsSendBoxOpen(PChar) || IsRecvBoxOpen(PChar);
}
