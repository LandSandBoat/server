-----------------------------------
-- Area: Bastok Mines
--  NPC: Deegis
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_CAP,        176, 3 },
        { xi.item.BRASS_CAP,        1716, 2 },
        { xi.item.PADDED_CAP,      21216, 1 },
        { xi.item.LEATHER_BANDANA,   462, 2 },
        { xi.item.IRON_MASK,       10670, 1 },
        { xi.item.BRONZE_HARNESS,    268, 3 },
        { xi.item.BRASS_HARNESS,    2609, 2 },
        { xi.item.PADDED_ARMOR,    32747, 1 },
        { xi.item.LEATHER_VEST,      705, 2 },
        { xi.item.CHAINMAIL,       16632, 3 },
        { xi.item.BRONZE_MITTENS,    147, 3 },
        { xi.item.BRASS_MITTENS,    1433, 2 },
        { xi.item.IRON_MITTENS,    17971, 1 },
        { xi.item.LEATHER_GLOVES,    378, 2 },
        { xi.item.CHAIN_MITTENS,    8883, 3 },
    }

    player:showText(npc, zones[xi.zone.BASTOK_MINES].text.DEEGIS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
