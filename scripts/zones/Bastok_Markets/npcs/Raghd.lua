-----------------------------------
-- Area: Bastok Markets
--  NPC: Raghd
-- !pos -149.200 -4.819 -74.939 235
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.COPPER_RING,      79, 3 },
        { xi.item.BRASS_RING,      210, 2 },
        { xi.item.SILVER_RING,    1312, 2 },
        { xi.item.SILVER_EARRING, 1312, 2 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MARKETS].text.RAGHD_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
