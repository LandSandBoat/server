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
#include "common/settings.h"
#include "common/sql.h"
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

    const char* fmtQuery = "SELECT itemid, itemsubid, slot, quantity, sent, extra, sender, charname FROM delivery_box WHERE charid = %u AND box = %d "
                           "AND slot < 8 ORDER BY slot";

    int32 ret = _sql->Query(fmtQuery, PChar->id, boxtype);

    if (ret != SQL_ERROR)
    {
        int items = 0;
        if (_sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CItem* PItem = itemutils::GetItem(_sql->GetIntData(0));

                if (PItem != nullptr) // Prevent an access violation in the event that an item doesn't exist for an ID
                {
                    PItem->setSubID(_sql->GetIntData(1));
                    PItem->setSlotID(_sql->GetIntData(2));
                    PItem->setQuantity(_sql->GetUIntData(3));

                    if (_sql->GetUIntData(4) > 0)
                    {
                        PItem->setSent(true);
                    }

                    size_t length = 0;
                    char*  extra  = nullptr;
                    _sql->GetData(5, &extra, &length);
                    std::memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                    if (boxtype == 2)
                    {
                        PItem->setSender(_sql->GetStringData(7));
                        PItem->setReceiver(_sql->GetStringData(6));
                    }
                    else
                    {
                        PItem->setSender(_sql->GetStringData(6));
                        PItem->setReceiver(_sql->GetStringData(7));
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
        auto rset = db::preparedStmt("SELECT charid, accid FROM chars WHERE charname = ? LIMIT 1", recieverName);
        if (rset && rset->rowsCount() && rset->next())
        {
            uint32 charid = rset->get<uint32>("charid");

            if (PItem->getFlag() & ITEM_FLAG_NODELIVERY)
            {
                if (!(PItem->getFlag() & ITEM_FLAG_MAIL2ACCOUNT))
                {
                    return;
                }

                uint32 accid = rset->get<uint32>("accid");

                // clang-format off
                auto exists = [&]() -> bool
                {
                    auto rset2 = db::preparedStmt("SELECT COUNT(*) FROM chars WHERE charid = ? AND accid = ? LIMIT 1", PChar->id, accid);
                    return rset2 && rset2->rowsCount() && rset2->next() && rset2->get<uint32>("COUNT(*)");
                }();
                if (!exists)
                {
                    return;
                }
                // clang-format on
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

            char extra[sizeof(PItem->m_extra) * 2 + 1];
            _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

            // NOTE: This will trigger SQL trigger: delivery_box_insert
            auto ret = _sql->Query(
                "INSERT INTO delivery_box(charid, charname, box, slot, itemid, itemsubid, quantity, extra, senderid, sender) "
                "VALUES(%u, '%s', %u, %u, %u, %u, %u, '%s', %u, '%s')",
                PChar->id, PChar->getName(), 2, slotID, PItem->getID(), PItem->getSubID(), quantity, extra, charid, recieverName);

            if (ret != SQL_ERROR && _sql->AffectedRows() == 1 && charutils::UpdateItem(PChar, LOC_INVENTORY, invslot, -(int32)quantity))
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
            bool isAutoCommitOn = _sql->GetAutoCommit();
            bool commit         = false;

            if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
            {
                int32 ret = _sql->Query("SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PItem->getReceiver());
                if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
                {
                    uint32 charid = _sql->GetUIntData(0);

                    ret = _sql->Query("UPDATE delivery_box SET sent = 1 WHERE charid = %u AND senderid = %u AND slot = %u AND box = 2",
                                      PChar->id, charid, slotID);

                    if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                    {
                        char extra[sizeof(PItem->m_extra) * 2 + 1];
                        _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                        // NOTE: This will trigger SQL trigger: delivery_box_insert
                        ret = _sql->Query(
                            "INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                            "VALUES(%u, '%s', 1, %u, %u, %u, '%s', %u, '%s'); ",
                            charid, PItem->getReceiver(), PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id, PChar->getName());

                        if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                        {
                            PItem->setSent(true);
                            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, send_items, 0x02);
                            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, send_items, 0x01);
                            commit = true;
                        }
                    }
                }

                if (!commit || !_sql->TransactionCommit())
                {
                    _sql->TransactionRollback();
                    ShowErrorFmt("DBOX: Could not finalize send transaction (player: {} ({}), target: {}, slotID: {})",
                                 PChar->getName(), PChar->id, PItem->getReceiver(), slotID);
                }

                _sql->SetAutoCommit(isAutoCommitOn);
            }
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
        bool   isAutoCommitOn = _sql->GetAutoCommit();
        bool   commit         = false;
        bool   orphan         = false;
        CItem* PItem          = PChar->UContainer->GetItem(slotID);

        if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
        {
            int32 ret = _sql->Query("SELECT charid FROM chars WHERE charname = '%s' LIMIT 1", PChar->UContainer->GetItem(slotID)->getReceiver());
            if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                uint32 charid = _sql->GetUIntData(0);
                ret           = _sql->Query(
                    "UPDATE delivery_box SET sent = 0 WHERE charid = %u AND box = 2 AND slot = %u AND sent = 1 AND received = 0 LIMIT 1",
                    PChar->id, slotID);

                if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                {
                    ret = _sql->Query(
                        "DELETE FROM delivery_box WHERE senderid = %u AND box = 1 AND charid = %u AND itemid = %u AND quantity = %u "
                        "AND slot >= 8 LIMIT 1",
                        PChar->id, charid, PItem->getID(), PItem->getQuantity());

                    if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                    {
                        PChar->UContainer->GetItem(slotID)->setSent(false);
                        commit = true;
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                              PChar->UContainer->GetItemsCount(), 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PChar->UContainer->GetItem(slotID), slotID,
                                                              PChar->UContainer->GetItemsCount(), 0x01);
                    }
                    else if (ret != SQL_ERROR && _sql->AffectedRows() == 0)
                    {
                        orphan = true;
                    }
                }
            }
            else if (ret != SQL_ERROR && _sql->NumRows() == 0)
            {
                orphan = true;
            }

            if (!commit || !_sql->TransactionCommit())
            {
                _sql->TransactionRollback();
                ShowErrorFmt("DBOX: Could not finalize cancel send transaction (player: {} ({}), target: {}, slotID: {})",
                             PChar->getName(), PChar->id, PItem->getReceiver(), slotID);
                if (orphan)
                {
                    _sql->SetAutoCommit(true);
                    ret = _sql->Query(
                        "DELETE FROM delivery_box WHERE box = 2 AND charid = %u AND itemid = %u AND quantity = %u AND slot = %u LIMIT 1",
                        PChar->id, PItem->getID(), PItem->getQuantity(), slotID);
                    if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                    {
                        ShowErrorFmt("DBOX: Deleting orphaned outbox record (player: {} ({}), target: {}, slotID: {})",
                                     PChar->getName(), PChar->id, PItem->getReceiver(), slotID);
                        PChar->pushPacket<CDeliveryBoxPacket>(0x0F, boxtype, 0, 1);
                    }
                }
                // error message: "Delivery orders are currently backlogged."
                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, -1);
            }

            _sql->SetAutoCommit(isAutoCommitOn);
        }
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

    uint8 received_items = 0;
    int32 ret            = SQL_ERROR;

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
        std::string Query = "SELECT charid FROM delivery_box WHERE charid = %u AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT %u";
        ret               = _sql->Query(Query.c_str(), PChar->id, limit);
    }
    else if (boxtype == 0x02)
    {
        std::string Query = "SELECT charid FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2";
        ret               = _sql->Query(Query.c_str(), PChar->id);
    }

    if (ret != SQL_ERROR)
    {
        received_items = (uint8)_sql->NumRows();
    }

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
        bool isAutoCommitOn = _sql->GetAutoCommit();
        bool commit         = false;

        if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
        {
            std::string Query = "SELECT itemid, itemsubid, quantity, extra, sender, senderid FROM delivery_box WHERE charid = %u "
                                "AND box = 1 AND slot >= 8 ORDER BY slot ASC LIMIT 1";

            int32 ret = _sql->Query(Query.c_str(), PChar->id);

            CItem* PItem = nullptr;

            if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                PItem = itemutils::GetItem(_sql->GetUIntData(0));
                if (PItem)
                {
                    PItem->setSubID(_sql->GetIntData(1));
                    PItem->setQuantity(_sql->GetUIntData(2));

                    size_t length = 0;
                    char*  extra  = nullptr;
                    _sql->GetData(3, &extra, &length);
                    std::memcpy(PItem->m_extra, extra, (length > sizeof(PItem->m_extra) ? sizeof(PItem->m_extra) : length));

                    PItem->setSender(_sql->GetStringData(4));
                    if (PChar->UContainer->IsSlotEmpty(slotID))
                    {
                        int senderID = _sql->GetUIntData(5);
                        PItem->setSlotID(slotID);

                        // the result of this query doesn't really matter, it can be sent from the auction house which has no sender record
                        _sql->Query("UPDATE delivery_box SET received = 1 WHERE senderid = %u AND charid = %u AND box = 2 AND received = 0 AND quantity "
                                    "= %u AND sent = 1 AND itemid = %u LIMIT 1",
                                    PChar->id, senderID, PItem->getQuantity(), PItem->getID());

                        _sql->Query("SELECT slot FROM delivery_box WHERE charid = %u AND box = 1 AND slot > 7 ORDER BY slot ASC", PChar->id);
                        if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
                        {
                            uint8 queue = _sql->GetUIntData(0);
                            Query       = "UPDATE delivery_box SET slot = %u WHERE charid = %u AND box = 1 AND slot = %u";
                            ret         = _sql->Query(Query.c_str(), slotID, PChar->id, queue);
                            if (ret != SQL_ERROR)
                            {
                                Query = "UPDATE delivery_box SET slot = slot - 1 WHERE charid = %u AND box = 1 AND slot > %u";
                                ret   = _sql->Query(Query.c_str(), PChar->id, queue);
                                if (ret != SQL_ERROR)
                                {
                                    PChar->UContainer->SetItem(slotID, PItem);

                                    // TODO: increment "count" for every new item, if needed
                                    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, nullptr, slotID, 1, 2);
                                    PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, 1, 1);
                                    commit = true;
                                }
                            }
                        }
                    }
                }
            }

            if (!commit || !_sql->TransactionCommit())
            {
                destroy(PItem);

                _sql->TransactionRollback();
                ShowErrorFmt("DBOX: Could not finalize send transaction (player: {} ({}), slotID: {})", PChar->getName(), PChar->id, slotID);
                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 0xEB);
            }
        }
        _sql->SetAutoCommit(isAutoCommitOn);
    }
}

void dboxutils::RemoveDeliveredItemFromSendingBox(CCharEntity* PChar, uint8 action, uint8 boxtype, uint8 slotID)
{
    if (!IsSendBoxOpen(PChar))
    {
        ShowWarningFmt("DBOX: Received action {} while UContainer is in a state other than UCONTAINER_SEND_DELIVERYBOX: {} ({})", action, PChar->getName(), PChar->id);
        return;
    }

    uint8 received_items = 0;
    uint8 deliverySlotID = 0;

    int32 ret = _sql->Query("SELECT slot FROM delivery_box WHERE charid = %u AND received = 1 AND box = 2 ORDER BY slot ASC", PChar->id);

    if (ret != SQL_ERROR)
    {
        received_items = (uint8)_sql->NumRows();
        if (received_items && _sql->NextRow() == SQL_SUCCESS)
        {
            deliverySlotID = _sql->GetUIntData(0);
            if (!PChar->UContainer->IsSlotEmpty(deliverySlotID))
            {
                CItem* PItem = PChar->UContainer->GetItem(deliverySlotID);
                if (PItem && PItem->isSent())
                {
                    ret = _sql->Query("DELETE FROM delivery_box WHERE charid = %u AND box = 2 AND slot = %u LIMIT 1", PChar->id, deliverySlotID);
                    if (ret != SQL_ERROR && _sql->AffectedRows() == 1)
                    {
                        DebugDeliveryBoxFmt("DBOX: RemoveDeliveredItemFromSendingBox (action: {:02X}): player: {} ({}) removed item: {} ({})",
                                            action, PChar->getName(), PChar->id, PItem->getName(), PItem->getID());

                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, 0, 0x02);
                        PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, deliverySlotID, received_items, 0x01);
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
        bool isAutoCommitOn = _sql->GetAutoCommit();
        bool commit         = false; // When in doubt back it out.

        CItem*      PItem    = PChar->UContainer->GetItem(slotID);
        auto        item_id  = PItem->getID();
        auto        quantity = PItem->getQuantity();
        uint32      senderID = 0;
        std::string senderName;

        if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
        {
            // Get sender of delivery record
            int32 ret = _sql->Query("SELECT senderid, sender FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1",
                                    PChar->id, slotID);

            if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
            {
                senderID = _sql->GetUIntData(0);
                senderName.insert(0, (const char*)_sql->GetData(1));

                if (senderID != 0)
                {
                    char extra[sizeof(PItem->m_extra) * 2 + 1];
                    _sql->EscapeStringLen(extra, (const char*)PItem->m_extra, sizeof(PItem->m_extra));

                    // Insert a return record into delivery_box
                    ret = _sql->Query("INSERT INTO delivery_box(charid, charname, box, itemid, itemsubid, quantity, extra, senderid, sender) "
                                      "VALUES(%u, '%s', %u, %u, %u, %u, '%s', %u, '%s')",
                                      senderID, senderName, 1, PItem->getID(), PItem->getSubID(), PItem->getQuantity(), extra, PChar->id, PChar->getName());

                    if (ret != SQL_ERROR && _sql->AffectedRows() > 0)
                    {
                        // Remove original delivery record
                        ret = _sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1", PChar->id, slotID);

                        if (ret != SQL_ERROR && _sql->AffectedRows() > 0)
                        {
                            PChar->UContainer->SetItem(slotID, nullptr);
                            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1);
                            destroy(PItem);
                            commit = true;
                        }
                    }
                }
            }

            if (!commit || !_sql->TransactionCommit())
            {
                _sql->TransactionRollback();
                ShowErrorFmt("DBOX: Could not finalize delivery return transaction (player: {} ({}), sender: {}, itemID: {}, quantity: {})",
                             PChar->getName(), PChar->id, senderName, item_id, quantity);
                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xEB);
            }
            else
            {
                DebugDeliveryBoxFmt("DBOX: ReturnToSender (action: {:02X}): player: {} ({}) returned item: {} ({}) to sender: {} ({})",
                                    action, PChar->getName(), PChar->id, PItem->getName(), item_id, senderName, senderID);
            }

            _sql->SetAutoCommit(isAutoCommitOn);
        }
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
        bool isAutoCommitOn = _sql->GetAutoCommit();
        bool commit         = false;
        bool invErr         = false;

        CItem* PItem = PChar->UContainer->GetItem(slotID);

        if (!PItem->isType(ITEM_CURRENCY) && PChar->getStorage(LOC_INVENTORY)->GetFreeSlotsCount() == 0)
        {
            PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xB9);
            return;
        }

        if (_sql->SetAutoCommit(false) && _sql->TransactionStart())
        {
            int32 ret = SQL_ERROR;
            if (boxtype == 0x01)
            {
                ret = _sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = %u LIMIT 1",
                                  PChar->id, slotID, boxtype);
            }
            else if (boxtype == 0x02)
            {
                ret = _sql->Query("DELETE FROM delivery_box WHERE charid = %u AND sent = 0 AND slot = %u AND box = %u LIMIT 1",
                                  PChar->id, slotID, boxtype);
            }

            if (ret != SQL_ERROR && _sql->AffectedRows() != 0)
            {
                if (charutils::AddItem(PChar, LOC_INVENTORY, itemutils::GetItem(PItem), true) != ERROR_SLOTID)
                {
                    commit = true;
                }
                else
                {
                    invErr = true;
                }
            }

            if (!commit || !_sql->TransactionCommit())
            {
                _sql->TransactionRollback();
                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 0xBA);
                if (!invErr)
                {
                    // only display error in log if there's a database problem, not if inv is full or rare item conflict
                    ShowErrorFmt("DBOX: Could not finalize receive transaction player: {} ({}), slotID: {}", PChar->getName(), PChar->id, slotID);
                }
            }
            else
            {
                DebugDeliveryBoxFmt("DBOX: TakeItemFromCell (action: {:02X}): player: {} ({}) received item: {} ({}) from slot {}",
                                    action, PChar->getName(), PChar->id, PItem->getName(), PItem->getID(), slotID);

                PChar->pushPacket<CDeliveryBoxPacket>(action, boxtype, PItem, slotID, PChar->UContainer->GetItemsCount(), 1);
                PChar->pushPacket<CInventoryFinishPacket>();
                PChar->UContainer->SetItem(slotID, nullptr);
                destroy(PItem);
            }
        }

        _sql->SetAutoCommit(isAutoCommitOn);
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
        int32 ret = _sql->Query("DELETE FROM delivery_box WHERE charid = %u AND slot = %u AND box = 1 LIMIT 1", PChar->id, slotID);

        if (ret != SQL_ERROR && _sql->AffectedRows() != 0)
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

    int32 ret = _sql->Query("SELECT accid FROM chars WHERE charname = '%s' LIMIT 1", recieverName);
    if (ret != SQL_ERROR && _sql->NumRows() > 0 && _sql->NextRow() == SQL_SUCCESS)
    {
        uint32 accid = _sql->GetUIntData(0);
        ret          = _sql->Query("SELECT COUNT(*) FROM chars WHERE charid = '%u' AND accid = '%u' LIMIT 1", PChar->id, accid);
        if (ret != SQL_ERROR && _sql->NextRow() == SQL_SUCCESS && _sql->GetUIntData(0))
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
