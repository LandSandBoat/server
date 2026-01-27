-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Famad
-- Type: Assault Mission Giver
-- !pos 134.098 0.161 -43.759 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local items =
{
    [ 1] = { itemId = xi.item.INSOMNIA_EARRING,             price =  3000 },
    [ 2] = { itemId = xi.item.HALE_RING,                    price =  5000 },
    [ 3] = { itemId = xi.item.CHIVALROUS_CHAIN,             price =  8000 },
    [ 4] = { itemId = xi.item.PRECISE_BELT,                 price = 10000 },
    [ 5] = { itemId = xi.item.INTENSIFYING_CAPE,            price = 10000 },
    [ 6] = { itemId = xi.item.IMPERIAL_POLE,                price = 15000 },
    [ 7] = { itemId = xi.item.DOOMBRINGER,                  price = 15000 },
    [ 8] = { itemId = xi.item.SAYOSAMONJI,                  price = 15000 },
    [ 9] = { itemId = xi.item.PAHLUWAN_DASTANAS,            price = 20000 },
    [10] = { itemId = xi.item.YIGIT_CRACKOWS,               price = 20000 },
    [11] = { itemId = xi.item.AMIR_KORAZIN,                 price = 20000 },
    [12] = { itemId = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
    [13] = { itemId = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
}

entity.onTrigger = function(player, npc)
    local rank              = xi.besieged.getMercenaryRank(player)
    local haveimperialIDtag = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints     = player:getCurrency('lebros_assault_point')
    local cipher            = 0
    local active            = xi.extravaganza.campaignActive()

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    if rank > 0 then
        player:startEvent(275, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault(), cipher)
    else
        player:startEvent(281)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local selectiontype = bit.band(option, 0xF)
    if csid == 275 and selectiontype == 2 then
        local item          = bit.rshift(option, 14)
        local choice        = items[item]
        local assaultPoints = player:getCurrency('lebros_assault_point')
        local canEquip      = player:canEquipItem(choice.itemId) and 2 or 0

        player:updateEvent(0, 0, assaultPoints, 0, canEquip)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 275 then
        local selectiontype = bit.band(option, 0xF)

        -- Taken assault mission
        if
            selectiontype == 1 and
            npcUtil.giveKeyItem(player, xi.ki.LEBROS_ASSAULT_ORDERS)
        then
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_LEBROS_CAVERN)

        -- Purchased an item
        elseif selectiontype == 2 then
            local choice = items[bit.rshift(option, 14)]
            if not choice then
                return
            end

            local currency = player:getCurrency('lebros_assault_point')
            if currency < choice.price then
                return
            end

            if npcUtil.giveItem(player, choice.itemId) then
                player:delCurrency('lebros_assault_point', choice.price)
            end
        end
    end
end

return entity
