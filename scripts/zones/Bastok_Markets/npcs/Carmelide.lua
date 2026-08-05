-----------------------------------
-- Area: Bastok Markets
--  NPC: Carmelide
-- !pos -151.693 -4.819 -69.635 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.TOURMALINE,   1863, 2 },
        { xi.item.SARDONYX,     1863, 2 },
        { xi.item.AMETHYST,     1863, 2 },
        { xi.item.AMBER_STONE,  1863, 2 },
        { xi.item.LAPIS_LAZULI, 1863, 2 },
        { xi.item.CLEAR_TOPAZ,  1863, 2 },
        { xi.item.ONYX,         1863, 2 },
        { xi.item.LIGHT_OPAL,   1863, 2 },
        { xi.item.COPPER_RING,    76, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.CARMELIDE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
