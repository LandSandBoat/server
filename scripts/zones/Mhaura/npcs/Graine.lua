-----------------------------------
-- Area: Mhaura
--  NPC: Graine
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.LEATHER_BANDANA,    439 },
        { xi.item.BRONZE_CAP,         168 },
        { xi.item.BRASS_CAP,         1635 },
        { xi.item.LEATHER_VEST,       671 },
        { xi.item.BRONZE_HARNESS,     256 },
        { xi.item.BRASS_HARNESS,     2485 },
        { xi.item.LEATHER_GLOVES,     360 },
        { xi.item.BRONZE_MITTENS,     140 },
        { xi.item.BRASS_MITTENS,     1365 },
        { xi.item.LEATHER_TROUSERS,   536 },
        { xi.item.BRONZE_SUBLIGAR,    208 },
        { xi.item.BRASS_SUBLIGAR,    2000 },
        { xi.item.LEATHER_HIGHBOOTS,  336 },
        { xi.item.BRONZE_LEGGINGS,    128 },
        { xi.item.BRASS_LEGGINGS,    1240 },
    }

    player:showText(npc, zones[xi.zone.MHAURA].text.GRAINE_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
