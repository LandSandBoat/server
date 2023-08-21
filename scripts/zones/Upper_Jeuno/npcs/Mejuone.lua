-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mejuone
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        4545, 62,    -- Gysahl Greens
        840,   7,    -- Chocobo Feather
        17307, 9,    -- Dart
    }

    player:showText(npc, ID.text.MEJUONE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
