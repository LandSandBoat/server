/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

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

#include "itemutils.h"

#include "map_engine.h"

#include <array>
#include <cstring>

#include "common/database.h"
#include "common/logging.h"

#include "entities/battleentity.h"
#include "enums/item_types.h"
#include "items/item_furnishing.h"
#include "items/item_general.h"
#include "items/item_linkshell.h"
#include "items/item_puppet.h"
#include "lua/luautils.h"

std::array<CItem*, MAX_ITEMID>      g_pItemList; // global array of pointers to game items
std::array<DropList_t*, MAX_DROPID> g_pDropList; // global array of monster droplist items
std::array<LootList_t*, MAX_LOOTID> g_pLootList; // global array of BCNM lootlist items

CItemWeapon* PUnarmedItem;
CItemWeapon* PUnarmedH2HItem;

DropItem_t::DropItem_t(uint8 DropType, uint16 ItemID, uint16 DropRate)
: DropType(DropType)
, ItemID(ItemID)
, DropRate(DropRate)
, hasFixedRate(false)
{
}

DropItem_t::DropItem_t(uint8 DropType, uint16 ItemID, uint16 DropRate, bool hasFixedRate)
: DropType(DropType)
, ItemID(ItemID)
, DropRate(DropRate)
, hasFixedRate(hasFixedRate)
{
}

DropGroup_t::DropGroup_t(uint16 GroupRate)
: GroupRate(GroupRate)
, hasFixedRate(false)
{
}

DropGroup_t::DropGroup_t(uint16 GroupRate, bool hasFixedRate)
: GroupRate(GroupRate)
, hasFixedRate(hasFixedRate)
{
}

LootContainer::LootContainer(DropList_t* dropList)
: dropList(dropList)
{
}

void LootContainer::ForEachGroup(const std::function<void(const DropGroup_t&)>& func)
{
    for (const auto& group : dropList->Groups)
    {
        func(group);
    }

    for (const auto& group : drops.Groups)
    {
        func(group);
    }
}

void LootContainer::ForEachItem(const std::function<void(const DropItem_t&)>& func)
{
    for (const auto& item : dropList->Items)
    {
        func(item);
    }

    for (const auto& item : drops.Items)
    {
        func(item);
    }
}

/************************************************************************
 *                                                                       *
 *  Actually methods of working with a global collection of items        *
 *                                                                       *
 ************************************************************************/

namespace itemutils
{

/************************************************************************
 *                                                                       *
 *  Create an empty instance of the item by ID (private method)          *
 *                                                                       *
 ************************************************************************/

CItem* CreateItem(const uint16 itemId, const ItemType itemType)
{
    switch (itemType)
    {
        case ItemType::General:
            return new CItemGeneral(itemId);
        case ItemType::Linkshell:
            return new CItemLinkshell(itemId);
        case ItemType::Furnishing:
            return new CItemFurnishing(itemId);
        case ItemType::Puppet:
            return new CItemPuppet(itemId);
        case ItemType::Usable:
            return new CItemUsable(itemId);
        case ItemType::Equipment:
            return new CItemEquipment(itemId);
        case ItemType::Weapon:
            return new CItemWeapon(itemId);
        case ItemType::Currency:
            return new CItemCurrency(itemId);
        default:
        {
            ShowErrorFmt("CreateItem({}): Unknown item type {}", itemId, static_cast<uint8>(itemType));
            return new CItemGeneral(itemId);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  Create a new copy of the item ID                                     *
 *                                                                       *
 ************************************************************************/

CItem* GetItem(const uint16 ItemID)
{
    if (ItemID == 0xFFFF)
    {
        return new CItemCurrency(ItemID);
    }

    if (ItemID < MAX_ITEMID && g_pItemList[ItemID] != nullptr)
    {
        return GetItem(g_pItemList[ItemID]);
    }

    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Create a copy of the item                                            *
 *                                                                       *
 ************************************************************************/

CItem* GetItem(CItem* PItem)
{
    if (PItem == nullptr)
    {
        ShowWarning("CItem::GetItem() - PItem is null.");
        return nullptr;
    }

    if (PItem->isType(ITEM_WEAPON))
    {
        return new CItemWeapon(*static_cast<CItemWeapon*>(PItem));
    }

    if (PItem->isType(ITEM_EQUIPMENT))
    {
        return new CItemEquipment(*static_cast<CItemEquipment*>(PItem));
    }

    if (PItem->isType(ITEM_USABLE))
    {
        return new CItemUsable(*static_cast<CItemUsable*>(PItem));
    }

    if (PItem->isType(ITEM_LINKSHELL))
    {
        return new CItemLinkshell(*static_cast<CItemLinkshell*>(PItem));
    }

    if (PItem->isType(ITEM_FURNISHING))
    {
        return new CItemFurnishing(*static_cast<CItemFurnishing*>(PItem));
    }

    if (PItem->isType(ITEM_PUPPET))
    {
        return new CItemPuppet(*static_cast<CItemPuppet*>(PItem));
    }

    if (PItem->isType(ITEM_GENERAL))
    {
        return new CItemGeneral(*static_cast<CItemGeneral*>(PItem));
    }

    if (PItem->isType(ITEM_CURRENCY))
    {
        return new CItemCurrency(*static_cast<CItemCurrency*>(PItem));
    }

    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Get a pointer to an item (read-only)                                 *
 *                                                                       *
 ************************************************************************/

CItem* GetItemPointer(uint16 ItemID)
{
    if (ItemID < MAX_ITEMID)
    {
        // False positive: this is CItem*, so it's OK
        // cppcheck-suppress CastIntegerToAddressAtReturn
        return g_pItemList[ItemID];
    }
    ShowWarning("ItemID %u too big", ItemID);
    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  True if pointer points to a read-only g_pItemList array item         *
 *                                                                       *
 ************************************************************************/

bool IsItemPointer(CItem* item)
{
    return g_pItemList[item->getID()] == item;
}

CItemWeapon* GetUnarmedItem()
{
    return PUnarmedItem;
}

CItemWeapon* GetUnarmedH2HItem()
{
    return PUnarmedH2HItem;
}

/************************************************************************
 *                                                                       *
 *  Get the monsters item drop list                                      *
 *                                                                       *
 ************************************************************************/

DropList_t* GetDropList(uint16 DropID)
{
    if (DropID < MAX_DROPID)
    {
        // False positive: this is DropList_t*, so it's OK
        // cppcheck-suppress CastIntegerToAddressAtReturn
        return g_pDropList[DropID];
    }
    ShowWarning("DropID %u too big", DropID);
    return nullptr;
}

/************************************************************************
 *                                                                       *
 *  Load the items                                                       *
 *                                                                       *
 ************************************************************************/

void LoadItemList()
{
    auto rset = db::preparedStmt("SELECT "
                                 "b.itemId,b.name,b.type,b.stackSize,b.flags,"
                                 "b.aH,b.BaseSell,b.subid,"
                                 "u.validTargets,u.activation,u.animation,u.animationTime,"
                                 "u.maxCharges,u.useDelay,u.reuseDelay,u.aoe,"
                                 "a.level,a.ilevel,a.jobs,a.MId,"
                                 "a.shieldSize,a.scriptType,a.slot,a.rslot,"
                                 "a.su_level,a.rslotlook,"
                                 "w.skill,w.subskill,w.ilvl_skill,w.ilvl_parry,"
                                 "w.ilvl_macc,w.delay,w.dmg,w.dmgType,"
                                 "w.hit,w.unlock_points,"
                                 "f.storage,f.moghancement,f.element,f.aura,"
                                 "p.slot AS pup_slot,p.element AS pup_element "
                                 "FROM item_basic AS b "
                                 "LEFT JOIN item_usable AS u USING (itemId) "
                                 "LEFT JOIN item_equipment  AS a USING (itemId) "
                                 "LEFT JOIN item_weapon AS w USING (itemId) "
                                 "LEFT JOIN item_furnishing AS f USING (itemId) "
                                 "LEFT JOIN item_puppet AS p USING (itemId) "
                                 "WHERE itemId < ?",
                                 MAX_ITEMID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        CItem* PItem = CreateItem(rset->get<uint16>("itemId"), rset->get<ItemType>("type"));

        if (PItem != nullptr)
        {
            PItem->setName(rset->get<std::string>("name"));
            PItem->setStackSize(rset->get<uint32>("stackSize"));
            PItem->setFlag(rset->get<uint16>("flags"));
            PItem->setAHCat(rset->get<uint8>("aH"));
            PItem->setBasePrice(rset->get<uint32>("BaseSell"));
            PItem->setSubID(rset->get<uint16>("subid"));

            if (PItem->isType(ITEM_GENERAL))
            {
                // TODO
            }

            // For some reason weapons and equipments always match ITEM_USABLE even when they aren't usable
            // The 2nd condition ensures we only load usable data for items that are purely usable or
            // equipment/weapons that are also usable (have validTargets set)
            if (PItem->isType(ITEM_USABLE) &&
                (!(PItem->isType(ITEM_EQUIPMENT) || PItem->isType(ITEM_WEAPON)) || !rset->isNull("validTargets")))
            {
                static_cast<CItemUsable*>(PItem)->setValidTarget(rset->get<uint16>("validTargets"));
                static_cast<CItemUsable*>(PItem)->setActivationTime(std::chrono::seconds(rset->get<uint32>("activation")));
                static_cast<CItemUsable*>(PItem)->setAnimationID(rset->get<uint16>("animation"));
                static_cast<CItemUsable*>(PItem)->setAnimationTime(std::chrono::seconds(rset->get<uint32>("animationTime")));
                static_cast<CItemUsable*>(PItem)->setMaxCharges(rset->get<uint8>("maxCharges"));
                static_cast<CItemUsable*>(PItem)->setCurrentCharges(rset->get<uint8>("maxCharges"));
                static_cast<CItemUsable*>(PItem)->setUseDelay(std::chrono::seconds(rset->get<uint32>("useDelay")));
                static_cast<CItemUsable*>(PItem)->setReuseDelay(std::chrono::seconds(rset->get<uint32>("reuseDelay")));
                static_cast<CItemUsable*>(PItem)->setAoE(rset->get<uint16>("aoe"));
            }

            if (PItem->isType(ITEM_PUPPET))
            {
                static_cast<CItemPuppet*>(PItem)->setEquipSlot(rset->get<uint32>("pup_slot"));
                static_cast<CItemPuppet*>(PItem)->setElementSlots(rset->get<uint32>("pup_element"));

                // If this is a PUP attachment, load the appropriate script as well
                auto attachmentFile = fmt::format("./scripts/actions/abilities/pets/attachments/{}.lua", PItem->getName());
                luautils::CacheLuaObjectFromFile(attachmentFile);
            }

            if (PItem->isType(ITEM_EQUIPMENT))
            {
                static_cast<CItemEquipment*>(PItem)->setReqLvl(rset->get<uint8>("level"));
                static_cast<CItemEquipment*>(PItem)->setILvl(rset->get<uint8>("ilevel"));
                static_cast<CItemEquipment*>(PItem)->setJobs(rset->get<uint32>("jobs"));
                static_cast<CItemEquipment*>(PItem)->setModelId(rset->get<uint32>("MId"));
                static_cast<CItemEquipment*>(PItem)->setShieldSize(rset->get<uint8>("shieldSize"));
                static_cast<CItemEquipment*>(PItem)->setScriptType(rset->get<uint16>("scriptType"));
                static_cast<CItemEquipment*>(PItem)->setEquipSlotId(rset->get<uint16>("slot"));
                static_cast<CItemEquipment*>(PItem)->setRemoveSlotId(rset->get<uint16>("rslot"));
                static_cast<CItemEquipment*>(PItem)->setRemoveSlotLookId(rset->get<uint16>("rslotlook"));
                static_cast<CItemEquipment*>(PItem)->setSuperiorLevel(rset->get<uint8>("su_level"));

                if (static_cast<CItemEquipment*>(PItem)->getValidTarget() != 0)
                {
                    PItem->setSubType(ITEM_CHARGED);
                }
            }

            if (PItem->isType(ITEM_WEAPON))
            {
                static_cast<CItemWeapon*>(PItem)->setSkillType(rset->get<uint8>("skill"));
                static_cast<CItemWeapon*>(PItem)->setSubSkillType(rset->get<uint8>("subskill"));
                static_cast<CItemWeapon*>(PItem)->setILvlSkill(rset->get<uint16>("ilvl_skill"));
                static_cast<CItemWeapon*>(PItem)->setILvlParry(rset->get<uint16>("ilvl_parry"));
                static_cast<CItemWeapon*>(PItem)->setILvlMacc(rset->get<uint16>("ilvl_macc"));
                static_cast<CItemWeapon*>(PItem)->setBaseDelay(rset->get<uint16>("delay"));
                static_cast<CItemWeapon*>(PItem)->setDelay((rset->get<uint16>("delay") * 1000) / 60);
                static_cast<CItemWeapon*>(PItem)->setDamage(rset->get<uint16>("dmg"));
                static_cast<CItemWeapon*>(PItem)->setDmgType(rset->get<DAMAGE_TYPE>("dmgType"));
                static_cast<CItemWeapon*>(PItem)->setMaxHit(rset->get<uint8>("hit"));
                static_cast<CItemWeapon*>(PItem)->setTotalUnlockPointsNeeded(rset->get<uint16>("unlock_points"));

                int        dmg   = rset->get<uint16>("dmg");
                int        delay = rset->get<uint16>("delay");
                const bool isH2H = static_cast<CItemWeapon*>(PItem)->getSkillType() == SKILL_HAND_TO_HAND;

                if ((dmg > 0 || isH2H) && delay > 0) // avoid division by zero for items not yet implemented. Zero dmg h2h weapons don't actually have zero dmg for the purposes of DPS.
                {
                    if (isH2H)
                    {
                        delay -= 240; // base h2h delay per fist is 240 when used in DPS calculation. We store Delay in the database as Weapon Delay+(240*2).
                        dmg += 3;     // add 3 base damage for DPS calculation. This base damage addition appears to come from "base" h2h damage of 3.
                                      // See Ninzas +2 in polutils/bg wiki: https://www.bg-wiki.com/ffxi/Ninzas_%2B2
                                      // The DPS field is in the DAT itself and is calculated by SE as follows:
                                      // ((104+3)*60)/(81+240) = 20
                    }

                    // calculate DPS
                    double dps = (dmg * 60.0) / delay;

                    // SE seems to round at the second decimal place, see Machine Crossbow, Falcata .DAT DPS values for rounding up and down respectively.
                    // https://www.bg-wiki.com/ffxi/Falcata, https://www.bg-wiki.com/ffxi/Machine_Crossbow
                    dps = round(dps * 100) / 100;

                    static_cast<CItemWeapon*>(PItem)->setDPS(dps);
                }
            }

            if (PItem->isType(ITEM_FURNISHING))
            {
                static_cast<CItemFurnishing*>(PItem)->setStorage(rset->get<uint8>("storage"));
                static_cast<CItemFurnishing*>(PItem)->setMoghancement(rset->get<uint16>("moghancement"));
                static_cast<CItemFurnishing*>(PItem)->setElement(rset->get<uint8>("element"));
                static_cast<CItemFurnishing*>(PItem)->setAura(rset->get<uint8>("aura"));
            }

            g_pItemList[PItem->getID()] = PItem;

            auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());
            luautils::CacheLuaObjectFromFile(filename);
        }
    }

    rset = db::preparedStmt("SELECT itemId, modId, value "
                            "FROM item_mods "
                            "WHERE itemId IN "
                            "(SELECT itemId FROM item_basic LEFT JOIN item_equipment USING (itemId))");
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto ItemID = rset->get<uint16>("itemId");
        const auto modID  = rset->get<Mod>("modId");
        const auto value  = rset->get<int16>("value");

        if ((g_pItemList[ItemID] != nullptr) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
        {
            static_cast<CItemEquipment*>(g_pItemList[ItemID])->addModifier(CModifier(modID, value));
        }
    }

    rset = db::preparedStmt("SELECT itemId, modId, value, petType "
                            "FROM item_mods_pet "
                            "WHERE itemId IN "
                            "(SELECT itemId FROM item_basic LEFT JOIN item_equipment USING (itemId))");
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto ItemID  = rset->get<uint16>("itemId");
        const auto modID   = rset->get<Mod>("modId");
        const auto value   = rset->get<int16>("value");
        const auto petType = rset->get<PetModType>("petType");

        if ((g_pItemList[ItemID]) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
        {
            static_cast<CItemEquipment*>(g_pItemList[ItemID])->addPetModifier(CPetModifier(modID, petType, value));
        }
    }

    rset = db::preparedStmt("SELECT itemId, modId, value, latentId, latentParam "
                            "FROM item_latents "
                            "WHERE itemId IN "
                            "(SELECT itemId FROM item_basic LEFT JOIN item_equipment USING (itemId))");
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto ItemID      = rset->get<uint16>("itemId");
        const auto modID       = rset->get<Mod>("modId");
        const auto value       = rset->get<int16>("value");
        const auto latentId    = rset->get<LATENT>("latentId");
        const auto latentParam = rset->get<uint16>("latentParam");

        if ((g_pItemList[ItemID] != nullptr) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
        {
            static_cast<CItemEquipment*>(g_pItemList[ItemID])->addLatent(latentId, latentParam, modID, value);
        }
    }
}

/************************************************************************
 *                                                                       *
 *  load lists of items monsters drop                                    *
 *                                                                       *
 ************************************************************************/

void LoadDropList()
{
    const auto rset = db::preparedStmt("SELECT dropId, itemId, dropType, itemRate, groupId, groupRate "
                                       "FROM mob_droplist WHERE dropid < ?",
                                       MAX_DROPID);
    FOR_DB_MULTIPLE_RESULTS(rset)
    {
        const auto DropID = rset->get<uint16>("dropId");

        if (g_pDropList[DropID] == nullptr)
        {
            g_pDropList[DropID] = new DropList_t;
        }

        DropList_t* dropList = g_pDropList[DropID];

        auto ItemID   = rset->get<uint16>("itemId");
        auto DropType = rset->get<uint8>("dropType");
        auto DropRate = rset->get<uint16>("itemRate");

        if (DropType == DROP_GROUPED)
        {
            const auto GroupId   = rset->get<uint8>("groupId");
            auto       GroupRate = rset->get<uint16>("groupRate");
            while (GroupId > dropList->Groups.size())
            {
                dropList->Groups.emplace_back(GroupRate);
            }
            dropList->Groups[GroupId - 1].GroupRate = GroupRate; // a bit redundant but it prevents any ordering issues.
            dropList->Groups[GroupId - 1].Items.emplace_back(DropType, ItemID, DropRate);
        }
        else
        {
            dropList->Items.emplace_back(DropType, ItemID, DropRate);
        }
    }

    // Populate 0 drop list with an empty list to support mobs that only drop loot through script logic
    g_pDropList[0] = new DropList_t;
}

/************************************************************************
 *                                                                       *
 *  Handles loot from NPCs that drop things into                         *
 *  the loot pool instead of adding them directly to the inventory       *
 *                                                                       *
 ************************************************************************/

void LoadLootList()
{
}

/************************************************************************
 *                                                                       *
 *  Initialization of the  game objects                                  *
 *                                                                       *
 ************************************************************************/

void Initialize()
{
    TracyZoneScoped;
    LoadItemList();
    LoadDropList();
    LoadLootList();

    PUnarmedItem = new CItemWeapon(0);

    PUnarmedItem->setDmgType(DAMAGE_TYPE::NONE);
    PUnarmedItem->setSkillType(SKILL_NONE);
    PUnarmedItem->setDamage(3);

    PUnarmedH2HItem = new CItemWeapon(0);

    PUnarmedH2HItem->setDmgType(DAMAGE_TYPE::HTH);
    PUnarmedH2HItem->setSkillType(SKILL_HAND_TO_HAND);
    PUnarmedH2HItem->setDamage(0);
}

/************************************************************************
 *                                                                       *
 *  Release the list of items                                            *
 *                                                                       *
 ************************************************************************/

void FreeItemList()
{
    for (int32 ItemID = 0; ItemID < MAX_ITEMID; ++ItemID)
    {
        destroy(g_pItemList[ItemID]);
        g_pItemList[ItemID] = nullptr;
    }

    for (int32 DropID = 0; DropID < MAX_DROPID; ++DropID)
    {
        destroy(g_pDropList[DropID]);
        g_pDropList[DropID] = nullptr;
    }
}

}; // namespace itemutils
