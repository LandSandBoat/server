-----------------------------------
-- Area: Port Jeuno
--  NPC: Challoux
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.PORT_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4545, 62,    -- Gysahl Greens
        840,   4,    -- Chocobo Feather
        17307, 9,    -- Dart
    }

    player:showText(npc, ID.text.CHALLOUX_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
