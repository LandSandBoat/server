-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Miogique
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.BRONZE_CAP,        174, 3,
        xi.item.BRASS_CAP,        1700, 3,
        xi.item.LEATHER_BANDANA,   457, 3,
        xi.item.STUDDED_BANDANA, 14899, 2,
        xi.item.IRON_MASK,       10670, 1,
        xi.item.BRONZE_HARNESS,    266, 3,
        xi.item.BRASS_HARNESS,    2584, 3,
        xi.item.LEATHER_VEST,      698, 3,
        xi.item.STUDDED_VEST,    23712, 2,
        xi.item.CHAINMAIL,       16473, 1,
        xi.item.BRONZE_MITTENS,    145, 3,
        xi.item.BRASS_MITTENS,    1419, 3,
        xi.item.LEATHER_GLOVES,    374, 3,
        xi.item.STUDDED_GLOVES,  12448, 2,
        xi.item.CHAIN_MITTENS,    8798, 1,
        xi.item.GAUNTLETS,       26956, 1,
    }

    player:showText(npc, ID.text.RAIMBROYS_SHOP_DIALOG + 1)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

return entity
