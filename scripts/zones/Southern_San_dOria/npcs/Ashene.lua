-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ashene
-- !pos 70 0 61 230
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_DAGGER,   162, 3,
        xi.item.BRASS_DAGGER,    967, 3,
        xi.item.DAGGER,         2111, 2,
        xi.item.BASELARD,       4979, 1,
        xi.item.XIPHOS,          698, 3,
        xi.item.BRASS_XIPHOS,   4071, 3,
        xi.item.GLADIUS,       19568, 1,
        xi.item.BRONZE_SWORD,    278, 3,
        xi.item.IRON_SWORD,     8236, 2,
        xi.item.BROADSWORD,    24344, 1,
        xi.item.SPATHA,         1934, 3,
        xi.item.LONGSWORD,      9584, 2,
        xi.item.HUNTING_SWORD, 41333, 1,
        xi.item.BILBO,          3634, 3,
        xi.item.FLEURET,       15491, 1,
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
