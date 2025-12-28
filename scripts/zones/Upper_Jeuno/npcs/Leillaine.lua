-----------------------------------
-- Area: Upper Jeuno
--  NPC: Leillaine
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        { xi.item.FLASK_OF_DISTILLED_WATER,   12 },
        { xi.item.FLASK_OF_EYE_DROPS,       2595 },
        { xi.item.ANTIDOTE,                  316 },
        { xi.item.FLASK_OF_ECHO_DROPS,       800 },
        { xi.item.POTION,                    910 },
        { xi.item.ETHER,                    4832 },
        { xi.item.REMEDY,                   3360 },
    }

    player:showText(npc, zones[xi.zone.UPPER_JEUNO].text.LEILLAINE_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
