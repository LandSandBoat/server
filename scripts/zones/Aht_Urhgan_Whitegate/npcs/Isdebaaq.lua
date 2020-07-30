-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Isdebaaq
-- Type: Assault Mission Giver
-- !pos 127.565 0.161 -43.846 50
-----------------------------------
require("scripts/globals/keyitems")
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/besieged")
require("scripts/globals/missions")
require("scripts/globals/npc_util")
-----------------------------------

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local rank = tpz.besieged.getMercenaryRank(player)
    local haveimperialIDtag
    local assaultPoints = player:getAssaultPoint(MAMOOL_ASSAULT_POINT)

    if (player:hasKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)) then
        haveimperialIDtag = 1
    else
        haveimperialIDtag = 0
    end

--[[    if (rank > 0) then
        player:startEvent(274, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault())
    else]]
        player:startEvent(280) -- no rank
    --end
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 274) then
        local selectiontype = bit.band(option, 0xF)
        if (selectiontype == 1) then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(tpz.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(tpz.ki.MAMOOL_JA_ASSAULT_ORDERS)
            player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.MAMOOL_JA_ASSAULT_ORDERS)
        elseif (selectiontype == 2) then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local itemID = 0
            local price = 0
            local items =
            {
                [1]  = {itemid = 15971, price = 3000},
                [2]  = {itemid = 15776, price = 5000},
                [3]  = {itemid = 15522, price = 8000},
                [4]  = {itemid = 15885, price = 10000},
                [5]  = {itemid = 15491, price = 10000},
                [6]  = {itemid = 17715, price = 15000},
                [7]  = {itemid = 18113, price = 15000},
                [8]  = {itemid = 17591, price = 15000},
                [9]  = {itemid = 14935, price = 20000},
                [10] = {itemid = 15688, price = 20000},
                [11] = {itemid = 15609, price = 20000},
            }

            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint("MAMOOL_ASSAULT_POINT", choice.price)
            end
        end
    end
end
