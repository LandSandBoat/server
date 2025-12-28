-----------------------------------
-- Area: Port Windurst
--  NPC: Ryan
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_AXE,       328 },
        { xi.item.BRONZE_SWORD,     278 },
        { xi.item.CROSSBOW_BOLT,      6 },
        { xi.item.BRONZE_HARNESS,   266 },
        { xi.item.BRASS_HARNESS,   2584 },
        { xi.item.BRONZE_MITTENS,   145 },
        { xi.item.BRASS_MITTENS,   1419 },
        { xi.item.BRONZE_SUBLIGAR,  216 },
        { xi.item.BRASS_SUBLIGAR,  2080 },
        { xi.item.BRONZE_LEGGINGS,  133 },
        { xi.item.BRASS_LEGGINGS,  1289 },
        { xi.item.KENPOGI,         1294 },
        { xi.item.TEKKO,            712 },
        { xi.item.SITABAKI,        1034 },
        { xi.item.KYAHAN,           660 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.RYAN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
