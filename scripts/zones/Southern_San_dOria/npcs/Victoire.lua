-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Victoire
-----------------------------------
local ID = zones[xi.zone.SOUTHERN_SAN_DORIA]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        xi.item.FACEGUARD,              1508,
        xi.item.HEADGEAR,               2013,
        xi.item.SCALE_MAIL,             2319,
        xi.item.DOUBLET,                2854,
        xi.item.SCALE_FINGER_GAUNTLETS, 1237,
        xi.item.GLOVES,                 1575,
        xi.item.SCALE_CUISSES,          1861,
        xi.item.BRAIS,                  2194,
        xi.item.SCALE_GREAVES,          1128,
        xi.item.GAITERS,                1466,
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
