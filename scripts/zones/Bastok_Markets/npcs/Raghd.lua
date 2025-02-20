-----------------------------------
-- Area: Bastok Markets
--  NPC: Raghd
-- !pos -149.200 -4.819 -74.939 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.COPPER_RING,      79, 3,
        xi.item.BRASS_RING,      208, 2,
        xi.item.SILVER_RING,    1300, 1,
        xi.item.SILVER_EARRING, 1300, 1,
    }

    player:showText(npc, ID.text.RAGHD_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
