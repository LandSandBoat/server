-----------------------------------
-- Abyssea Sturdy Pyxis - Item
-----------------------------------

xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.item = {}

---------------------------------
-- drop id's for items
-- use zone id as the key
---------------------------------
-- Containing Ore actually
local commonDrops = { 1255,1256,1257,1258,1259,1260,1261,1262 }

local itemDrops =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = {1633,4781,4272,5152,2824,2189,781,1262,778,1740,685,1259,740,1469,836,4377,5001},
    [xi.zone.ABYSSEA_TAHRONGI  ] = {2408,2198,887,4691,4771,4781,4660,4614,4982,5001,4965,645,1633,812,804,756,794,1259,785,4272,2946,740,786,1312,942,2920,2948,2922,2949,2924,2950,2925,2923,2947},
    [xi.zone.ABYSSEA_LA_THEINE ] = {1260,1415,2899,2901,2902,2895,2359,740,739,1446,685,1769,702,1258,756,4272,780,4377,5152,4781,4771,4655,5001,4982,4856,4991,4486,4965,2893,2900},
    [xi.zone.ABYSSEA_ATTOHWA   ] = {5455,898,887,654,4272,777,745,5564,1469,1302,1303,1306,2703,729,780,692,740,1740,4849,5099,5096,5057,5092,5089,4966,4893,5059,6059,4996,4850,4895,3076,3073,3080,3083,3075,3072,12088,12089,12090,12091,12092,12093},
    [xi.zone.ABYSSEA_MISAREAUX ] = {692,4387,2743,747,1711,2152,1447,685,1300,2408,1299,719,722,902,836,887,4377,793,4849,4766,6099,4863,5057,4707,4706,5092,5089,4996,5078,4893,5059,4895,3088,3097,3091,3092,3096,12094,12095,12096,12097,12098},
    [xi.zone.ABYSSEA_VUNKERL   ] = {747,2476,1711,2703,685,5564,1769,1304,1305,1301,1306,1299,1302,836,1312,4849,4766,5099,5057,4707,4706,5092,4850,4893,5059,5057,4895,4967,4966,3101,12102,12106,12105,12100, 12101, 12103, 12104, 12107, 12099},
    [xi.zone.ABYSSEA_ALTEPA    ] = {0,0,0},
    [xi.zone.ABYSSEA_ULEGUERAND] = {0,0,0},
    [xi.zone.ABYSSEA_GRAUBERG  ] = {0,0,0},
}

local itemTierDeductions =
{
    [xi.zone.ABYSSEA_KONSCHTAT ] = {  7,  7,  7, 0, 0 },
    [xi.zone.ABYSSEA_TAHRONGI  ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_LA_THEINE ] = { 13, 13, 13, 9, 0 },
    [xi.zone.ABYSSEA_ATTOHWA   ] = { 14, 14, 14, 9, 0 },
    [xi.zone.ABYSSEA_MISAREAUX ] = { 14, 14, 14, 5, 0 },
    [xi.zone.ABYSSEA_VUNKERL   ] = { 14, 14, 14, 6, 0 },
    [xi.zone.ABYSSEA_ALTEPA    ] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_ULEGUERAND] = {  0,  0,  0, 0, 0 },
    [xi.zone.ABYSSEA_GRAUBERG  ] = {  0,  0,  0, 0, 0 },
}

local function GetChestItemTable(npc)
    local maxItem = npc:getLocalVar("NB_ITEM")
    local itemTable = {}

    for i = 1, maxItem do
        itemTable[i] = npc:getLocalVar("ITEM" .. i)
    end

    return itemTable
end

local function GetRandItem(zoneId, tier)
    local drops = { unpack(commonDrops), unpack(itemDrops[zoneId]) }
    local rand = math.random(1, #drops - itemTierDeductions[zoneId][tier])
    return drops[rand]
end

local function GetLootTable(player, npc)
    local maxItem = npc:getLocalVar("NB_ITEM")
    local loot = {}

    for i = 1, maxItem do
        table.insert(loot, npc:getLocalVar("ITEM" ..i))
    end
    return loot
end

local function GiveItem(player, npc, itemnum)
    local zoneId  = player:getZoneID()
    local ID      = zones[zoneId]
    local chestid = npc:getLocalVar("CHESTID")
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
            xi.pyxis.messageChest(player,ID.text.OBTAINS_ITEM, itemList[itemnum], 0, 0, 0, npc)
            chest:setLocalVar("ITEM" .. itemnum, 0)
            itemList[itemnum] = 0
        end
    end
    if xi.pyxis.isChestEmpty(itemList) then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.item.setItems = function(npc, tier)
    local itemcount = npc:getLocalVar("NB_ITEM")

    for i = 1, itemcount do
        local item = GetRandItem(npc:getZoneID(), tier)
        npc:setLocalVar("ITEM" .. i, item)
    end
end

xi.pyxis.item.updateEvent = function(player, npc)
    player:updateEvent(unpack(GetChestItemTable(npc)))
end

xi.pyxis.item.giveItem = function(player, npc, option)
    local ID = zones[npc:getZoneID()]
    local loottable = GetLootTable(player, npc)
    local itemSelected = bit.rshift(option, 16)
    if itemSelected > 0 and itemSelected <= 8 then
        GiveItem(player, npc, itemSelected)

    -- Add spoils to treasure
    elseif itemSelected == 9 then
        for _, v in ipairs(loottable) do
            player:addTreasure(v)
        end

        xi.pyxis.messageChest(player, ID.text.ADD_SPOILS_TO_TREASURE, 0, 0, 0, 0, npc)
        xi.pyxis.removeChest(player, npc, 0, 1)
        ---- NOTE: NEED A CHECK HERE TO MAKE SURE ITS UPDATED AND CANT REMOVE THE SAME ITEM AGAIN
    end
end