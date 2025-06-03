-----------------------------------
-- Area: Mhaura
--  NPC: Graine
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_BANDANA,    432 },
        { xi.item.BRONZE_CAP,         174 },
        { xi.item.BRASS_CAP,         1700 },
        { xi.item.LEATHER_VEST,       669 },
        { xi.item.BRONZE_HARNESS,     266 },
        { xi.item.BRASS_HARNESS,     2584 },
        { xi.item.LEATHER_GLOVES,     374 },
        { xi.item.BRONZE_MITTENS,     145 },
        { xi.item.BRASS_MITTENS,     1419 },
        { xi.item.LEATHER_TROUSERS,   557 },
        { xi.item.BRONZE_SUBLIGAR,    216 },
        { xi.item.BRASS_SUBLIGAR,    2080 },
        { xi.item.LEATHER_HIGHBOOTS,  349 },
        { xi.item.BRONZE_LEGGINGS,    133 },
        { xi.item.BRASS_LEGGINGS,    1289 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.GRAINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
