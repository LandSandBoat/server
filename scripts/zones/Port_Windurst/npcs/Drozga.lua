-----------------------------------
-- Area: Port Windurst
--  NPC: Drozga
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FACEGUARD,              1508 },
        { xi.item.SCALE_MAIL,             2319 },
        { xi.item.SCALE_FINGER_GAUNTLETS, 1237 },
        { xi.item.SCALE_CUISSES,          1861 },
        { xi.item.SCALE_GREAVES,          1128 },
        { xi.item.LEATHER_BELT,            442 },
        { xi.item.SILVER_EARRING,         1300 },
        { xi.item.LEATHER_RING,           1300 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.DROZGA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
