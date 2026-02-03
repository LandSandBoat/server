-----------------------------------
-- Area: The Colosseum
--  NPC: Zandjarl
-- Type: Pankration NPC
-- !pos -599 0 45 71
-----------------------------------
local ID = zones[xi.zone.THE_COLOSSEUM]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    local result = nil
    local count  = trade:getItemCount()
    local total  = player:getCurrency('jetton')
    local max    = 100000000

    if trade:hasItemQty(xi.item.IMPERIAL_BRONZE_PIECE, count) then
        result = 2 * count
    elseif trade:hasItemQty(xi.item.IMPERIAL_SILVER_PIECE, count) then
        result = 10 * count
    elseif trade:hasItemQty(xi.item.IMPERIAL_MYTHRIL_PIECE, count) then
        result = 30 * count
    elseif trade:hasItemQty(xi.item.IMPERIAL_GOLD_PIECE, count) then
        result = 200 * count
    end

    if result ~= nil then
        if (result + total) > max then
            -- player:startEvent(47); ..it no work..
            npc:showText(npc, ID.text.EXCEED_THE_LIMIT_OF_JETTONS)
        else
            -- packet cap says its a 'showText' thing..
            npc:showText(npc, ID.text.I_CAN_GIVE_YOU, result)
            npc:showText(npc, ID.text.THANKS_FOR_STOPPING_BY)
            player:addCurrency('jetton', result)
            player:tradeComplete()
        end
    end
end

entity.onTrigger = function(player, npc)
    player:startEvent(1900, player:getCurrency('jetton'))
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 1900 then -- onTrigger
        local shop =
        {
            -- TODO: Bitwise math here on option
            [     1] = { itemId = 18721, price =    2, quantity =  1 }, -- SoulTrapper
            [   257] = { itemId = 18724, price =  500, quantity =  1 }, -- Soultrapper 2000
            [   513] = { itemId = 16134, price = 5000, quantity =  1 }, -- Zoraal Ja's Helm
            [ 65537] = { itemId = 18722, price =    2, quantity = 12 }, -- Blank Soul Plates
            [ 65793] = { itemId = 18725, price =  500, quantity = 12 }, -- High Speed Soul plates
            [ 66049] = { itemId = 16135, price = 5000, quantity =  1 }, -- Dartorgor's Coif
            [131585] = { itemId = 16136, price = 5000, quantity =  1 }, -- Lamia No.3's Garland
            [197121] = { itemId = 16137, price = 5000, quantity =  1 }, -- Cacaroon's Hood
        }

        local result = shop[option]
        if not result then
            return
        end

        local currency = player:getCurrency('jetton')
        if currency < result.price then
            return
        end

        if player:addItem(result.itemId, result.quantity) then
            player:delCurrency('jetton', result.price)
            player:messageSpecial(ID.text.ITEM_OBTAINED, result.itemId)
        else
            player:messageSpecial(ID.text.ITEM_CANNOT_BE_OBTAINED, result.itemId)
        end
    end
end

return entity
