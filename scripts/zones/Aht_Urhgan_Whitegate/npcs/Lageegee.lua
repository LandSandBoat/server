-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Lageegee
-- Type: Assault Mission Giver
-- !pos 120.808 0.161 -30.435
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
    local assaultPoints = player:getAssaultPoint(PERIQIA_ASSAULT_POINT)

    if player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG) then
        haveimperialIDtag = 1
    else
        haveimperialIDtag = 0
    end

--[[    if (rank > 0) then
        player:startEvent(276, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else]]
        player:startEvent(282) -- no rank
    --end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 276 then
        local selectiontype = bit.band(option, 0xF)
        if selectiontype == 1 then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)
            npcUtil.giveKeyItem(player, tpz.ki.PERIQIA_ASSAULT_ORDERS)
        elseif (selectiontype == 2) then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local items =
            {
                [1]  = {itemid = 15973, price = 3000},
                [2]  = {itemid = 15778, price = 5000},
                [3]  = {itemid = 15524, price = 8000},
                [4]  = {itemid = 15887, price = 10000},
                [5]  = {itemid = 15493, price = 10000},
                [6]  = {itemid = 18025, price = 15000},
                [7]  = {itemid = 18435, price = 15000},
                [8]  = {itemid = 18686, price = 15000},
                [9]  = {itemid = 16062, price = 20000},
                [10] = {itemid = 15695, price = 20000},
                [11] = {itemid = 14527, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delCurrency("PERIQIA_ASSAULT_POINT", choice.price)
            end
        end
    end
end
