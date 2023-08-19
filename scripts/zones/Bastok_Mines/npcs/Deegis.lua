-----------------------------------
-- Area: Bastok Mines
--  NPC: Deegis
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.BASTOK_MINES]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.items.BRONZE_CAP,        174, 3,
        xi.items.BRASS_CAP,        1700, 2,
        xi.items.PADDED_CAP,      21216, 1,
        xi.items.LEATHER_BANDANA,   457, 2,
        xi.items.IRON_MASK,       10670, 1,
        xi.items.BRONZE_HARNESS,    266, 3,
        xi.items.BRASS_HARNESS,    2584, 2,
        xi.items.PADDED_ARMOR,    32747, 1,
        xi.items.LEATHER_VEST,      698, 2,
        xi.items.CHAINMAIL,       16473, 3,
        xi.items.BRONZE_MITTENS,    145, 3,
        xi.items.BRASS_MITTENS,    1419, 2,
        xi.items.IRON_MITTENS,    17971, 1,
        xi.items.LEATHER_GLOVES,    374, 2,
        xi.items.CHAIN_MITTENS,    8798, 3,
    }

    player:showText(npc, ID.text.DEEGIS_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.BASTOK)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
