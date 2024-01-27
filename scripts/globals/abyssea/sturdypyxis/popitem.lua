-----------------------------------
-- Abyssea Sturdy Pyxis - Pop Item
-----------------------------------
xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.popitem = {}

-----------------------------------
-- drop id's for pop item
-----------------------------------
local popitemDrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = { 2903, 2904, 2906, 2907, 2908, 2909, 2910, 2911, 2912, 2913, 2914 },
    [xi.zone.ABYSSEA_TAHRONGI  ] = { },
    [xi.zone.ABYSSEA_LA_THEINE ] = { },
    [xi.zone.ABYSSEA_ATTOHWA   ] = { },
    [xi.zone.ABYSSEA_MISAREAUX ] = { },
    [xi.zone.ABYSSEA_VUNKERL   ] = { },
    [xi.zone.ABYSSEA_ALTEPA    ] = { },
    [xi.zone.ABYSSEA_ULEGUERAND] = { },
    [xi.zone.ABYSSEA_GRAUBERG  ] = { },
}

local function GetChestItemTable(npc)
    local maxItem = npc:getLocalVar('NB_ITEM')
    local itemTable = {}

    for i = 1, maxItem do
        itemTable[i] = npc:getLocalVar('POPITEM' .. i)
    end

    return itemTable
end

local function GetRandItem(zoneId)
    local rand = math.random(1, #popitemDrops[zoneId])
    return popitemDrops[zoneId][rand]
end

local function GetLootTable(player, npc)
    local maxItem = npc:getLocalVar('NB_ITEM')
    local loot = {}

    for i = 1, maxItem do
        table.insert(loot, npc:getLocalVar('POPITEM' ..i))
    end

    return loot
end

local function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar('CHESTID')
    local chest   = GetNPCByID(chestid)
    local itemList = GetChestItemTable(npc)

    if itemList[itemnum] == 0 then
        player:messageSpecial(ID.text.ITEM_DISAPPEARED)
        return
    else
        if player:getFreeSlotsCount() == 0 then -- NOTE: check a var or somthing for the item
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, itemList[itemnum])
            return
        else
            player:addItem(itemList[itemnum], 1, 0, 0, 0, 0)
            xi.pyxis.messageChest(player, ID.text.OBTAINS_ITEM, itemList[itemnum], 0, 0, 0, npc)
            chest:setLocalVar('POPITEM' .. itemnum, 0)
            itemList[itemnum] = 0
        end
    end

    if xi.pyxis.isChestEmpty(itemList) then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.popitem.setPopItems = function(npc)
    local itemcount = npc:getLocalVar('NB_ITEM')

    for i = 1, itemcount do
        local item = GetRandItem(npc:getZoneID())
        npc:setLocalVar('POPITEM' .. i, item)
    end
end

xi.pyxis.popitem.updateEvent = function(player, npc)
    player:updateEvent(unpack(GetChestItemTable(npc)))
end

xi.pyxis.popitem.givePopItem = function(player, npc, option)
    local ID = zones[npc:getZoneID()]
    local loottable = GetLootTable(player, npc)
    local itemSelected = bit.rshift(option, 16)

    if itemSelected > 0 and itemSelected <= 8 then
        GiveItem(player, npc, itemSelected)
    elseif itemSelected == 9 then
        for _, v in ipairs(loottable) do
            player:addTreasure(v)
        end

        xi.pyxis.messageChest(player, ID.text.ADD_SPOILS_TO_TREASURE, 0, 0, 0, 0, npc)
        xi.pyxis.removeChest(player, npc, 0, 1)
    end
end
