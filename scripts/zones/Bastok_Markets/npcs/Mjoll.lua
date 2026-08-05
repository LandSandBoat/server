-----------------------------------
-- Area: Batok Markets
--  NPC: Mjoll
-- !pos -318.902 -10.319 -178.087 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.WOODEN_ARROW,                4, 2 },
        { xi.item.IRON_ARROW,                  8, 3 },
        { xi.item.SILVER_ARROW,               17, 1 },
        { xi.item.SCROLL_OF_DARK_THRENODY,   217, 3 },
        { xi.item.SCROLL_OF_ICE_THRENODY,   1088, 3 },
        { xi.item.LIGHT_CROSSBOW,            179, 3 },
        { xi.item.CROSSBOW,                 2355, 3 },
        { xi.item.ZAMBURAK,                15243, 1 },
        { xi.item.CROSSBOW_BOLT,               6, 3 },
        { xi.item.MYTHRIL_BOLT,               25, 2 },
        { xi.item.TATHLUM,                   319, 1 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.MJOLL_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
