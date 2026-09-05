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

namespace
{

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

    if (static_cast<int32>(PItem->getQuantity() + quantity) < 0)
    {
        ShowDebug("UpdateItem: %s trying to move invalid quantity %u of itemID %u", PChar->getName(), quantity, ItemID);
        return {};
    }

    const bool heldByOwner = owner != nullptr && owner->holds(PItem);

    auto* PState = dynamic_cast<CItemState*>(PChar->PAI->GetCurrentState());
    if (PState && !heldByOwner)
    {
        const CItem* item = PState->GetItem();

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

    const uint32           oldQuantity = PItem->getQuantity();
    uint32                 newQuantity = oldQuantity + quantity;
    std::unique_ptr<CItem> removed;

    if (newQuantity > PItem->getStackSize())
    {
        newQuantity = PItem->getStackSize();

        ShowWarningFmt("UpdateItem: {} could only take {} of the {} added to item {}, the stack is full",
                       PChar->getName(),
                       newQuantity - oldQuantity,
                       quantity,
                       ItemID);
    }

    if (newQuantity > 0 || PItem->isType(ITEM_CURRENCY))
    {
        // the row goes first: reporting applied on a failed write would let the caller hand out a reward for a stack the database still holds
        if (!db::preparedStmt("UPDATE char_inventory "
                              "SET quantity = ? "
                              "WHERE charid = ? AND location = ? AND slot = ?",
                              newQuantity,
                              PChar->id,
                              LocationID,
                              slotID))
        {
            ShowErrorFmt("UpdateItem: could not write quantity {} of item {} for {}", newQuantity, ItemID, PChar->getName());

            return {};
        }

        PItem->setQuantity(newQuantity);
        PChar->pushPacket<GP_SERV_COMMAND_ITEM_NUM>(static_cast<CONTAINER_ID>(LocationID), slotID, newQuantity);
    }
    else if (newQuantity == 0)
    {
        if (!db::preparedStmt("DELETE FROM char_inventory "
                              "WHERE charid = ? AND location = ? AND slot = ?",
                              PChar->id,
                              LocationID,
                              slotID))
        {
            ShowErrorFmt("UpdateItem: could not delete item {} for {}", ItemID, PChar->getName());

            return {};
        }

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
    return { .itemId = ItemID, .applied = true, .delta = static_cast<int32>(newQuantity) - static_cast<int32>(oldQuantity), .removed = std::move(removed) };
}

auto applyAddItem(CCharEntity* PChar, uint8 LocationID, std::unique_ptr<CItem> PItem, const Silence silence, const Transaction* owner, int32& applied) -> uint8
{
    applied = 0;

    if (PItem->isType(ITEM_CURRENCY))
    {
        // currency merges into slot 0 rather than taking a new slot, so it routes through updateItem
        const auto mutation = applyItemUpdate(PChar, LocationID, 0, PItem->getQuantity(), owner);
        if (!mutation.applied)
        {
            ShowErrorFmt("AddItem: could not give {} currency to {}", PItem->getQuantity(), PChar->getName());
            return ERROR_SLOTID;
        }

        applied = mutation.delta;

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

    const auto Query = "INSERT INTO char_inventory("
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

    applied = static_cast<int32>(PInserted->getQuantity());

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PInserted, static_cast<CONTAINER_ID>(LocationID), SlotID);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);

    return SlotID;
}

// Undos are recorded against a slot, so a stack that returned to a different one would strand every undo still pointing at the original
auto restoreItem(CCharEntity* PChar, uint8 LocationID, uint8 SlotID, std::unique_ptr<CItem> PItem, const Transaction* owner) -> uint8
{
    auto* PStorage = PChar->getStorage(LocationID);

    if (PStorage == nullptr || PStorage->GetItem(SlotID) != nullptr)
    {
        ShowWarningFmt("RestoreItem: slot {} of {} is taken, putting item {} wherever it fits", SlotID, PChar->getName(), PItem->getID());

        int32 applied = 0;

        return applyAddItem(PChar, LocationID, std::move(PItem), Silence::No, owner, applied);
    }

    const uint32 quantity = PItem->getQuantity();

    if (PStorage->InsertItem(std::move(PItem), SlotID) == ERROR_SLOTID)
    {
        return ERROR_SLOTID;
    }

    auto* PRestored = PStorage->GetItem(SlotID);

    const auto Query = "INSERT INTO char_inventory(charid, location, slot, itemId, quantity, signature, extra) VALUES(?, ?, ?, ?, ?, ?, ?) LIMIT 1";

    if (!db::preparedStmt(Query, PChar->id, LocationID, SlotID, PRestored->getID(), quantity, PRestored->getSignature(), PRestored->m_extra))
    {
        ShowError("RestoreItem: Cannot insert item to database");
        PStorage->RemoveItem(SlotID);

        return ERROR_SLOTID;
    }

    PChar->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PRestored, static_cast<CONTAINER_ID>(LocationID), SlotID);
    PChar->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(PChar);

    return SlotID;
}

auto applyAddItem(CCharEntity* PChar, const uint8 LocationID, const uint16 ItemID, const uint32 quantity, const Silence silence, const Transaction* owner, int32& applied) -> uint8
{
    applied = 0;

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

    return applyAddItem(PChar, LocationID, std::move(PItem), silence, owner, applied);
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

    // doCommit runs with the claims still held, since its steps mutate what it claimed. A refusal keeps them for the rollback that follows
    if (!this->doCommit())
    {
        ShowWarningFmt("Transaction::commit: doCommit rejected for tx {}", this->id_);
        return false;
    }

    this->releaseAll();

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

    // undos run before the claims are dropped, since they mutate the same stacks
    if (this->reversible())
    {
        this->runUndos();
    }
    else
    {
        this->undos_.clear();
    }

    this->doRollback();
    this->releaseAll();
    this->state_ = TransactionState::RolledBack;
}

auto Transaction::claim(const CCharEntity* owner, CItem* item) -> ItemId
{
    if (!owner || !item)
    {
        return {};
    }

    // one entry per stack, so a single release is enough
    if (this->holds(item))
    {
        return ItemId(owner, item);
    }

    if (!enterTx(item))
    {
        return {};
    }

    this->claims_.emplace_back(owner, item);

    return this->claims_.back();
}

void Transaction::release(const ItemId& claimed)
{
    const auto entry = std::ranges::find(this->claims_, claimed);
    if (entry == this->claims_.end())
    {
        return;
    }

    // a stack consumed to nothing was freed with its container entry, so it no longer resolves
    if (auto* PItem = entry->resolve())
    {
        exitTx(PItem);
    }

    this->claims_.erase(entry);
}

void Transaction::releaseAll()
{
    for (const auto& claimed : this->claims_)
    {
        if (auto* PItem = claimed.resolve())
        {
            exitTx(PItem);
        }
    }

    this->claims_.clear();
}

auto Transaction::claims() const -> const std::vector<ItemId>&
{
    return this->claims_;
}

auto Transaction::holds(const CItem* item) const -> bool
{
    return std::ranges::any_of(this->claims_,
                               [item](const ItemId& claimed)
                               {
                                   return claimed == item;
                               });
}

void Transaction::runUndos()
{
    for (auto undo = this->undos_.rbegin(); undo != this->undos_.rend(); ++undo)
    {
        (*undo)();
    }

    this->undos_.clear();
    this->snapshots_.clear();
}

void Transaction::undoWith(std::function<void()> undo)
{
    this->undos_.push_back(std::move(undo));
}

auto Transaction::reversible() const -> bool
{
    return true;
}

// The undo takes back what landed rather than what was requested; the two differ when a stack hits its size limit
auto Transaction::recordGive(CCharEntity* PChar, const uint8 location, const uint8 slot, const int32 applied) -> std::optional<uint8>
{
    if (slot == ERROR_SLOTID)
    {
        return std::nullopt;
    }

    this->undoWith([this, PChar, location, slot, applied]()
                   {
                       if (!this->updateItem(PChar, location, slot, -applied).applied)
                       {
                           ShowErrorFmt("Transaction: could not take back {} handed to {} in slot {}", applied, PChar->getName(), slot);
                       }
                   });

    return slot;
}

auto Transaction::give(CCharEntity* PChar, const uint8 location, const uint16 itemId, const uint32 quantity, const Silence silence) -> std::optional<uint8>
{
    int32 applied = 0;

    const uint8 slot = applyAddItem(PChar, location, itemId, quantity, silence, this, applied);

    return this->recordGive(PChar, location, slot, applied);
}

auto Transaction::give(CCharEntity* PChar, const uint8 location, std::unique_ptr<CItem> item, const Silence silence) -> std::optional<uint8>
{
    if (!item)
    {
        return std::nullopt;
    }

    int32 applied = 0;

    const uint8 slot = applyAddItem(PChar, location, std::move(item), silence, this, applied);

    return this->recordGive(PChar, location, slot, applied);
}

auto Transaction::take(CCharEntity* PChar, const uint8 location, const uint8 slot, const uint32 quantity) -> bool
{
    const CItem* PItem = PChar->getStorage(location)->GetItem(slot);
    if (!PItem || PItem->getQuantity() < quantity)
    {
        return false;
    }

    // copied before it is freed so the undo can restore exdata, signature and augments
    std::unique_ptr<CItem> restore;
    if (PItem->getQuantity() == quantity)
    {
        restore = xi::items::clone(*PItem);
    }

    const auto mutation = this->updateItem(PChar, location, slot, -static_cast<int32>(quantity));
    if (!mutation.applied)
    {
        return false;
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

    // the transaction keeps the stack, so the undo carries an index rather than owning anything
    this->snapshots_.push_back(std::move(restore));

    const size_t snapshot = this->snapshots_.size() - 1;

    this->undoWith([this, PChar, location, slot, snapshot]()
                   {
                       const CItem* kept = this->snapshots_[snapshot].get();

                       auto returned = xi::items::clone(*kept);
                       if (!returned)
                       {
                           ShowErrorFmt("Transaction: could not give {} back to {}", kept->getID(), PChar->getName());
                           return;
                       }

                       if (restoreItem(PChar, location, slot, std::move(returned), this) == ERROR_SLOTID)
                       {
                           ShowErrorFmt("Transaction: {} has nowhere to put {} back", PChar->getName(), kept->getID());
                       }
                   });

    return true;
}

// Gil is claimed like any other stack, and stays held for the rest of the transaction
auto Transaction::claimGil(const CCharEntity* PChar) -> bool
{
    if (!PChar)
    {
        return false;
    }

    CItem* PGil = PChar->getStorage(LOC_INVENTORY)->GetItem(0);

    return PGil && PGil->isType(ITEM_CURRENCY) && this->claim(PChar, PGil).isSet();
}

auto Transaction::mergeInto(CCharEntity* PChar, const uint8 location, const uint8 slot, const uint32 quantity) -> bool
{
    const auto merged = this->updateItem(PChar, location, slot, static_cast<int32>(quantity));
    if (!merged.applied)
    {
        return false;
    }

    this->undoWith([this, PChar, location, slot, added = merged.delta]()
                   {
                       if (!this->updateItem(PChar, location, slot, -added).applied)
                       {
                           ShowErrorFmt("Transaction: could not unmerge {} from {} in slot {}", added, PChar->getName(), slot);
                       }
                   });

    // a merge clamped at the stack limit moved less than it was given, which the caller has to hear about
    return merged.delta == static_cast<int32>(quantity);
}

auto Transaction::pay(CCharEntity* PChar, const uint32 gil) -> bool
{
    return this->claimGil(PChar) && this->take(PChar, LOC_INVENTORY, 0, gil);
}

auto Transaction::earn(CCharEntity* PChar, const uint32 gil) -> bool
{
    if (!this->claimGil(PChar))
    {
        return false;
    }

    const auto earned = this->updateItem(PChar, LOC_INVENTORY, 0, static_cast<int32>(gil));
    if (!earned.applied)
    {
        return false;
    }

    this->undoWith([this, PChar, granted = earned.delta]()
                   {
                       if (!this->updateItem(PChar, LOC_INVENTORY, 0, -granted).applied)
                       {
                           ShowErrorFmt("Transaction: could not take back {} gil from {}", granted, PChar->getName());
                       }
                   });

    return earned.delta == static_cast<int32>(gil);
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

auto Transaction::updateItem(CCharEntity* PChar, const uint8 locationId, const uint8 slotId, const int32 quantity) const -> ItemMutation
{
    return applyItemUpdate(PChar, locationId, slotId, quantity, this);
}

void Transaction::exitTx(CItem* item)
{
    xi::items::detail::ItemAccess::exitTransaction(item, xi::Badge<Transaction>{});
}
