-----------------------------------
-- Area: Western Adoulin
--  NPC: Ansegusele
-- Type: Shop NPC
-- !pos 74 4 -126 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.ANSEGUSELE_SHOP_TEXT)
    local stock =
    {
        4363, 44, -- Faerie Apple
        4388, 44, -- Eggplant
        4444, 24, -- Rarab Tail
        619, 48, -- Popoto
        4468, 80, -- Pamamas
        4389, 32, -- San D'Or. Carrot
        630, 96, -- Ogre Pumpkin
    }
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
