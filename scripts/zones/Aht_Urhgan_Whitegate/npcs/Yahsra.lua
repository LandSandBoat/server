-----------------------------------
-- Area: Aht Urhgan Whitegate
--  NPC: Yahsra
-- Type: Assault Mission Giver
-- !pos 120.967 0.161 -44.002 50
-----------------------------------
local ID = require("scripts/zones/Aht_Urhgan_Whitegate/IDs")
require("scripts/globals/assault")
require("scripts/globals/besieged")
require("scripts/globals/items")
require("scripts/globals/npc_util")
require("scripts/globals/extravaganza")
-----------------------------------
local entity = {}

local items =
{
    [1]  = { itemid = xi.items.STOIC_EARRING,                price =  3000 },
    [2]  = { itemid = xi.items.UNFETTERED_RING,              price =  5000 },
    [3]  = { itemid = xi.items.TEMPERED_CHAIN,               price =  8000 },
    [4]  = { itemid = xi.items.POTENT_BELT,                  price = 10000 },
    [5]  = { itemid = xi.items.MIRACULOUS_CAPE,              price = 10000 },
    [6]  = { itemid = xi.items.YIGIT_BULAWA,                 price = 10000 },
    [7]  = { itemid = xi.items.IMPERIAL_BHUJ,                price = 15000 },
    [8]  = { itemid = xi.items.PAHLUWAN_PATAS,               price = 15000 },
    [9]  = { itemid = xi.items.AMIR_KOLLUKS,                 price = 15000 },
    [10] = { itemid = xi.items.PAHLUWAN_QALANSUWA,           price = 20000 },
    [11] = { itemid = xi.items.YIGIT_SERAWEELS,              price = 20000 },
    [12] = { itemid = xi.items.CIPHER_OF_OVJANGS_ALTER_EGO,  price  = 3000 },
    [13] = { itemid = xi.items.CIPHER_OF_MNEJINGS_ALTER_EGO, price =  3000 },
}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local rank = xi.besieged.getMercenaryRank(player)
    local haveimperialIDtag = player:hasKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG) and 1 or 0
    local assaultPoints = player:getAssaultPoint(xi.assault.assaultArea.LEUJAOAM_SANCTUM)
    local cipher = 0
    local active = xi.extravaganza.campaignActive()

    if
        active == xi.extravaganza.campaign.SPRING_FALL or
        active == xi.extravaganza.campaign.BOTH
    then
        cipher = 1
    end

    if rank > 0 then
        player:startEvent(273, rank, haveimperialIDtag, assaultPoints, player:getCurrentAssault(), cipher)
    else
        player:startEvent(279)
    end
end

entity.onEventUpdate = function(player, csid, option)
    local selectiontype = bit.band(option, 0xF)
    if csid == 273 and selectiontype == 2 then
        local item = bit.rshift(option, 14)
        local choice = items[item]
        local assaultPoints = player:getAssaultPoint(xi.assault.assaultArea.LEUJAOAM_SANCTUM)
        local canEquip = player:canEquipItem(choice.itemid) and 2 or 0

        player:updateEvent(0, 0, assaultPoints, 0, canEquip)
    end
end

entity.onEventFinish = function(player, csid, option)
    if csid == 273 then
        local selectiontype = bit.band(option, 0xF)
        if
            selectiontype == 1 and
            npcUtil.giveKeyItem(player, xi.ki.LEUJAOAM_ASSAULT_ORDERS)
        then
            -- taken assault mission
            player:addAssault(bit.rshift(option, 4))
            player:delKeyItem(xi.ki.IMPERIAL_ARMY_ID_TAG)
            player:addKeyItem(xi.ki.MAP_OF_LEUJAOAM_SANCTUM)
        elseif selectiontype == 2 then
            -- purchased an item
            local item = bit.rshift(option, 14)
            local choice = items[item]
            if choice and npcUtil.giveItem(player, choice.itemid) then
                player:delAssaultPoint(xi.assault.assaultArea.LEUJAOAM_SANCTUM, choice.price)
            end
        end
    end
end

return entity
