-----------------------------------
-- Area: Bastok Mines
--  NPC: Deegis
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_CAP,        174, 3,
        xi.item.BRASS_CAP,        1700, 2,
        xi.item.PADDED_CAP,      21216, 1,
        xi.item.LEATHER_BANDANA,   457, 2,
        xi.item.IRON_MASK,       10670, 1,
        xi.item.BRONZE_HARNESS,    266, 3,
        xi.item.BRASS_HARNESS,    2584, 2,
        xi.item.PADDED_ARMOR,    32747, 1,
        xi.item.LEATHER_VEST,      698, 2,
        xi.item.CHAINMAIL,       16473, 3,
        xi.item.BRONZE_MITTENS,    145, 3,
        xi.item.BRASS_MITTENS,    1419, 2,
        xi.item.IRON_MITTENS,    17971, 1,
        xi.item.LEATHER_GLOVES,    374, 2,
        xi.item.CHAIN_MITTENS,    8798, 3,
    }

    player:showText(npc, ID.text.DEEGIS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

return entity
