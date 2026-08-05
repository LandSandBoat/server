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
        { xi.item.BRONZE_DAGGER,   156, 3, },
        { xi.item.BRASS_DAGGER,    930, 3, },
        { xi.item.DAGGER,         2030, 2, },
        { xi.item.BASELARD,       4788, 1, },
        { xi.item.XIPHOS,          672, 3, },
        { xi.item.BRASS_XIPHOS,   3915, 3, },
        { xi.item.GLADIUS,       18816, 1, },
        { xi.item.BRONZE_SWORD,    268, 3, },
        { xi.item.IRON_SWORD,     7920, 2, },
        { xi.item.BROADSWORD,    23408, 1, },
        { xi.item.SPATHA,         1860, 3, },
        { xi.item.LONGSWORD,      9216, 2, },
        { xi.item.HUNTING_SWORD, 39744, 1, },
        { xi.item.BILBO,          3495, 3, },
        { xi.item.FLEURET,       14896, 1, },
    }

    player:showText(npc, ID.text.ASH_THADI_ENE_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
