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
        { xi.item.FACEGUARD,              1450, },
        { xi.item.HEADGEAR,               1936, },
        { xi.item.SCALE_MAIL,             2230, },
        { xi.item.DOUBLET,                2745, },
        { xi.item.SCALE_FINGER_GAUNTLETS, 1190, },
        { xi.item.GLOVES,                 1515, },
        { xi.item.SCALE_CUISSES,          1790, },
        { xi.item.BRAIS,                  2110, },
        { xi.item.SCALE_GREAVES,          1085, },
        { xi.item.GAITERS,                1410, },
    }

    player:showText(npc, ID.text.CARAUTIA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
