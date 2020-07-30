-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Famad
-- Type: Assault Mission Giver
-- !pos 134.098 0.161 -43.759 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/besieged")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rank = tpz.besieged.getMercenaryRank(player)
    local haveimperialIDtag
    local assaultPoints = player:getAssaultPoint(LEBROS_ASSAULT_POINT)

    if (player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)) then
        haveimperialIDtag = 1
    else
        haveimperialIDtag = 0
    end

--[[    if (rank > 0) then
        player:startEvent(275, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else]]
        player:startEvent(281) -- no rank
    --end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 275) then
        local selectiontype = bit.band(option, 0xF)
        if (selectiontype == 1) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)
            npcUtil.giveKeyItem(player, tpz.ki.LEBROS_ASSAULT_ORDERS)
        elseif (selectiontype == 2) then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local items =
            {
                [1]  = {itemid = 15972, price = 3000},
                [2]  = {itemid = 15777, price = 5000},
                [3]  = {itemid = 15523, price = 8000},
                [4]  = {itemid = 15886, price = 10000},
                [5]  = {itemid = 15492, price = 10000},
                [6]  = {itemid = 18583, price = 15000},
                [7]  = {itemid = 18383, price = 15000},
                [8]  = {itemid = 18417, price = 15000},
                [9]  = {itemid = 14525, price = 20000},
                [10] = {itemid = 14940, price = 20000},
                [11] = {itemid = 15690, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delCurrency("LEBROS_ASSAULT_POINT", choice.price)
            end
        end
    end
end
