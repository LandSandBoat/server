-----------------------------------
-- Area: Castle Oztroja
--  NPC: Antiqix
-- Type: Dynamis Vendor
-- !pos -207.835 -0.751 -25.498 151
-----------------------------------
local ID = require("scripts/zones/Castle_Oztroja/IDs")
require("scripts/globals/keyitems")
require("scripts/globals/settings")
require("scripts/globals/dynamis")

local TIMELESS_HOURGLASS = 4236
local currency = {1449, 1450, 1451}
local shop = {
     7, 1312, -- Angel Skin
     8, 1518, -- Colossal Skull
     9, 1464, -- Lancewood Log
    23, 1463, -- Chronos Tooth
    24, 1467, -- Relic Steel
    25, 1462, -- Lancewood Lumber
    28, 658,  -- Damascus Ingot
}
local maps = {
    [tpz.ki.MAP_OF_DYNAMIS_SANDORIA]   = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_BASTOK]     = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_WINDURST]   = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_JEUNO]      = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_BEAUCEDINE] = 15000,
    [tpz.ki.MAP_OF_DYNAMIS_XARCABARD]  = 20000,
    [tpz.ki.MAP_OF_DYNAMIS_VALKURM]    = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_BUBURIMU]   = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_QUFIM]      = 10000,
    [tpz.ki.MAP_OF_DYNAMIS_TAVNAZIA]   = 20000,
}
-----------------------------------

function onTrade(player, npc, trade)
    local gil = trade:getGil()
    local count = trade:getItemCount()

    if (player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND)) then

        -- buy prismatic hourglass
        if (gil == PRISMATIC_HOURGLASS_COST and count == 1 and not player:hasKeyItem(tpz.ki.PRISMATIC_HOURGLASS)) then
            player:startEvent(54)

        -- return timeless hourglass for refund
        elseif (count == 1 and trade:hasItemQty(TIMELESS_HOURGLASS, 1)) then
            player:startEvent(97)

        -- currency exchanges
        elseif (count == CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[1], CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(55, CURRENCY_EXCHANGE_RATE)
        elseif (count == CURRENCY_EXCHANGE_RATE and trade:hasItemQty(currency[2], CURRENCY_EXCHANGE_RATE)) then
            player:startEvent(56, CURRENCY_EXCHANGE_RATE)
        elseif (count == 1 and trade:hasItemQty(currency[3], 1)) then
            player:startEvent(58, currency[3], currency[2], CURRENCY_EXCHANGE_RATE)

        -- shop
        else
            local item
            local price
            for i=1, 13, 2 do
                price = shop[i]
                item = shop[i+1]
                if (count == price and trade:hasItemQty(currency[2], price)) then
                    player:setLocalVar("hundoItemBought", item)
                    player:startEvent(57, currency[2], price, item)
                    break
                end
            end

        end
    end
end

function onTrigger(player, npc)
    if (player:hasKeyItem(tpz.ki.VIAL_OF_SHROUDED_SAND)) then
        player:startEvent(53, currency[1], CURRENCY_EXCHANGE_RATE, currency[2], CURRENCY_EXCHANGE_RATE, currency[3], PRISMATIC_HOURGLASS_COST, TIMELESS_HOURGLASS, TIMELESS_HOURGLASS_COST)
    else
        player:startEvent(50)
    end
end

function onEventUpdate(player, csid, option)
    if (csid == 53) then

        -- asking about hourglasses
        if (option == 1) then
            if (not player:hasItem(TIMELESS_HOURGLASS)) then
                -- must figure out what changes here to prevent the additional dialog
                -- player:updateEvent(?)
            end

        -- shop
        elseif (option == 2) then
            player:updateEvent(unpack(shop, 1, 8))
        elseif (option == 3) then
            player:updateEvent(unpack(shop, 9, 14))

        -- offer to trade down from a 10k
        elseif (option == 10) then
            player:updateEvent(currency[3], currency[2], CURRENCY_EXCHANGE_RATE)

        -- main menu (param1 = dynamis map bitmask, param2 = gil)
        elseif (option == 11) then
            player:updateEvent(getDynamisMapList(player), player:getGil())

        -- maps
        elseif (maps[option] ~= nil) then
            local price = maps[option]
            if (price > player:getGil()) then
                player:messageSpecial(ID.text.NOT_ENOUGH_GIL)
            else
                player:delGil(price)
                player:addKeyItem(option)
                player:messageSpecial(ID.text.KEYITEM_OBTAINED, option)
            end
            player:updateEvent(getDynamisMapList(player), player:getGil())

        end
    end
end

function onEventFinish(player, csid, option)

    -- bought prismatic hourglass
    if (csid == 54) then
        player:tradeComplete()
        player:addKeyItem(tpz.ki.PRISMATIC_HOURGLASS)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.PRISMATIC_HOURGLASS)

    -- refund timeless hourglass
    elseif (csid == 97) then
        player:tradeComplete()
        player:addGil(TIMELESS_HOURGLASS_COST)
        player:messageSpecial(ID.text.GIL_OBTAINED, TIMELESS_HOURGLASS_COST)

    -- singles to hundos
    elseif (csid == 55) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[2])
        else
            player:tradeComplete()
            player:addItem(currency[2])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[2])
        end

    -- hundos to 10k pieces
    elseif (csid == 56) then
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[3])
        else
            player:tradeComplete()
            player:addItem(currency[3])
            player:messageSpecial(ID.text.ITEM_OBTAINED, currency[3])
        end

    -- 10k pieces to hundos
    elseif (csid == 58) then
        local slotsReq = math.ceil(CURRENCY_EXCHANGE_RATE / 99)
        if (player:getFreeSlotsCount() < slotsReq) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, currency[2])
        else
            player:tradeComplete()
            for i=1, slotsReq do
                if (i < slotsReq or (CURRENCY_EXCHANGE_RATE % 99) == 0) then
                    player:addItem(currency[2], CURRENCY_EXCHANGE_RATE)
                else
                    player:addItem(currency[2], CURRENCY_EXCHANGE_RATE % 99)
                end
            end
            player:messageSpecial(ID.text.ITEMS_OBTAINED, currency[2], CURRENCY_EXCHANGE_RATE)
        end

    -- bought item from shop
    elseif (csid == 57) then
        local item = player:getLocalVar("hundoItemBought")
        if (player:getFreeSlotsCount() == 0) then
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, item)
        else
            player:tradeComplete()
            player:addItem(item)
            player:messageSpecial(ID.text.ITEM_OBTAINED, item)
        end
        player:setLocalVar("hundoItemBought", 0)

    end
end
