-----------------------------------
-- Area: Port Windurst
--  NPC: Ryan
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.BRONZE_AXE,       316 },
        { xi.item.BRONZE_SWORD,     268 },
        { xi.item.CROSSBOW_BOLT,      6 },
        { xi.item.BRONZE_HARNESS,   256 },
        { xi.item.BRASS_HARNESS,   2485 },
        { xi.item.BRONZE_MITTENS,   140 },
        { xi.item.BRASS_MITTENS,   1365 },
        { xi.item.BRONZE_SUBLIGAR,  208 },
        { xi.item.BRASS_SUBLIGAR,  2000 },
        { xi.item.BRONZE_LEGGINGS,  128 },
        { xi.item.BRASS_LEGGINGS,  1240 },
        { xi.item.KENPOGI,         1245 },
        { xi.item.TEKKO,            685 },
        { xi.item.SITABAKI,        995 },
        { xi.item.KYAHAN,           635 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.RYAN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
