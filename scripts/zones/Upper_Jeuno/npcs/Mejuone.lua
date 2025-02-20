-----------------------------------
-- Area: Upper Jeuno
--  NPC: Mejuone
-----------------------------------
local ID = zones[xi.zone.UPPER_JEUNO]
-----------------------------------
---@type TNpcEntity
local entity = {}

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

return entity
