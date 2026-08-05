-----------------------------------
-- Area: Bastok Mines
--  NPC: Deegis
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_CAP,        168, 3 },
        { xi.item.BRASS_CAP,        1635, 2 },
        { xi.item.PADDED_CAP,      20206, 1 },
        { xi.item.LEATHER_BANDANA,   440, 2 },
        { xi.item.IRON_MASK,       10162, 1 },
        { xi.item.BRONZE_HARNESS,    256, 3 },
        { xi.item.BRASS_HARNESS,    2485, 2 },
        { xi.item.PADDED_ARMOR,    31188, 1 },
        { xi.item.LEATHER_VEST,      672, 2 },
        { xi.item.CHAINMAIL,       15840, 3 },
        { xi.item.BRONZE_MITTENS,    140, 3 },
        { xi.item.BRASS_MITTENS,    1365, 2 },
        { xi.item.IRON_MITTENS,    17116, 1 },
        { xi.item.LEATHER_GLOVES,    360, 2 },
        { xi.item.CHAIN_MITTENS,    8460, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.DEEGIS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
