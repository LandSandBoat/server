-----------------------------------
-- Area: Batok Markets
--  NPC: Mjoll
-- !pos -318.902 -10.319 -178.087 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.WOODEN_ARROW,                4, 2,
        xi.item.IRON_ARROW,                  8, 3,
        xi.item.SILVER_ARROW,               18, 1,
        xi.item.SCROLL_OF_DARK_THRENODY,   225, 3,
        xi.item.SCROLL_OF_ICE_THRENODY,   1131, 3,
        xi.item.LIGHT_CROSSBOW,            187, 3,
        xi.item.CROSSBOW,                 2449, 3,
        xi.item.ZAMBURAK,                16005, 1,
        xi.item.CROSSBOW_BOLT,               6, 3,
        xi.item.MYTHRIL_BOLT,               24, 2,
        xi.item.TATHLUM,                   334, 1,
    }

    player:showText(npc, ID.text.MJOLL_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
