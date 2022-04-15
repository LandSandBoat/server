-----------------------------------
-- Abyssea Sturdy Pyxis - Temporary item
-----------------------------------

xi = xi or {}
xi.pyxis = xi.pyxis or {}

xi.pyxis.tempItem = {}

---------------------------------
-- drop id's for temp items
-- use zone id as the key
---------------------------------
-- TODO: Add Temp Items to items.lua
local drops =
{
    [1] = {4206,4254,5394,5397,5433,5824,5827},
    [2] = {4206,4254,5394,5397,5433,5824,5827,5440,5835,5837,5839,5841,5843,5850,5849},
    [3] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852},
    [4] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851},
    [5] = {5395,5435,5439,5825,5828,5830,5832,5833,5834,5838,5844,5846,5852,4255,5322,5393,5434,5826,5829,5831,5836,5840,5842,5847,5848,5851,4146,4202,5845},
}

local function GetTempDropTable(npc)
    local maxItem = npc:getLocalVar("NB_ITEM")
    local tempTable = {}

    for i = 1, maxItem do
        tempTable[i] = npc:getLocalVar("TEMP" .. i)
    end

    return tempTable
end

local function GiveTempItem(player, npc, tempNum)
    local tempItems = GetTempDropTable(npc)
    local ID = zones[player:getZoneID()]

    if tempItems[tempNum] == 0 then
        player:messageSpecial(ID.text.TEMP_ITEM_DISAPPEARED)
        return
    else
        if player:hasItem(tempItems[tempNum], 3) then
            player:messageSpecial(ID.text.ALLREADY_POSSESS_TEMP_ITEM)
            return
        else
            player:addTempItem(tempItems[tempNum])
            xi.pyxis.messageChest(player, ID.text.OBTAINS_TEMP_ITEM, tempItems[tempNum], 0, 0, 0, npc)
            npc:setLocalVar("TEMP" .. tempNum, 0)
            tempItems[tempNum] = 0
        end
    end

    if xi.pyxis.isChestEmpty(tempItems) then
        xi.pyxis.removeChest(player, npc, 0, 3)
    end
end

xi.pyxis.tempItem.setTempItems = function(npc, tier)
    local maxItem = npc:getLocalVar("NB_ITEM")

    for i = 1, maxItem do
        local temp = drops[tier][math.random(1, #drops[tier])]
        npc:setLocalVar("TEMP" .. i, temp)
    end
end

xi.pyxis.tempItem.giveTemporaryItems = function(npc, player)
    local tier = npc:getLocalVar("TIER")
    local ID = zones[npc:getZoneID()]
    local alliance = player:getAlliance()

    for i = 1, #drops[tier] do
        local item = drops[tier][math.random(1,#drops[tier])]
        for p, member in ipairs(alliance) do
            if member:isPC() and not member:hasItem(item,3) and member:getZoneID() == player:getZoneID() then
                member:addTempItem(item, 1, 0, 0, 0, 0, 0, 0, 0, 0)
            end
        end
    end

    for p, member in ipairs(alliance) do
        if member:isPC() then
            member:messageSpecial(ID.text.OBTAINS_SEVERAL_TEMPS, 0, 0, 0, 0)
        end
    end
end

xi.pyxis.tempItem.updateEvent = function(player, npc)
    player:updateEvent(unpack(GetTempDropTable(npc)))
end

xi.pyxis.tempItem.giveTemporaryItem = function(player, npc, option)
    local itemSelected = bit.rshift(option, 16)

    if itemSelected > 0 and itemSelected <= 8 then
        GiveTempItem(player, npc, itemSelected)
    end
end
