-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rank = xi.besieged.getMercenaryRank(player)
    local haveimperialIDtag = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints = player:getAssaultPoint(xi.assaultUtil.assaultArea.LEUJAOAM_SANCTUM)

    if rank > 0 then
        player:startEvent(273, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else
        player:startEvent(279)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 273 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 and npcUtil.giveKeyItem(player, xi.ki.LEUJAOAM_ASSAULT_ORDERS) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local items =
            {
                [1]  = {itemid = 15970, price = 3000},
                [2]  = {itemid = 15775, price = 5000},
                [3]  = {itemid = 15521, price = 8000},
                [4]  = {itemid = 15884, price = 10000},
                [5]  = {itemid = 15490, price = 10000},
                [6]  = {itemid = 18408, price = 10000},
                [7]  = {itemid = 18485, price = 15000},
                [8]  = {itemid = 18365, price = 15000},
                [9]  = {itemid = 14933, price = 15000},
                [10] = {itemid = 16069, price = 20000},
                [11] = {itemid = 15606, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assaultUtil.assaultArea.LEUJAOAM_SANCTUM, choice.price)
            end
        end
    end
end

return entity
