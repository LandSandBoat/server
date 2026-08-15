/*
===========================================================================

  Copyright (c) 2026 LandSandBoat Dev Teams

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

#include "transaction.h"

#include "utils/charutils.h"
#include "utils/itemutils.h"

#include "ai/ai_container.h"
#include "ai/states/item_state.h"
#include "entities/char_entity.h"
#include "enums/item_state.h"
#include "enums/msg_std.h"
#include "item_container.h"
#include "items/item.h"
#include "lua/luautils.h"
#include "packets/s2c/0x009_message.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01e_item_num.h"
#include "packets/s2c/0x020_item_attr.h"

#include "common/cbasetypes.h"
#include "common/logging.h"
#include "common/types/badge.h"
#include "items/item_access.h"

#include <magic_enum/magic_enum.hpp>

#include <atomic>
#include <cstdlib>

namespace
{

// Only a transaction may create or destroy an item, so the whole of it lives here

auto applyItemUpdate(CCharEntity* PChar, uint8 LocationID, uint8 slotID, int32 quantity, const Transaction* owner) -> ItemMutation
{
    CItem* PItem = PChar->getStorage(LocationID)->GetItem(slotID);

    if (PItem == nullptr)
    {
        ShowDebug("UpdateItem: No item in slot %u", slotID);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(nullptr, static_cast<CONTAINER_ID>(LocationID), slotID);
        return {};
    }

    uint16 ItemID = PItem->getID();

    if ((int32)(PItem->getQuantity() + quantity) < 0)
    {
        ShowDebug("UpdateItem: %s trying to move invalid quantity %u of itemID %u", PChar->getName(), quantity, ItemID);
        return {};
    }

    const bool heldByOwner = owner != nullptr && owner->holds(PItem);

    auto* PState = dynamic_cast<CItemState*>(PChar->PAI->GetCurrentState());
    if (PState && !heldByOwner)
    {
        CItem* item = PState->GetItem();

        if (item && item->getSlotID() == PItem->getSlotID() && item->getLocationID() == PItem->getLocationID())
        {
            return {};
        }
    }

    // Equipped ammo decrements its stack on consumption without leaving the slot.
    const bool isEquippedAmmo = PItem->state() == ItemState::Equipped &&
                                PChar->getEquip(SLOT_AMMO) == PItem;
    if (PItem->isBusy() && !isEquippedAmmo && !heldByOwner)
    {
        ShowWarningFmt("UpdateItem: refusing to mutate busy item {} in state {} (loc={}, slot={}, char={})",
                       ItemID,
                       magic_enum::enum_name(PItem->state()),
                       LocationID,
                       slotID,
                       PChar->getName());
        return {};
    }

    uint32                 newQuantity = PItem->getQuantity() + quantity;
    std::unique_ptr<CItem> removed;

    if (newQuantity > PItem->getStackSize())
    {
        newQuantity = PItem->getStackSize();
    }

    if (newQuantity > 0 || PItem->isType(ITEM_CURRENCY))
    {
        db::preparedStmt("UPDATE char_inventory "
                         "SET quantity = ? "
                         "WHERE charid = ? AND location = ? AND slot = ?",
                         newQuantity,
                         PChar->id,
                         LocationID,
                         slotID);
        PItem->setQuantity(newQuantity);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_NUM>(static_cast<CONTAINER_ID>(LocationID), slotID, newQuantity);
    }
    else if (newQuantity == 0)
    {
        db::preparedStmt("DELETE FROM char_inventory "
                         "WHERE charid = ? AND location = ? AND slot = ?",
                         PChar->id,
                         LocationID,
                         slotID);
        removed = PChar->getStorage(LocationID)->RemoveItem(slotID);

        PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(nullptr, static_cast<CONTAINER_ID>(LocationID), slotID);

        luautils::OnItemDrop(PChar, PItem);

        // Equipped item consumed to 0: resync equipment.
        if (PChar->inventorySyncState().hasEquipChange(PItem))
        {
            PChar->inventorySyncState().clearEquipChanges();
            PChar->resyncEquipment();
        }
    }
    return { .itemId = ItemID, .applied = true, .removed = std::move(removed) };
}

auto applyAddItem(CCharEntity* PChar, uint8 LocationID, std::unique_ptr<CItem> PItem, Silence silence, const Transaction* owner) -> uint8
{
    if (PItem->isType(ITEM_CURRENCY))
    {
        // Currency lands on the stack the transaction may already hold, so it keeps the owner
        if (!applyItemUpdate(PChar, LocationID, 0, PItem->getQuantity(), owner).applied)
        {
            ShowErrorFmt("AddItem: could not give {} currency to {}", PItem->getQuantity(), PChar->getName());
            return ERROR_SLOTID;
        }

        return 0;
    }

    if (PItem->hasFlag(ItemFlag::Rare) && charutils::HasItem(PChar, PItem->getID()))
    {
        if (!silence)
        {
            PChar->pushPacket<GP_SERV_COMMAND_MESSAGE>(PChar, PItem->getID(), 0, MsgStd::ItemEx);
        }
        return ERROR_SLOTID;
    }

    auto* PStorage = PChar->getStorage(LocationID);
    uint8 SlotID   = PStorage->InsertItem(std::move(PItem));
    if (SlotID == ERROR_SLOTID)
    {
        ShowDebug("AddItem: Location %i is full", LocationID);
        return SlotID;
    }

    auto* PInserted = PStorage->GetItem(SlotID);

    const char* Query = "INSERT INTO char_inventory("
                        "charid, "
                        "location, "
                        "slot, "
                        "itemId, "
                        "quantity, "
                        "signature, "
                        "extra) "
                        "VALUES(?, ?, ?, ?, ?, ?, ?) "
                        "LIMIT 1";

    if (!db::preparedStmt(Query, PChar->id, LocationID, SlotID, PInserted->getID(), PInserted->getQuantity(), PInserted->getSignature(), PInserted->m_extra))
    {
        ShowError("AddItem: Cannot insert item to database");
        PStorage->RemoveItem(SlotID);
        return ERROR_SLOTID;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PInserted, static_cast<CONTAINER_ID>(LocationID), SlotID);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);

    return SlotID;
}

auto applyAddItem(CCharEntity* PChar, uint8 LocationID, uint16 ItemID, uint32 quantity, Silence silence, const Transaction* owner) -> uint8
{
    if (PChar->getStorage(LocationID)->GetFreeSlotsCount() == 0 || quantity == 0)
    {
        return ERROR_SLOTID;
    }

    auto PItem = xi::items::spawn(ItemID);
    if (PItem == nullptr)
    {
        ShowWarning("AddItem: Item <%i> is not found in a database", ItemID);
        return ERROR_SLOTID;
    }

    PItem->setQuantity(quantity);

    return applyAddItem(PChar, LocationID, std::move(PItem), silence, owner);
}

auto allocTxId() -> uint64
{
    static std::atomic<uint64> counter{ 1 };
    return counter.fetch_add(1, std::memory_order_relaxed);
}

} // namespace

Transaction::Transaction()
: id_(allocTxId())
{
}

Transaction::~Transaction()
{
    if (this->state_ == TransactionState::Open)
    {
        ShowErrorFmt("Transaction::~Transaction: tx {} still Open - subclass dtor must call rollbackIfOpen()", this->id_);
        std::abort();
    }
}

auto Transaction::id() const -> uint64
{
    return this->id_;
}

auto Transaction::isOpen() const -> bool
{
    return this->state_ == TransactionState::Open;
}

auto Transaction::commit() -> bool
{
    if (this->state_ != TransactionState::Open)
    {
        ShowWarningFmt("Transaction::commit: tx {} not Open (state={})", this->id_, magic_enum::enum_name(this->state_));
        return false;
    }

    if (!this->doCommit())
    {
        ShowWarningFmt("Transaction::commit: doCommit rejected for tx {}", this->id_);
        return false;
    }

    this->undos_.clear();
    this->state_ = TransactionState::Committed;

    return true;
}

void Transaction::rollback()
{
    if (this->state_ != TransactionState::Open)
    {
        ShowWarningFmt("Transaction::rollback: tx {} not Open (state={})", this->id_, magic_enum::enum_name(this->state_));
        return;
    }

    // The work comes undone before the claims go, so each step still owns what it is putting back.
    // One that cannot be taken back keeps what it did, and only forgets how to reverse it
    if (this->reversible())
    {
        this->runUndos();
    }
    else
    {
        this->undos_.clear();
    }

    this->doRollback();
    this->state_ = TransactionState::RolledBack;
}

void Transaction::runUndos()
{
    for (auto undo = this->undos_.rbegin(); undo != this->undos_.rend(); ++undo)
    {
        (*undo)();
    }

    this->undos_.clear();
}

void Transaction::undoWith(std::function<void()> undo)
{
    this->undos_.push_back(std::move(undo));
}

void Transaction::onItemDestroyed(CItem*)
{
}

auto Transaction::reversible() const -> bool
{
    return true;
}

auto Transaction::give(CCharEntity* PChar, const uint8 location, const uint16 itemId, const uint32 quantity, const Silence silence) -> std::optional<uint8>
{
    const uint8 slot = this->addItem(PChar, location, itemId, quantity, silence);
    if (slot == ERROR_SLOTID)
    {
        return std::nullopt;
    }

    this->undoWith([this, PChar, location, slot, quantity]()
                   {
                       if (!this->updateItem(PChar, location, slot, -static_cast<int32>(quantity)).applied)
                       {
                           ShowErrorFmt("Transaction: could not take back {} handed to {} in slot {}", quantity, PChar->getName(), slot);
                       }
                   });

    return slot;
}

auto Transaction::give(CCharEntity* PChar, const uint8 location, std::unique_ptr<CItem> item, const Silence silence) -> std::optional<uint8>
{
    if (!item)
    {
        return std::nullopt;
    }

    const uint32 quantity = item->getQuantity();

    const uint8 slot = this->addItem(PChar, location, std::move(item), silence);
    if (slot == ERROR_SLOTID)
    {
        return std::nullopt;
    }

    this->undoWith([this, PChar, location, slot, quantity]()
                   {
                       if (!this->updateItem(PChar, location, slot, -static_cast<int32>(quantity)).applied)
                       {
                           ShowErrorFmt("Transaction: could not take back {} handed to {} in slot {}", quantity, PChar->getName(), slot);
                       }
                   });

    return slot;
}

auto Transaction::take(CCharEntity* PChar, const uint8 location, const uint8 slot, const uint32 quantity) -> bool
{
    CItem* PItem = PChar->getStorage(location)->GetItem(slot);
    if (!PItem || PItem->getQuantity() < quantity)
    {
        return false;
    }

    // A stack about to vanish is copied first, so putting it back keeps exdata, signature and augments
    std::unique_ptr<CItem> restore;
    if (PItem->getQuantity() == quantity)
    {
        restore = xi::items::clone(*PItem);
    }

    auto mutation = this->updateItem(PChar, location, slot, -static_cast<int32>(quantity));
    if (!mutation.applied)
    {
        return false;
    }

    // Reported while the stack is still alive, so nobody is handed a pointer that has already gone
    if (mutation.removed)
    {
        this->onItemDestroyed(mutation.removed.get());
    }

    if (!restore)
    {
        this->undoWith([this, PChar, location, slot, quantity]()
                       {
                           if (!this->updateItem(PChar, location, slot, static_cast<int32>(quantity)).applied)
                           {
                               ShowErrorFmt("Transaction: could not put {} back for {} in slot {}", quantity, PChar->getName(), slot);
                           }
                       });

        return true;
    }

    restore->setQuantity(quantity);

    this->undoWith([this, PChar, location, kept = std::shared_ptr<CItem>(std::move(restore))]()
                   {
                       auto returned = xi::items::clone(*kept);
                       if (!returned)
                       {
                           ShowErrorFmt("Transaction: could not give {} back to {}", kept->getID(), PChar->getName());
                           return;
                       }

                       if (this->addItem(PChar, location, std::move(returned)) == ERROR_SLOTID)
                       {
                           ShowErrorFmt("Transaction: {} has nowhere to put {} back", PChar->getName(), kept->getID());
                       }
                   });

    return true;
}

auto Transaction::pay(CCharEntity* PChar, const uint32 gil) -> bool
{
    return this->take(PChar, LOC_INVENTORY, 0, gil);
}

auto Transaction::earn(CCharEntity* PChar, const uint32 gil) -> bool
{
    if (!this->updateItem(PChar, LOC_INVENTORY, 0, static_cast<int32>(gil)).applied)
    {
        return false;
    }

    this->undoWith([this, PChar, gil]()
                   {
                       if (!this->updateItem(PChar, LOC_INVENTORY, 0, -static_cast<int32>(gil)).applied)
                       {
                           ShowErrorFmt("Transaction: could not take back {} gil from {}", gil, PChar->getName());
                       }
                   });

    return true;
}

void Transaction::rollbackIfOpen()
{
    if (this->state_ == TransactionState::Open)
    {
        this->rollback();
    }
}

auto Transaction::enterTx(CItem* item) -> bool
{
    return xi::items::detail::ItemAccess::enterTransaction(item, xi::Badge<Transaction>{});
}

auto Transaction::updateItem(CCharEntity* PChar, const uint8 locationId, const uint8 slotId, const int32 quantity) -> ItemMutation
{
    return applyItemUpdate(PChar, locationId, slotId, quantity, this);
}

auto Transaction::addItem(CCharEntity* PChar, const uint8 locationId, std::unique_ptr<CItem> item, const Silence silence) -> uint8
{
    return applyAddItem(PChar, locationId, std::move(item), silence, this);
}

auto Transaction::addItem(CCharEntity* PChar, const uint8 locationId, const uint16 itemId, const uint32 quantity, const Silence silence) -> uint8
{
    return applyAddItem(PChar, locationId, itemId, quantity, silence, this);
}

void Transaction::exitTx(CItem* item)
{
    xi::items::detail::ItemAccess::exitTransaction(item, xi::Badge<Transaction>{});
}
