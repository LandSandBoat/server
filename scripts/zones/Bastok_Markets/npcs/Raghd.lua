-----------------------------------
-- Area: Bastok Markets
--  NPC: Raghd
-- Standard Merchant NPC
-- !pos -149.200 -4.819 -74.939 235
-----------------------------------
local ID = zones[xi.zone.BASTOK_MARKETS]
-----------------------------------
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.COPPER_RING,      79, 3,
        xi.items.BRASS_RING,      208, 2,
        xi.items.SILVER_RING,    1300, 1,
        xi.items.SILVER_EARRING, 1300, 1,
    }

    player:showText(npc, ID.text.RAGHD_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
