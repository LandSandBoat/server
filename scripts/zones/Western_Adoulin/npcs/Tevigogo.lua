-----------------------------------
-- Area: Western Adoulin
--  NPC: Tevigogo
-- Type: Shop NPC
-- !pos -151 3 -36 256
-----------------------------------
local ID = zones[xi.zone.WESTERN_ADOULIN]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    -- Standard shop
    player:showText(npc, ID.text.TEVIGOGO_SHOP_TEXT)
    local stock =
    {
        605, 200,    -- Pickaxe
        1021, 500,    -- Hatchet
        1020, 300,    -- Sickle
        17307, 10,     -- Dart
        17308, 60,     -- Hawkeye
        17320, 8,      -- Iron Arrow
    }
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
