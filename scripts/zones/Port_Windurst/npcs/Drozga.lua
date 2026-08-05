-----------------------------------
-- Area: Port Windurst
--  NPC: Drozga
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FACEGUARD,              1450 },
        { xi.item.SCALE_MAIL,             2230 },
        { xi.item.SCALE_FINGER_GAUNTLETS, 1190 },
        { xi.item.SCALE_CUISSES,          1790 },
        { xi.item.SCALE_GREAVES,          1085 },
        { xi.item.LEATHER_BELT,            425 },
        { xi.item.SILVER_EARRING,         1250 },
        { xi.item.LEATHER_RING,           1250 },
    }

    player:showText(npc, zones[xi.zone.PORT_WINDURST].text.DROZGA_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
