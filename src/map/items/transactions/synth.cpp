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

namespace
{

// unlocks the ingredients that are still claimed
void unlockAll(CCharEntity* PChar, const std::vector<ItemId>& claims)
{
    for (const auto& claimed : claims)
    {
        if (auto* PItem = claimed.resolve())
        {
            PChar->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(PItem, ItemLockFlg::Normal);
        }
    }
}

} // namespace

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

    // clears the slots so the rollback in the destructor consumes nothing. reversible() is false, so without this a refused start would still charge the ingredients
    const auto abandon = [&transaction]() -> std::unique_ptr<SynthTransaction>
    {
        transaction->slots_ = {};

        return nullptr;
    };

    auto* crystalItem = container->GetItem(offer.crystal.invSlot);

    const auto crystalClaim = transaction->claimAndLock(crystalItem);
    if (!crystalClaim.isSet())
    {
        ShowWarningFmt("SynthTransaction::start: {} could not claim crystal {} at slot {}",
                       player->getName(),
                       offer.crystal.itemId,
                       offer.crystal.invSlot);
        return abandon();
    }

    transaction->slots_[0] = Slot{ .claimed = crystalClaim, .itemId = offer.crystal.itemId, .saved = false };

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
            return abandon();
        }

        auto* item = container->GetItem(ing.invSlot);
        if (!item)
        {
            continue;
        }

        const auto claimed = transaction->claimAndLock(item);
        if (!claimed.isSet())
        {
            ShowWarningFmt("SynthTransaction::start: {} could not claim ingredient {} at slot {} (entry {})",
                           player->getName(),
                           ing.itemId,
                           ing.invSlot,
                           i);
            return abandon();
        }

        transaction->slots_[i + 1] = Slot{ .claimed = claimed, .itemId = ing.itemId, .saved = false };
    }

    return transaction;
}

// Crystal is always consumed/rendered early
void SynthTransaction::consumeCrystal()
{
    auto& slot = this->slots_[0];
    if (!slot.claimed.isSet())
    {
        return;
    }

    const auto crystalSlot = slot.claimed.slot;

    if (!slot.claimed.resolve() || !Transaction::take(this->player_, LOC_INVENTORY, crystalSlot, 1))
    {
        ShowErrorFmt("SynthTransaction: {} kept the crystal in slot {}", this->player_->getName(), crystalSlot);
    }
    else
    {
        // only one crystal is used, so the rest of the stack goes back to the player now
        this->release(slot.claimed);
    }

    slot.claimed.clean();
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
        if (s.claimed.resolve() && !s.saved && s.claimed.slot < consumePerSlot.size())
        {
            consumePerSlot[s.claimed.slot] += 1;
        }
    }

    for (size_t s = 0; s < consumePerSlot.size(); ++s)
    {
        const uint8 toConsume = consumePerSlot[s];
        if (toConsume == 0)
        {
            continue;
        }

        if (!Transaction::take(this->player_, LOC_INVENTORY, static_cast<uint8>(s), toConsume))
        {
            ShowErrorFmt("SynthTransaction: {} kept {} of the ingredient in slot {}", this->player_->getName(), toConsume, s);
        }
    }

    unlockAll(this->player_, this->claims());

    if (pendingResult_)
    {
        const auto resultSlot = this->give(this->player_, LOC_INVENTORY, pendingResult_->itemId, pendingResult_->qty);
        if (!resultSlot)
        {
            ShowErrorFmt("SynthTransaction: {} had no room for result {}, the ingredients are already spent", this->player_->getName(), pendingResult_->itemId);
        }
        else
        {
            CItem* PItem = this->player_->getStorage(LOC_INVENTORY)->GetItem(*resultSlot);
            if (PItem && PItem->hasFlag(ItemFlag::Inscribable) && this->slots_[0].itemId > 0x1080)
            {
                PItem->setSignature(this->player_->name);
                db::preparedStmt("UPDATE char_inventory SET signature = ? WHERE charid = ? AND location = 0 AND slot = ? LIMIT 1",
                                 this->player_->name,
                                 this->player_->id,
                                 *resultSlot);
            }
            this->player_->pushPacket<GP_SERV_COMMAND_ITEM_ATTR>(PItem, LOC_INVENTORY, *resultSlot);
        }

        this->player_->pushPacket<GP_SERV_COMMAND_ITEM_SAME>(this->player_);
    }

    return true;
}

// Synth rollbacks LOSE EVERYTHING on purpose: the ingredients are spent the moment the synth starts, so disconnecting mid-craft must not hand them back
auto SynthTransaction::reversible() const -> bool
{
    return false;
}

void SynthTransaction::doRollback()
{
    this->pendingResult_.reset();
    std::ignore = doCommit();
}

// the client greys out an ingredient for as long as the synth holds it
auto SynthTransaction::claimAndLock(CItem* item) -> ItemId
{
    // a recipe can draw several units from one stack, and the client only needs one lock packet
    const bool alreadyHeld = this->holds(item);

    const auto claimed = this->claim(this->player_, item);
    if (claimed.isSet() && !alreadyHeld)
    {
        this->player_->pushPacket<GP_SERV_COMMAND_ITEM_LIST>(item, ItemLockFlg::NoSelect);
    }

    return claimed;
}
