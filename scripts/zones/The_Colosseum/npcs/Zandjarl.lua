-----------------------------------
-- Area: The Colosseum
--  NPC: Zandjarl
-- Type: Pankration NPC
-- !pos -599 0 45 71
-----------------------------------
local ID = require("scripts/zones/The_Colosseum/IDs")
-----------------------------------

function onTrade(player, npc, trade)
    local RESULT = nil
    local COUNT = trade:getItemCount()
    local TOTAL = player:getCurrency("jetton")
    local MAX = 100000000

    if (trade:hasItemQty(2184, COUNT)) then
        RESULT = 2*COUNT
    elseif (trade:hasItemQty(2185, COUNT)) then
        RESULT = 10*COUNT
    elseif (trade:hasItemQty(2186, COUNT)) then
        RESULT = 30*COUNT
    elseif (trade:hasItemQty(2187, COUNT)) then
        RESULT = 200*COUNT
    end

    if (RESULT ~= nil) then
        if ((RESULT + TOTAL) > MAX) then
            -- player:startEvent(47); ..it no work..
            npc:showText(npc, ID.text.EXCEED_THE_LIMIT_OF_JETTONS)
        else
            -- packet cap says its a "showText" thing..
            npc:showText(npc, ID.text.I_CAN_GIVE_YOU, RESULT)
            npc:showText(npc, ID.text.THANKS_FOR_STOPPING_BY)
            player:addCurrency("jetton", RESULT)
            player:tradeComplete()
        end
    end
end

function onTrigger(player, npc)
    player:startEvent(1900, player:getCurrency("jetton"))
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if (csid == 1900) then -- onTrigger
        local shop =
        {
            [1] = {itemID = 18721, price = 2, QTY = 1}, -- SoulTrapper
            [257] = {itemID = 18724, price = 500, QTY = 1}, -- Soultrapper 2000
            [513] = {itemID = 16134, price = 5000, QTY = 1}, -- Zoraal Ja's Helm
            [65537] = {itemID = 18722, price = 2, QTY = 12}, -- Blank Soul Plates
            [65793] = {itemID = 18725, price = 500, QTY = 12}, -- High Speed Soul plates
            [66049] = {itemID = 16135, price = 5000, QTY = 1}, -- Dartorgor's Coif
            [131585] = {itemID = 16136, price = 5000, QTY = 1}, -- Lamia No.3's Garland
            [197121] = {itemID = 16137, price = 5000, QTY = 1}  -- Cacaroon's Hood
        }
        local result = shop[option]
        if (result ~= nil) then
            if (result.itemID ~= nil) then
                if (player:addItem(result.itemID, result.QTY)) then
                    player:delCurrency("jetton", result.price)
                    player:messageSpecial(ID.text.ITEM_OBTAINED, result.itemID)
                else
                    player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, result.itemID)
                end
            end
        end
    end
end
