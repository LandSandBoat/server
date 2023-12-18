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

#include <array>
#include <cstring>

#include "entities/battleentity.h"
#include "itemutils.h"
#include "lua/luautils.h"
#include "map.h"

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

    CItem* CreateItem(uint16 ItemID)
    {
        if ((ItemID >= 0x0200) && (ItemID <= 0x0206))
        {
            return new CItemLinkshell(ItemID);
        }

        if ((ItemID >= 0x01D8) && (ItemID <= 0x0DFF))
        {
            return new CItemGeneral(ItemID);
        }

        if (ItemID <= 0x0FFF)
        {
            return new CItemFurnishing(ItemID);
        }

        if (ItemID <= 0x1FFF)
        {
            return new CItemUsable(ItemID);
        }

        if (ItemID <= 0x27FF)
        {
            return new CItemPuppet(ItemID);
        }

        if (ItemID <= 0x3FFF)
        {
            return new CItemEquipment(ItemID);
        }

        if (ItemID <= 0x5FFF)
        {
            return new CItemWeapon(ItemID);
        }

        if (ItemID <= 0x6FFF)
        {
            return new CItemEquipment(ItemID);
        }

        if (ItemID <= 0x7FFF)
        {
            return new CItemGeneral(ItemID);
        }

        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *  Create a new copy of the item ID                                     *
     *                                                                       *
     ************************************************************************/

    CItem* GetItem(uint16 ItemID)
    {
        if (ItemID == 0xFFFF)
        {
            return new CItemCurrency(ItemID);
        }

        if (ItemID < MAX_ITEMID && g_pItemList[ItemID] != nullptr)
        {
            if ((ItemID >= 0x0200) && (ItemID <= 0x0206))
            {
                return new CItemLinkshell(*((CItemLinkshell*)g_pItemList[ItemID]));
            }

            if ((ItemID >= 0x01D8) && (ItemID <= 0x0DFF))
            {
                return new CItemGeneral(*((CItemGeneral*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x0FFF)
            {
                return new CItemFurnishing(*((CItemFurnishing*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x1FFF)
            {
                return new CItemUsable(*((CItemUsable*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x27FF)
            {
                return new CItemPuppet(*((CItemPuppet*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x3FFF)
            {
                return new CItemEquipment(*((CItemEquipment*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x5FFF)
            {
                return new CItemWeapon(*((CItemWeapon*)g_pItemList[ItemID]));
            }

            if (ItemID <= 0x6FFF)
            {
                return new CItemEquipment(*((CItemEquipment*)g_pItemList[ItemID]));
            }

            return new CItemGeneral(*((CItemGeneral*)g_pItemList[ItemID]));
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
            return new CItemWeapon(*((CItemWeapon*)PItem));
        }

        if (PItem->isType(ITEM_EQUIPMENT))
        {
            return new CItemEquipment(*((CItemEquipment*)PItem));
        }

        if (PItem->isType(ITEM_USABLE))
        {
            return new CItemUsable(*((CItemUsable*)PItem));
        }

        if (PItem->isType(ITEM_LINKSHELL))
        {
            return new CItemLinkshell(*((CItemLinkshell*)PItem));
        }

        if (PItem->isType(ITEM_FURNISHING))
        {
            return new CItemFurnishing(*((CItemFurnishing*)PItem));
        }

        if (PItem->isType(ITEM_PUPPET))
        {
            return new CItemPuppet(*((CItemPuppet*)PItem));
        }

        if (PItem->isType(ITEM_GENERAL))
        {
            return new CItemGeneral(*((CItemGeneral*)PItem));
        }

        if (PItem->isType(ITEM_CURRENCY))
        {
            return new CItemCurrency(*((CItemCurrency*)PItem));
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

    LootList_t* GetLootList(uint16 LootID)
    {
        if (LootID < MAX_LOOTID)
        {
            // False positive: this is LootList_t*, so it's OK
            // cppcheck-suppress CastIntegerToAddressAtReturn
            return g_pLootList[LootID];
        }
        ShowWarning("LootID %u too big", LootID);
        return nullptr;
    }

    /************************************************************************
     *                                                                       *
     *  Load the items                                                       *
     *                                                                       *
     ************************************************************************/

    void LoadItemList()
    {
        const char* Query = "SELECT "
                            "b.itemId,"    //  0
                            "b.name,"      //  1
                            "b.stackSize," //  2
                            "b.flags,"     //  3
                            "b.aH,"        //  4
                            "b.BaseSell,"  //  5
                            "b.subid,"     //  6

                            "u.validTargets,"  //  7
                            "u.activation,"    //  8
                            "u.animation,"     //  9
                            "u.animationTime," // 10
                            "u.maxCharges,"    // 11
                            "u.useDelay,"      // 12
                            "u.reuseDelay,"    // 13
                            "u.aoe,"           // 14

                            "a.level,"      // 15
                            "a.ilevel,"     // 16
                            "a.jobs,"       // 17
                            "a.MId,"        // 18
                            "a.shieldSize," // 19
                            "a.scriptType," // 20
                            "a.slot,"       // 21
                            "a.rslot,"      // 22
                            "a.su_level,"   // 23

                            "w.skill,"         // 24
                            "w.subskill,"      // 25
                            "w.ilvl_skill,"    // 26
                            "w.ilvl_parry,"    // 27
                            "w.ilvl_macc,"     // 28
                            "w.delay,"         // 29
                            "w.dmg,"           // 30
                            "w.dmgType,"       // 31
                            "w.hit,"           // 32
                            "w.unlock_points," // 33

                            "f.storage,"      // 34
                            "f.moghancement," // 35
                            "f.element,"      // 36
                            "f.aura,"         // 37

                            "p.slot,"    // 38
                            "p.element " // 39
                            "FROM item_basic AS b "
                            "LEFT JOIN item_usable AS u USING (itemId) "
                            "LEFT JOIN item_equipment  AS a USING (itemId) "
                            "LEFT JOIN item_weapon AS w USING (itemId) "
                            "LEFT JOIN item_furnishing AS f USING (itemId) "
                            "LEFT JOIN item_puppet AS p USING (itemId) "
                            "WHERE itemId < %u;";

        int32 ret = _sql->Query(Query, MAX_ITEMID);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                CItem* PItem = CreateItem(_sql->GetUIntData(0));

                if (PItem != nullptr)
                {
                    PItem->setName(_sql->GetStringData(1));
                    PItem->setStackSize(_sql->GetUIntData(2));
                    PItem->setFlag(_sql->GetUIntData(3));
                    PItem->setAHCat(_sql->GetUIntData(4));
                    PItem->setBasePrice(_sql->GetUIntData(5));
                    PItem->setSubID(_sql->GetUIntData(6));

                    if (PItem->isType(ITEM_GENERAL))
                    {
                        // TODO
                    }

                    if (PItem->isType(ITEM_USABLE))
                    {
                        ((CItemUsable*)PItem)->setValidTarget(_sql->GetUIntData(7));
                        ((CItemUsable*)PItem)->setActivationTime(_sql->GetUIntData(8) * 1000);
                        ((CItemUsable*)PItem)->setAnimationID(_sql->GetUIntData(9));
                        ((CItemUsable*)PItem)->setAnimationTime(_sql->GetUIntData(10) * 1000);
                        ((CItemUsable*)PItem)->setMaxCharges(_sql->GetUIntData(11));
                        ((CItemUsable*)PItem)->setCurrentCharges(_sql->GetUIntData(11));
                        ((CItemUsable*)PItem)->setUseDelay(_sql->GetUIntData(12));
                        ((CItemUsable*)PItem)->setReuseDelay(_sql->GetUIntData(13));
                        ((CItemUsable*)PItem)->setAoE(_sql->GetUIntData(14));
                    }
                    if (PItem->isType(ITEM_PUPPET))
                    {
                        ((CItemPuppet*)PItem)->setEquipSlot(_sql->GetUIntData(38));
                        ((CItemPuppet*)PItem)->setElementSlots(_sql->GetUIntData(39));

                        // If this is a PUP attachment, load the appropriate script as well
                        auto attachmentFile = fmt::format("./scripts/actions/abilities/pets/attachments/{}.lua", PItem->getName());
                        luautils::CacheLuaObjectFromFile(attachmentFile);
                    }

                    if (PItem->isType(ITEM_EQUIPMENT))
                    {
                        ((CItemEquipment*)PItem)->setReqLvl(_sql->GetUIntData(15));
                        ((CItemEquipment*)PItem)->setILvl(_sql->GetUIntData(16));
                        ((CItemEquipment*)PItem)->setJobs(_sql->GetUIntData(17));
                        ((CItemEquipment*)PItem)->setModelId(_sql->GetUIntData(18));
                        ((CItemEquipment*)PItem)->setShieldSize(_sql->GetUIntData(19));
                        ((CItemEquipment*)PItem)->setScriptType(_sql->GetUIntData(20));
                        ((CItemEquipment*)PItem)->setEquipSlotId(_sql->GetUIntData(21));
                        ((CItemEquipment*)PItem)->setRemoveSlotId(_sql->GetUIntData(22));
                        ((CItemEquipment*)PItem)->setSuperiorLevel(_sql->GetUIntData(23));

                        if (((CItemEquipment*)PItem)->getValidTarget() != 0)
                        {
                            ((CItemEquipment*)PItem)->setSubType(ITEM_CHARGED);
                        }
                    }

                    if (PItem->isType(ITEM_WEAPON))
                    {
                        ((CItemWeapon*)PItem)->setSkillType(_sql->GetUIntData(24));
                        ((CItemWeapon*)PItem)->setSubSkillType(_sql->GetUIntData(25));
                        ((CItemWeapon*)PItem)->setILvlSkill(_sql->GetUIntData(26));
                        ((CItemWeapon*)PItem)->setILvlParry(_sql->GetUIntData(27));
                        ((CItemWeapon*)PItem)->setILvlMacc(_sql->GetUIntData(28));
                        ((CItemWeapon*)PItem)->setBaseDelay(_sql->GetUIntData(29));
                        ((CItemWeapon*)PItem)->setDelay((_sql->GetIntData(29) * 1000) / 60);
                        ((CItemWeapon*)PItem)->setDamage(_sql->GetUIntData(30));
                        ((CItemWeapon*)PItem)->setDmgType(static_cast<DAMAGE_TYPE>(_sql->GetUIntData(31)));
                        ((CItemWeapon*)PItem)->setMaxHit(_sql->GetUIntData(32));
                        ((CItemWeapon*)PItem)->setTotalUnlockPointsNeeded(_sql->GetUIntData(33));

                        int  dmg   = _sql->GetUIntData(30);
                        int  delay = _sql->GetIntData(29);
                        bool isH2H = ((CItemWeapon*)PItem)->getSkillType() == SKILL_HAND_TO_HAND;

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

                            ((CItemWeapon*)PItem)->setDPS(dps);
                        }
                    }

                    if (PItem->isType(ITEM_FURNISHING))
                    {
                        ((CItemFurnishing*)PItem)->setStorage(_sql->GetUIntData(34));
                        ((CItemFurnishing*)PItem)->setMoghancement(_sql->GetUIntData(35));
                        ((CItemFurnishing*)PItem)->setElement(_sql->GetUIntData(36));
                        ((CItemFurnishing*)PItem)->setAura(_sql->GetUIntData(37));
                    }

                    g_pItemList[PItem->getID()] = PItem;

                    auto filename = fmt::format("./scripts/items/{}.lua", PItem->getName());
                    luautils::CacheLuaObjectFromFile(filename);
                }
            }
        }

        ret = _sql->Query(
            "SELECT itemId, modId, value FROM item_mods WHERE itemId IN (SELECT itemId FROM item_basic LEFT JOIN item_equipment USING (itemId))");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 ItemID = (uint16)_sql->GetUIntData(0);
                Mod    modID  = static_cast<Mod>(_sql->GetUIntData(1));
                int16  value  = (int16)_sql->GetIntData(2);

                if ((g_pItemList[ItemID] != nullptr) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
                {
                    ((CItemEquipment*)g_pItemList[ItemID])->addModifier(CModifier(modID, value));
                }
            }
        }

        ret = _sql->Query(
            "SELECT itemId, modId, value, petType FROM item_mods_pet WHERE itemId IN (SELECT itemId FROM item_basic LEFT JOIN item_equipment USING (itemId))");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16     ItemID  = (uint16)_sql->GetUIntData(0);
                Mod        modID   = static_cast<Mod>(_sql->GetUIntData(1));
                int16      value   = (int16)_sql->GetIntData(2);
                PetModType petType = static_cast<PetModType>(_sql->GetIntData(3));

                if ((g_pItemList[ItemID]) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
                {
                    ((CItemEquipment*)g_pItemList[ItemID])->addPetModifier(CPetModifier(modID, petType, value));
                }
            }
        }

        ret = _sql->Query("SELECT itemId, modId, value, latentId, latentParam FROM item_latents WHERE itemId IN (SELECT itemId FROM item_basic LEFT "
                          "JOIN item_equipment USING (itemId))");

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 ItemID      = (uint16)_sql->GetUIntData(0);
                Mod    modID       = static_cast<Mod>(_sql->GetUIntData(1));
                int16  value       = (int16)_sql->GetIntData(2);
                LATENT latentId    = static_cast<LATENT>(_sql->GetIntData(3));
                uint16 latentParam = (uint16)_sql->GetIntData(4);

                if ((g_pItemList[ItemID] != nullptr) && g_pItemList[ItemID]->isType(ITEM_EQUIPMENT))
                {
                    ((CItemEquipment*)g_pItemList[ItemID])->addLatent(latentId, latentParam, modID, value);
                }
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
        int32 ret = _sql->Query("SELECT dropId, itemId, dropType, itemRate, groupId, groupRate FROM mob_droplist WHERE dropid < %u;", MAX_DROPID);

        if (ret != SQL_ERROR && _sql->NumRows() != 0)
        {
            while (_sql->NextRow() == SQL_SUCCESS)
            {
                uint16 DropID = (uint16)_sql->GetUIntData(0);

                if (g_pDropList[DropID] == nullptr)
                {
                    g_pDropList[DropID] = new DropList_t;
                }

                DropList_t* dropList = g_pDropList[DropID];

                uint16 ItemID   = (uint16)_sql->GetIntData(1);
                uint8  DropType = (uint8)_sql->GetIntData(2);
                uint16 DropRate = (uint16)_sql->GetIntData(3);

                if (DropType == DROP_GROUPED)
                {
                    uint8  GroupId   = (uint8)_sql->GetIntData(4);
                    uint16 GroupRate = (uint16)_sql->GetIntData(5);
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
     *  Initialization of the  game objects             bbbb                 *
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
