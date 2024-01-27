-----------------------------------
-- Abyssea Sturdy Pyxis Chest
-----------------------------------
require('scripts/globals/abyssea')
require('scripts/globals/abyssea/sturdypyxis/augmented_item')
require('scripts/globals/abyssea/sturdypyxis/temporary_item')
require('scripts/globals/abyssea/sturdypyxis/keyitem')
require('scripts/globals/abyssea/sturdypyxis/item')
require('scripts/globals/abyssea/sturdypyxis/popitem')
require('scripts/globals/abyssea/sturdypyxis/cruor')
require('scripts/globals/abyssea/sturdypyxis/light')
require('scripts/globals/abyssea/sturdypyxis/experience')
require('scripts/globals/abyssea/sturdypyxis/time')
require('scripts/globals/abyssea/sturdypyxis/restore')
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.chestType =
{
    BLUE = 1,
    RED  = 2,
    GOLD = 3,
}

xi.pyxis.chestDropType =
{
    TEMPORARY_ITEM      = 1,
    ITEM                = 2,
    POPITEM             = 3,
    AUGMENTED_ITEM      = 4,
    KEY_ITEM            = 5,
    LIGHT               = 6,
    RESTORE             = 7,
    CRUOR               = 8,
    TIME                = 9,
    EXP                 = 10,
    NUMEROUS_TEMPITEMS  = 11
}

-----------------------------------
-- Desc: Messages sent to all players in a party in the zone
-----------------------------------
xi.pyxis.canOpenChest = function(player, npc)
    local playerOwner = GetPlayerByID(npc:getLocalVar('PLAYERID'))

    local ally = player:getAlliance()

    local canOpen = false
    for k, member in ipairs(ally) do
        if member:getID() == playerOwner:getID() then
            canOpen = true
            break
        end
    end

    if not canOpen and playerOwner:getZoneID() ~= npc:getZoneID() then
        canOpen = true
    end

    if not canOpen then
        local ID = zones[player:getZoneID()]
        player:messageSpecial(ID.text.PARTY_NOT_OWN_CHEST)
    end

    return canOpen
end

-----------------------------------
-- Desc: Messages sent to all players in a party in the zone
-----------------------------------
xi.pyxis.messageChest = function(player, messageid, param1, param2, param3, param4, npc)
    local alliance = player:getAlliance()

    for _, member in ipairs(alliance) do
        if member:getZoneID() == player:getZoneID() and member:isPC() then
            member:messageName(messageid, player, param1, param2, param3, param4)
        end
    end
end

xi.pyxis.isChestEmpty = function(contentsTable)
    for _, v in ipairs(contentsTable) do
        if v ~= 0 then
            return false
        end
    end

    return true
end

xi.pyxis.removeChest = function(player, npc, addcruor, delay)
    local ID = zones[player:getZoneID()]
    local amount = npc:getLocalVar('TIER') * 10

    if addcruor ~= 0 then
        player:addCurrency('cruor', amount)
        player:messageSpecial(ID.text.CRUOR_OBTAINED, amount, 0, 0, 0)
    end

    npc:setUntargetable(true)
    npc:timer(delay * 1000, function(npcArg)
        npcArg:setAnimationSub(16)
        npcArg:setNpcFlags(3203)
        npcArg:setLocalVar('SPAWNSTATUS', 0)
        npcArg:setStatus(xi.status.DISAPPEAR)
        npcArg:entityAnimationPacket('kesu')
        npc:setUntargetable(false)
    end)
end

xi.pyxis.getDrops = function(npc, dropType, tier)
    if npc:getLocalVar('ITEMS_SET') == 1 then -- sets this to 1 so can get items once when triggered
        return
    end

    switch(dropType): caseof
    {
        [xi.pyxis.chestDropType.TEMPORARY_ITEM] = function(x)
            xi.pyxis.tempItem.setTempItems(npc, tier)
            npc:setLocalVar('ITEMS_SET', 1)
        end,

        [xi.pyxis.chestDropType.KEY_ITEM] = function(x)
            xi.pyxis.ki.setKeyItems(npc)
            npc:setLocalVar('ITEMS_SET', 1)
        end,

        [xi.pyxis.chestDropType.AUGMENTED_ITEM] = function(x)
            xi.pyxis.augItem.setAugmentItems(npc, tier)
            npc:setLocalVar('ITEMS_SET', 1)
        end,

        [xi.pyxis.chestDropType.ITEM] = function(x)
            xi.pyxis.item.setItems(npc, tier)
            npc:setLocalVar('ITEMS_SET', 1)
        end,

        [xi.pyxis.chestDropType.POPITEM] = function(x)
            xi.pyxis.popitem.setPopItems(npc)
            npc:setLocalVar('ITEMS_SET', 1)
        end
    }
end

xi.pyxis.openChest = function(player, npc)
    local dropType = npc:getLocalVar('DROPTYPE')

    npc:setAnimationSub(13)

    switch(dropType) : caseof
    {
        [xi.pyxis.chestDropType.LIGHT] = function() -- LIGHT
            xi.pyxis.light.giveLight(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 3)
        end,

        [xi.pyxis.chestDropType.RESTORE] = function() -- RESTORE HP/MP/JA
            xi.pyxis.restore.giveRestore(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 4)
        end,

        [xi.pyxis.chestDropType.CRUOR] = function() -- CRUOR
            xi.pyxis.cruor.giveCruor(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 3)
        end,

        [xi.pyxis.chestDropType.TIME] = function() -- TIME
            xi.pyxis.time.giveTime(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 3)
        end,

        [xi.pyxis.chestDropType.EXP] = function() -- EXP
            xi.pyxis.exp.giveExperience(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 3)
        end,

        [xi.pyxis.chestDropType.NUMEROUS_TEMPITEMS] = function() -- TEMPORARY ITEM
            xi.pyxis.tempItem.giveTemporaryItems(npc, player)
            xi.pyxis.removeChest(player, npc, 0, 3)
        end,
    }
end
