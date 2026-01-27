-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Isdebaaq
-- Type: Assault Mission Giver
-- !pos 127.565 0.161 -43.846 50
-----------------------------------
---@type TNpcEntity
local entity = {}

local items =
{
    [ 1] = { itemId = xi.item.ANTIVENOM_EARRING,            price =  3000 },
    [ 2] = { itemId = xi.item.EBULLIENT_RING,               price =  5000 },
    [ 3] = { itemId = xi.item.ENLIGHTENED_CHAIN,            price =  8000 },
    [ 4] = { itemId = xi.item.SPECTRAL_BELT,                price = 10000 },
    [ 5] = { itemId = xi.item.BULLSEYE_CAPE,                price = 10000 },
    [ 6] = { itemId = xi.item.STORM_TULWAR,                 price = 15000 },
    [ 7] = { itemId = xi.item.IMPERIAL_NEZA,                price = 15000 },
    [ 8] = { itemId = xi.item.STORM_TABAR,                  price = 15000 },
    [ 9] = { itemId = xi.item.YIGIT_GAGES,                  price = 20000 },
    [10] = { itemId = xi.item.AMIR_BOOTS,                   price = 20000 },
    [11] = { itemId = xi.item.PAHLUWAN_SERAWEELS,           price = 20000 },
    [12] = { itemId = xi.item.CIPHER_OF_OVJANGS_ALTER_EGO,  price =  3000 },
    [13] = { itemId = xi.item.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
}

entity.onTrigger = function(player, npc)
    local rank              = xi.besieged.getMercenaryRank(player)
    local haveimperialIDtag = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints     = player:getCurrency('mamool_assault_point')
    local cipher            = 0
    local active            = xi.extravaganza.campaignActive()

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    if rank > 0 then
        player:startEvent(274, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault(), cipher)
    else
        player:startEvent(280)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
    local selectiontype = bit.band(option, 0xF)
    if csid == 274 and selectiontype == 2 then
        local item          = bit.rshift(option, 14)
        local choice        = items[item]
        local assaultPoints = player:getCurrency('mamool_assault_point')
        local canEquip      = player:canEquipItem(choice.itemId) and 2 or 0

        player:updateEvent(0, 0, assaultPoints, 0, canEquip)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 274 then
        local selectiontype = bit.band(option, 0xF)

        -- Taken assault mission
        if
            selectiontype == 1 and
            npcUtil.giveKeyItem(player, xi.ki.MAMOOL_JA_ASSAULT_ORDERS)
        then
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_THE_TRAINING_GROUNDS)

        -- Purchased an item
        elseif selectiontype == 2 then
            local choice = items[bit.rshift(option, 14)]
            if not choice then
                return
            end

            local currency = player:getCurrency('mamool_assault_point')
            if currency < choice.price then
                return
            end

            if npcUtil.giveItem(player, choice.itemId) then
                player:delCurrency('mamool_assault_point', choice.price)
            end
        end
    end
end

return entity
