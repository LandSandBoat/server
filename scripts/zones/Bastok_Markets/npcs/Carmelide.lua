-----------------------------------
-- Area: Bastok Markets
--  NPC: Carmelide
-- !pos -151.693 -4.819 -69.635 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.TOURMALINE,   1937, 2,
        xi.item.SARDONYX,     1937, 2,
        xi.item.AMETHYST,     1937, 2,
        xi.item.AMBER_STONE,  1937, 2,
        xi.item.LAPIS_LAZULI, 1937, 2,
        xi.item.CLEAR_TOPAZ,  1937, 2,
        xi.item.ONYX,         1937, 2,
        xi.item.LIGHT_OPAL,   1937, 2,
        xi.item.COPPER_RING,    79, 3,
    }

    player:showText(npc, ID.text.CARMELIDE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
