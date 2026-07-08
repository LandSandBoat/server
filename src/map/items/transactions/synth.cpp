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

#include "synth.h"

#include "common/logging.h"

#include "entities/char_entity.h"
#include "enums/item_flag.h"
#include "enums/item_lockflg.h"
#include "item_container.h"
#include "items/item.h"
#include "packets/s2c/0x01d_item_same.h"
#include "packets/s2c/0x01f_item_list.h"
#include "packets/s2c/0x020_item_attr.h"
#include "utils/charutils.h"

SynthTransaction::SynthTransaction(xi::Badge<SynthTransaction>, CCharEntity* player)
: player_(player)
{
}

SynthTransaction::~SynthTransaction()
{
    this->rollbackIfOpen();
}

auto SynthTransaction::start(CCharEntity* player, const SynthOffer& offer) -> std::unique_ptr<SynthTransaction>
{
    if (!player)
    {
        ShowWarningFmt("SynthTransaction::start: null player");
        return nullptr;
    }

    const auto* container = player->getStorage(LOC_INVENTORY);
    if (!container || offer.crystal.invSlot == 0xFF)
    {
        ShowWarningFmt("SynthTransaction::start: {} has no inventory or invalid crystal slot ({})",
                       player->getName(),
                       offer.crystal.invSlot);
        return nullptr;
    }

    auto transaction = std::unique_ptr<SynthTransaction>(new SynthTransaction(xi::Badge<SynthTransaction>{}, player));

    auto* crystalItem = container->GetItem(offer.crystal.invSlot);
    if (!crystalItem || !transaction->claim(crystalItem))
    {
        ShowWarningFmt("SynthTransaction::start: {} could not claim crystal {} at slot {}",
                       player->getName(),
                       offer.crystal.itemId,
                       offer.crystal.invSlot);
        return nullptr;
    }

    transaction->slots_[0] = Slot{ crystalItem, offer.crystal.itemId, offer.crystal.invSlot, false };

    for (size_t i = 0; i < offer.ingredients.size(); ++i)
    {
        const auto& ing = offer.ingredients[i];
        if (ing.invSlot == 0xFF)
        {
            continue;
        }

        if (ing.invSlot == offer.crystal.invSlot)
        {
            ShowWarningFmt("SynthTransaction::start: {} ingredient entry {} aliases crystal slot {}",
                           player->getName(),
                           i,
                           ing.invSlot);
            transaction->releaseAllClaims();
            return nullptr;
        }

        auto* item = container->GetItem(ing.invSlot);
        if (!item)
        {
            continue;
        }

        if (!transaction->holds(item) && !transaction->claim(item))
        {
            ShowWarningFmt("SynthTransaction::start: {} could not claim ingredient {} at slot {} (entry {})",
                           player->getName(),
                           ing.itemId,
                           ing.invSlot,
                           i);
            // If we can't start the transaction, release all already locked items to owner.
            transaction->releaseAllClaims();
            return nullptr;
        }

        transaction->slots_[i + 1] = Slot{ .item = item, .itemId = ing.itemId, .invSlot = ing.invSlot, .saved = false };
    }

    return transaction;
}

auto SynthTransaction::holds(const CItem* item) const -> bool
{
    if (!item)
    {
        return false;
    }

    for (const auto& s : this->slots_)
    {
        if (s.item == item)
        {
            return true;
        }
    }

    return false;
}

// Crystal is always consumed/rendered early
void SynthTransaction::consumeCrystal()
{
    auto& slot = this->slots_[0];
    if (!slot.item)
    {
        return;
    }

    exitTx(slot.item);
    slot.item->setSubType(ITEM_UNLOCKED);
    charutils::UpdateItem(this->player_, LOC_INVENTORY, slot.invSlot, -1);
    slot.item = nullptr;
}

void SynthTransaction::markSaved(const uint8 ingredientIdx)
{
    this->slots_[ingredientIdx + 1].saved = true;
}

void SynthTransaction::setResultDelivery(const CCraftState::Result result)
{
    pendingResult_ = result;
}

// Synthesis is complete: consume all ingredients not explicitly saved and deliver result
auto SynthTransaction::doCommit() -> bool
{
    std::array<uint8, MAX_CONTAINER_SIZE> consumePerSlot{};
    for (const auto& s : this->slots_)
    {
        if (s.item && !s.saved && s.invSlot < consumePerSlot.size())
        {
            consumePerSlot[s.invSlot] += 1;
        }
    }

    // Release all items so subsequent UpdateItem can modify them
    this->releaseAllClaims();

    for (size_t s = 0; s < consumePerSlot.size(); ++s)
    {
        const uint8 toConsume = consumePerSlot[s];
        if (toConsume > 0)
        {
            charutils::UpdateItem(this->player_, LOC_INVENTORY, static_cast<uint8>(s), -static_cast<int32>(toConsume));
        }
    }

    if (pendingResult_)
    {
        const uint8 resultSlot = charutils::AddItem(this->player_, LOC_INVENTORY, pendingResult_->itemId, pendingResult_->qty);
        if (resultSlot != ERROR_SLOTID)
        {
            CItem* PItem = this->player_->getStorage(LOC_INVENTORY)->GetItem(resultSlot);
            if (PItem && PItem->hasFlag(ItemFlag::Inscribable) && this->slots_[0].itemId > 0x1080)
            {
                PItem->setSignature(this->player_->name);
                db::preparedStmt("UPDATE char_inventory SET signature = ? WHERE charid = ? AND location = 0 AND slot = ? LIMIT 1",
                                 this->player_->name,
                                 this->player_->id,
                                 resultSlot);
            }
            this->player_->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, LOC_INVENTORY, resultSlot);
        }

        this->player_->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(this->player_);
    }

    return true;
}

// Synth rollbacks LOSE EVERYTHING on purpose.
// Drop any pending result so an accidental rollback never delivers an item.
void SynthTransaction::doRollback()
{
    this->pendingResult_.reset();
    std::ignore = doCommit();
}

// Lock the item and notify client
auto SynthTransaction::claim(CItem* item) const -> bool
{
    if (!item || !enterTx(item))
    {
        return false;
    }

    this->player_->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(item, ItemLockFlg::NoSelect);
    return true;
}

void SynthTransaction::releaseAllClaims()
{
    for (size_t i = 0; i < this->slots_.size(); ++i)
    {
        auto* item = this->slots_[i].item;
        if (!item)
        {
            continue;
        }

        bool seen = false;
        for (size_t j = 0; j < i; ++j)
        {
            if (this->slots_[j].item == item)
            {
                seen = true;
                break;
            }
        }

        if (!seen)
        {
            exitTx(item);
            item->setSubType(ITEM_UNLOCKED);
            this->player_->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(item, ItemLockFlg::Normal);
        }

        this->slots_[i].item = nullptr;
    }
}
